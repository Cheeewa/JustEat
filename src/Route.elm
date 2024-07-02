module Route exposing(Route(..))

import Url exposing (Url)

type Route
    = Home
    | Recipe
    | NotFound

fromUrl: Url -> Route
fromUrl url = 
    case url.path of
        "/" -> Home
        "/Recipe" -> Recipe
        _ -> NotFound