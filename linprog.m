

A =[ 1	1	1	0	0	0	0	0	0
   	 0	0	0	0	0	0	1	1	1
   	 0	0	0	1	1	1	0	0	0
   	 1	0	0	1	0	0	1	0	0
   	 0	1	0	0	1	0	0	1	0
   	 0	0	1	0	0	1	0	0	1
   	 9	0	0	21	0	0	17	0	0
   	 0	9	0	0	21	0	0	17	0
   	 0	0	9	0	0	21	0	0	17];
 
 B = [340 900  700  550  750   275  10000 7000  4200]';
 
 f =  [-9 -9 -9 -12 -12 -12 -10 -10 -10]';
 
 lb = zeros(9,1);
 	
x = linprog(f,A,B,[],[],lb);

disp(x);

disp (f'*x);