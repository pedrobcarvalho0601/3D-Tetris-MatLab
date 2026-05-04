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
    
   % 1. Nome do Jogador
    lblNome = uilabel(janela, 'Text', 'Nome do Jogador:', 'Position', [300, 420, 200, 20], 'FontColor', 'w', 'FontSize', 14);
    campoNome = uieditfield(janela, 'text', 'Position', [300, 390, 200, 30]);
    lblNome.Visible = 'off'; 
    campoNome.Visible = 'off';

    % 2. Dimensão 'n' (Base n x n)
    lblDimN = uilabel(janela, 'Text', 'Largura/Profundidade (n):', 'Position', [300, 340, 200, 20], 'FontColor', 'w', 'FontSize', 14);
    % O spinner garante que o valor é numérico e fica entre 4 e 10. Começa no 5.
    spinnerN = uispinner(janela, 'Limits', [4, 10], 'Value', 5, 'Position', [300, 310, 200, 30]);
    lblDimN.Visible = 'off'; spinnerN.Visible = 'off';

    % 3. Dimensão 'h' (Altura)
    lblDimH = uilabel(janela, 'Text', 'Altura (h):', 'Position', [300, 260, 200, 20], 'FontColor', 'w', 'FontSize', 14);
    % Limites entre 4 e 10. Começa no 10.
    spinnerH = uispinner(janela, 'Limits', [4, 10], 'Value', 10, 'Position', [300, 230, 200, 30]);
    lblDimH.Visible = 'off'; spinnerH.Visible = 'off';

    % 4. Dica / Recomendação
    lblDica = uilabel(janela, 'Text', '(Recomendado: n=5 e h=10)', 'Position', [300, 190, 200, 20], 'FontColor', 'y', 'FontSize', 12, 'HorizontalAlignment', 'center');
    lblDica.Visible = 'off';

    % 5. Botão para Confirmar
    botaoConfirmar = uibutton(janela, 'push', 'Text', 'Confirmar e Iniciar');
    botaoConfirmar.Position = [300, 120, 200, 45];
    botaoConfirmar.BackgroundColor = [0.2, 0.6, 0.2];
    botaoConfirmar.FontColor = 'w';
    botaoConfirmar.FontSize = 14;
    botaoConfirmar.Visible = 'off';

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
        lblNome.Visible = 'on'; campoNome.Visible = 'on';
        lblDimN.Visible = 'on'; spinnerN.Visible = 'on';
        lblDimH.Visible = 'on'; spinnerH.Visible = 'on';
        lblDica.Visible = 'on'; botaoConfirmar.Visible = 'on';
    end

    % O que acontece ao clicar em CONFIRMAR:
    botaoConfirmar.ButtonPushedFcn = @(src, event) iniciarJogo();

    function iniciarJogo()
        nomePlayer = campoNome.Value;
        if isempty(nomePlayer)
            nomePlayer = 'Jogador Desconhecido';
        end
        
        n = spinnerN.Value; % Guarda o valor de n (largura e profundidade)
        h = spinnerH.Value; % Guarda o valor de h (altura)

        stop(leitorMusica); % Pára a música
        close(janela);      % Fecha o menu
        
        % Chama o script do Tabuleiro passando o nome
        Tabuleiro(nomePlayer, n, h); 
    end
end