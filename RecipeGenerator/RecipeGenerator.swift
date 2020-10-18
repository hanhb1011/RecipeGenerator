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
    let recipeInformation: String = "recipe information"
    //let techniqueTypes: [TechniqueType]
    let lastTimeRecipeOpened: Date = Date()
    let latitude: Double = 0.0
    let longitude: Double = 0.0
    //let liquidColor: LiquidColorType
    //let glassType: GlassType
    
    print("=======================================================")
    print("중단하려면 마우것도 입력하지 않고 엔터 입력!")
    
    //TODO: redundancy check.
    names = getNamesFromCLI()!
    if names.isEmpty {
        print("취소됨!")
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
    print("Recipe name 입력(공백으로 구분, ex: 맨해튼 맨하탄 Manhattan):")
    let names = readLine()!.split(separator: " ").map(String.init)
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
        print("ingredient[\(i)] name 입력:")
        guard let name = readLine() else {
            return nil
        }
        
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
        
        let ingredient = Ingredient(name: name, volume: volume, type: type)
        
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



func updateRecipe(recipe: Recipe) {
    
    let savedRecipes: [Recipe] = loadSavedRecipes()
    
    let changedRecipes = savedRecipes.map { (currentRecipe) -> Recipe in
        if (recipe.name == currentRecipe.name) {
            var modifiedRecipe = currentRecipe
            modifiedRecipe = recipe
            return modifiedRecipe
        }
        else {
            return currentRecipe
        }
    }
    
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(changedRecipes) {
        let defaults = UserDefaults.standard
        defaults.set(encoded, forKey: "SavedRecipes")
    }
    
}
    
func findRecipeById(id: UUID) -> Recipe {
    let savedRecipes: [Recipe] = loadSavedRecipes()
    var foundedRecipe: Recipe!
    
    savedRecipes.forEach { recipe in
        if (recipe.id == id) {
            foundedRecipe = recipe
        }
    }
    
    return foundedRecipe
}
