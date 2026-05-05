function Tabuleiro(nomePlayer, n, h)

%======================%
%         JOGO
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

end