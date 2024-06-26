module Api exposing (fetchRecipes)

import Http
import Json.Decode as Decode
import Msg exposing (Msg(..))
import Model exposing (Recipe)

recipeDecoder : Decode.Decoder Recipe
recipeDecoder =
    Decode.map3 Recipe
        (Decode.field "label" Decode.string)
        (Decode.field "image" Decode.string)

        {-could be modify to use Thumbnail instead, need new decoder implementation
         something like "images" (Decode.list (
                            Decode.field "THUMBNAIL" (Decode.list (
                                Decode.field "url" Decode.string)))) 
        -}
        
        (Decode.field "ingredientLines" (Decode.list Decode.string))

recipesDecoder : Decode.Decoder (List Recipe)
recipesDecoder =
    Decode.field "hits" (Decode.list (Decode.field "recipe" recipeDecoder))

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
