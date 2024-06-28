module View exposing (view)

import Html exposing (Html, div, input, button, text, ul, li, img ,h1, p , section)
import Html.Attributes exposing (placeholder, value, src , class)
import Html.Events exposing (onClick, onInput)
import Model exposing (Model, Recipe)
import Msg exposing (Msg(..))
import Html exposing (h1)

view : Model -> Html Msg
view model =
    div [class "has-text-centered"]
        [ titleSection
        ,input [ placeholder "Enter ingredients", value model.ingredients, onInput UpdateIngredients ] []
        , button [ class "button is-primary", onClick FetchRecipes ] [ text "Get Recipes" ]
        , ul [] (List.map recipeItem model.recipes)
        ]

recipeItem : Recipe -> Html Msg
recipeItem recipe =
    li []
        [ img [ src recipe.image ] []
        , text recipe.label
        ]

titleSection : Html Msg
titleSection =
    section [class "section"]
        [div[]
            [h1 [class "title"][text "WELCOME TO JUSTEAT"]]
        ]