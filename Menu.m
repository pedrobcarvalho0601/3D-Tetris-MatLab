%*******************************************%
% Completar botão "opções" 
% Meter controle de Volume.
%
% O menu está dividido em duas partes,
% uma escondida e outra já ligada,
%
%********************************************%




function Menu()

    % Janela principal
    janela = uifigure('Name', 'Tetris 3D - Menu Principal');
    janela.Position = [100, 100, 800, 600]; 
    janela.Resize = 'off';
    janela.Color = [0.2, 0.2, 0.2];

    % --- IMAGEM DE FUNDO ---
    fundo = uiimage(janela, 'ImageSource', 'Menu_Background.png');
    fundo.Position = [1, 1, 800, 600]; 

    % --- MÚSICA DE FUNDO ---
    [audio, frequencia] = audioread('Menu_Song.mp3'); 
    leitorMusica = audioplayer(audio, frequencia);
    janela.UserData = leitorMusica; 
    leitorMusica.StopFcn = @(src, event) play(src);
    play(leitorMusica);
    
    % =====================================================================
    % --- COMPONENTES DO NOME (INICIALMENTE INVISÍVEIS) ---
    % =====================================================================
    
    % Legenda para o nome
    lblNome = uilabel(janela, 'Text', 'Introduz o teu Nome:', 'Position', [300, 310, 200, 20]);
    lblNome.FontColor = 'w';
    lblNome.FontSize = 16;
    lblNome.Visible = 'off'; % Começa escondido

    % Campo de texto para o nome
    campoNome = uieditfield(janela, 'text', 'Position', [300, 270, 200, 35]);
    campoNome.Visible = 'off'; % Começa escondido

    % Botão para confirmar o nome e iniciar o jogo
    botaoConfirmar = uibutton(janela, 'push', 'Text', 'Confirmar e Iniciar');
    botaoConfirmar.Position = [300, 210, 200, 45];
    botaoConfirmar.BackgroundColor = [0.2, 0.6, 0.2]; % Verde
    botaoConfirmar.FontColor = 'w';
    botaoConfirmar.Visible = 'off'; % Começa escondido

    % =====================================================================
    % --- BOTÕES PRINCIPAIS ---
    % =====================================================================

    % Botão JOGAR
    botaoJogar = uibutton(janela, 'push', 'Text', 'Jogar');
    botaoJogar.Position = [300, 280, 200, 50];
    botaoJogar.FontSize = 18;

    % Botão OPÇÕES
    botaoOpcoes = uibutton(janela, 'push', 'Text', 'Opções');
    botaoOpcoes.Position = [300, 200, 200, 50];
    botaoOpcoes.FontSize = 18;

    % Botão SAIR
    botaoSair = uibutton(janela, 'push', 'Text', 'Sair');
    botaoSair.Position = [300, 130, 200, 50];
    botaoSair.FontSize = 18;
    botaoSair.ButtonPushedFcn = @(src, event) [stop(leitorMusica), close(janela)];

    % =====================================================================
    % --- LÓGICA DE TRANSIÇÃO ---
    % =====================================================================

    % O que acontece ao clicar em JOGAR:
    botaoJogar.ButtonPushedFcn = @(src, event) mostrarCampoNome();

    function mostrarCampoNome()
        % Esconde os botões do menu principal
        botaoJogar.Visible = 'off';
        botaoOpcoes.Visible = 'off';
        botaoSair.Visible = 'off';
        
        % Mostra os campos para o nome
        lblNome.Visible = 'on';
        campoNome.Visible = 'on';
        botaoConfirmar.Visible = 'on';
    end

    % O que acontece ao clicar em CONFIRMAR:
    botaoConfirmar.ButtonPushedFcn = @(src, event) iniciarJogo();

    function iniciarJogo()
        nomePlayer = campoNome.Value;
        if isempty(nomePlayer)
            nomePlayer = 'Jogador Desconhecido';
        end
        
        stop(leitorMusica); % Pára a música
        close(janela);      % Fecha o menu
        
        % Chama o script do Tabuleiro passando o nome
        Tabuleiro(nomePlayer); 
    end
end