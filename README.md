# interval-arithmetic
An Interval Arithmetic Library written in MATLAB following the implementation of BIAS (https://www.tuhh.de/ti3/keil/profil1/docu/Profil.texinfo_19.html)

Interval Arithmetic (IA), introduced by Ramon E. Moore in 1960, is a powerful methodology for avoiding rounding and truncation errors introduced by Floating-Point Arithmetic. The idea is to represent any real number 'x' as an interval 'X'
such that 
```math
X.inf \leq x \leq X.sup
```

An arithmetic operation '*' in IA for two intervals 'X' and 'Y' is defined such that
```math
X*Y = \{ x*y : x \in X, y \in Y \}
```
The four basic arithmetic operations can be defined as follows
#### Addition
For intervals $X=[x_{1},x_{2}]$ and $Y=[y_{1},y_{2}]$
```math
[x_{1},x_{2}]+[y_{1},y_{2}]=[x_{1}+y_{1},x_{2}+y_{2}]
```
#### Subtraction
For intervals $X=[x_{1},x_{2}]$ and $Y=[y_{1},y_{2}]$
```math
[x_{1},x_{2}]-[y_{1},y_{2}]=[x_{1}-y_{2},x_{2}-y_{1}]
```
#### Multiplication
For intervals $X=[x_{1},x_{2}]$ and $Y=[y_{1},y_{2}]$
```math
[x_{1},x_{2}].[y_{1},y_{2}]=[\min\{x_{1}y_{1},x_{1}y_{2},x_{2}y_{1},x_{2}y_{2}\},\max\{x_{1}y_{1},x_{1}y_{2},x_{2}y_{1},x_{2}y_{2}\}]
```
#### Division
For intervals $X=[x_{1},x_{2}]$ and $Y=[y_{1},y_{2}]$
```math
\frac{[x_{1},x_{2}]}{[y_{1},y_{2}]}=[x_{1},x_{2}].\frac{1}{[y_{1},y_{2}]},
\text{ where } 
\frac{1}{[y_{1},y_{2}]}=[1/y_{2},1/y_{1}] \text{ if } 0 \notin[y_{1},y_{2}]
```
## Examples
### Example 1: Initialize an interval
The $INTERVAL$ keyword is used to represent a number as an interval. For instance
```matlab
>> I = INTERVAL(pi)
I = 

    [3.141593,3.141593] 
```
represents the constant $\pi$ as an interval $I$.
```matlab
>> fprintf('%1.15f \n',I.inf)
3.141592653589792 
>> fprintf('%1.15f \n',I.sup)
3.141592653589794
>>  I.inf<=pi && pi<=I.sup

ans =

  logical

   1
```
We can also define an interval using the endpoints
```matlab
>> I=INTERVAL(1,2)

I = 

    [1.000000,2.000000] 
```
### Example 2: Adding two intervals
Operator overloading allows us to use the '+' sign for adding two intervals
```matlab
>> J=INTERVAL(3,4)

J = 

    [3.000000,4.000000] 
>> I+J

ans = 

    [4.000000,6.000000]
```
### Example 3: Subtracting two intervals
Operator '-' is used to find the difference between two intervals
```matlab
>> I-J

ans = 

    [-3.000000,-1.000000]
```
### Example 4: Dividing an interval by another
Operator '/' is used to divide an interval by another interval
```matlab
>> I/J

ans = 

    [0.250000,0.666667]
```
### Example 4: Natural Logarithm of an interval
The keyword 'BiasLog' is used to find the natural log of an interval
```matlab
>> BiasLog(J)

ans = 

    [1.098613,1.386295]
```
### Example 5: Exponential of an interval
The keyword 'BiasExp' is used to find the exponential of an interval
```matlab
>> BiasExp(J)

ans = 

    [20.085537,54.598151]
```







