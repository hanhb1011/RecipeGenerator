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
}

while true {
    print("================================")
    print("0. 레시피 생성")
    print("1. 저장된 레시피 출력")
    print("2. 레시피 업데이트 (미구현)")
    print("3. 레시피 제거")
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
        }
        saveRecipesToJSONFile(recipes: recipes)
        
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
    }
    
    

}
