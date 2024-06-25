module View exposing (view)

import Html exposing (Html, div, input, button, text, ul, li)
import Html.Attributes exposing (placeholder, value)
import Html.Events exposing (onClick, onInput)
import Model exposing (Model)
import Msg exposing (Msg(..))

view : Model -> Html Msg
view model =
    div []
        [ input [ placeholder "Enter ingredients", value model.ingredients, onInput UpdateIngredients ] []
        , button [ onClick FetchRecipes ] [ text "Get Recipes" ]
        , ul [] (List.map recipeItem model.recipes)
        ]

recipeItem : String -> Html Msg
recipeItem recipe =
    li [] [ text recipe ]
