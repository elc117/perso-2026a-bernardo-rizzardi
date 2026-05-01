{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DeriveAnyClass #-}

module Types where

import GHC.Generics (Generic)
import Data.Aeson (ToJSON, FromJSON)

data Personagem = Personagem {
    particularId :: Maybe Int,
    nome :: String,
    hp :: Int,
    forca :: Int,
    defesa :: Int,
    velocidade :: Int
} deriving (Show, Generic, ToJSON, FromJSON)

data ResultadoCombate = ResultadoCombate {
    vencedor :: String,
    turnosLevados :: Int,
    vidaVencedor :: Int,
    batalha :: [String]
} deriving (Show, Generic, ToJSON, FromJSON)