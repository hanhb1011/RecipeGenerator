//
//  JSONRepository.swift
//  RecipeGenerator
//
//  Created by 한효병 on 2020/10/17.
//

import Foundation



func saveRecipesToJSONFile(recipes: [Recipe]) {
    
    let jsonEncoder = JSONEncoder()
    let jsonString: String!
    do {
        let jsonData = try jsonEncoder.encode(recipes)
        jsonString = String(data: jsonData, encoding: String.Encoding.utf8)!
    } catch {
        print("file save error")
        return
    }
    
    //print(jsonString)
    
    // Create data to be saved
    let data = jsonString.data(using: .utf8)!
    
    guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
    let fileUrl = documentDirectoryUrl.appendingPathComponent("RecipeData.json")
    
    do {
        try data.write(to: fileUrl, options: [])
        print("saved: \(documentDirectoryUrl.absoluteURL)")
    } catch {
        print(error)
    }
}

func getRecipesFromJSONFile() -> [Recipe] {
    
    guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return [] }
    let fileLocation = documentDirectoryUrl.appendingPathComponent("RecipeData.json")
    
    do {
        let data = try Data(contentsOf: fileLocation)
        let jsonDecoder = JSONDecoder()
        let dataFromJson = try jsonDecoder.decode([Recipe].self, from: data)
        return dataFromJson
    } catch {
        print(error)
    }
    
    return []
}

func deleteRecipeByName(name: String) -> Bool {
    
    var savedRecipes: [Recipe] = getRecipesFromJSONFile()
    var index = 0
    
    for recipe in savedRecipes {
        
        if recipe.names.contains(name.precomposedStringWithCanonicalMapping) {
            savedRecipes.remove(at: index)
            saveRecipesToJSONFile(recipes: savedRecipes)
            return true
        }
        
        index += 1
    }
    
    return false
}

func updateRecipe(recipe: Recipe) {
    let savedRecipes: [Recipe] = getRecipesFromJSONFile()
    
    let changedRecipes = savedRecipes.map { (currentRecipe) -> Recipe in
        if (recipe.id == currentRecipe.id) { //TODO
            var modifiedRecipe = currentRecipe
            modifiedRecipe = recipe
            return modifiedRecipe
        }
        else {
            return currentRecipe
        }
    }
    
    saveRecipesToJSONFile(recipes: changedRecipes)
}


func findRecipeByNames(names: [String]) -> Recipe? {
    for name in names {
        let recipes: [Recipe] = getRecipesFromJSONFile()
        
        for recipe in recipes {
            if recipe.names.contains(name) {
                return recipe
            }
        }
    }
    
    return nil
}

func printRecipeNames() {
    
    let recipes: [Recipe] = getRecipesFromJSONFile()
    var index = 0
    print("====================================")
    
    for recipe in recipes {
        print("[\(index)] \(recipe.names)")
        index += 1
    }
    
}

func updateAllrecipes() {
    
    var recipes: [Recipe] = getRecipesFromJSONFile()
    
    var count = 0
    var currentCount = 0
    for i in (0..<recipes.count) {
        if ((recipes[i].liquidColor == .brown) || (recipes[i].liquidColor == .black))
        {
            count += 1
        }
    }
    print("total count: \(count)")
    
    for i in (0..<recipes.count) {
        if ((recipes[i].glassType == .oldFashonedGlass) && (recipes[i].liquidColor == .none))
        {
            currentCount += 1
            
            print("\(recipes[i].names[0]) \(currentCount) / \(count) change? (1 any character)")
            let input = Int(readLine()!)
            
            if (1 == input) {
                print("changed to \(recipes[i].liquidColor)")
            }
        }
    }
    
    saveRecipesToJSONFile(recipes: recipes)
}

