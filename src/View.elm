module View exposing (view)

import Html exposing (Html, div, input, button, text, ul, li, img ,h1, p , section)
import Html.Attributes exposing (placeholder, value, src , class)
import Html.Events exposing (onClick, onInput)
import Model exposing (Model, Recipe)
import Msg exposing (Msg(..))
import Html exposing (h1)

view : Model -> Html Msg
view model =
    div []
        [ titleSection
        ,input [ placeholder "Enter ingredients", value model.ingredients, onInput UpdateIngredients ] []
        , button [ class "button is-primary has-text-centered", onClick FetchRecipes ] [ text "Get Recipes" ]
        , ul [class "has-text-centered"] (List.map recipeItem model.recipes)
        ]

recipeItem : Recipe -> Html Msg
recipeItem recipe =
    li []
        [ img [ src recipe.image ] []
        , text recipe.label
        ]




titleSection : Html Msg
titleSection =
    section [class "section has-text-centered"]
        [div[]
            [h1 [class "title"][text "WELCOME TO JUSTEAT"]]
        ]