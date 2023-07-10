//
//  MovieHomeViewController.swift
//  MovieApp
//
//  Created by Christian Adiputra on 23/06/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import DesignKit
import SkeletonView

class RoundedBottomCornersImageView: UIImageView {
    
    private let cornerRadius: CGFloat = 12
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: [.bottomLeft, .bottomRight],
                                cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
    }
}

class MovieHomeViewController: UIViewController {
    
    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    var discoverLbl: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.text = "Discover"
        return label
    }()
    
    var seeAllBtn: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("See all", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(navigateToListMovies), for: .touchUpInside)
        return button
    }()
    
    var imageBanner: RoundedBottomCornersImageView = {
        let image = RoundedBottomCornersImageView()
        image.backgroundColor = .gray
        image.image = ImageProvider.image(named: "batmanPoster")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(
            MovieCell.self, forCellWithReuseIdentifier: "MovieCell")
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    var seeDetailBtn: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("See Detail", for: .normal)
        button.setTitleColor(UIColor.backgroundColor(), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(navigateToDetailMovie), for: .touchUpInside)
        return button
    }()
    
    var presenter: MovieHomePresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.backgroundColor()
        navigationController?.navigationBar.tintColor = UIColor.white
        
        scrollView.delegate = self
        setupView()
        showSkeleton()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Update the content size of the scroll view
        scrollView.contentSize = stackView.bounds.size
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setupView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        stackView.addSubview(imageBanner)
        view.addSubview(seeDetailBtn)
        containerView.addSubview(discoverLbl)
        containerView.addSubview(seeAllBtn)
        stackView.addSubview(containerView)
        stackView.addSubview(collectionView)
        
        scrollView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.top.left.right.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
            make.height.greaterThanOrEqualTo(scrollView.frameLayoutGuide)
        }
        
        seeDetailBtn.snp.makeConstraints { make in
            make.centerX.equalTo(imageBanner.snp.centerX)
            make.bottom.equalTo(imageBanner.snp.bottom).offset(-16)
            make.width.equalTo(100)
        }
        
        containerView.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.width.equalTo(stackView)
            make.top.equalTo(imageBanner.snp.bottom)
        }
        
        discoverLbl.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(15)
            make.left.equalTo(containerView).offset(16)
        }
        
        seeAllBtn.snp.makeConstraints { make in
            make.centerY.equalTo(discoverLbl)
            make.right.equalTo(containerView).offset(-16)
        }
        
        imageBanner.snp.makeConstraints { make in
            make.top.left.right.equalTo(stackView)
            make.height.equalTo(600)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(discoverLbl.snp.bottom).offset(5)
            make.left.right.equalTo(stackView)
            make.height.equalTo(200)
        }
    }
    
    @objc func navigateToListMovies() {
        presenter?.goToListMovie()
    }
    
    @objc func navigateToDetailMovie() {
        guard let id = presenter?.randomMovie?.id else { return }
        presenter?.goToDetailMovie(movieId: id)
    }
    
    func hideSkeleton() {
        collectionView.stopSkeletonAnimation()
        collectionView.hideSkeleton()
        self.view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
    }
    
    func showSkeleton() {
        collectionView.isSkeletonable = true
        collectionView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .darkClouds), animation: nil ,transition: .crossDissolve(0.25))
    }

    
}

extension MovieHomeViewController: MovieHomeViewProtocol, UIScrollViewDelegate {
    
    func updateList() {
        collectionView.reloadData()
        hideSkeleton()
        imageBanner.kf.setImage(with: presenter?.getRandomPoster())
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            alertController.dismiss(animated: false)
        }

        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }

    
}

extension MovieHomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, SkeletonCollectionViewDataSource {
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        return "MovieCell"
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell( withReuseIdentifier: "MovieCell", for: indexPath)
                as? MovieCell
        else { return UICollectionViewCell() }
        guard let data = presenter?.getListDiscover(), data.count != 0 else { return cell }
        
        cell.updateImage(url: data[indexPath.row].posterPath)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 120, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset: CGFloat = 16
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let data = presenter?.getListDiscover(), data.count != 0 else { return }
        presenter?.goToDetailMovie(movieId: data[indexPath.row].id)
    }
    
    
    
    
}
