module Msg exposing (Msg(..))
import Http

type Msg
    = UpdateIngredients String
    | FetchRecipes
    | ReceiveRecipes (Result Http.Error (List String))
