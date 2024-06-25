module Api exposing (fetchRecipes)

import Http
import Json.Decode as Decode
import Msg exposing (Msg(..))

type alias Recipe =
    { label : String }

recipeDecoder : Decode.Decoder String
recipeDecoder =
    Decode.field "recipe" (Decode.field "label" Decode.string)

recipesDecoder : Decode.Decoder (List String)
recipesDecoder =
    Decode.field "hits" (Decode.list recipeDecoder)

fetchRecipes : String -> Cmd Msg
fetchRecipes ingredients =
    let
        url =
            "https://api.edamam.com/search?q="
                ++ ingredients
                ++ "&app_id=2bd6b567&app_key=f4929fb1d1b798798f27bef6e8bf956e"
    in
    Http.get
        { url = url
        , expect = Http.expectJson ReceiveRecipes recipesDecoder
        }
