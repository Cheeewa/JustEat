module View exposing (view)

import Html exposing (Html, div, input, button, text, ul, li, img, a, h2, h1, p, table, thead, tbody, tr, th, td ,section , br)
import Html.Attributes exposing (href, placeholder, value, src, class)
import Html.Events exposing (onClick, onInput)
import Model exposing (Model, Recipe)
import Msg exposing (Msg(..))
import Design exposing (introduction, recipesTable )

view : Model -> Html Msg
view model =
    div [ class "has-text-centered"]
        [ introduction
        , entertoGetIngredients model
        , if model.ingredients /= "" && not (List.isEmpty model.recipes) then   --if ingredients wont get any input and recipe still empty
            case model.selectedRecipe of
                Nothing ->
                    recipesTable model.recipes

                Just recipe ->
                    div []
                        [ button [ onClick DeselectRecipe ] [ text "Back to Recipes" ]
                        , h2 [] [ text recipe.label ]
                        , ul [] (List.map ingredientItem recipe.ingredients)
                     ]
            else
                div[][br[][]
                     , text "Ready to find recipes?"
                     , br[][]
                     , text "Please enter one ingredient from your fridge to get cooking ideas! "
                     ]
        ]

entertoGetIngredients : Model -> Html Msg
entertoGetIngredients model = 
            div []
            [ input [ placeholder "Enter ingredients", value model.ingredients, onInput UpdateIngredients ] []
            , br[][]
            , br[][]
            , button [ class "button is-warning", onClick FetchRecipes ] [ text "Get Recipes" ]
            ]


ingredientItem : String -> Html Msg
ingredientItem ingredient =
    li [] [ text ingredient ]
