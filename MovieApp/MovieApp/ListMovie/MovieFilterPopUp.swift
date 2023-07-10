//
//  PopUpFilterMovie.swift
//  ToolTracking
//
//  Created by Christian Adiputra on 07/07/23.
//

import Foundation
import UIKit
import DesignKit
import NetworkKit

public struct GenreFilter {
    public var list: [MovieGenre] = []
    public var selected: [MovieGenre] = []
}

protocol MovieFilterDelegate {
    func didTapCancel()
    func didTapApplyFilter(filter: [MovieGenre])
}

class MovieFilterPopUp: UIViewController {
    
    var filter: GenreFilter = GenreFilter()
    
    private static func create(
        delegate: MovieFilterDelegate? = nil, title: String
    ) -> MovieFilterPopUp {
        let view = MovieFilterPopUp(delegate: delegate, title: title)
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
        initialView: UIViewController, delegate: MovieFilterDelegate? = nil,
        title: String
    ) -> MovieFilterPopUp {
        
        let view = MovieFilterPopUp.create(delegate: delegate, title: title)
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
        label.text = "Choose Genre"
        label.textAlignment = .left
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
    
    public init(delegate: MovieFilterDelegate? = nil, title: String) {
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
    
    var delegate: MovieFilterDelegate?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
    }
    
    private func setupViews() {
        view.addSubview(canvas)
        canvas.addSubview(titleLabel)
        canvas.addSubview(closeButton)
        canvas.addSubview(collectionView)
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
        
        
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
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
        delegate?.didTapApplyFilter(filter: filter.selected)
        self.dismiss(animated: true)
    }
}

extension MovieFilterPopUp: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filter.list.count
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChipsCell", for: indexPath) as? ChipsCell else { return UICollectionViewCell() }
        
        let filter = filter.list[indexPath.row]
        if self.filter.selected.contains(where: { $0.name == filter.name }) {
            cell.updateData(text: filter.name, isSelected: true)
//            cell.isSelected = true
        } else {
            cell.updateData(text: filter.name, isSelected: false)
        }
        
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChipsCell", for: indexPath) as? ChipsCell else { return }
        cell.isSelected = true
        let selected = filter.list[indexPath.row]
        filter.selected.append(selected)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChipsCell", for: indexPath) as? ChipsCell else { return }
        cell.isSelected = false
        let deselected = filter.list[indexPath.row]
        filter.selected.removeAll { $0 == deselected }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 30, height: 50)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let margin: CGFloat = 10
        return UIEdgeInsets(top: 0, left: 0, bottom: margin, right: 0)
    }
    
}

extension MovieFilterPopUp {
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

