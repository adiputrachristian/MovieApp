//
//  BaseTabBarController.swift
//  DesignKit
//
//  Created by Christian Adiputra on 28/03/23.
//

import Foundation
import UIKit

public protocol TabBarActionDelegate: AnyObject {
    func scrollToTop()
}

open class BaseTabBarController: UITabBarController {

    public weak var actionDelegate: TabBarActionDelegate?

    public func scrollToTop() {
        actionDelegate?.scrollToTop()
    }
}
