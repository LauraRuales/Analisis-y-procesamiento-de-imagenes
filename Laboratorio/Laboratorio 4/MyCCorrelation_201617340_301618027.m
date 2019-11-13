function MyCCorrelation_201617340_301618027(imagen, mascara, condicion_frontera)
im = imread('cameraman.tif');
tam = size(im);
a = (tam(1))/2; %ancho
b = (tam(2))/2; % alto
im2 = zeros(tam(1)+2, tam(2)+2)
im2(2:tam(1)+1;2:tam(2)+1) = im;
im3 = zeros(size(im);
for i = 1: tam(1,1) % Recorrido para el ancho de la imagen
    for j = 1:tam(1,2) %Recorrido para el alto de la imagen
       m = zeros(3,3)
       for k =1:3
       m(:,k) = i-a;i+a;
       m(k,:) = j-b;j+n;
    end
end