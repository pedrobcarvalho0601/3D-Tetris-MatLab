function Menu()
    
    % janela principal da interface
    janela = uifigure('Name', 'Tetris 3D - Menu Principal');
    janela.Position = [100, 100, 800, 600]; % [X, Y, Largura, Altura].
    janela.Resize = 'off';
    
    % Muda a cor de fundo da janela para um cinzento escuro (RGB de 0 a 1).
    janela.Color = [0.2, 0.2, 0.2];

    % =====================================================================
    % --- ESPAÇO PARA A TUA IMAGEM DE FUNDO ---

    fundo = uiimage(janela, 'ImageSource', 'Menu_Background.png');
    fundo.Position = [1, 1, 800, 600]; % Faz a imagem cobrir toda a janela.
    % =====================================================================
    

    % =====================================================================
    % --- ESPAÇO PARA A TUA MÚSICA DE FUNDO ---
    
    [audio, frequencia] = audioread('Menu_Song.mp3'); 
    leitorMusica = audioplayer(audio, frequencia);
    
    % Guarda o leitor dentro da janela
    % MATLAB não apaga a música enquanto a janela existir.
    janela.UserData = leitorMusica; 

    leitorMusica.StopFcn = @(src, event) play(src);
    play(leitorMusica);
    % =====================================================================
    

    % =====================================================================
    % --- CRIAR OS BOTÕES (CENTRADOS NO MEIO DA JANELA) ---
    % Como a janela tem 800 de largura, um botão de 200 fica centrado no X=300.

    % Cria o botão Jogar 
    botaoJogar = uibutton(janela, 'push');
    botaoJogar.Text = 'Jogar';
    botaoJogar.Position = [300, 280, 200, 50];     %[X=300, Y=280, Largura=200, Altura=50]
    botaoJogar.FontSize = 18;                      %tamanho da letra 
    botaoJogar.ButtonPushedFcn = @(src, event) disp('A iniciar o Tetris 3D...'); % Define o que acontece ao clicar (neste momento imprime uma mensagem no comando).

    % Cria o botão "Opções" 
    botaoOpcoes = uibutton(janela, 'push');
    botaoOpcoes.Text = 'Opções';
    botaoOpcoes.Position = [300, 200, 200, 50];    %(Y=200)
    botaoOpcoes.FontSize = 18;
    botaoOpcoes.ButtonPushedFcn = @(src, event) disp('A abrir o menu de opções...');

    % Cria o botão "Sair" e associa-o à janela.
    botaoSair = uibutton(janela, 'push');
    botaoSair.Text = 'Sair';
    botaoSair.Position = [300, 130, 200, 50];      %(Y=130).
    botaoSair.FontSize = 18;
    botaoSair.ButtonPushedFcn = @(src, event) close(janela); % fecha a janela usando o comando "close".

end