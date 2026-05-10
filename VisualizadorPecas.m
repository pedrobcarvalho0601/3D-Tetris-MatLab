function VisualizadorPecas()
    %Isto é um script temporario só para ver as peças


    % Cria uma janela para visualizar os 7 formatos das peças
    fig = figure('Name', 'Visualizador de Peças Tetris 3D', 'Color', 'w', 'Position', [100, 100, 1200, 600]);
    
    for i = 1:4
        % Cria um sub-gráfico para cada peça (2 linhas, 4 colunas)
        ax = subplot(2, 4, i);
        
        % Chama a função Pecas que criaste para obter coordenadas e cor
        [peca, ~] = Pecas(i);
        coords = peca.coords;
        cor = peca.cor;
        
        % Para cada um dos 4 blocos da peça, vamos desenhar um cubo
        for b = 1:4
            desenharCubo(ax, coords(b,1), coords(b,2), coords(b,3), cor);
        end
        
        % Configurações de visualização
        view(ax, 3);
        grid(ax, 'on');
        axis(ax, 'equal');
        title(ax, sprintf('Peça %d', i));
        
        % Define limites pequenos para a peça não parecer minúscula
        xlim(ax, [-2 3]); ylim(ax, [-2 3]); zlim(ax, [-1 2]);
    end
end

function desenharCubo(ax, x, y, z, cor)
    % Esta função desenha um cubo unitário na posição x, y, z
    % Definimos os vértices de um cubo de tamanho 1
    vertices = [0 0 0; 1 0 0; 1 1 0; 0 1 0; 0 0 1; 1 0 1; 1 1 1; 0 1 1];
    % Ajustamos a posição dos vértices para as coordenadas desejadas
    vertices = vertices + [x y z];
    
    % Definimos as 6 faces do cubo (ligando os vértices)
    faces = [1 2 6 5; 2 3 7 6; 3 4 8 7; 4 1 5 8; 1 2 3 4; 5 6 7 8];
    
    % Desenha o cubo no gráfico
    patch('Parent', ax, 'Vertices', vertices, 'Faces', faces, ...
          'FaceColor', cor, 'EdgeColor', 'k', 'FaceAlpha', 0.8);
end