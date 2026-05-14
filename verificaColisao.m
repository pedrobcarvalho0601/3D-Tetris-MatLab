% --- FUNÇÃO PARA VERIFICAR COLISÃO ---
function colisao = verificaColisao(tab, peca, px, py, pz, limN, limH)
    colisao = false;
    for j = 1:size(peca.coords, 1)
        x = peca.coords(j,1) + px;
        y = peca.coords(j,2) + py;
        z = peca.coords(j,3) + pz;

        % Verifica se saiu dos limites da arena
        if z < 0 || x < 0 || x >= limN || y < 0 || y >= limN
            colisao = true;
            return;
        end

        % Verifica se a célula está ocupada na matriz
        % (+1 para converter de índice base-0 para base-1 do MATLAB)
        if z >= 0 && z < limH
            if tab(x+1, y+1, z+1) == 1
                colisao = true;
                return;
            end
        end
    end
end