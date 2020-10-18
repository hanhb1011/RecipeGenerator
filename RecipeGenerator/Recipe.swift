//
//  Recipe.swift
//  SwiftUI Demo
//
//  Created by 한효병 on 2020/09/26.
//  Copyright © 2020 hb. All rights reserved.
//

import Foundation


struct Recipe: Codable, Identifiable {
    var id = UUID()
    var names: [String]
    var alcoholDegree: Int
    var ingredients: [Ingredient]
    var favoriteChecked: Bool
    var RecipeInformation: String
    var techniqueTypes: [TechniqueType]
    var lastTimeRecipeOpened: Date
    var latitude: Double
    var longitude: Double
    var liquidColor: LiquidColorType
    var glassType: GlassType
}

struct Ingredient: Codable, Identifiable {
    var id = UUID()
    var names: [String]
    var volume: Double
    var type: LiquidUnitType
    
    internal init(names: [String], volume: Double, type: LiquidUnitType) {
        self.names = names
        self.volume = volume
        self.type = type
    }
}

enum TechniqueType: String, Codable, CaseIterable {
    case build
    case stir
    case shake
    case float
    case blend
}

enum LiquidColorType: String, Codable, CaseIterable {
    case red
    case blue
    case pink
    case yellow
    case brown
    case mixed
    case none
}

enum LiquidUnitType: String, Codable, CaseIterable {
    case ml
    case oz
    case dash
    case part
    case tsp
    case pieces
    case pinch
    case none
}

enum GlassType: String, Codable, CaseIterable {
    case stemmedLiqueurGlass
    case cocktailGlass
    case oldFashonedGlass
    case highballGlass
    case footedPilsnerGlass
    case sourGlass
    case collinsGlass
    case sherryGlass
    case champagneGlass
    case whiteWineGlass
}
