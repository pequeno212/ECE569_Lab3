function [m63] = M63()

clear all
clf
register=[1 0 0 0 0 0];
for ri=1:63,
m63(ri)=register(1,6);
register(2:6)=register(1:5);
register(1,1)=rem((register(1,1)+m63(1,ri)),2);
end
m63=2*m63-1;
stem((0:62),m63)




