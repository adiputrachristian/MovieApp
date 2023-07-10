//
//  ChipsView.swift
//  DesignKit
//
//  Created by Christian Adiputra on 19/05/23.
//

import Foundation
import UIKit

public class ChipsCell: UICollectionViewCell {
    
    var textLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.backgroundColor = .lightGray
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.text = "-"
        label.setPadding(left: 8, right: 8, top: 6, bottom: 6)
        label.layer.cornerRadius = 4
        label.layer.masksToBounds = true
        return label
    }()
    
    public override var isSelected: Bool {
        didSet {
            textLabel.backgroundColor = isSelected ? .black : .lightGray
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    func setupView() {
        addSubview(textLabel)
        
        textLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalToSuperview()
        }
    }
    
    public func updateData(text: String, isSelected: Bool) {
        textLabel.text = text
        textLabel.backgroundColor = isSelected ? .black : .lightGray
    }
    
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
