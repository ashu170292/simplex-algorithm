# simplex-algorithm
simplex algorithm from scratch

The purpose of this project is to understand the inner workings of the Simplex Algorithm by coding it from scratch. The code has been written to solve a particular problem in the manufacturing industry. The problem has been taken from the following link:

https://sites.math.washington.edu/~burke/crs/407/models/

This code specifically solves Model 1. The linear program looks like follows:

Formulation
Maximize 9(s1+s2+s3) + 12(L1+L2+L3) + 10(m1+m2+m3) 

s.t.

s1 + s2 + s3 <= 340

m1 + m2 + m3 <= 900

L1 + L2 +L3 <= 700

s1+ m1 + L1 <= 550

s2 + m2 + L2 <= 750

s3 + m3 + L3 <= 275

9s1 + 17 m1 + 21 L1 <= 10,000

9s2 + 17 m2 + 21 L2 <= 7,000

9s3 + 17 m3 + 21 L3 <= 4200

s1 , s2 , s3 , m1 , m2 , m3 , L1 , L2 , L3 >=0
