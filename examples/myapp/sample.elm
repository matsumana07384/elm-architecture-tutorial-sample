import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)



-- MAIN


main =
  Browser.sandbox { init = init, update = update, view = view }



-- MODEL

-- データモデルを定義
type alias Model =
  { name : String
  , password : String
  , passwordAgain : String
  , age :String
  }


init : Model
-- 初期値？
init =
  Model "" "" ""



-- UPDATE

-- メッセージ値を定義
type Msg
  = Name String
  | Password String
  | PasswordAgain String
  | CharacterLength String


update : Msg -> Model -> Model
update msg model =
  case msg of
    Name name ->
      { model | name = name }

    Password password ->
      { model | password = password }

    PasswordAgain password ->
      { model | passwordAgain = password }
    
    CharacterLength password ->
      { model | password =  password > 8  }


-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ viewInput "text" "Name" model.name Name
    , viewInput "password" "Password" model.password Password
    , viewInput "password" "Re-enter Password" model.passwordAgain PasswordAgain  
    , viewValidation model
    ]


viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
  input [ type_ t, placeholder p, value v, onInput toMsg ] []


viewValidation : Model -> Html msg
viewValidation model =
  if model.password == model.passwordAgain then
    div [ style "color" "green" ] [ text "OK" ]
  else if
    div [ style "color" "red" ] [ text "Passwords do not match!" ]
  