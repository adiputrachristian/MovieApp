//
//  BaseViewController.swift
//  DesignKit
//
//  Created by Christian Adiputra on 18/05/23.
//

import Foundation
import UIKit

open class BaseViewController: UIViewController {
    
    let searchBar = UISearchBar()
    public weak var popUpDelegate: PopUpModalDelegate?
    var vSpinner : UIView?
    
    public func hideBackButton() {
        navigationItem.hidesBackButton = true
    }
    
    public func showBackButton() {
        navigationItem.hidesBackButton = false
    }
    
    public func configureNavBar(delegate: UISearchBarDelegate, title: String) {
        hideBackButton()
        searchBar.sizeToFit()
        searchBar.delegate = delegate
        
        navigationItem.title = title
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.tintColor = UIColor.gray
        
        
        let leftBarButtonItem = UIBarButtonItem(customView: setupFilterButton())
        leftBarButtonItem.imageInsets = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 0)
        
        
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleShowSearchBar))
        
        navigationItem.leftBarButtonItem?.isAccessibilityElement = true
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        showSeachBarButton(show: true)
    }
    
    @objc func handleShowSearchBar(){
        search(shouldShow: true)
        searchBar.becomeFirstResponder()
    }
    
    private func showSeachBarButton(show: Bool) {
        if show {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleShowSearchBar))
            navigationItem.leftBarButtonItem = nil
        } else {
            navigationItem.rightBarButtonItem = nil
            let leftBarButtonItem = UIBarButtonItem(customView: setupFilterButton())
            leftBarButtonItem.imageInsets = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 0)
            
            
            navigationItem.leftBarButtonItem = leftBarButtonItem
        }
    }
    
    public func search(shouldShow: Bool) {
        showSeachBarButton(show: !shouldShow)
        searchBar.showsCancelButton = shouldShow
        navigationItem.titleView = shouldShow ? searchBar : nil
    }
    
    @objc public func showPopupFilter() {
        BasicModal.present(initialView: self, delegate: popUpDelegate, title: "Filter")
            .setHeight(height: 0.5)
    }
    
}

extension BaseViewController {
    public func setupFilterButton() -> UIView {
        navigationItem.hidesBackButton = true
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 44))
        let button = UIButton(frame: CGRect(x: 0, y: 7, width: 30.0, height: 30.0) )
        button.addTarget(self, action: #selector(showPopupFilter), for: .touchUpInside)
        
        let image = IconSet.filter.value
        
        button.setImage(image?.withRenderingMode(.alwaysOriginal), for: UIControl.State.normal)
        view.addSubview(button)
        return view
    }
}

extension BaseViewController {
    
    public func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.large)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    public func removeSpinner() {
        DispatchQueue.main.async {
            self.vSpinner?.removeFromSuperview()
            self.vSpinner = nil
        }
    }
    
    
}
