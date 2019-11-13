function Intensity_2016173140_201618270 (imagen, r1, r2, s1,s2)
imagenT = imagen;

for i =1:size(imagenT,1)
    for j =1:size(imagenT,2)
        pixel = imagenT(i,j);
        if pixel <=r1
            imagenT(i,j) = pixel*(s1/r1);
        elseif pixel > r1 & pixel < r2
            imagenT(i,j) = ((s2-s1)/(r2-r1))*(pixel -r1)+s1;
        else
            imagenT(i,j) = ((255-s2)/(255-r2))*(pixel -r2) + s2;
        end
    end
end

x = 0:1:255;
y = zeros(1,256);
for i = 1: size(x,2)
    if x(i)<=r1
        y(i) = x(i)*(s1/r1);
    elseif x(i)> r1 & x(i) < r2
        y(i) = ((s2-s1)/(r2-r1))*(x(i) -r1)+s1;
    elseif x(i)>=r2
        y(i) = ((255-s2)/(255-r2))*(x(i) -r2) + s2;
    end
end


figure;
subplot(1,2,1)
imshow(imagen);
title('Imágen original')

subplot(1,2,2)
imshow(imagenT)
title('Imágen transformada');
pause

figure
plot(x,y)
title('Función de la transformación');
end