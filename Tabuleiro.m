function Tabuleiro(nomePlayer, n, h)

%======================%
%      TABULEIRO
%======================%

% Cria o tabuleiro
    figJogo = uifigure('Name', 'Tetris 3D');
    figJogo.WindowState = 'fullscreen';
    figJogo.Color = 'black';

% Adiciona a musica
    [audio, frequencia] = audioread('GameMusic.mp3');
    leitorMusica = audioplayer(audio, frequencia);
    figJogo.UserData = leitorMusica;
    leitorMusica.StopFcn = @(src, event) play(src);
    play(leitorMusica);

% Painel de jogo
    jogo = uiaxes('Parent', figJogo);
    disableDefaultInteractivity(jogo);
    grid(jogo, 'on');
    view(jogo, 3);
    axis(jogo, 'equal');
    jogo.Units = 'normalized';
    jogo.Position = [0.1, 0.05, 0.8, 0.9];

% Remove os numeros dos lados
    jogo.XTickLabel = {};
    jogo.YTickLabel = {};
    jogo.ZTickLabel = {};

% Define o tamanho do tabuleiro
    xlim(jogo, [0, n]);
    ylim(jogo, [0, n]);
    zlim(jogo, [0, h]);

% Mostra a grelha completa sempre
    jogo.Box = 'on';
    jogo.BoxStyle = 'full';

% Cores do tabuleiro
    jogo.GridColor = 'white';
    jogo.GridAlpha = 0.5;
    jogo.Color = 'blue';
    jogo.XColor = 'w'; jogo.YColor = 'w'; jogo.ZColor = 'w';
    title(jogo, sprintf('Boa sorte %s! Arena: %dx%dx%d', nomePlayer, n, n, h), 'Color', 'w', 'FontSize', 14);

%======================%
%         JOGO
%======================%
% Inicializa o estado do jogo
    score = 0;
    level = 1; %velocidade
    gameOver = false;

    while ~gameOver
        % Exibe a pontuação
        lblPontos = uilabel('Parent', figJogo, 'Text', sprintf('Pontuação: %d', score), 'Position', [10, 10, 100, 22], 'FontColor', 'w');
        
        sel = randi([1, 4]);
        [novaPeca, Pontos] = Pecas(sel);
        
        % Atualiza a pontuação
        score = score + Pontos;
        lblPontos.Text = sprintf('Pontuação: %d', score);
        
        % Verifica se o jogo acabou
        if %colocar a condiçao para fim de jogo
            gameOver = true;
        end
    end
    % Tela de GameOver    
end