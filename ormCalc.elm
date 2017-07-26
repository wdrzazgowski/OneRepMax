import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Html.Events exposing (onClick)
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
    | UpdateORM 




update: Msg -> Model -> ( Model, Cmd Msg )
update msg model = 
    case msg of
        UpdateReps reps ->
            ( { model 
              | repetitions = Result.withDefault 0 (String.toInt reps)
              }
              , Cmd.none )
        UpdateWeight weight ->
            ( 
                { model 
                | weight = Result.withDefault 0 (String.toInt weight)
                }
                , 
                Cmd.none
            )
        UpdateORM ->
            ( 
                {
                model 
                | oneRepMax = recalculateORM model 
                }, 
                Cmd.none
            )

recalculateORM: Model -> Int
recalculateORM model = 
    model.repetitions * model.weight
    

subscriptions: Model -> Sub Msg
subscriptions model = 
    Sub.none

view: Model -> Html Msg
view model =
    div []
    [ input [type_ "text", placeholder "repetitions", onInput UpdateReps ] []
    , input [type_ "text", placeholder "weight", onInput UpdateWeight ] []
    , button [ onClick UpdateORM ] [ text "Recalculate ORM" ]
    , text (toString model.oneRepMax)
    ]