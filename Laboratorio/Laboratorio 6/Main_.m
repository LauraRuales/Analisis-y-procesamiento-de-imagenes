%% 5.1 Espacios de color

%Se leen las imagenes originales
imagen2 = imread('underwater.jpg');
imagen3 = imread('festival.jpg');
imagen4 = imread('building.jpg');

%3 Transformación 2a - 2b
%Esta imagen se modifica en RGB, se lleva el canal 'Blue' a 0. De este modo
%se lleva todo azul a negro y se conservan las tonalidades rojo, verde y
%amarillos

imagen2b = imagen2;
imagen2b(:,:,3) = 0;

%4 Transformación 2b -2c
%Esta imagen se modifica en RGB, se lleva el canal 'Green' a 0. De este modo
%se lleva todo azul y verde a negro y sólo seconservan las tonalidades
%rojo.
imagen2c = imagen2b;
imagen2c(:,:,2) = 50;

figure;
subplot(1,3,1)
imshow(imagen2)
title('Imagen original');

subplot(1,3,2)
imshow(imagen2b)
title('Imagen transformada b')

subplot(1,3,3)
imshow(imagen2c)
title('Imagen transformada c')
pause

%5
%Se transforma la imagen al espacio de color HSV, el canal 'Hue' se
%convierte en 0 así sólo se tienen en cuenta las tonalidades de rojo. Se
%convierte la imagen en RGB de nuevo para poder visualizarla
hsv = rgb2hsv(imagen3);
hsv(:,:,1) = 0;
imagen3b = hsv2rgb(hsv);

%6
%El canal 'Saturation' se convierte en 0 así sólo se tienen en cuenta los niveles de gris.
%Se convierte la imagen en RGB de nuevo para poder visualizarla

hsv2 = hsv;
hsv2(:,:,2) = 0;
imagen3c = hsv2rgb(hsv2);

figure;
subplot(1,3,1)
imshow(imagen3)
title('Imagen original');

subplot(1,3,2)
imshow(imagen3b)
title('Imagen transformada b')

subplot(1,3,3)
imshow(imagen3c)
title('Imagen transformada c')
pause

%7
%Se transforma la imagen al espacio de color LAB, el canal 'A' se
%convierte en 0 así los valores de rojo y verde se convierten en niveles de gris.
%Se convierte la imagen en RGB de nuevo para poder visualizarla
lab = rgb2lab(imagen4);
lab(:,:,2)= 0;

imagen4b = lab2rgb(lab);

%8
%El canal 'B' se convierte en 0 así sólo se tienen en cuenta los niveles de gris.
%Se convierte la imagen en RGB de nuevo para poder visualizarla

lab2 = lab;
lab2(:,:,3) = 0;
imagen4c = lab2rgb(lab2);

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

%Se crea una celda en la que se guardaran las imagenes
imagenes = {};

% Se inicializa las celdas con las imagenes
for i = 1:30
    j = int2str(i);
    nombre = strcat(j,'.png');
    im = imread(nombre);
    imagenes{i} = im;
end

%Se crea un array para almacenar la clasificación
clasificacion = zeros(30,1);
for i = 1:30
    % Se separan los valores de la imagen por cada canal
    im = imagenes{i};
    R = im(:,:,1);
    G = im(:,:,2);
    B = im(:,:,3);
    
    %Se suman todos los valores de la imagen en cada canal
    R = sum(sum(R,1),2);
    B = sum(sum(B,1),2);
    G = sum(sum(G,1),2);
    
    %Se la porción de verde es mayor a la rojo y azul, los ojos se
    %clasifican como verdes.
    if G>B & G>R
        clasificacion(i) = 2;
        
        %Se la porción de azul es mayor a la rojo y verde, los ojos se
        %clasifican como azules.
    elseif  B>G & B>R
        clasificacion(i) = 3;
        %Si los ojos no son azules o verdes, son color miel
    else
        clasificacion(i) = 1;
    end
end

an = readtable('Anotaciones.txt');
an = table2array(an(:,2));
mat = zeros(3,3);

for i =1:30
    if an(i) == 1 && clasificacion(i) == 1
        mat(1,1) = mat(1,1)+1;
    elseif  an(i) == 2 && clasificacion(i) == 2
        mat(2,2) = mat(2,2)+1;
    elseif  an(i) == 3 && clasificacion(i) == 3
        mat(3,3) = mat(3,3)+1;
    end
end
mat = mat/30;
ACA = sum(sum(mat,1),2);


