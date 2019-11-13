% 7.1.1
im=imread (fullfile(toolboxdir('images'),'imdata', 'football.jpg'));
im2 = rgb2gray(im);
mascara = int8(im2>230);

for i =1:size(im,1)
    for j = 1: size(im,2)
        if mascara(i,j) == 1
            im(i,j,1)= 2;
            im(i,j,2)= 253;
            im(i,j,3)= 254;
        end
    end
end
imshow(im);
pause
%%
% 7.1.3
tree =imread (fullfile(toolboxdir('images'),'imdata', 'trees.tif'));
eight=imcomplement(imread (fullfile(toolboxdir('images'),'imdata', 'eight.tif')));
eight2 = imresize(eight,size(tree));

suma = imadd(eight2, tree);
imshow(suma,[0 200]);
pause

% 7.1.4
camara = uint16(imread (fullfile(toolboxdir('images'),'imdata', 'cameraman.tif')));
arroz = uint16(imread (fullfile(toolboxdir('images'),'imdata', 'rice.png')));

multiplicacion = immultiply(camara, arroz);
imshow(multiplicacion);

%% 7.1.5
im =imread (fullfile(toolboxdir('images'),'imdata', 'eight.tif'));
centro=[size(im,1)/2 size(im,2)/2];
matT=uint8(zeros(size(im,1),size(im,2)));
radio=min(centro(1),centro(2));
for i=1:size(im,1)
    for j=1:size(im,2)
        de=(((centro(1)-i)^2)+(centro(2)-j)^2)^0.5;
        if de<radio
            matT(i,j)=1;
        else
            matT(i,j)=0;
        end
        
    end
end

imCirculo=immultiply(im,matT);
imshow(imCirculo);
pause;
%% 7.2 Precisión y cobertura

% anotaciones = 0;
% detecciones = 0;
% verdaderosPos = 0;
% for i = 1:size(method,1)
%     imagen = method{1,i};
%     anotacion = imagen{1,1};
%     deteccion = imagen{1,2};
%     score = imagen{1,3};
%     if score > 90
%         xa = anotacion(1,1);
%         ya = anotacion(1,2);
%         ha = anotacion(1,3);
%         wa = anotacion(1,4);
%         
%         xd = deteccion(1,1);
%         yd = deteccion(1,2);
%         hd = deteccion(1,3);
%         wd = deteccion(1,4);
%         
%         an = zeros(120,120);
%         an(xa:xa+wa,ya:ya+ha) = 1;
%         
%         det = zeros(120,120);
%         det(xd:xd+wd,yd:yd+hd) = 1;
%         
%         un = an ==1 & det==1;
%         inter = an==1 | det==1;
%     end    
% end
% 
% precision = verdaderosPos/detecciones;
% cobertura = verdaderosPos/anotaciones;

%% 7.3

im=imread (fullfile(toolboxdir('images'),'imdata', 'football.jpg'));
Intensity_201617340_201618270(im,r1,r2,s1,s2);

%% Bono

