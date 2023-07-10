//
//  UICollectionView+Extensions.swift
//  DesignKit
//
//  Created by Christian Adiputra on 19/05/23.
//

import Foundation
import UIKit

public extension UICollectionView {
    func scrollToNearestVisibleCollectionViewCell(completion: ((Int) -> Void)? = nil) {
        self.decelerationRate = UIScrollView.DecelerationRate.fast
        let visibleCenterPositionOfScrollView = Float(self.contentOffset.x + (self.bounds.size.width / 2))
        var closestCellIndex = -1
        var closestDistance: Float = .greatestFiniteMagnitude
        for index in 0..<self.visibleCells.count {
            let cell = self.visibleCells[index]
            let cellWidth = cell.bounds.size.width
            let cellCenter = Float(cell.frame.origin.x + cellWidth / 2)

            // Now calculate closest cell
            let distance: Float = fabsf(visibleCenterPositionOfScrollView - cellCenter)
            if distance < closestDistance {
                closestDistance = distance
                closestCellIndex = self.indexPath(for: cell)!.row
            }
        }
        if closestCellIndex != -1 {
            self.scrollToItem(at: IndexPath(row: closestCellIndex, section: 0), at: .centeredHorizontally, animated: true)
            completion?(closestCellIndex)
        }
    }
}

