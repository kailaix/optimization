load mnist.mat
l = 1;
t = 1e-4;
max_iter = 5000;
err = PGM(Xtest,ytest+1,l,t,max_iter,f_star);
save('err.mat','err');