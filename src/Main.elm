module Main exposing (main)

import Browser
import Url
import Browser.Navigation as Nav
import Http
import Html exposing (Html, div, input, button, text, ul, li, img, a, h2, h1, p, table, thead, tbody, tr, th, td ,section , br)
import Html.Attributes exposing (href, placeholder, value, src, class ,style)
import Html.Events exposing (onClick, onInput)
import Json.Decode as Decode
import Svg as S exposing (svg, rect, image, text_)
import Svg.Attributes as SA exposing (width, height, viewBox, x, y, fill , stroke, strokeWidth, xlinkHref, fontSize, textAnchor, dy, opacity )
import Svg exposing (foreignObject)




-- Decoder


recipeDecoder : Decode.Decoder Recipe
recipeDecoder =
    Decode.map4 Recipe
        (Decode.field "label" Decode.string)
        (Decode.field "image" Decode.string)
        (Decode.field "ingredientLines" (Decode.list Decode.string))
        (Decode.field "url" Decode.string)

recipesDecoder : Decode.Decoder (List Recipe)
recipesDecoder =
    Decode.field "hits" (Decode.list (Decode.field "recipe" recipeDecoder))

fetchRecipes : String -> Cmd Msg
fetchRecipes ingredients =
    let
        url =
            "https://api.edamam.com/search?q="
                ++ ingredients
                ++ "&app_id=2bd6b567&app_key=f4929fb1d1b798798f27bef6e8bf956e"
    in
    Http.get
        { url = url
        , expect = Http.expectJson ReceiveRecipes recipesDecoder
        }



-- MAIN


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , update = update
        , view = view
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        , subscriptions = subscriptions
        }



-- MODEL


type alias Recipe =
    { label : String
    , image : String
    , ingredients : List String
    , url : String
    }

type alias Model =
    { ingredients : String
    , recipes : List Recipe
    , selectedRecipe : Maybe Recipe
    , url : Url.Url
    , key : Nav.Key
    , showBox : Bool
    }

init : () -> Url.Url -> Nav.Key -> (Model, Cmd Msg)
init flags url key =
    ({ ingredients = ""
     , recipes = []
     , selectedRecipe = Nothing
     , url = url
     , key = key
     , showBox = False }
    , Cmd.none )



  -- UPDATE


type Msg
    = UpdateIngredients String
    | FetchRecipes
    | ReceiveRecipes (Result Http.Error (List Recipe))
    | SelectRecipe Recipe
    | DeselectRecipe
    | LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | ToggleBox


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateIngredients ingredients ->
            ( { model | ingredients = ingredients }, Cmd.none )

        FetchRecipes ->
            ( model, fetchRecipes model.ingredients )

        ReceiveRecipes (Ok recipes) ->
            ( { model | recipes = recipes }, Cmd.none )

        ReceiveRecipes (Err _) ->
            ( model, Cmd.none )

        SelectRecipe recipe ->
            ( { model | selectedRecipe = Just recipe }, Cmd.none )

        DeselectRecipe ->
            ( { model | selectedRecipe = Nothing }, Cmd.none )
        
        LinkClicked urlRequest ->
          case urlRequest of
            Browser.Internal url ->
                ( model, Nav.pushUrl model.key (Url.toString url) )

            Browser.External href ->
                ( model, Nav.load href )

        UrlChanged url ->
            ( { model | url = url }, Cmd.none)
        
        ToggleBox ->
            ({model | showBox = not model.showBox}, Cmd.none)



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
  Sub.none



  -- VIEW


view : Model -> Browser.Document Msg
view model =
    { title = "JustEat"
    , body = 
        [   svgLogo
           -- ,div [ style "width" "100%", style "height" "100%" ]
             -- [ div [  style "width" "100%", style "height" "100%" ][ svgBackground]
            --, div[class "content box"][ conten model]
              --]
              , div [ class "container" ]
                [ div [ class "background" ] [ svgBackground ]
                , div [ class "content box" ] -- Added Bulma's 'box' class for styling
            [ conten model]
        ]

            
      
                     
         -- div[class "has-text-centered"][footView]        
        ]
        
                
             
        
    }

footView: Html Msg
footView =  div[][text "Ready to find recipes?"
                , br[][]
                , text "Please enter one ingredient from your fridge to get cooking ideas! "
                ] 
conten : Model -> Html Msg
conten model =    
        div [ class "has-text-centered content"]
                      [ br[][] 
                      , headview model
                      , br[][]
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
                                    , a [ href recipe.url ] [ text "Go to recipe" ]
                                    ]
                        else 
                            div[][]
                            
                        ]
        

entertoGetIngredients : Model -> Html Msg
entertoGetIngredients model = 
            div []
            [ input [ placeholder "Enter ingredients", value model.ingredients, onInput UpdateIngredients ] []
            , br[][]
            , br[][]
            , button [ class "button is-warning", onClick FetchRecipes ] [ text "Get Recipes" ]
            ]


headview : Model -> Html Msg
headview model = 
    div[] 
       [ button [onClick ToggleBox][text "What is JustEat?"]
        , if model.showBox then 
            div[][svgBox]
          else   
            text ""
        ]


--Design

--vgbgToHtmlAttribute : string
--svgbgToHtmlAttribute = 
svgBackground1 : Html Msg
svgBackground1 =
         div[class "svg-background"]
        [ svg [ width "100%", height "100%", viewBox "0 0 200 200" ]
            [ rect [ x "0", y "0", width "200", height "200", fill "none", stroke "black" ] []
            , Svg.image [ x "50", y "0", width "100", height "100", xlinkHref "docs/logobg.png", opacity "0.65" ] []
            ]

         ]
         
        

svgBackground : S.Svg msg
svgBackground =
         svg [ width "100%", height "100%", viewBox "0 0 200 200" ]
            [ rect [ x "0", y "0", width "200", height "200", fill "none", stroke "black" ] []
            , Svg.image [ x "50", y "0", width "100", height "100", xlinkHref "docs/logobg.png", opacity "0.65" ] []
            ]
        



svgBox : Html Msg
svgBox =
    svg [ SA.width "1000", SA.height "300", viewBox "0 0 300 300" ]
        [ --rect [ x "10", y "10", SA.width "180", SA.height "180", fill "none", stroke "black", strokeWidth "3" ] [] 
         foreignObject [ x "-150", y "0", width "600" , height "300"][ div [ ][br[][], introduction ]]
        --, text_ [ x "100", y "100", fontSize "20", textAnchor "middle", fill "black", dy ".3em" ][ introduction ]
         --,img[href ""http://www.informatik.uni-halle.de/im/1285058520_1381_00_800.jpg"][]
        ]
--logo : Html Msg
--logo =
  --   img [ class "is-round image is-96x96", src "docs/logo.png" ] [] 

svgLogo : Html Msg
svgLogo =
    svg [ width "100%", height "150", viewBox "0 0 90 90" , style "background" "orange"]
        [image [ x "-400", y"-10", width "130", height "128", xlinkHref "docs/logo.png" , stroke "black"] [] ]

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
        [ td [] [ img [ src recipe.image, class "128x128", class "has-text-cenetered"] [] ]
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
