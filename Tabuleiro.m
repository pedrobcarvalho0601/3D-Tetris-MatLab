function Tabuleiro(nomeJogador, n, h)
    % A função agora recebe três informações: o nome, o n e o h.

    % Cria a janela do jogo e ajusta o título para incluir as dimensões
    tituloJanela = sprintf('Tetris 3D - %s [%dx%dx%d]', nomeJogador, n, n, h);
    figJogo = figure('Name', tituloJanela, 'Color', 'black');
    
    % Cria os eixos 3D (o "recinto")
    ax = axes('Parent', figJogo);
    grid(ax, 'on');       
    view(ax, 3);          
    axis(ax, 'equal');    % Mantém os blocos como cubos perfeitos
    
    % =====================================================================
    % APLICA AS DIMENSÕES FORNECIDAS PELO UTILIZADOR
    % O campo será de n x n na base (X e Y), e altura h (Z).
    % =====================================================================
    xlim(ax, [0, n]);
    ylim(ax, [0, n]);
    zlim(ax, [0, h]);
    
    % Opções de design: cores estilo "Neon" / Retro
    ax.GridColor = [0, 1, 1]; % Grelha azul cyano
    ax.GridAlpha = 0.5;       % Torna a grelha ligeiramente transparente
    ax.Color = 'black';       % Fundo do gráfico a preto
    ax.XColor = 'w'; ax.YColor = 'w'; ax.ZColor = 'w'; % Texto dos eixos a branco
    
    % Legendas dos Eixos
    xlabel(ax, 'Eixo X');
    ylabel(ax, 'Eixo Y');
    zlabel(ax, 'Altura Z');
    
    % Dá as boas-vindas e confirma o tamanho no topo do tabuleiro
    title(ax, sprintf('Boa sorte %s! Arena: %dx%dx%d', nomeJogador, n, n, h), 'Color', 'w', 'FontSize', 14);
    
    % Desenha uma linha mais grossa à volta da base (para o "chão" ser mais visível)
    hold(ax, 'on');
    plot3(ax, [0 n n 0 0], [0 0 n n 0], [0 0 0 0 0], 'Color', [1 0 1], 'LineWidth', 2); % Quadrado rosa na base
    hold(ax, 'off');
    
    disp(['Tetris 3D iniciado para: ', nomeJogador, ' com recinto ', num2str(n), 'x', num2str(n), 'x', num2str(h)]);
end