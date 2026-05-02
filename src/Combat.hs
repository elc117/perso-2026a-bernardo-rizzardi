module Combat where
import Types

-- Recebe o ataque de um personagem e a defesa do oponente e calcula: att1 - def2, sendo o minimo de 1.
calculoDano :: Int -> Int -> Int
calculoDano att1 d2 = if dano < 1 then 1 else dano
    where dano = att1 - d2

-- Seleciona de quem eh a vez.
player :: Bool -> Personagem -> Personagem -> Personagem
player vez in1 in2 = if vez then in1 else in2

-- Executa os turnos.
turnos :: Personagem -> Personagem -> (Personagem, Personagem, [String])
turnos input1 input2 =
    let 
        vez = velocidade input1 > velocidade input2 -- se true, input1 starts, se false, input2 starts
        p1 = player vez input1 input2
        p2 = player vez input2 input1
        dano1 = calculoDano (forca p1) (defesa p2)
        p2att = p2 {hp = hp p2 - dano1}
        str1 = "No turno 1, " ++ (nome p1) ++ " atacou " ++ (nome p2) ++ " causando " ++ show dano1 ++ " de dano."
        tem2turnos = (hp p2att) > 0
        dano2 = calculoDano (forca p2att) (defesa p1)
        p1att = p1 {hp = hp p1 - dano2}
        str2 = if tem2turnos 
            then "No turno 2, " ++ (nome p2) ++ " atacou " ++ (nome p1) ++ " causando " ++ show dano2 ++ " de dano!!"
            else (nome p2) ++ " morreu!!"
    in  if tem2turnos then (p1att, p2att, [str1, str2]) else (p1, p2att, [str1, str2]) 

-- Logica do combate em si.
combate :: Personagem -> Personagem -> ResultadoCombate -> ResultadoCombate
combate p1 p2 turnoAtual = if alguemMorreu then finalizado else combate p1att p2att logAcumulado
        where
            alguemMorreu = (hp p1) <= 0 || (hp p2) <= 0
            quemVenceu = if (hp p1) > 0 then p1 else p2
            finalizado = turnoAtual {
                vencedor = nome quemVenceu,
                vidaVencedor = hp quemVenceu,
                batalha = batalha turnoAtual ++ ["Batalha finalizada!"]
            }
            (p1att, p2att, str) = turnos p1 p2
            logAcumulado = turnoAtual {
                rodadasLevadas = rodadasLevadas turnoAtual + 1,
                batalha = batalha turnoAtual ++ str
            }

resultadoInicial :: ResultadoCombate
resultadoInicial = ResultadoCombate
    { 
        vencedor = "", 
        rodadasLevadas = 0, 
        vidaVencedor = 0, 
        batalha = []
    }