func printAllGlasses() {
    let recipes: [Recipe] = getRecipesFromJSONFile()
    
    //1. color dictionary
    var glassDictionary: [GlassType:Set<LiquidColorType>] = [:]
    GlassType.allCases.forEach { type in
        glassDictionary[type] = []
    }
    //2. build color dict.
    
    recipes.forEach { recipe in
        let glassType = recipe.glassType
        let color = recipe.liquidColor
        
        if (glassDictionary[glassType] != nil) {
            glassDictionary[glassType]?.insert(color)
        }
    }
    
    //3. print color dict.
    glassDictionary.forEach { dict in
        print(dict)
    }
    
    /*
    let glassList:[GlassType] = [.sourGlass, .stemmedLiqueurGlass, .sherryGlass]
    
    glassList.forEach { glassType in
        print(glassType)
        for i in (0..<recipes.count) {
            if (recipes[i].glassType == glassType) {
                print("\(recipes[i].names[0]) color: \(recipes[i].liquidColor.rawValue)")
            }
        }
    }
    
     */
    GlassType.allCases.forEach { glassType in
        print("Type: \(glassType.rawValue)")
        for i in (0..<recipes.count) {
            if (recipes[i].glassType == glassType) {
                print("\(recipes[i].names[0]) color: \(recipes[i].liquidColor.rawValue)")
            }
        }
        print("")
    }
    
    print("\nmixed color")
    recipes.forEach { recipe in
        let glassType = recipe.glassType
        let color = recipe.liquidColor
        
        if (color == .mixed) {
            print("name: \(recipe.names[0]) glasstype: \(glassType)")
        }
    }
    
    printAllImageNames()
}


func getNameOfGlass(glassType: GlassType) -> String {
    var adjsutedGlassType: String = glassType.rawValue
    
    /*
     stemmedLiqueurGlass -> sherryGlass
     cocktailGlass
     oldFashonedGlass
     highballGlass
     footedPilsnerGlass
     sourGlass
     collinsGlass
     sherryGlass
     champagneGlass
     whiteWineGlass
     */
    
    switch (glassType) {
    case .sourGlass:
        adjsutedGlassType = "whiteWineGlass"
    case .stemmedLiqueurGlass:
        adjsutedGlassType = "shotGlass"
    case .cocktailGlass:
        break
    case .oldFashonedGlass:
        break
    case .highballGlass:
        break
    case .footedPilsnerGlass:
        adjsutedGlassType = "highballGlass"
    case .collinsGlass:
        adjsutedGlassType = "highballGlass"
    case .sherryGlass:
        adjsutedGlassType = "shotGlass"
        break
    case .champagneGlass:
        break
    case .whiteWineGlass:
        break
    }
    
    return adjsutedGlassType
}

func getImageNameOfMixedColor(recipe: Recipe) -> String {
    
    if (recipe.names[0] == "커비 블루") {
        return "Cubby Blue"
    }
    else if (recipe.names[0] == "B-52") {
        return "B-52"
    }
    
    return recipe.names[1]
}

func isValidName(imageName: String) -> Bool {
    return true
}

func getCocktailImageName(recipe: Recipe) -> String {
    let glass: String = getNameOfGlass(glassType: recipe.glassType)
    let liquidColor: String = recipe.liquidColor.rawValue
    var imageName: String
    
    if (.mixed == recipe.liquidColor) {
        imageName = getImageNameOfMixedColor(recipe: recipe)
    } else {
        imageName = glass + "_" + liquidColor
    }
    
    //check
    if (true == isValidName(imageName: imageName)) {
        return imageName
    } else {
        return glass + "_none"
    }
    
}

func printAllImageNames() -> Void {
    let recipes: [Recipe] = getRecipesFromJSONFile()
    
    recipes.forEach { recipe in
        print("recipe name: \(recipe.names[0]), image name: " + getCocktailImageName(recipe: recipe))
    }
}

func printTargetIngredients(target: String) {
    let recipes: [Recipe] = getRecipesFromJSONFile()
    
    for i in (0..<recipes.count) {
        
        for j in (0..<recipes[i].ingredients.count) {
            for k in (0..<recipes[i].ingredients[j].names.count) {
                var found = false
                if (recipes[i].ingredients[j].names[k].contains(target)) {
                    found = true
                }
                
                if (found) {
                    print(recipes[i].ingredients[j].names)
                }
            }
        }
    }
    
}

func printAllIngredients(target: String) {
    let recipes: [Recipe] = getRecipesFromJSONFile()
    
    for i in (0..<recipes.count) {
        for j in (0..<recipes[i].ingredients.count) {
            print(recipes[i].ingredients[j].names)
        }
    }
    
}

func updateGarnish() {
    var recipes: [Recipe] = getRecipesFromJSONFile()
    
    for i in (0..<recipes.count) {
        print("\(recipes[i].names[0]) garnish 입력 (없으면 엔터): ")
        
        let garnish: String = readLine()!.trimmingCharacters(in: .whitespaces).precomposedStringWithCanonicalMapping
        
        if (garnish.count != 0) {
            recipes[i].garnish = garnish
        }
        
        print(recipes[i].garnish)
    }
    
    saveRecipesToJSONFile(recipes: recipes)
}
