{-# LANGUAGE OverloadedStrings #-}

module Main (main) where

import Web.Scotty
import Database.SQLite.Simple
import Database
import Combat

main :: IO ()
main = do
  conn <- open "rpg.db"
  criarTabela conn
  scotty 3000 $ do
    get "/personagem/:id" $ do
      idBuscado <- pathParam "id"
      p <- liftIO (buscarPersonagemId conn idBuscado)
      case p of
        Just personagem -> json personagem
        Nothing -> text "Personagem não encontrado"
    post "/personagem" $ do
      p <- jsonData
      liftIO (salvarPersonagem conn p)
      json p
    post "/combate/:id1/:id2" $ do
      id1Buscado <- pathParam "id1"
      id2Buscado <- pathParam "id2"
      mp1 <- liftIO (buscarPersonagemId conn id1Buscado)
      mp2 <- liftIO (buscarPersonagemId conn id2Buscado)
      case (mp1, mp2) of
        (Just p1, Just p2) -> do
          let resultado = combate p1 p2 resultadoInicial
          json resultado
        _ -> text "Um ou mais personagens nao encontrados"