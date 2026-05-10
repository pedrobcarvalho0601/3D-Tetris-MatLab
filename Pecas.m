function [novaPeca, Pontos] = Pecas(sel)
    % Esta função recebe um número (sel) e devolve a peça correspondente.
    % Cada peça é guardada numa "estrutura" (novaPeca) com coordenadas e cor.
    
    Pontos = 10; % Ganhas 10 pontos de cada vez que uma peça nova cai
    
    % As coordenadas representam a posição [X, Y, Z] dos 4 cubinhos que formam a peça.
    % Assumimos que a peça nasce deitada na horizontal (Z = 0).
    
    switch sel
        case 1
            % Peça 'I' (Reta) - Cor Ciano
            % Formato: Quatro blocos em linha
            coords = [0 0 0; 1 0 0; 2 0 0; -1 0 0];
            cor = [0 1 1]; 
            
        case 2
            % Peça 'O' (Quadrado) - Cor Amarelo
            coords = [0 0 0; 1 0 0; 0 1 0; 1 1 0];
            cor = [1 1 0];
            
        case 3
            % Peça 'T' - Cor Magenta
            coords = [0 0 0; -1 0 0; 1 0 0; 0 1 0];
            cor = [1 0 1];
            
        case 4
            % Peça 'S' - Cor Verde
            coords = [0 0 0; 1 0 0; 0 1 0; -1 1 0];
            cor = [0 1 0];
            
        otherwise
            % Caso ocorra um erro, devolve um bloco único branco por segurança
            coords = [0 0 0; 0 0 0; 0 0 0; 0 0 0];
            cor = [1 1 1];
    end
    
    % Empacotamos os dados na variável de saída
    novaPeca.coords = coords;
    novaPeca.cor = cor;
end