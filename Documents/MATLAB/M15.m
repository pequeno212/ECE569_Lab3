function [m15] = M15()

clear all
clf
register=[1 0 0 0];
for ri=1:15,
m15(ri)=register(1,4);
register(2:4)=register(1:3);
register(1,1)=rem((register(1,1)+m15(1,ri)),2);
end
m15=2*m15-1;
stem((0:14),m15)




