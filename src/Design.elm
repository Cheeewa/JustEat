module Design exposing (..)

import Html exposing (Html, div, input, button, text, ul, li, img, a, h2, h1, p, table, thead, tbody, tr, th, td ,section , br)
import Html.Attributes exposing (href, placeholder, value, src, class ,style)
import Html.Events exposing (onClick, onInput)
import Model exposing (Model, Recipe)
import Msg exposing (Msg(..))
import Svg as S exposing (svg, rect, image, text_)
import Svg.Attributes as SA exposing (width, height, viewBox, x, y, fill , stroke, strokeWidth, xlinkHref, fontSize, textAnchor, dy )
import Svg exposing (foreignObject)




svgBox : Html Msg
svgBox =
    svg [ SA.width "420", SA.height "420", viewBox "0 0 400 400" ]
        [ --rect [ x "10", y "10", SA.width "180", SA.height "180", fill "none", stroke "black", strokeWidth "3" ] []
        --, S.image [ x "200", y "200", SA.width "140", SA.height "140", SA.xlinkHref "http://www.informatik.uni-halle.de/im/1285058520_1381_00_800.jpg"] []
        --, S.image [x "50", y"10", SA.width "100" ,SA.height "180",  SA.xlinkHref "docs/logo.png"][]
        --, svgLogo
        --, 
        foreignObject [ x "0", y "0", width "400" , height "400"]
            [ div [ --class "has-text-centered" , style "background" "white", style "padding" "10px" 
                    class "has-text-centered" --,  style "padding" "10px" 
                ]
                [br[][],introduction ]
            ]
        --, text_ [ x "100", y "100", fontSize "20", textAnchor "middle", fill "black", dy ".3em" ][ introduction ]
         --,img[href ""http://www.informatik.uni-halle.de/im/1285058520_1381_00_800.jpg"][]
        ]
--logo : Html Msg
--logo =
  --   img [ class "is-round image is-96x96", src "docs/logo.png" ] [] 

svgLogo : Html Msg
svgLogo =
    svg [ width "100%", height "150", viewBox "0 0 90 90" , style "background" "orange"]
        [ --rect [x "0", y "0", width "100", height "100", stroke "black" , strokeWidth"3", fill "none"][]
        --, 
        image [ x "0", y"0", width "128", height "128", xlinkHref "docs/logo.png" , stroke "black"] [] 
        ]

introduction : Html Msg
introduction =
    section [ --class "section", class "has-background-warning ", class "box"
            ]
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
