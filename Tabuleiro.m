function Tabuleiro(nomeJogador)
    % Cria a janela do jogo
    figJogo = figure('Name', ['Tetris 3D - Arena de ', nomeJogador], 'Color', 'black');
    
    % Cria o espaço 3D
    ax = axes('Parent', figJogo);
    grid(ax, 'on');       % Ativa a grelha
    view(ax, 3);          % Coloca em vista 3D
    axis(ax, 'equal');    % Mantém as proporções
    
    % Define os limites da arena (ex: 10x10 de base e 20 de altura)
    xlim(ax, [0 10]);
    ylim(ax, [0 10]);
    zlim(ax, [0 20]);
    
    % Cores e legendas
    ax.GridColor = [0 1 1]; % Grelha em Cyan neon
    ax.XColor = 'w'; ax.YColor = 'w'; ax.ZColor = 'w';
    xlabel(ax, 'Largura (X)');
    ylabel(ax, 'Profundidade (Y)');
    zlabel(ax, 'Altura (Z)');
    
    title(ax, ['Bem-vindo, ', nomeJogador, '!'], 'Color', 'w');
    
    disp(['Jogo iniciado para: ', nomeJogador]);
end