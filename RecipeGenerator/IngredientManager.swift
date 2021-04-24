//
//  IngredientManager.swift
//  RecipeGenerator
//
//  Created by 한효병 on 2021/03/14.
//

import Foundation

func getIngredientsFromJSONFile() -> [String] {
    
    guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return [] }
    let fileLocation = documentDirectoryUrl.appendingPathComponent("Ingredients.json")
    
    do {
        let data = try Data(contentsOf: fileLocation)
        let jsonDecoder = JSONDecoder()
        let dataFromJson = try jsonDecoder.decode([String].self, from: data)
        return dataFromJson
    } catch {
        print(error)
    }
    
    return []
}

func saveIngredientsToJSONFile(ingredients: [String]) {
    
    let jsonEncoder = JSONEncoder()
    let jsonString: String!
    do {
        let jsonData = try jsonEncoder.encode(ingredients)
        jsonString = String(data: jsonData, encoding: String.Encoding.utf8)!
    } catch {
        print("file save error")
        return
    }
    
    //print(jsonString)

    // Create data to be saved
    let data = jsonString.data(using: .utf8)!

    guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
    let fileUrl = documentDirectoryUrl.appendingPathComponent("Ingredients.json")
    
    do {
        try data.write(to: fileUrl, options: [])
        print("saved: \(documentDirectoryUrl.absoluteURL)")
    } catch {
        print(error)
    }
}

func getIngredients() -> [String] {
    let recipes = getRecipesFromJSONFile()
    var ingredients: [String] = []
    
    recipes.forEach { recipe in
        recipe.ingredients.forEach { item in
            let ingredient: String = item.names[0]
            
            if false == ingredients.contains(ingredient) {
                ingredients.append(ingredient)
            }
        }
    }
    
    return ingredients
}

func saveIngredients() {
    let ingredients = getIngredients()
    print(ingredients)
    
    
    saveIngredientsToJSONFile(ingredients: ingredients)
}

func getClassificationsFromJSONFile() -> [Classification] {
    
    guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return [] }
    let fileLocation = documentDirectoryUrl.appendingPathComponent("Classifications.json")
    
    do {
        let data = try Data(contentsOf: fileLocation)
        let jsonDecoder = JSONDecoder()
        let dataFromJson = try jsonDecoder.decode([Classification].self, from: data)
        return dataFromJson
    } catch {
        print(error)
    }
    
    return []
}

func saveClassificationsToJSONFile(classifications: [Classification]) {
    
    let jsonEncoder = JSONEncoder()
    let jsonString: String!
    do {
        let jsonData = try jsonEncoder.encode(classifications)
        jsonString = String(data: jsonData, encoding: String.Encoding.utf8)!
    } catch {
        print("file save error")
        return
    }
    
    //print(jsonString)

    // Create data to be saved
    let data = jsonString.data(using: .utf8)!

    guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
    let fileUrl = documentDirectoryUrl.appendingPathComponent("Classifications.json")
    
    do {
        try data.write(to: fileUrl, options: [])
        print("saved: \(documentDirectoryUrl.absoluteURL)")
    } catch {
        print(error)
    }
}

func createClassification() {
    
    let ingredients : [String] = getIngredients()
    var classifications: [Classification] = [Classification(index: 0, name: "기주")
                                             , Classification(index: 1, name: "리큐어")
                                             , Classification(index: 2, name: "주스")
                                             , Classification(index: 3, name: "기타")]
    
    ingredients.forEach { ingredient in
        print("name: \(ingredient) 분류 선택 (0: 기주, 1: 리큐어, 2: 주스, 3: 기타) -> ")
        
        guard let idx = Int(readLine()!) else {
            print("입력이 잘못되었습니다.")
            return
        }
        
        classifications[idx].ingredientSearchItems.append(ingredient)
        
    }
    
    print(classifications)
    saveClassificationsToJSONFile(classifications: classifications)
    
}

func printClassification() {
    let clssifications = getClassificationsFromJSONFile()
    print(clssifications)
}
