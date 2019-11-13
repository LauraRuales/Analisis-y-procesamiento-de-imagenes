function MyEspHistogram_201617340_201618027(imagen_original, imagen_template)

histO = zeros(256,4);
histT = zeros(256,4);

tamO = size(imagen_original,1)*size(imagen_original,2);
tamT = size(imagen_template,1)*size(imagen_template,2);

for i = 0:255
    a = int8(imagen_original == i);
    b = int8(imagen_template == i);
    
    %cantidad pixeles por intensidad
    histO(i+1,1) = sum(sum(a,1),2);
    histT(i+1,1) = sum(sum(b,1),2);
    
    %Probabilidad pixeles
    histO(i+1,2) = histO(i+1,1)/tamO;
    histT(i+1,2) = histT(i+1,1)/tamT;
    
    %probabilidad acumulada
    if i ==0
        histO(i+1,3) = histO(i+1,2);
        histT(i+1,3) = histT(i+1,2);
    else
        histO(i+1,3) =histO(i,3)+ histO(i+1,2);
        histT(i+1,3) =histT(i,3)+ histT(i+1,2);
    end
    
    % Valor histograma ecualizado
    histO(i+1,4) = round(histO(i+1,3)*255);
    histT(i+1,4) = round(histT(i+1,3)*255);
end


final = int8(zeros(size(imagen_original)));
for i = 0:255
    out = int8(imagen_original==i);
    modificado = histO(i+1,4);
    nuevo = histT(:,4);
    [minimo,buscado]=min(abs(nuevo-modificado));
    out = out*buscado(1,1);
    final = final+out;
end

histM = zeros(256,1);
for i = 0:255
    m = int8(final == i);
    histM(i+1,1) = sum(sum(m,1),2);
end


figure
subplot(2,3,1)
histMO = imhist(imagen_original);
bar(histMO);
title('Histograma Imagen Original Matlab')

subplot(2,3,2)
histMT = imhist(imagen_template);
bar(histMT);
title('Histograma Imagen Template Matlab')

subplot(2,3,3)
ajustada = histeq(imagen_original,histMT);
histMM = imhist(ajustada);
bar(histMM);
title('Histograma Imagen Modificada Matlab')

subplot(2,3,4)
bar(0:1:255, histO(:,2));
title('Histograma Imagen Original')

subplot(2,3,5)
bar(0:1:255, histT(:,2));
title('Histograma Imagen Template')

subplot(2,3,6)
bar(0:1:255, histM(:,1));
title('Histograma Imagen Modificada')

pause
figure
subplot(2,2,1)
imshow(imagen_original);
title('Imagen Original')

subplot(2,2,2)
imshow(imagen_template)
title('Imagen Template')

subplot(2,2,3)
imshow(final)
title('Imagen Modificada')

subplot(2,2,4)
imshow(ajustada)
title('Imagen Modificada Matlab')


scO = 0;
scT = 0;
scM = 0;

 for i =1:256
scO = scO + (histO(i,1) - histMO(i,1))^2;
scT = scT + (histT(i,1) - histMT(i,1))^2;
scM = scM + (histM (i,1) - histMM(i,1))^2;
 end
 scO = scO/256
 scT = scT/256
 scM = scM/256
