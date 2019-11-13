function [Imagen_filtrada] = ContraHarmonic_201617340_201618027(imagen,ventana, Q)

tam = size(imagen); % tamaño imagen;
path = (ventana-1)/2; % tamaño del borde
filt = uint8(zeros(tam(1,1) + ventana-1, tam(1,2) + ventana -1)); % Se crea la matriz de imagen de mayor tamaño
filt(path+1:size(filt,1)-path , path+1:size(filt,2)-path) = imagen; % Se llena la matriz de la imagen de mayor tamaño con la imagen original
filt = double(filt);
tamF = size(filt); % tamaño imagen grande;
kernel = uint64(zeros(ventana, ventana)); % se crea una matriz del tamaño que entra por parámetro


for i=path+1: tamF(1)-path
    for j =path+1:tamF(2)-path
        kernel = filt(i-path:i+path,j-path:j+path); %El kernel se llena con los valores vecinos del pixel a filtrar
        
        kernelN = power(kernel,Q+1); %Se eleva cada valor de la matriz a Q+1
        kernelN (kernelN==Inf)=0;
        kernelD = power(kernel,Q); %Se eleva cada valor de la matriz a Q
        kernelD ( kernelD== Inf)=0;
        %             kernelN = (1./kernel).^(-Q-1); %Se eleva cada valor de la matriz a Q+1
        %             kernelD = (1./kernel).^(-Q); %Se eleva cada valor de la matriz a Q
        %
        %         end
        num = sum(sum(kernelN,1),2); %Se hace la sumatoria de los valores de la matriz
        den = sum(sum(kernelD,1),2); %Se hace la sumatoria de los valores de la matriz
        imagen(i-path,j-path) = num/den; %El pixel a filtrar toma el valor del cociente.
    end
end
Imagen_filtrada = imagen;
end