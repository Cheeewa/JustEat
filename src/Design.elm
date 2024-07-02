module Design exposing (..)

import Html exposing (Html, div, input, button, text, ul, li, img, a, h2, h1, p, table, thead, tbody, tr, th, td ,section , br)
import Html.Attributes exposing (href, placeholder, value, src, class ,style)
import Html.Events exposing (onClick, onInput)
import Model exposing (Model, Recipe)
import Msg exposing (Msg(..))

logo : Html Msg
logo =
    div [ class "box" ]
        [ img [ class "is-round image is-64x64", src "docs/logo.png" ] [] ]

introduction : Html Msg
introduction =
    section [ class "section", class "has-background-warning ", class "box"]
            [ h1 [ class "title" ] [ text "WELCOME TO JUSTEAT!" ]
            , h2 [ class "title is-4" ] [ text "Are you hungry and want to clear your refrigerator?" ]
            , p [] [ text "At JustEat, we help you make the most out of what you already have. Simply enter the ingredients you have on hand"]
            , p [] [ text "and we'll suggest delicious recipes you can whip up in no time." ]
            , p [] [ text "Say goodbye to food waste and hello to creativity in the kitchen!" ]
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
        [ td [] [ img [ src recipe.thumbnail, class "128x128", class "has-text-cenetered"] [] ]
        , td [] [ a [ href "#", onClick (SelectRecipe recipe) ] [ text recipe.label ] ]
        ]

ingredientItem : String -> Html Msg
ingredientItem ingredient =
    li [] [ text ingredient ]

entertogetrecipe : Model -> Html Msg
entertogetrecipe model =
    div []
            [ input [ placeholder "Enter ingredients"
                    , style "padding" "40px 40px"
                    , value model.ingredients
                    , onInput UpdateIngredients ] []
            , br[][]
            , br[][]
            --class "button is-warning"
            , button [ class "button is-warning"--style "background-color" "orange", style "padding" "20px 30px"
                     , onClick FetchRecipes 
                     ] 
                     [ text "Get Recipes" ]
            ]

