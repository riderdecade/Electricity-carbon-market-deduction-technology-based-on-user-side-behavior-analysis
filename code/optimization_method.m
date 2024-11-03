%%
ti = 0:0.001:10;
fi = min(min(2*ti,4),16-3*ti);
l = plot(ti,fi);
grid on;hold on
l = plot(ti,0.001*cumsum(fi))

%%
sdpvar x
sdpvar f
region = binvar(3,1);

R1 = [0 <= x <= 2];
R2 = [2 <= x <= 4];
R3 = [4 <= x <= 10];
Model = [implies(region(1), [R1, f == x^2])
         implies(region(2), [R2, f == -4 + 4*x])
         implies(region(3), [R3, f == -28 + 16*x - 1.5*x^2])
         sum(region) == 1
         [0 <= x <= 10, -100 <= f <= 100]];

optimize(Model, -f)
%%
sdpvar x1 x2 x3
Model = [implies(region(1), [R1, x1 == x, x2 == 0, x3 == 0])
         implies(region(2), [R2, x2 == x, x1 == 0, x3 == 0])
         implies(region(3), [R3, x3 == x, x1 == 0, x2 == 0])
         sum(region) == 1
         [0 <= [x x1 x2 x3] <= 10]];
f = x1^2 + (-4*region(2)+4*x2) + (-28*region(3)+16*x3 - 1.5*x3^2);
optimize(Model, -f)

%%
sdpvar z
sdpvar f
f1 = 2*z; 
f2 = 4;   
f3 = 16-3*z;
q1 = int(f1,z,0,x);
q2 = int(f1,z,0,2) + int(f2,z,2,x);
q3 = int(f1,z,0,2) + int(f2,z,2,4) + int(f3,z,4,x);

Model = [implies(region(1), [R1, f == q1])
         implies(region(2), [R2, f == q2])
         implies(region(3), [R3, f == q3])
         sum(region) == 1
         [0 <= x <= 10, -100 <= f <= 100]];

optimize(Model, -f)

%%
clc;
yalmip("clear")
y = sdpvar(2,3);
getvariables(y)

depends(y)

%%
% 定义决策变量
x = sdpvar(1,1);
y = sdpvar(2,3);

% 定义约束条件
Constraints = [x >= 0, sum(y) == 1];

% 定义目标函数
Objective = x^2 + norm(y,1);

% 求解优化问题
optimize(Constraints, Objective);

% 获取结果
optimal_x = value(x);
optimal_y = value(y);

% 显示结果
disp('Optimal x:');
disp(optimal_x);
disp('Optimal y:');
disp(optimal_y);

base_x=getbase(x);
base_y=getbase(y);

disp(base_x)
disp(base_y)


%%
yalmip('clear')
x = sdpvar(1);
y = sdpvar(1);
z = [1 2*x;
    3*y 4*x+5*y+6*x^2];

base_z=getbase(z)

full(getbase(z))


%%
yalmip("clear")
x=sdpvar(1);
getvariables(x)
y=sdpvar(1);
getvariables(y)
z=x^2;
getvariables(z)
all=recover([1 2 3])
all=all-[x;y;x^2]














