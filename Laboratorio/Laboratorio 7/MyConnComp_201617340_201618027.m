function [Estructura]= MyConnComp_201617340_201618027(bw)

elEst=ones(3); %Elemento estructurante
largoEl=floor(size(elEst,1)/2);
anchoEl=floor(size(elEst,2)/2);

%Imagen indexada comienza con matriz de 0s, del tamaño de la imagen orginal
%Añado capa de 0s en la imagen original (para mover el elemento estructurante.

bordeFla=zeros(largoEl,size(bw,2));
bw=[bordeFla;bw;bordeFla];
bordeCol=zeros(size(bw,1),anchoEl);
bw=[bordeCol bw bordeCol];

contCon=0; %Contador componentes conexos
indexada=zeros(size(bw));
final=indexada;
%Ciclo que recorre toda la imagen
for i=1:size(bw,1)
    for j=1:size(bw,2)
        if bw(i,j)==1 && final(i,j)==0
            %Nuevo componente, se encuentra el primer pixel de un nuevo
            %componente conexo 
            contCon=contCon+1;
            indexada(i,j)=contCon;
            interseccion=imdilate(indexada,elEst) & bw ;
            indexada=interseccion;
            completo=0;
            
            %Se dilta la imagen resultante hasta que alcance la frontera de
            %la imagen original
            while ~completo
                indexada=imdilate(indexada,elEst) & bw ;                
                if indexada==interseccion
                    completo=1;
                end
                interseccion=indexada;                
            end
            %Se añade a la imagen final el componente conexo encontrado y 
            final=final+(indexada*contCon);
            indexada=zeros(size(bw));
        end        
    end
end

Estructura=final(2:size(final,1)-1,2:size(final,2));
