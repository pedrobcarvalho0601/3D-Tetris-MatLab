function Tabuleiro(nomePlayer, n, h)
    % --- CONFIGURAÇÃO DA INTERFACE ---
    figJogo = uifigure('Name', 'Tetris 3D');
    figJogo.WindowState = 'fullscreen';
    figJogo.Color = 'black';

    % --- VARIÁVEL PARTILHADA PARA A TECLA ---
    % Definida aqui para ser acessível tanto pelo ciclo principal
    % como pela função de callback do teclado.
    teclaAtual = '';

    % --- REGISTO DO CALLBACK DO TECLADO ---
    % Definido UMA ÚNICA VEZ, antes de qualquer ciclo.
    figJogo.KeyPressFcn = @(src, event) teclaPressionada(event);

    % --- GESTÃO DO SOM ---
    [audio, freq] = audioread('GameMusic.mp3');
    leitorMusica = audioplayer(audio, freq);
    figJogo.UserData = leitorMusica;
    leitorMusica.StopFcn = @(src, event) play(src);
    play(leitorMusica);

    % --- CONFIGURAÇÃO DO CAMPO 3D (ARENA) ---
    jogo = uiaxes('Parent', figJogo);
    disableDefaultInteractivity(jogo);
    grid(jogo, 'on');
    view(jogo, 3);
    axis(jogo, 'equal');
    jogo.Units = 'normalized';
    jogo.Position = [0.1, 0.05, 0.8, 0.9];

    xlim(jogo, [0, n]);
    ylim(jogo, [0, n]);
    zlim(jogo, [0, h]);

    jogo.GridColor = 'white';
    jogo.Color = [0.05 0.05 0.1];
    title(jogo, sprintf('Jogador: %s', nomePlayer), 'Color', 'w');

    %-----------------------------------------------------------------------------------------------%

    % --- MATRIZ DO TABULEIRO ---
    % Regista quais as células ocupadas: 0 = livre, 1 = ocupado.
    % Índices: tabuleiro(x, y, z) — todos com offset +1 por MATLAB começar em 1.
    tabuleiro = zeros(n, n, h);

    % --- CICLO PRINCIPAL DO JOGO ---
    while true
        % --- PREPARAÇÃO DA PEÇA ---
        sel = randi([1, 4]);
        [pecaInfo, Pontos] = Pecas(sel);

        posX = floor(n/2);
        posY = floor(n/2);
        posZ = h - 1;

        % Verifica se a posição inicial já está ocupada (fim de jogo)
        if verificaColisao(tabuleiro, pecaInfo, posX, posY, posZ, n, h)
            title(jogo, 'GAME OVER', 'Color', 'r');
            break;
        end

        % --- CICLO DE QUEDA ---
        while true
            % Desenha a peça na posição atual
            atualPeca = [];
            for i = 1:Pontos
                realX = pecaInfo.coords(i,1) + posX;
                realY = pecaInfo.coords(i,2) + posY;
                realZ = pecaInfo.coords(i,3) + posZ;
                hCubo = desenharCubo(jogo, realX, realY, realZ, pecaInfo.cor);
                atualPeca = [atualPeca, hCubo];
            end

            pause(0.5);

            % --- PROCESSAR TECLA PRESSIONADA ---
            % Lê a teclaAtual (partilhada com o callback), tenta mover,
            % e verifica colisão antes de aplicar o movimento.
            novoPosX = posX;
            novoPosY = posY;
            
            switch teclaAtual
                case 'leftarrow'
                    novoPosX = posX - 1;
                case 'rightarrow'
                    novoPosX = posX + 1;
                case 'uparrow'
                    novoPosY = posY + 1;
                case 'downarrow'
                    novoPosY = posY - 1;
            end

            % Só aplica o movimento se não causar colisão lateral
            if ~verificaColisao(tabuleiro, pecaInfo, novoPosX, novoPosY, posZ, n, h)
                posX = novoPosX;
                posY = novoPosY;
            end

            teclaAtual = '';   % Limpa a tecla depois de processar

            % --- DESCIDA ---
            % Calcula a próxima posição (um nível abaixo)
            proximoZ = posZ - 1;

            % Verifica se a próxima posição causa colisão (fundo ou cubo existente)
            if verificaColisao(tabuleiro, pecaInfo, posX, posY, proximoZ, n, h)
                % A peça fica aqui — regista na matriz e sai do ciclo de queda
                for i = 1:Pontos
                    mx = pecaInfo.coords(i,1) + posX + 1;   % +1 por MATLAB começar em 1
                    my = pecaInfo.coords(i,2) + posY + 1;
                    mz = pecaInfo.coords(i,3) + posZ + 1;
                    tabuleiro(mx, my, mz) = 1;
                end
                break;
            end

            % Sem colisão: apaga e desce
            delete(atualPeca);
            posZ = proximoZ;
            
            for z = 1:h
                if camadaCompleta(tabuleiro, z)
                    tabuleiro(:, :, z) = 0;
                    
                end
            end
        end

        % A peça ficou desenhada (não foi apagada) — continua para a próxima
    end

    %-----------------------------------------------------------------------------------------------%

    % --- FUNÇÃO CALLBACK DO TECLADO ---
    % Atualiza a variável partilhada 'teclaAtual' sempre que uma tecla é pressionada.
    function teclaPressionada(event)
        teclaAtual = event.Key;
    end

    function completo = camadaCompleta(tabuleiro, z)
        completo = all(all(tabuleiro(:, :, z) == 1));
    end    
end