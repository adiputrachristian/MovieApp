//
//  MovieReviewCell.swift
//  MovieApp
//
//  Created by Christian Adiputra on 03/07/23.
//

import UIKit
import NetworkKit
import DesignKit

class MovieReviewCell: UITableViewCell {
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.text = "Baker Street"
        return label
    }()
    
    var txtLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.text = "adsdadadasdadadadada adadasdadada adadasdasda dasdasdadas dasdasdasda daasdasdasd asdasdas adasdasda asdasdas dasdasd"
        label.numberOfLines = 0
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.backgroundColor = .clear
        addSubview(nameLabel)
        addSubview(txtLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(16)
        }
        
        txtLabel.snp.makeConstraints { make in
            make.left.equalTo(nameLabel.snp.left)
            make.right.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.bottom.equalToSuperview().offset(-8)
        }
    
    }
    
    func updateCell(review: MovieReview) {
        nameLabel.text =  review.author
        txtLabel.text = review.content
    }

}
