module View exposing (view)

<<<<<<< HEAD
import Html exposing (Html, div, input, button, text, ul, li, img ,h1, p , section)
import Html.Attributes exposing (placeholder, value, src , class)
=======
import Html exposing (Html, div, input, button, text, ul, li, img, a, h2)
import Html.Attributes exposing (href, placeholder, value, src)
>>>>>>> main
import Html.Events exposing (onClick, onInput)
import Model exposing (Model, Recipe)
import Msg exposing (Msg(..))
import Html exposing (h1)

view : Model -> Html Msg
view model =
<<<<<<< HEAD
    div [class "has-text-centered"]
        [ titleSection
        ,input [ placeholder "Enter ingredients", value model.ingredients, onInput UpdateIngredients ] []
        , button [ class "button is-primary", onClick FetchRecipes ] [ text "Get Recipes" ]
        , ul [] (List.map recipeItem model.recipes)
=======
    div []
        [ input [ placeholder "Enter ingredients", value model.ingredients, onInput UpdateIngredients ] []
        , button [ onClick FetchRecipes ] [ text "Get Recipes" ]
        , case model.selectedRecipe of
            Nothing ->
                ul [] (List.map (recipeItem model) model.recipes)

            Just recipe ->
                div []
                    [ button [ onClick DeselectRecipe ] [ text "Back to Recipes" ]
                    , h2 [] [ text recipe.label ]
                    , ul [] (List.map ingredientItem recipe.ingredients)
                    ]
>>>>>>> main
        ]

recipeItem : Model -> Recipe -> Html Msg
recipeItem model recipe =
    li []
        [ a [ href "#", onClick (SelectRecipe recipe) ] 
            [ img [ src recipe.thumbnail ] []
            , text recipe.label
            ]
        ]

<<<<<<< HEAD
titleSection : Html Msg
titleSection =
    section [class "section"]
        [div[]
            [h1 [class "title"][text "WELCOME TO JUSTEAT"]]
        ]
=======
ingredientItem : String -> Html Msg
ingredientItem ingredient =
    li [] [ text ingredient ]
>>>>>>> main
