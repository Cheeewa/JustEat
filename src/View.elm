module View exposing (view)

import Html exposing (Html, div, input, button, text, ul, li, img, a, h2, h1, p, table, thead, tbody, tr, th, td ,section)
import Html.Attributes exposing (href, placeholder, value, src, class)
import Html.Events exposing (onClick, onInput)
import Model exposing (Model, Recipe)
import Msg exposing (Msg(..))

view : Model -> Html Msg
view model =
    div [class "has-text-centered"]
        [ introduction
        , div [class "field"]
            [ input [ placeholder "Enter ingredients", value model.ingredients, onInput UpdateIngredients ] []
            , p[][]
            , button [ class "button is-primary", onClick FetchRecipes ] [ text "Get Recipes" ]
            ]
        , case model.selectedRecipe of
            Nothing ->
                recipesTable model.recipes

            Just recipe ->
                div []
                    [ button [ onClick DeselectRecipe ] [ text "Back to Recipes" ]
                    , h2 [] [ text recipe.label ]
                    , ul [] (List.map ingredientItem recipe.ingredients)
                    ]
        ]

recipesTable : List Recipe -> Html Msg
recipesTable recipes =
    table [ class "table is-fullwidth" ]
        [ thead []
            [ tr []
                [ th [] [ text "Image" ]
                , th [] [ text "Recipe" ]
                ]
            ]
        , tbody [] (List.map recipeRow recipes)
        ]

recipeRow : Recipe -> Html Msg
recipeRow recipe =
    tr []
        [ td [] [ img [ src recipe.thumbnail, class "64x64", class "has-text-cenetered"] [] ]
        , td [] [ a [ href "#", onClick (SelectRecipe recipe) ] [ text recipe.label ] ]
        ]

ingredientItem : String -> Html Msg
ingredientItem ingredient =
    li [] [ text ingredient ]

introduction : Html Msg
introduction =
    section [ class "section" ]
        [ div [ class "box" ]
            [ h1 [ class "title" ] [ text "Welcome to JustEat!" ]
            , h2 [ class "title is-4" ] [ text "Are you hungry and want to clear your refrigerator?" ]
            , p [] [ text "At JustEat, we help you make the most out of what you already have. Simply enter the ingredients you have on hand, and we'll suggest delicious recipes you can whip up in no time." ]
            , p [] [ text "Say goodbye to food waste and hello to creativity in the kitchen!" ]
            ]
        ]

logo : Html Msg
logo =
    div [ class "box" ]
        [ img [ class "is-round image is-64x64", src "docs/logo.png" ] [] ]