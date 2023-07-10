//
//  LoadingCell.swift
//  DesignKit
//
//  Created by Christian Adiputra on 18/04/23.
//

import Foundation
import UIKit

public class LoadingCell: UICollectionViewCell {
    var inidicator : UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        addSubview(inidicator)
        inidicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        inidicator.startAnimating()
    }
    
    public func startAnimating() {
        inidicator.startAnimating()
    }
}
