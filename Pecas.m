function [novaPeca, Pontos] = Pecas(sel)
    % Esta função recebe um número (sel) e devolve a peça correspondente.
    % Cada peça é guardada numa "estrutura" (novaPeca) com coordenadas e cor.
    
    % As coordenadas representam a posição [X, Y, Z] dos 4 cubinhos que formam a peça.
    % Assumimos que a peça nasce deitada na horizontal (Z = 0).
    
    switch sel
        case 1
            coords = [0 0 0];
            cor = [0 1 1];
            Pontos = 1;
            
        case 2
            coords = [0 0 0; 1 0 0; 0 1 0; 1 1 0; 0 0 1; 1 0 1; 0 1 1; 1 1 1];
            cor = [1 1 0];
            Pontos = 8;
            
        case 3
            coords = [0 0 0; -1 0 0];
            cor = [1 0 1];
            Pontos = 2;
            
        case 4
            coords = [0 0 0; 1 0 0; -1 0 0];
            cor = [0 1 0];
            Pontos = 3;
            
        otherwise
            % Caso ocorra um erro, devolve um bloco único branco por segurança
            coords = [0 0 0; 0 0 0; 0 0 0; 0 0 0];
            cor = [1 1 1];
    end
    
    % Empacotamos os dados na variável de saída
    novaPeca.coords = coords;
    novaPeca.cor = cor;
end