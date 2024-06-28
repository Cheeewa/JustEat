module Msg exposing (Msg(..))

import Http
import Model exposing (Recipe)

type Msg
    = UpdateIngredients String
    | FetchRecipes
    | ReceiveRecipes (Result Http.Error (List Recipe))
    | SelectRecipe Recipe
    | DeselectRecipe
