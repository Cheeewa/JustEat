module Model exposing (Model, Recipe, init)

type alias Recipe =
    { label : String
    , thumbnail : String
    , ingredients : List String
    }

type alias Model =
    { ingredients : String
    , recipes : List Recipe
    , selectedRecipe : Maybe Recipe
    }

init : Model
init =
    { ingredients = ""
    , recipes = []
    , selectedRecipe = Nothing }


