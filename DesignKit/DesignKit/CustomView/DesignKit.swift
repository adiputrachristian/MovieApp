//
//  RoundedView.swift
//  DesignKit
//
//  Created by Christian Adiputra on 28/02/23.
//

import UIKit
import SnapKit

public protocol DesignKit {
    
}

public class DesignKitImp: DesignKit {
    
    public init (){}
    
    public func buildRoundedView(withRadius: CGFloat? = 8) -> UIView {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = withRadius ?? 8
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
}
