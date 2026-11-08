function [m127] = M127()

clear all
clf

    register=[1 0 0 0 0 0 0];
    for ri=1:127,
    m127(ri)=register(1,7);
    register(2:7)=register(1:6);
    register(1,1)=rem((register(1,1)+m127(1,ri)),2);
    end
    m127=2*m127-1;
    stem((0:126),m127)

end



