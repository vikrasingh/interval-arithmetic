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
