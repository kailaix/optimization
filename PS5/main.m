Y = [ 0.8404   -2.1384
   -0.8880   -0.8396
    0.1001    1.3546
   -0.5445   -1.0722
    0.3035    0.9610
   -0.6003    0.1240
    0.4900    1.4367
    0.7394   -1.9609
    1.7119   -0.1977
   -0.1941   -1.2078
   12.9080    9.6462
   10.8252    9.1764
   11.3790    8.4229
    8.9418   10.5080
    9.5314   10.2820
    9.7275   10.0335
   11.0984    8.6663
    9.7221   11.1275
   10.7015   10.3502
    7.9482    9.7009];

gammas = [0.001,0.01,0.1,1,10];
parfor i=1:length(gammas)
    gamma = gammas(i);
    [E,X] = cluster(Y,gamma);
    f = figure;
    plot(log(E));
    title(['log||DX-Z||_F ,\gamma=' num2str(gamma)])
    ylabel('error')
    xlabel('iterations');
    print(f,'-djpeg',[num2str(i) '_err.jpeg']);
    
    f = figure;
    plot(X(:,1),X(:,2),'or');
    hold
    plot(Y(:,1),Y(:,2),'+b');
    legend('Clustered','Original');
    title(['\gamma=' num2str(gamma)])
    ylabel('y')
    xlabel('x');
    print(f,'-djpeg',[num2str(i) '_pts.jpeg']);
end
% save('E.mat','E','X','Y');
