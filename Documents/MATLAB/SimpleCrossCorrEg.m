clear all
clf
%D1=7;
D2=21;
code = M63();
disp(code);
%Remember:  n=0 corresponds to 1st location in array
%0 cannot be an index of an array
M=length(code);
NL=200;  %"arbitrary" length
codeplusw=randn(1,NL);
%codeplusw(D1+1:D1+M)=codeplusw(D1+1:D1+M)+code;
codeplusw(D2+1:D2+M)= codeplusw(D2+1:D2+M) - code;
ryx=conv(codeplusw,fliplr(code));
ydata=ryx(M:M+NL-1);
%throw away first M-1 values, IMPORTANT ^^
figure(1)
stem([0:M-1],code,'LineWidth',3)
rxx=conv(code,fliplr(code));
title('x[n] = Shift Register Length 15')
xlabel('n')
ylabel('x[n]')
figure(2)
stem([-(M-1):(M-1)],rxx,'LineWidth',3)
title('Autocorrelation')
xlabel('n')
ylabel('r_{xx} [n]')
figure(3)
subplot(2,1,1)
stem(0:NL-1,codeplusw,'LineWidth',3)
title('y[n] = recorded data')
xlabel('n')
ylabel('y[n]')
subplot(2,1,2)
stem(0:NL-1,ydata,'LineWidth',4)
title('r_{yx} [n] = Cross-correlation')
xlabel('n')
ylabel('r_{yx} [n]')
hold on
%plot([D1 D1], [0 max((ydata))],'r--','LineWidth',3)
plot([D2 D2], [0 -max(abs(ydata))],'r--','LineWidth',3)
hold off

