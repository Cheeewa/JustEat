module View exposing (view)

import Html exposing (Html, div, input, button, text, ul, li, img)
import Html.Attributes exposing (placeholder, value, src)
import Html.Events exposing (onClick, onInput)
import Model exposing (Model, Recipe)
import Msg exposing (Msg(..))
import Html exposing (h1)

view : Model -> Html Msg
view model =
    div []
        [ h1[][text "WELCOME TO JUST EAT"]
        ,input [ placeholder "Enter ingredients", value model.ingredients, onInput UpdateIngredients ] []
        , button [ onClick FetchRecipes ] [ text "Get Recipes" ]
        , ul [] (List.map recipeItem model.recipes)
        ]

recipeItem : Recipe -> Html Msg
recipeItem recipe =
    li []
        [ img [ src recipe.image ] []
        , text recipe.label
        ]
