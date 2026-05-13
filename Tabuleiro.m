function Tabuleiro(nomePlayer, n, h)
    % --- CONFIGURAÇÃO DA INTERFACE ---
    figJogo = uifigure('Name', 'Tetris 3D');                 % Cria a janela principal da aplicação
    figJogo.WindowState = 'fullscreen';                      % Define o modo de visualização para ecrã total
    figJogo.Color = 'black';                                 % Define a cor de fundo da janela como preto

    % --- GESTÃO DO SOM ---
    [audio, freq] = audioread('GameMusic.mp3');              % Carrega o ficheiro de áudio e a sua frequência
    leitorMusica = audioplayer(audio, freq);                 % Cria o objeto de reprodução sonora
    figJogo.UserData = leitorMusica;                         % Guarda o objeto na janela para evitar que pare
    leitorMusica.StopFcn = @(src, event) play(src);          % Configura o loop (tocar sempre que acabar)
    play(leitorMusica);                                      % Inicia a música de fundo

    % --- CONFIGURAÇÃO DO CAMPO 3D (ARENA) ---
    jogo = uiaxes('Parent', figJogo);                        % Cria o espaço de desenho 3D na janela
    disableDefaultInteractivity(jogo);                       % Desativa zoom/rotação automáticos do rato
    grid(jogo, 'on');                                        % Ativa a grelha visual de referência
    view(jogo, 3);                                           % Define a perspetiva de visualização em 3D
    axis(jogo, 'equal');                                     % Mantém proporções iguais para os cubos não deformarem
    jogo.Units = 'normalized';                               % Define o sistema de unidades como percentagem
    jogo.Position = [0.1, 0.05, 0.8, 0.9];                   % Posiciona o gráfico [Esq, Baixo, Larg, Alt]
    
    xlim(jogo, [0, n]);                                      % Define o limite da largura (Eixo X)
    ylim(jogo, [0, n]);                                      % Define o limite da profundidade (Eixo Y)
    zlim(jogo, [0, h]);                                      % Define o limite da altura máxima (Eixo Z)
    
    jogo.GridColor = 'white';                                % Define a cor das linhas da grelha
    jogo.Color = [0.05 0.05 0.1];                            % Define a cor do "espaço" interior da arena
    title(jogo, sprintf('Jogador: %s', nomePlayer), 'Color', 'w'); % Exibe o nome do jogador no topo


    %-----------------------------------------------------------------------------------------------%
        

    % --- PREPARAÇÃO DA PEÇA ---
    sel = randi([1, 4]);                                     % Escolhe um tipo de peça aleatoriamente
    [pecaInfo, Pontos] = Pecas(sel);                         % Obtém coordenadas e cor do script 'Pecas.m'
    
    posX = floor(n/2);                                       % Define a posição X inicial no centro da base
    posY = floor(n/2);                                       % Define a posição Y inicial no centro da base
    posZ = h - 1;                                            % Define a altura de nascimento (topo da arena)
    
    % --- CICLO DE ANIMAÇÃO (QUEDA) ---
    %isto é gemini para ver como seria feito e ver se funciona
    %vamos tentar mudar mas usar uma base

    while posZ >= 0
        atualPeca = [];                                      % Cria lista vazia para guardar os cubos da peça
        
        for i = 1:Pontos
            realX = pecaInfo.coords(i,1) + posX;             % Calcula a posição X final no tabuleiro
            realY = pecaInfo.coords(i,2) + posY;             % Calcula a posição Y final no tabuleiro
            realZ = pecaInfo.coords(i,3) + posZ;             % Calcula a posição Z final no tabuleiro
            
            hCubo = desenharCubo(jogo, realX, realY, realZ, pecaInfo.cor); % Desenha o cubo 3D
            atualPeca = [atualPeca, hCubo];                  % Guarda a "ID" do cubo para apagar depois
        end
        
        pause(0.5);                                          % Pausa o código para o olho humano ver a queda
        
        if posZ > 0
            delete(atualPeca);                             % Apaga o desenho atual antes de mover para baixo
        end
        
        posZ = posZ - 1;
    end
    
    %title(jogo, 'A peça chegou ao fundo!', 'Color', 'y');    % Altera o título quando a peça para de cair
end

% --- FUNÇÃO PARA CONSTRUIR O CUBO ---
function h = desenharCubo(ax, x, y, z, cor)
    v = [0 0 0; 1 0 0; 1 1 0; 0 1 0; 0 0 1; 1 0 1; 1 1 1; 0 1 1]; % Coordenadas dos 8 vértices de um cubo
    v = v + [x y z];                                              % Move os vértices para o local correto (Translação)
    f = [1 2 6 5; 2 3 7 6; 3 4 8 7; 4 1 5 8; 1 2 3 4; 5 6 7 8];   % Define as 6 faces que formam o volume
    h = patch('Parent', ax, 'Vertices', v, 'Faces', f, ...        % Renderiza o objeto 3D com a cor escolhida
              'FaceColor', cor, 'EdgeAlpha', 0.3);                % Define cor e transparência das arestas
end