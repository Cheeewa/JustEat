module Main exposing (main)

import Browser
import Html exposing (Html)
import Model exposing (Model)
import Update exposing (update)
import View exposing (view)
import Msg exposing (Msg)

main : Program () Model Msg
main =
    Browser.element { init = \_ -> ( Model.init, Cmd.none ), update = update, view = view, subscriptions = \_ -> Sub.none }
