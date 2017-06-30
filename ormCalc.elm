import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Http

main =
    Html.program { init = init, update = update, view = view, subscriptions = subscriptions }



type alias Model =
    { repetitions: Int
    , weight: Int
    , oneRepMax: Int
    }



init: ( Model, Cmd Msg )
init =
    ({ repetitions = 1, weight = 1, oneRepMax = 1}, Cmd.none)



type Msg =
    UpdateReps String
    | UpdateWeight String 
    | UpdateORM Int



update: Msg -> Model -> ( Model, Cmd Msg )
update msg model = 
    case msg of
        UpdateReps reps ->
            ( { model 
              | repetitions = Result.withDefault 0 (String.toInt reps)
              }
              , UpdateORM (recalculateORM model) )
        UpdateWeight weight ->
            ( { model | weight = Result.withDefault 0 (String.toInt weight) }, Cmd.none )
        UpdateORM (Err _, orm) ->
            ( { model | oneRepMax = orm }, Cmd.none )

recalculateORM: Model -> Model
recalculateORM model = 
    { 
        model | oneRepMax =  model.repetitions * model.weight
    }

subscriptions: Model -> Sub Msg
subscriptions model = 
    Sub.none

view: Model -> Html Msg
view model =
    div []
    [ input [type_ "text", placeholder "repetitions", onInput UpdateReps ] []
    , input [type_ "text", placeholder "weight", onInput UpdateWeight ] []
    , text (toString model.oneRepMax)
    ]