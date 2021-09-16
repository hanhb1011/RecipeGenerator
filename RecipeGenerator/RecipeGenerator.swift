//
//  RecipeGenerator.swift
//  RecipeGenerator
//
//  Created by 한효병 on 2020/10/17.
//

import Foundation

func makeRecipeFromCommandLine () -> Recipe? {
    var names: [String]
    //let alcoholDegree: Int
    //var ingredients: [Ingredient]
    let favoriteChecked: Bool = false
    //let recipeInformation: String = "recipe information"
    //let techniqueTypes: [TechniqueType]
    let lastTimeRecipeOpened: Date = nil
    let latitude: Double = 0.0
    let longitude: Double = 0.0
    //let liquidColor: LiquidColorType
    //let glassType: GlassType
    
    print("=======================================================")
    print("중단하려면 마우것도 입력하지 않고 엔터 입력!")
    
    names = getNamesFromCLI()!
    if names.isEmpty {
        print("취소됨!")
        return nil
    }
    
    let recipe: Recipe? = findRecipeByNames(names: names)
    if recipe != nil {
        print("레시피 중복!")
        return nil
    }
    
    print("alcoholDegree 입력(정수로 입력, ex: 15):")
    guard let alcoholDegree = Int(readLine()!) else {
        print("취소됨!")
        return nil
    }
    
    guard let ingredients = getIngredientsFromCLI() else {
        print("취소됨!")
        return nil
    }
    
    guard let recipeInformation = getRecipeInformationFromCLI() else {
        print("취소됨!")
        return nil
    }
    
    guard let techniqueTypes = getTechniqueTypesFromCLI() else {
        print("취소됨!")
        return nil
    }
    
    guard let liquidColor = getLiquidColorTypeFromCLI() else {
        print("취소됨!")
        return nil
    }
    
    guard let glassType = getGlassTypeFromCLI() else {
        print("취소됨!")
        return nil
    }
    
    print("names: \(names)")
    print("alcoholDegree: \(alcoholDegree)")
    print("ingredients: \(ingredients)")
    print("techniqueTypes: \(techniqueTypes)")
    print("liquidColor: \(liquidColor)")
    print("glassType: \(glassType)")
    
   return Recipe(names: names, alcoholDegree: alcoholDegree, ingredients: ingredients, favoriteChecked: favoriteChecked, RecipeInformation: recipeInformation, techniqueTypes: techniqueTypes, lastTimeRecipeOpened: lastTimeRecipeOpened, latitude: latitude, longitude: longitude, liquidColor: liquidColor, glassType: glassType)
}


func getNamesFromCLI() -> [String]? {
    print("Recipe name 입력(공백으로 구분, ex: 모스코 뮬, Moscow Mule):")
    let names = readLine()!.split(separator: ",")
        .map(String.init)
        .map{$0.trimmingCharacters(in: .whitespaces).precomposedStringWithCanonicalMapping}
    return names
}

func getIngredientsFromCLI() -> [Ingredient]? {
    
    var ingredients: [Ingredient] = []
    
    print("총 ingredients 수 입력:")
    guard let numIngredients = Int(readLine()!) else {
        return nil
    }
    if numIngredients <= 0 {
        return nil
    }
    
    for i in (0...numIngredients - 1) {
        print("ingredient[\(i)] names 입력(공백으로 구분, ex: 그레나딘 시럽, Grenadine Syrup):")
        let names = readLine()!.split(separator: ",")
            .map(String.init)
            .map{$0.trimmingCharacters(in: .whitespaces).precomposedStringWithCanonicalMapping}
        
        print("ingredient[\(i)] volume 입력(double):")
        guard let volume = Double(readLine()!) else {
            return nil
        }
        
        print("ingredient[\(i)] type 선택(숫자 입력):")
        var index = 0
        LiquidUnitType.allCases.forEach {type in
            print("\(index). \(type.rawValue)")
            index += 1
        }
        
        guard let ingredientIdx = Int(readLine()!) else {
            return nil
        }
        if ingredientIdx > LiquidUnitType.allCases.count {
            return nil
        }
        
        let type = LiquidUnitType.allCases[ingredientIdx]
        
        let ingredient = Ingredient(names: names, volume: volume, type: type)
        
        ingredients.append(ingredient)
    }
    
    return ingredients
}


func getTechniqueTypesFromCLI() -> [TechniqueType]? {
    var techniqueTypes: [TechniqueType] = []
    
    print("총 techniqueTypes 수 입력:")
    guard let numTechniqueTypes = Int(readLine()!) else {
        return nil
    }
    
    if numTechniqueTypes <= 0 {
        return nil
    }
    
    for i in (0...numTechniqueTypes - 1) {
        
        print("techniqueTypes[\(i)] type 선택(숫자 입력):")
        var index = 0
        TechniqueType.allCases.forEach {type in
            print("\(index). \(type.rawValue)")
            index += 1
        }
        
        guard let techniqueIndex = Int(readLine()!) else {
            return nil
        }
        if index > TechniqueType.allCases.count {
            return nil
        }
        
        let type = TechniqueType.allCases[techniqueIndex]
        
        techniqueTypes.append(type)
    }
    
    print(techniqueTypes)
    return techniqueTypes
}

func getLiquidColorTypeFromCLI() -> LiquidColorType? {

    print("LiquidColorType 선택(숫자 입력):")
    var i = 0
    LiquidColorType.allCases.forEach {type in
        print("\(i). \(type.rawValue)")
        i += 1
    }
    
    guard let index = Int(readLine()!) else {
        return nil
    }
    if index > LiquidColorType.allCases.count {
        return nil
    }
    
    return LiquidColorType.allCases[index]
}

func getGlassTypeFromCLI() -> GlassType? {

    print("GlassType 선택(숫자 입력):")
    var i = 0
    GlassType.allCases.forEach {type in
        print("\(i). \(type.rawValue)")
        i += 1
    }
    
    guard let index = Int(readLine()!) else {
        return nil
    }
    if index > GlassType.allCases.count {
        return nil
    }
    
    return GlassType.allCases[index]
}

func getRecipeInformationFromCLI() -> [RecipeProcess]? {
    var recipeProcesses: [RecipeProcess] = []
    
    print("총 recipeProcess 수 입력:")
    guard let numrecipeProcesses = Int(readLine()!) else {
        return nil
    }
    
    if numrecipeProcesses <= 0 {
        return nil
    }
    
    for i in (0...numrecipeProcesses - 1) {
        
        print("ingredient index 선택(ingredient 없을 경우 -1이나 공백 입력):")
        var ingredientIndex: Int? = Int(readLine()!)
        
        if ingredientIndex == nil {
            ingredientIndex = -1
        }
        
        print("동작 [\(i)] type 선택(숫자 입력):")
        var index = 0
        BehaviorType.allCases.forEach {type in
            print("\(index). \(type.rawValue)")
            index += 1
        }
        
        guard let behaviorIndex = Int(readLine()!) else {
            return nil
        }
        if index > BehaviorType.allCases.count {
            return nil
        }
        
        let type = BehaviorType.allCases[behaviorIndex]
        
        recipeProcesses.append(RecipeProcess(ingredientIndex: ingredientIndex!, behavior: type))
    }
    
    print(recipeProcesses)
    return recipeProcesses
    
    
    
}


