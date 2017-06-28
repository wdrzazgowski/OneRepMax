import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)

main =
    Html.beginnerProgram { model = model, update = update, view = view }

type alias Model =
    { repetitions: Int
    , weight: Int
    , oneRepMax: Int
    }
model: Model
    
model = 
    { repetitions = 0
    , weight = 0
    ,oneRepMax = 0
    }

type Msg =
    UpdateReps String
    | UpdateWeight String

update: Msg -> Model -> Model
update msg model = 
    case msg of
        UpdateReps reps ->
            { model | repetitions = Result.withDefault 0 (String.toInt reps) }
        UpdateWeight weight ->
            { model | weight = Result.withDefault 0 (String.toInt weight) }

view: Model -> Html Msg
view model =
    div []
    [ input [type_ "text", placeholder "repetitions", onInput UpdateReps ] []
    , input [type_ "text", placeholder "weight", onInput UpdateWeight ] []
    , text (toString model.oneRepMax)
    ]