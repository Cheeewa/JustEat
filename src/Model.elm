module Model exposing (Model, init)

type alias Model =
    { ingredients : String
    , recipes : List String
    }

init : Model
init =
    { ingredients = ""
    , recipes = [] }
