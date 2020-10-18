//
//  UnitTests.swift
//  RecipeGenerator
//
//  Created by 한효병 on 2020/10/17.
//

import Foundation


func ingredientTypeUT() {
    
    for ingredientIdx in (0...LiquidUnitType.allCases.count - 1) {
        print("ingredient type idx : \(ingredientIdx)")
        var index = 0
        LiquidUnitType.allCases.forEach {type in
            print("\(index): \(type.rawValue)")
            index += 1
        }
        
        let type = LiquidUnitType.allCases[ingredientIdx]
        print(type.rawValue)
    }
}
