//
//  AppDelegate+Providers.swift
//  MyPokedex
//
//  Created by Christian Adiputra on 27/03/23.
//

import Foundation
import UIKit
import PokemonCard
import PokemonList
import Provider
import Login
import BusinessSearch
import ToolTracking
import MovieApp

extension AppDelegate {
    func setupFeatureProviders() {
        MovieProvider.instance = MovieFeatureProvider()
    }
}
