module Main where

import Test.HUnit
import Types
import Combat
import Combat (player, turnos)
import Types (Personagem(velocidade), ResultadoCombate (vencedor))

main :: IO ()
main = do
    runTestTT testes
    return ()

p1 :: Personagem
p1 = Personagem
    { particularId = Nothing
    , nome = "Aragorn"
    , hp = 100
    , forca = 20
    , defesa = 10
    , velocidade = 15
    }

p2 :: Personagem
p2 = Personagem
    { particularId = Nothing
    , nome = "Goblin"
    , hp = 30
    , forca = 8
    , defesa = 5
    , velocidade = 10
    }

p3 :: Personagem
p3 = Personagem
    { particularId = Nothing
    , nome = "Paragon"
    , hp = 50
    , forca = 15
    , defesa = 7
    , velocidade = 10
    }


testes :: Test
testes = TestList
    [ TestCase (assertEqual "minimo de dano eh 1" 1 (calculoDano 5 10))
    , TestCase (assertEqual "dano eh arg1 - agr2" 95 (calculoDano 100 5))
    , TestCase (assertEqual "Aragorn comeca primeiro, por ser mais rapido" "Aragorn" (nome (player ((velocidade p1) > (velocidade p2)) p1 p2)))  
    , TestCase (assertEqual "Quando velocidade igual, o segundo comeca" "Paragon" (nome (player ((velocidade p2) > (velocidade p3)) p2 p3)))  
    , TestCase (let (_, _, logs) = turnos p1 p2 0
                in assertEqual "Primeiro ataque do turno correto" "No turno 1, Aragorn atacou Goblin causando 15 de dano." (head logs))
    , TestCase (let (_, _, logs) = turnos p1 p2 0
                in assertEqual "Segundo ataque do turno correto" "No turno 2, Goblin atacou Aragorn causando 1 de dano!!" (last logs))
    , TestCase (let relatorio = combate p1 p2 resultadoInicial
                in assertEqual "Verifica vencedor entre p1 e p2" "Aragorn" (vencedor relatorio))
    ]