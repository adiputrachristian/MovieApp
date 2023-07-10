//
//  ImageProvider.swift
//  DesignKit
//
//  Created by Christian Adiputra on 28/02/23.
//

import Foundation
import UIKit

public class ImageProvider {
    public static func image(named: String) -> UIImage? {
        return UIImage(named: named, in: Bundle(for: self), compatibleWith: nil) ?? UIImage()
    }
}
