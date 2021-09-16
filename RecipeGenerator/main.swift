//
//  main.swift
//  RecipeGenerator
//
//  Created by 한효병 on 2020/10/17.
//

import Foundation

//ingredientTypeUT()
enum CommandType: CaseIterable {
    case create
    case read
    case update
    case delete
    case printIngredients
    case createClassification
    case printClassification
    case test
}

while true {
    print("================================")
    print("0. 레시피 생성")
    print("1. 저장된 레시피 출력")
    print("2. 레시피 업데이트 (미구현)")
    print("3. 레시피 제거")
    print("4. 재료 출력 & 저장")
    print("5. 분류 생성")
    print("6. 분류 출력")
    print("7. 시간초기화")
    print("command 입력(숫자):")
    
    guard let index = Int(readLine()!) else {
        continue
    }
    
    if index > CommandType.allCases.endIndex || index < 0 {
        continue
    }
    
    let command = CommandType.allCases[index]
    
    switch command {
    case .create:
        var recipes: [Recipe] = getRecipesFromJSONFile()
        let recipe = makeRecipeFromCommandLine()
        
        if recipe != nil {
            recipes.append(recipe!)
            saveRecipesToJSONFile(recipes: recipes)
        }
        
    case .read:
        printRecipeNames()
        
    case .update:
        print("미구현")
        
    case .delete:
        print("삭제할 Recipe name 입력")
        let name = readLine()!
        let result = deleteRecipeByName(name: name)
        if result == true {
            print("삭제 성공")
        } else {
            print("삭제 실패")
        }
        
    case .printIngredients:
        saveIngredients()
        
    case .createClassification:
        createClassification()
        
    case .printClassification:
        printClassification()
        
    }
    
    
}
