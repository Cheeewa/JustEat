module Main exposing (main)

import Browser
import Url
import Browser.Navigation as Nav
import Http
import Html exposing (Html, div, input, button, text, ul, li, img, a, h2, h1, p, table, thead, tbody, tr, th, td ,section)
import Html.Attributes exposing (href, placeholder, value, src, class)
import Html.Events exposing (onClick, onInput)
import Json.Decode as Decode



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
    }

init : () -> Url.Url -> Nav.Key -> (Model, Cmd Msg)
init flags url key =
    ({ ingredients = ""
     , recipes = []
     , selectedRecipe = Nothing
     , url = url
     , key = key }
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
          ( { model | url = url }
          , Cmd.none
          )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
  Sub.none



  -- VIEW


view : Model -> Browser.Document Msg
view model =
    { title = "JustEat"
    , body = 
        [ div [ class "has-text-centered" ]
            [ introduction
            , div [ class "field" ]
                [ input [ placeholder "Enter ingredients", value model.ingredients, onInput UpdateIngredients ] []
                , p [] []
                , button [ class "button is-primary", onClick FetchRecipes ] [ text "Get Recipes" ]
                ]
            ]
            {-
                model.url.fragment of
                    Just fragment ->
                        case fragment of

            --}
        , case model.selectedRecipe of
            Nothing ->
                recipesTable model.recipes

            Just recipe ->
                div []
                    [ button [ href "", onClick DeselectRecipe ] [ text "Back to Recipes" ]
                    , h2 [] [ text recipe.label ]
                    , ul [] (List.map ingredientItem recipe.ingredients)
                    , a [ href recipe.url ] [ text "Go to recipe" ]
                    ]
        ]
    }


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
        [ td [] [ img [ src recipe.image, class "64x64", class "has-text-cenetered"] [] ]
        , td [] [ a [ href "Recipe", onClick (SelectRecipe recipe) ] [ text recipe.label ] ]
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