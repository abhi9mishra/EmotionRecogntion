
function shape = InitShape(bbox,rshape)
    n = size(rshape,1)/2;
    a = 0.80*bbox(3)/(max(rshape(1:n))-min(rshape(1:n)));
    b = 0;
    tx = bbox(1) + bbox(3)/2;
    ty = bbox(2) + bbox(4)/2+15;

    shape = zeros(2*n,1);
    for i = 1:n
        shape(i) = a*rshape(i) - b*rshape(i+n) + tx;
        shape(i+n) = b*rshape(i) + a*rshape(i+n) + ty;
    end
end
