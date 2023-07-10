//
//  MovieFeatureProvider.swift
//  MovieApp
//
//  Created by Christian Adiputra on 29/06/23.
//

import UIKit
import Provider


public class MovieFeatureProvider: MovieInterface {
    
    public func createMovieVc() -> UIViewController {
        return MovieHomeWireframe().viewController
    }
    public init() {}


}
