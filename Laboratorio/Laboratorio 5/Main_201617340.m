%Se descomprime el zip, se leen y se muestran las im�genes originales.
imagenes = unzip('microscopia.zip');

im1 = imagenes{1,2};
im2 = imagenes{1,3};

imagen1 = imread(im1);
imagen2 = imread(im2);
figure
subplot(1,2,1)
imshow(imagen1);
title('Imagen de microscop�a 1');

subplot(1,2,2)
imshow(imagen2);
title('Imagen de microscop�a 2');
pause;
%% 6.1 Filtro Mediano

%Se utiliza un filtro mediano y se muestran las im�genes filtradas.
[filtMed1] = Median_201617340_201618027(imagen1,3);
[filtMed2] = Median_201617340_201618027(imagen2,3);

figure;
imshow(filtMed1);
title({'Imagen de microscop�a 1';'Ventana de tama�o 3'});
pause

figure
imshow(filtMed2);
title({'Imagen de microscop�a 2';'Ventana de tama�o 3'});
pause;

%% 6.2 Filtro Mediano Adaptativo

%Se utiliza un filtro mediano adaptativo y se muestran las im�genes filtradas.
[filtMedA1] = AdaptativeMedian_201617340_201618027(imagen1,3);
[filtMedA2] = AdaptativeMedian_201617340_201618027(imagen2,3);

figure;
imshow(filtMedA1);
title({'';'Imagen de microscop�a 1';'Tama�o m�ximo de ventana: 3'});
pause

figure
imshow(filtMedA2);
title({'Imagen de microscop�a 2' ;'Ventana de tama�o 3'});
pause;

%% 6.3 Funci�n Filtro Contra-arm�nico

%Se utiliza un filtro Contra-Arm�nico y se muestran las im�genes filtradas.
[filtCA1] = ContraHarmonic_201617340_201618027(imagen1,3,-2);
[filtCA2] = ContraHarmonic_201617340_201618027(imagen2,7,-2);

figure;
imshow(filtCA1);
title({'Imagen de microscop�a 1';'Tama�o de ventana:3 ';'Q= -2'});
pause;

figure;
imshow(filtCA2);
title({'Imagen de microscop�a 2';'Tama�o de ventana:7 ';'Q= -2'});
