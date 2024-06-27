module Model exposing (Model, Recipe, init)

type alias Recipe =
    { label : String
    , image : String
    }

type alias Model =
    { ingredients : String
    , recipes : List Recipe
    }

init : Model
init =
    { ingredients = ""
    , recipes = [] }
