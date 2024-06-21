module Main exposing (main)

-- Press buttons to increment and decrement a counter.
--
-- Read how it works:
--   https://guide.elm-lang.org/architecture/buttons.html
--


import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (..)
--onClick



-- MAIN


main =
  Browser.sandbox { init = init, update = update, view = view }



-- MODEL(Variable)


type alias Model = Int -- nur eine Variable

--Alternativ für obene Zeile
-- type alias Model =
--	{count = int}


init : Model
init =
  0



-- UPDATE

--Function
type Msg
  = Increment
  | Decrement


update : Msg -> Model -> Model
update msg model =
  case msg of
    Increment ->
      model + 1

    Decrement ->
      model - 1



-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ button [ onClick Decrement ] [ text "-" ]
    , div [] [ text (String.fromInt model) ]
    , button [ onClick Increment ] [ text "+" ]
    ]
