{-# OPTIONS_GHC -Wno-orphans #-}

module Database where

import Database.SQLite.Simple
import Data.String (fromString)
import Types

instance FromRow Personagem where
    fromRow = Personagem <$> field <*> field <*> field <*> field <*> field <*> field

criarTabela :: Connection -> IO ()
criarTabela conn = execute_ conn (fromString "CREATE TABLE IF NOT EXISTS personagens (id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT, hp INTEGER, forca INTEGER, defesa INTEGER, velocidade INTEGER)")

salvarPersonagem :: Connection -> Personagem -> IO ()
salvarPersonagem conn p = execute conn (fromString "INSERT INTO personagens (nome, hp, forca, defesa, velocidade) VALUES (?, ?, ?, ?, ?)") 
    (nome p, hp p, forca p, defesa p, velocidade p)

buscarPersonagem :: Connection -> IO [Personagem]
buscarPersonagem conn = query_ conn (fromString "SELECT * FROM personagens")

buscarPersonagemId :: Connection -> Int -> IO (Maybe Personagem)
buscarPersonagemId conn idBuscado = do
    resultados <- query conn (fromString "SELECT * FROM personagens WHERE id = ?") (Only idBuscado)
    case resultados of
        (p:_) -> return (Just p)
        []    -> return Nothing