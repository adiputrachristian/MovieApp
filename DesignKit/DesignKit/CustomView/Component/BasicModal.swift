//
//  BasicModal.swift
//  DesignKit
//
//  Created by Christian Adiputra on 18/05/23.
//

import Foundation
import UIKit


public protocol Filter: Any {
    var list: [String] { get set}
    var selected: [String] { get set}
}

public struct PriceFilter: Filter {
    public var selected: [String] = []
    public var list = ["$", "$$", "$$$", "$$$$"]
}

public struct OpenFilter: Filter {
    public var selected: [String] = []
    public var list = ["Open", "Close"]
}


public protocol PopUpModalDelegate: AnyObject {
    func didTapCancel()
    func didTapApplyFilter(filter: [Filter])
}

public class BasicModal: UIViewController {
    
    var filter: [Filter] = [PriceFilter(), OpenFilter()]
    
    private static func create(
        delegate: PopUpModalDelegate? = nil, title: String
    ) -> BasicModal {
        let view = BasicModal(delegate: delegate, title: title)
        return view
    }
    
    private var height: CGFloat? {
        didSet {
            canvas.snp.makeConstraints { make in
                make.height.equalTo(UIScreen.main.bounds.height*(height ?? 0.5))
            }
        }
    }
    
    @discardableResult
    static public func present(
        initialView: UIViewController, delegate: PopUpModalDelegate? = nil,
        title: String
    ) -> BasicModal {
        
        let view = BasicModal.create(delegate: delegate, title: title)
        view.modalPresentationStyle = .overFullScreen
        view.modalTransitionStyle = .coverVertical
        initialView.present(view, animated: false)
        return view
        
    }
    
    public func setHeight(height: CGFloat) {
        self.height = height
    }
    
    let canvas: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.clipsToBounds = true
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.title()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let filterPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.text = "by price :"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
        return button
    }()
    
    lazy var applyButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Apply Filter", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didApplyButton), for: .touchUpInside)
        return button
    }()
    
    var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.allowsMultipleSelection = true
        return collectionView
    }()
    
    public init(delegate: PopUpModalDelegate? = nil, title: String) {
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ChipsCell.self, forCellWithReuseIdentifier: "ChipsCell")
        self.setupProperty(title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public weak var delegate: PopUpModalDelegate?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
    }
    
    private func setupViews() {
        view.addSubview(canvas)
        canvas.addSubview(titleLabel)
        canvas.addSubview(closeButton)
        canvas.addSubview(collectionView)
        canvas.addSubview(filterPriceLabel)
        canvas.addSubview(applyButton)
        
        canvas.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.top)
            make.right.equalTo(canvas.snp.right).offset(-22)
            make.height.equalTo(30)
            make.width.equalTo(50)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.right.equalTo(canvas.snp.right).offset(-22)
            make.left.equalTo(canvas.snp.left).offset(22)
            make.centerX.equalTo(canvas.snp.centerX)
            make.top.equalTo(canvas.snp.top).offset(32)
        }
        
        filterPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(32)
            make.left.equalTo(titleLabel.snp.left)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(filterPriceLabel.snp.bottom).offset(6)
            make.bottom.equalToSuperview()
            make.left.equalTo(titleLabel.snp.left)
            make.right.equalToSuperview().offset(-16)
        }
        
        applyButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-16)
            make.height.equalTo(50)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
        }
        
        
    }
    
    func setupProperty(title: String) {
        self.titleLabel.text = title
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateShow()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0)
    }
    
    @objc func didTapCancel(_ btn: UIButton) {
        self.dismiss(animated: true)
    }
    
    @objc func didApplyButton(_ btn: UIButton) {
        delegate?.didTapApplyFilter(filter: filter)
        self.dismiss(animated: true)
    }
}

extension BasicModal: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filter[section].list.count
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return filter.count
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChipsCell", for: indexPath) as? ChipsCell else { return UICollectionViewCell() }
        
        let kindFilter = filter[indexPath.section].list
//        cell.updateData(text: kindFilter[indexPath.row])
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChipsCell", for: indexPath) as? ChipsCell else { return }
        cell.isSelected = true
        let selected = filter[indexPath.section].list[indexPath.row]
        filter[indexPath.section].selected.append(selected)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChipsCell", for: indexPath) as? ChipsCell else { return }
        cell.isSelected = false
        let deselected = filter[indexPath.section].list[indexPath.row]
        filter[indexPath.section].selected.removeAll { $0 == deselected }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 30, height: 50)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let margin: CGFloat = 10
        return UIEdgeInsets(top: 0, left: 0, bottom: margin, right: 0)
    }
    
}

extension BasicModal {
    private func animateShow() {
        canvas.transform = CGAffineTransform(translationX: 0, y: 20)
        UIView.animate(
            withDuration: 0.33, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.7
        ) { [weak self] in
            self?.canvas.transform = .identity
            self?.canvas.isHidden = false
        }
    }
}
