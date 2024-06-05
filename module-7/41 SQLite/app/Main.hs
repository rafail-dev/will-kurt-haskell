module Main (main) where

import Control.Monad (forM_, (<=<))
import qualified Rental.Actions as Rental
import Text.Read (readMaybe)
import qualified Tool.Actions as Tool
import qualified User.Actions as User

handleResult :: (Show e) => IO (Either e a) -> (a -> IO String) -> IO String
handleResult action onSuccess = do
  result <- action
  case result of
    Left e -> pure $ "Caught an exception: " ++ show e
    Right r -> onSuccess r

performCommand' :: [String] -> IO String
performCommand' command = do
  case command of
    {-
      Users
    -}
    ("add_user" : firstName : maybeSecondNames) ->
      handleResult
        (User.add name)
        (\_ -> pure $ "Added user: " ++ name)
      where
        name = take 255 $ unwords $ firstName : maybeSecondNames
    --

    ("find_users" : maybeSearch) ->
      handleResult
        (User.findAll $ unwords maybeSearch)
        (pure . concatMap (\v -> show v ++ "\n"))
    --
    ["delete_user", userId] ->
      case readMaybe userId of
        Just userId' ->
          handleResult
            (User.delete userId')
            (\_ -> pure $ "Deleted user: " ++ userId)
        Nothing -> pure "Wrong user id"
    {-
      Tools
    -}
    ["add_tool", name, description] ->
      handleResult
        (Tool.add name description)
        (\_ -> pure $ "Added tool: " ++ name)
    --

    ("find_tools" : maybeSearch) ->
      handleResult
        (Tool.findAll $ concat maybeSearch)
        (pure . concatMap (\v -> show v ++ "\n\n"))
    --
    ["delete_tool", toolId] ->
      case readMaybe toolId of
        Just toolId' -> do
          result <- Tool.delete toolId'
          case result of
            Left e -> pure $ show e
            Right _ -> pure $ "Deleted tool: " ++ toolId
        Nothing -> pure "Wrong tool id"
    {-
      Help
    -}
    ["rent", userId, rentId] ->
      case (readMaybe userId, readMaybe rentId) of
        (Just userId', Just rentId') -> do
          let a = userId' + rentId' :: Int
          pure $ show a
        _ -> pure "Wrong user id ot tool id"
    --
    ["return", rentId] ->
      case readMaybe rentId of
        (Just rendtId') ->
          handleResult
            (Rental.return' rendtId')
            (\_ -> pure $ "Returned rental: " ++ rentId)
        Nothing -> pure "Wrong rent id"
    --
    -- ["rentals"] ->
    --   handleResult
    --     (Rental.find False)
    --     (pure . concatMap (\v -> show v ++ "\n"))
    --

    ["all_rentals"] ->
      handleResult
        (Rental.find False)
        (pure . concatMap (\v -> show v ++ "\n"))
    --
    ["actual_rentals"] ->
      handleResult
        (Rental.find True)
        (pure . concatMap (\v -> show v ++ "\n"))
    {-
      Help
    -}
    ["help"] ->
      pure $
        unlines
          [ "Available commands:",
            "Users:",
            "  add_user <name>                   - Add a new user with the given name",
            "  find_users [search]               - List all users or search for users",
            "  delete_user <userId>              - Delete a user with the given user ID",
            "",
            "Tools:",
            "  add_tool <name> <description>     - Add a new tool with the given name and description",
            "  find_tools [search]               - List all tools or search for tools",
            "  delete_tool <toolId>              - Delete a tool with the given tool ID",
            "",
            "Rentals:",
            "  rent <userId> <toolId>            - Rent a tool by a user",
            "  return <rentalId>                 - Return a rented tool",
            "  all_rentals                       - List all rentals",
            "  actual_rentals                    - List currently active rentals",
            "",
            "help                                - Show this help message"
          ]
    _ -> pure "Sorry command not found"

basePrompt :: IO ()
basePrompt = putStrLn "Enter commands (type 'quit' to exit):"

-- recursive sample
-- main :: IO ()
-- main = do
--   basePrompt
--   command <- getLine
--   when (command /= "quit") $ do
--     performCommand command
--     putStrLn ""
--     main

processInput :: [String] -> IO ()
processInput =
  (>> basePrompt) . (>> putStrLn "") . (putStrLn <=< performCommand')

main :: IO ()
main = do
  basePrompt
  input <- getContents
  let commands = takeWhile (/= "quit") (lines input)
  forM_
    (map words commands)
    processInput
  putStrLn "Bye, bye!"
