//
//  IconSet.swift
//  DesignKit
//
//  Created by Christian Adiputra on 18/05/23.
//

import Foundation
import UIKit

public enum IconSet {
    case filter
    
    public var value: UIImage? {
        switch self {
        case .filter:
            return ImageProvider.image(named: "filter")
        }
    }
}


