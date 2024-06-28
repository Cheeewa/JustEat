module Main exposing (main)

import Browser
import Html exposing (..)
import Model exposing (Model)
import Update exposing (update)
import View exposing (view)
import Msg exposing (Msg)
--import Dict exposing (..) 

main : Program () Model Msg
main =
    Browser.element
        { init = \_ -> (Model.init, Cmd.none)
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }