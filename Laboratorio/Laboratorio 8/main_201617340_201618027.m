%% Elementos estructurantes
%Lee la imagen, la convierte a escala de grises, la binariza y toma el
%complemento (para seguir la convenci�n de objeto de inter�s 1 (letras) y
%fondo 0)
im=imread(fullfile(pwd, 'Lorem_Ipsum_Helvetica.png'));
im=rgb2gray(im);
im=imbinarize(im);
im=imcomplement(im);
subplot(2,3,1);
imshow(imcomplement(im));
title('Original');

%Elemento 1: cuadrado de 2x2
el=[1 1; 1 1];

%Apertura por reconstrucci�n
erosion=imerode(im,el);
subplot(2,3,2);
imshow(imcomplement(imreconstruct(erosion,im)));
title('Cuadrado 2x2');

%Elemento 2: disco de radio 2
el=strel('disk',2);

%Apertura por reconstrucci�n
erosion=imerode(im,el); 
subplot(2,3,3);
imshow(imcomplement(imreconstruct(erosion,im)));
title('Circulo de radio 2');

%Elemento 3: l�nea vertical de 4 pixeles
el=[1;1;1;1];

%Apertura por reconstrucci�n
erosion=imerode(im,el);
subplot(2,3,4);
imshow(imcomplement(imreconstruct(erosion,im)));
title('L�nea vertical de 4 p�xeles');

%Elemento 4: l�nea horizontal de 3 pixeles
el=[1 1 1];

%Apertura por reconstrucci�n
erosion=imerode(im,el);
subplot(2,3,5);
imshow(imcomplement(imreconstruct(erosion,im)));
title('L�nea horizontal de 3 p�xeles');

%Elemento 5: rectangulo de 4x3
el=[1 1 1;1 1 1;1 1 1;1 1 1];

%Apertura por reconstrucci�n
erosion=imerode(im,el);
subplot(2,3,6);
imshow(imcomplement(imreconstruct(erosion,im)));
title('Rectangulo 4x3');
pause;

% Reconocer T's

%Elemento estructurante
el=[0 0 1 1 1 1 0;1 1 1 1 1 1 1;1 1 1 1 1 1 1;1 1 1 1 1 1 1;1 1 1 1 1 1 1;0 0 1 1 1 1 0];

%Apertura por reconstrucci�n
erosion=imerode(im,el);
reconstruccion=imreconstruct(erosion,im);
%Muestra los resultados en pantalla
subplot(1,2,1);
imshow(imcomplement(im));
title('Imagen Original');
subplot(1,2,2);
imshow(imcomplement(reconstruccion));
title('Recuperaci�n de letras t');
pause;

% Reconocer O's

im=imread(fullfile(pwd, 'Lorem_Ipsum_Helvetica.png'));
im=rgb2gray(im);
im=imcomplement(imbinarize(im));
el=[0 0 0 0 0 1 1 1 1;0 0 0 0 1 1 1 1 0;0 0 0 1 1 1 1 1 0;1 1 1 1 1 1 1 0 0;1 1 1 1 1 1 0 0 0;1 1 1 1 1 0 0 0 0;1 0 0 0 0 0 0 0 0];

%Apertura por reconstrucci�n
erosion=imerode(im,el);
reconstruccion=imreconstruct(erosion,im);
%Muestra los resultados en pantalla
subplot(1,2,1);
imshow(imcomplement(im));
title('Imagen Original');
subplot(1,2,2);
imshow(imcomplement(reconstruccion));
title('Recuperaci�n de letras o');
pause;

% Recuperaci�n de M's

im=imread(fullfile(pwd, 'Lorem_Ipsum_Helvetica.png'));
im=rgb2gray(im);
im=imcomplement(imbinarize(im));
el=[1   1   0   0   0   0   0   0   1
    1   1   1   1   0   0   1   1   1
    1   1   1   1   1   1   1   1   1
    0   1   1   1   1   1   1   1   0
    0   0   1   1   1   1   1   0   0
    0   0   1   1   1   1   1   0   0];

%Apertura por reconstrucci�n
erosion=imerode(im,el);
reconstruccion=imreconstruct(erosion,im);
%Muestra los resultados en pantalla
subplot(1,2,1);
imshow(imcomplement(im));
title('Imagen Original');
subplot(1,2,2);
imshow(imcomplement(reconstruccion));
title('Recuperaci�n de letras m');
pause;
%% Jerarqu�as y h m�nimos
 
%Lee y carga la imagen  
im=(imread (fullfile(toolboxdir('images'),'imdata', 'cameraman.tif')));
%Elemento estructural: disco de radio 1
el=strel('disk',1);
%Crea el gradiente de la imagen
grad=imsubtract(imdilate(im,el),imerode(im,el));

%Valores de altura m�nima a probar
 h=[0 1 5 10 20 30 50 75 100];
 
%Ciclo que recorre y muestra en pantalla los resultados para cada altura de
%m�nimos
 for i=1:size(h,2)
    %Impone sobre la imagen los nuevos m�nimos
    marcador=imextendedmin(grad,h(i));
    gradH=imimposemin(grad,marcador);
    %Crea el watershed con los m�nimos predefinidos
    ws=watershed(gradH);
    
    subplot(2,5,1);
    imshow(im);
    title('Original');
    
    subplot(2,5,(i+1));
    imshow((ws==0)); %Muestra el watershed en binario (objetos en negro, lineas divisorias en blanco)
    titulo=strcat('Altura m�nima: ',num2str(h(i)),'.');
    title(titulo);
      
 end
pause;
clf;
%N�mero de altura m�nima a probar
 h=(0:1:255);
%N�mero de elementos conexos por h.
 numElementos=zeros(size(h));
 

%Ciclo que recorre y calcula el n�mero de elementos por altura m�nima de
%los m�nimos
 for i=1:1:size(h,2)
    %Impone sobre la imagen los nuevos m�nimos.
    marcador=imextendedmin(grad,h(i));
    gradH=imimposemin(grad,marcador);
    %Crea el watershed con los m�nimos predefinidos.
    ws=watershed(gradH);
    %Calcula y guarda el n�mero de componentes conexos por h.
    info=bwconncomp(imcomplement(ws==0));
    numElementos(i)=info.NumObjects;
        
 end

 %Gr�fica de n�mero de elementos segmentados en la imagen en funci�n de la
 %altura de m�nimos definida.
 plot(h,numElementos,'r');
 xlabel('Altura de los M�nimos Locales');
 ylabel('Elementos en la imagen');
%% Probl�ma biom�dico
%Lee y carga la imagen
bacilos=imread(fullfile(pwd, 'bacillus.jpg'));

%Angulos a los que se calcular� el n�mero de bacilos.
angulo=(0:5:180);
numBacilos=angulo;

%Ciclo que segmenta los bacilos que se encuentran en cada uno de los
%�ngulos predefinidos
for i=1:1:size(angulo,2)
%Elemento estructurante
el=strel('line',10,angulo(i));

%Cuenta los bacilos que est�n en la misma direcci�n que el elemento
%estructurante
clausura=imclose(bacilos,el);
complemento=imcomplement(clausura);
resta=imsubtract(complemento,bacilos);
subplot(1,2,1);
imshow(imbinarize(resta));
conexos=bwconncomp(imbinarize(resta));
numBacilos(i)=conexos.NumObjects;

%Muestra el resultado en pantalla
subplot(1,2,2);
imshow(resta);
title(strcat('Bacilos con orientaci�n: ',num2str(angulo(i)),'�'));
pause;
end
%Gr�fica del n�mero de bacilos encontrados en funci�n del �ngulo al que se
%encuentran.
plot(angulo,numBacilos,'r');
xlabel('�ngulo');
ylabel('N�mero de Bacilos Encontrados');
title('N�mero de Bacilos por �ngulo');
