module Main exposing (main)

import Browser
import Html exposing (Html, div, h1, p, button, input, nav, a, text)
import Html.Attributes exposing (class, href, placeholder, type_)
import Html.Events exposing (onClick)

-- MODEL

type alias Model =
    { count : Int }

initialModel : Model
initialModel =
    { count = 0 }

-- UPDATE

type Msg
    = Increment
    | Decrement

update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            { model | count = model.count + 1 }

        Decrement ->
            { model | count = model.count - 1 }

-- VIEW

view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ nav [ class "navbar" ]
            [ div [ class "navbar-brand" ]
                [ a [ class "navbar-item", href "#" ] [ text "Just Eat" ]
                ]
            ]
        , div [ class "section" ]
            [ div [ class "columns" ]
                [ div [ class "column is-half is-offset-one-quarter" ]
                    [ div [ class "field has-addons" ]
                        [ div [ class "control" ]
                            [ button [ class "button is-primary", onClick Increment ] [ text "+" ] ]
                        , div [ class "control" ]
                            [ input [ class "input", type_ "text", placeholder (String.fromInt model.count) ] [] ]
                        , div [ class "control" ]
                            [ button [ class "button is-danger", onClick Decrement ] [ text "-" ] ]
                        ]
                    ]
                ]
            ]
        ]

-- MAIN

main =
    Browser.sandbox { init = initialModel, update = update, view = view }
