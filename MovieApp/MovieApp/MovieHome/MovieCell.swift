//
//  MovieCell.swift
//  MovieApp
//
//  Created by Christian Adiputra on 29/06/23.
//

import UIKit
import DesignKit
import NetworkKit

class MovieCell: UICollectionViewCell {
    
    var movieImg: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .gray
        image.contentMode = .scaleAspectFill
        image.image = ImageProvider.image(named: "spidermanPoster")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.layer.cornerRadius = 8
        image.isSkeletonable = true
        return image
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.isSkeletonable = true
        addSubview(movieImg)
        
        movieImg.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
            make.centerY.centerX.equalToSuperview()
        }
        
    }
    
    func updateImage(url: String) {
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(url)")
        movieImg.kf.setImage(with: url)
    }
    
}
