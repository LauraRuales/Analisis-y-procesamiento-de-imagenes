load('detection_method.mat');
curva=zeros(100,3);
cont=1;

for j=0.01:0.01:1
    TP=0;
    FN=0;
    FP=0;
    for i=1:size(method,2)
        imagen = method{1,i};
        anotacion = imagen{1,1};
        deteccion = imagen{1,2};
        score = imagen{1,3};
        if score >= j
            an=zeros(120,120);
            an(anotacion(2):anotacion(2)+anotacion(4)-1,anotacion(1):anotacion(1)+anotacion(3)-1)=1;
            det=zeros(120,120);
            det(deteccion(2):deteccion(2)+deteccion(4)-1,deteccion(1):deteccion(1)+deteccion(3)-1)=1;
            
            un = int8(an ==1 | det==1);
            numUn=sum(sum(un,1),2);
            inter = int8(an==1 & det==1);
            numInter=sum(sum(inter,1),2);
            
            if numInter/numUn<j
                FP=FP+1;
                FN=FN+1;
            else
                TP=TP+1;
            end
        else
            FN=FN+1;
        end
    end
    cobertura=TP/(TP+FN);
    cobertura = 1-cobertura;
    presicion=TP/(TP+FP);
    Fmed=(2*presicion*cobertura)/(presicion+cobertura);
    curva(cont,1)=cobertura;
    curva(cont,2)=presicion;
    curva(cont,3) = Fmed;
    cont = cont +1;
end
figure;
% plot(curva(:,1),curva(:,2),'r');
% xlim([0 1]),ylim([0 1]);
% title('Curva Presición/Cobertura');
% xlabel('Cobertura');
% ylabel('Presición');
umbr=0.01:0.01:1;
plot(umbr,curva(:,3))
xlim([0 1]),ylim([0 1]);
title('Curva Umbral/F-medida');
xlabel('Umbral');
ylabel('F-medida');
Fmax=max(curva(:,3));