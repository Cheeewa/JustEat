module View exposing (view)

import Html exposing (Html, div, input, button, text, ul, li, img, a, h2, h1, p)
import Html.Attributes exposing (href, placeholder, value, src, class)
import Html.Events exposing (onClick, onInput)
import Model exposing (Model, Recipe)
import Msg exposing (Msg(..))
import Html exposing (section)

view : Model -> Html Msg
view model =
    div [class "has-text-centered"]
        [introduction
        ,input [ placeholder "Enter ingredients", value model.ingredients, onInput UpdateIngredients] []
        ,button [ class "button is-primary", onClick FetchRecipes] [ text "Get Recipes" ]
        , case model.selectedRecipe of
            Nothing ->
                ul [] (List.map (recipeItem model) model.recipes)

            Just recipe ->
                div []
                    [ button [ onClick DeselectRecipe ] [ text "Back to Recipes" ]
                    , h2 [] [ text recipe.label ]
                    , ul [] (List.map ingredientItem recipe.ingredients)
                    ]
        ]

recipeItem : Model -> Recipe -> Html Msg
recipeItem model recipe =
    li []
        [ a [ href "#", onClick (SelectRecipe recipe) ] 
            [ img [ src recipe.thumbnail ] []
            , text recipe.label
            ]
        ]

ingredientItem : String -> Html Msg
ingredientItem ingredient =
    li [] [ text ingredient ]
introduction : Html Msg
introduction =
    section [class "section"]
        [  div[class "box"][h1 [class "title"][ text "Welcome to JustEat!"]
                    , h2 [class "title is-4"] [text"Are you hungry and want to clear your refrigerator?"]
                    , p [][text "At JustEat, we help you make the most out of what you already have. Simply enter the ingredients you have on hand, and we'll suggest delicious recipes you can whip up in no time."]
                    , p [][text "Say goodbye to food waste and hello to creativity in the kitchen!"]
                    ] 
        ]

