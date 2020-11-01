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
    var RecipeInformation: [RecipeProcess]
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

struct RecipeProcess: Codable {
    var id = UUID()
    var ingredientIndex: Int
    var behavior: BehaviorType
    
    internal init(ingredientIndex: Int, behavior: BehaviorType) {
        self.ingredientIndex = ingredientIndex
        self.behavior = behavior
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

enum BehaviorType: String, Codable, CaseIterable {
    case build
    case stir
    case shake
    case float
    case blend
    case pour
}



/*
  ingredients: orange rum gin
 
 
 1. orage "붓다" -> ingredient[0]  .pour
 2. rum 부어 -> ingredient[1] .pour
 3. shake -> .shake
 4. gin 부어버렷 -> ingredient[2] .pour
 5. 섞어 -> .stir
 
 */
