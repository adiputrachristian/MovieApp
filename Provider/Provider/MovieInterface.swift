//
//  MovieInterface.swift
//  Provider
//
//  Created by Christian Adiputra on 29/06/23.
//

import Foundation
import UIKit

public class MovieProvider {
    public static var instance: MovieInterface!
}

public protocol MovieInterface {
    
    func createMovieVc() -> UIViewController
    
}
