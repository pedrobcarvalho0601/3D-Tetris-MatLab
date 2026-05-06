%recebe um valor random entre 1 e 4 e envia a peça

function [novaPeca, Pontos] = Pecas(sel)

switch sel
    case 1
        %peça 1x1x1
        Pontos = 1;
    case 2
        %peça 2x2x2
        Pontos = 8;
    case 3
        %peça 2x2x1
        Pontos = 4;
    case 4
        %peça 3x3x1
        Pontos = 9;
end