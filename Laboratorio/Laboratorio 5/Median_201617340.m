function[Imagen_filtrada] = Median_201617340_201618027(imagen, ventana)

%Se crea una imagen de mayor tamaño para poder hacer uso del filtro en los
%extremos de la imagen

tam = size(imagen); % tamaño imagen;
path = (ventana-1)/2; % tamaño del borde 
filt = int8(zeros(tam(1,1) + ventana-1, tam(1,2) + ventana -1)); % Se crea la matriz de imagen de mayor tamaño
filt(path+1:size(filt,1)-path , path+1:size(filt,2)-path) = imagen; % Se llena la matriz de la imagen de mayor tamaño con la imagen original 
tamF = size(filt); % tamaño imagen grande; 

kernel = zeros(ventana, ventana); %Ventana que se usará para filtrar
a = ventana^2; %Tamaño del vector en el que se organiza los valores
mediana = (a-1)/2 + 1; %Valor central del vecotr
vector = int8(zeros(a,1)); % Vector que organiza los valores 

%Ciclo que recorre la imagen de mayor tamaño
for i=path+1: tamF(1)-path
    for j =path+1:tamF(2)-path
        kernel = filt(i-path:i+path,j-path:j+path); %El kernel se llena con los valores vecinos del pixel a filtrar
        vector = kernel(:); % Se organizan los valores de la matriz en el vector
        vector = sort(vector); % Se organizan los valores del vector. 
        imagen(i-path,j-path) = vector(mediana); %El pixel a filtrar toma el valor medio del vector
    end    
end

Imagen_filtrada = imagen;
end