function[Imagen_filtrada] = AdaptativeMedian_201617340_201618027(imagen, ventana)


tam = size(imagen); % tamaño imagen;
path = (ventana-1)/2; % tamaño del borde
filt = int8(zeros(tam(1,1) + ventana-1, tam(1,2) + ventana -1)); % Se crea la matriz de imagen de mayor tamaño
filt(path+1:size(filt,1)-path , path+1:size(filt,2)-path) = imagen; % Se llena la matriz de la imagen de mayor tamaño con la imagen original
tamF = size(filt); % tamaño imagen grande;

for i=path+1: tamF(1)-path;
    for j =path+1:tamF(2)-path
        k = 1;
        while k <= ventana
            kernel = zeros(k, k); %Ventana que se usará para filtrar
            a = k^2; %Tamaño del vector en el que se organiza los valores
            mediana = (a-1)/2 + 1; %Valor central del vecotr
            vector = int8(zeros(a,1)); % Vector que organiza los valores
            
            
            kernel = filt(i-path:i+path,j-path:j+path); %El kernel se llena con los valores vecinos del pixel a filtrar
            vector = kernel(:); % Se organizan los valores de la matriz en el vector
            vector = sort(vector); % Se organizan los valores del vector.
            median = vector(mediana);% El valor medio del vector.                      
            %Condicional que verifica que el valor no sea un impulso
            if median ~= 0 && median ~= 255
                imagen(i-path,j-path) = median; %El pixel a filtrar toma el valor del valor medio de la ventana
                break;
            else
                k = k+2; %Si el valor medio es un impulso se repite el proceso con un valor de ventana mas grande
            end
        end
    end
end

Imagen_filtrada = imagen;
end