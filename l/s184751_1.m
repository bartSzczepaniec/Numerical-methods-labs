Edges = sparse([1,1,2,2,2,3,3,3,4,4,5,5,6,6,7;4,6,3,4,5,5,6,7,5,6,4,6,4,7,6]);
n = 7;

I = speye(n);

l = size(Edges,2);
x = ones(1,l);
in = Edges(2,:);
jn = Edges(1,:);
B = sparse(in,jn,x,n,n);

all = 1:n;
val = zeros(1,n);
for i = 1:n
    val(i) = 1 / sum(B(:,i));
end
A = sparse(all,all,val,n,n);

d = 0.85;
M = I - d * B * A;
b = (1-d)/n * ones(1,n);
b = b';

r = M \ b
bar(r)

x = ones(7,1)