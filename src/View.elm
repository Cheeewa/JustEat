module View exposing (view)

import Html exposing (Html, div, input, button, text, ul, li, img, a,h1,h2,section)
import Html.Attributes exposing (href, placeholder, value, src ,class)
import Html.Events exposing (onClick, onInput)
import Model exposing (Model, Recipe)
import Msg exposing (Msg(..))

view : Model -> Html Msg
view model =
    div [class "has-text-centered"]
        [titelSection 
        ,input [ placeholder "Enter ingredients", value model.ingredients, onInput UpdateIngredients ] []
        , button [ class "button is-primary", onClick FetchRecipes ] [ text "Get Recipes" ]
        , case model.selectedRecipe of
            Nothing ->
                ul [] (List.map (recipeItem model) model.recipes)

            Just recipe ->
                div []
                    [ button [onClick DeselectRecipe ] [ text "Back to Recipes" ]
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

titelSection : Html Msg
titelSection =
    section[class "section"]
        [div[][h1[class"title"][text"Hello"]]]