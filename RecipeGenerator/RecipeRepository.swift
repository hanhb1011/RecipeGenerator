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
    
    
    for i in (0..<recipes.count) {
        if (recipes[i].liquidColor == .none || recipes[i].liquidColor == .yellow || recipes[i].liquidColor == .white) {
            
            
            print(recipes[i].names)
            print(recipes[i].liquidColor)
            print("바꿉니까? 1 / any number  >>")
            guard let index = Int(readLine()!) else {
                continue
            }
            
            if (1 == index) {
                recipes[i].liquidColor = .lightYellow
            }
            
            print(recipes[i])
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
        
        glassDictionary[glassType]?.insert(color)
    }
    
    //3. print color dict.
    
    print(glassDictionary)
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
