A = {[1;1;1] [1;1;2] [1;2;2]};
b = [1;2;3];
fs = {@(x)0 @(x)0 @(x)0};
gs = {@(x)0 @(x)0 @(x)0};

Methods = {'RP-ADMM' 'PD-RADMM' 'P-RADMM' 'ADMM' 'R-ADMM'};


ks=[5];

parfor k=ks
    E = rand_admm(fs,gs,A,b,k);
    f = figure;
    loglog(E(:,1))

    legend('||x-x^*||_2');
    title([Methods{k} ' Convergence Plot']);

    xlabel('Iteration');
    ylabel('Error');
    print(f,'-djpeg',[Methods{k} 'conv.jpeg']);
end
    
    
% for i=1:3
%     E = rand_admm(fs,gs,A,b,i);
%     f = figure;
%     loglog(E(:,1))
% %     hold on
% %     loglog(E(:,2))
%     legend('||x-x^*||_2');
%     title([Methods{i} ' Convergence Plot']);
% 
%     xlabel('Iteration');
%     ylabel('Error');
%     print(f,'-djpeg',[Methods{i} 'conv.jpeg']);
% end

