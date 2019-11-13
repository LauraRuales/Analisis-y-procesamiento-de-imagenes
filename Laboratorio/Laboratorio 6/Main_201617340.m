%% 5.1 Espacios de color

% Se leen las imágenes originales
imagen2 = imread('underwater.jpg');
imagen3 = imread('festival.jpg');
imagen4 = imread('building.jpg');

%Se hace la transformación de la imagen 2b y 2c. Además se presentan en un
%subplot
imagen2b = imagen2;
imagen2b(:,:,3) = 0;

imagen2c = imagen2b;
imagen2c(:,:,2) = 50;

figure;
subplot(1,3,1)
imshow(imagen2)
title('Imagen original');

subplot(1,3,2)
imshow(imagen2b)
title('Imagen transformada 2b')

subplot(1,3,3)
imshow(imagen2c)
title('Imagen transformada 2c')
pause

%Se convierte la imagen de RGB a HSV y se hace la transformación a la imagen
%3b y 3c y se convierte nuevamente en RGB. Además se presentan en un subplot.

hsvB = rgb2hsv(imagen3);
hsvB(:,:,1) = 0;

hsvC = hsvB;
hsvC(:,:,2) = 0;

imagen3c = hsv2rgb(hsvC);
imagen3b = hsv2rgb(hsvB);

figure;
subplot(1,3,1)
imshow(imagen3)
title('Imagen original');

subplot(1,3,2)
imshow(imagen3b)
title('Imagen transformada 3b')

subplot(1,3,3)
imshow(imagen3c)
title('Imagen transformada 3c')
pause

%Se convierte la imagen de RGB a LAB  y se hace la transformación a la imagen
%4b y 4c y se convierte nuevamente en RGB. Además se presentan en un subplot.

labB = rgb2lab(imagen4);
labB(:,:,2)= 0;

labC = labB;
labC(:,:,3) = 0;

imagen4b = lab2rgb(labB);
imagen4c = lab2rgb(labC);

figure;
subplot(1,3,1)
imshow(imagen4)
title('Imagen original');

subplot(1,3,2)
imshow(imagen4b)
title('Imagen transformada b')

subplot(1,3,3)
imshow(imagen4c)
title('Imagen transformada c')
pause

%% 5.2 Problema biomédico

%Inicializar una celda que contenga los ojos.
ojos = {};
for i = 1:30
    ojos{i} = imread(strcat(int2str(i),'.png'));
end

%Leer el archivo de anotaciones y guardarlas en un vector
anotaciones = readtable('Anotaciones.txt');
anotaciones = table2array(anotaciones(:,2));

clas = zeros(length(anotaciones),2);
clas(:,1) = anotaciones;

%Matriz de confusión
matriz = zeros(3,3);

%Calasificación de cada ojo
for i = 1:30
    ojo = ojos{i};
    
    R = ojo(:,:,1); R = sum(sum(R,1),2);
    G = ojo(:,:,2); G = sum(sum(G,1),2);
    B = ojo(:,:,3); B = sum(sum(B,1),2);
    
    if  B>G & B>R
        clas(i,2) = 3;
        
    elseif G>B & G>R
        clas(i,2) = 2;
    else
        clas(i,2) = 1;
    end
    matriz(clas(i,1), clas(i,2))= matriz(clas(i,1), clas(i,2)) +1;    
end

%Normalización de la matriz y ACA.
matriz = matriz/30;
ACA = matriz(1,1) + matriz(2,2)+ matriz(3,3);



