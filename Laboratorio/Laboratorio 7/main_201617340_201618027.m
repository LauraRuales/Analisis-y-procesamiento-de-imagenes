dir (fullfile(toolboxdir('images'),'imdata' ))

%%
im=imread (fullfile(toolboxdir('images'),'imdata', 'coins.png'));
im=imbinarize(im);
subplot(1,3,1);
imshow(im);
title('Orginal');

con=bwlabel(im);
subplot(1,3,2);
imagesc(con);
colorbar;
title('bwlabel');

funcion=MyConnComp_201617340_201618027(double(im));
subplot(1,3,3);
imagesc(funcion);
colorbar;
title('MIO');
%%
con2=bwconncomp(im);
subplot(1,3,3);
imagesc(con2);
colorbar;
title('bwconncomp');

%%

vector=reshape(con,1,[]);

%%
bw=[1 0 1; 0 1 0];
elEst=ones(3);
tamElEst=size(elEst);
%Imagen indexada comienza con matriz de 0s, del tamaño de la imagen orginal
indexada=zeros(size(bw));
%Añado capa de 0s en la imagen original (para mover el elemento estructurante. 
bordeFla=zeros(floor(tamElEst(1)/2),size(bw,2));
bw=[bordeFla;bw;bordeFla];
bordeCol=zeros(size(bw,1),floor(tamElEst(2)/2));
bw=[bordeCol bw bordeCol];

%Ciclo que recorre toda la imagen
for i=1:size(bw,1)
    for j=1:size(bw,2)
    %Nuevo componente, encontré p
    if bw(i,j)==1
        completo=0;
        while completo==0
        er = bw(i-floor(tamElEst(1)/2):i+floor(tamElEst(1)/2),j-floor(tamElEst(2)/2):j+floor(tamElEst(2)/2))|elEst;    
        bw(i-floor(tamElEst(1)/2):i+floor(tamElEst(1)/2),j-floor(tamElEst(2)/2):j+floor(tamElEst(2)/2))= er&bw(i-floor(tamElEst(1)/2):i+floor(tamElEst(1)/2),j-floor(tamElEst(2)/2));
        completo=1;
        end
        
    end
        
    end
end

%%
unzip(fullfile(pwd,'Data.zip'));
