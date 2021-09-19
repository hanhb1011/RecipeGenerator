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
    
    let savedRecipes: [Recipe] = getRecipesFromJSONFile()
    
    let updatedRecipes = savedRecipes.map { recipe -> Recipe in
        var newRecipe: Recipe = recipe
        newRecipe.lastTimeRecipeOpened = nil
        return newRecipe
    }
    saveRecipesToJSONFile(recipes: updatedRecipes)
}
