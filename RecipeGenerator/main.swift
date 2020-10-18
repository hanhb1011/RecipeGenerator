//
//  main.swift
//  RecipeGenerator
//
//  Created by 한효병 on 2020/10/17.
//

import Foundation

//ingredientTypeUT()


var recipes: [Recipe] = getRecipesFromJSONFile()

var recipe = makeRecipeFromCommandLine()

if recipe != nil {
    recipes.append(recipe!)
}

saveRecipesToJSONFile(recipes: recipes)

