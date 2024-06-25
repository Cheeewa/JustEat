module Update exposing (update)

import Model exposing (Model)
import Msg exposing (Msg(..))
import Api

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateIngredients ingredients ->
            ( { model | ingredients = ingredients }, Cmd.none )

        FetchRecipes ->
            ( model, Api.fetchRecipes model.ingredients )

        ReceiveRecipes (Ok recipes) ->
            ( { model | recipes = recipes }, Cmd.none )

        ReceiveRecipes (Err _) ->
            ( model, Cmd.none )
