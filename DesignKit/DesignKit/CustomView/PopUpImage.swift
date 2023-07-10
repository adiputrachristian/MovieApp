//
//  PopUpImage.swift
//  DesignKit
//
//  Created by Christian Adiputra on 03/03/23.
//

import Foundation
import SnapKit
import Kingfisher

public class PopUpImage: UIViewController {
    
    var container: UIView = {
        let kit = DesignKitImp()
        let view = kit.buildRoundedView(withRadius: 8)
        return view
    }()
    
    var imageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .gray
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = .black.withAlphaComponent(0.2)
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        view.backgroundColor = .black.withAlphaComponent(0)
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    public init(url: String) {
        super.init(nibName: nil, bundle: nil)
        imageView.kf.setImage(with: URL(string: url))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        view.addSubview(container)
        container.addSubview(imageView)
        
        let screnWidth = UIScreen.main.bounds.width
        let height = (screnWidth-32)*1.5
        
        container.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(height)
            make.centerX.centerY.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(container)
        }
    }

}
