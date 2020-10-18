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
    
    print(jsonString)

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

func getRecipesFromJSONFile() -> [Recipe]? {
    
    guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
    let fileLocation = documentDirectoryUrl.appendingPathComponent("RecipeData.json")
    
    do {
        let data = try Data(contentsOf: fileLocation)
        let jsonDecoder = JSONDecoder()
        let dataFromJson = try jsonDecoder.decode([Recipe].self, from: data)
        return dataFromJson
    } catch {
        print(error)
    }
    
    return nil
}
