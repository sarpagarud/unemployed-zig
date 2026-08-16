// Calculations
// https://codeberg.org/ziglang/zig/src/branch/master/doc/langref/math.zig
//const calculations = @import("std").calculations;

//extern fn print(i32) void;

// https://en.wikipedia.org/wiki/Velocity_of_money
/*
V=PQ/M
V is the velocity for transactions counting towards national or domestic product;
Q is an index of real expenditures (on newly produced goods and services); and
PQ is nominal national or domestic product.
*/
export fn velocity_of_money(P: i32, Q: i32, M: i32) i32 {
  V = (P*Q)/M;
  return V;
}
/*
Vt = PT/M
Vt is the velocity of money for all transactions in a given time frame;
P is the price level;
T is the amount of transactions occurring in a given time frame; and
M is the total nominal amount of money in circulation on average in the economy (see “Money supply” for details).
*/
export fn velocity_of_money_all(P: i32, T: i32, M: i32) i32 {
  Vt = (P*T)/M;
  return V;
}

//https://en.wikipedia.org/wiki/Inflation
/*
To illustrate the method of calculation, in January 2007, the U.S. Consumer Price Index was 202.416, and in January 2008 it was 211.080. 
The formula for calculating the annual percentage rate inflation in the CPI over the course of the year is: 
((211.080−202.416)/202.416)×100%=4.28%

*/
export fn inflation_cpi(previous: f64, current: f64) f64 {
  return ((current - previous)/previous) * 100;
}

/*
The quantity theory of money, simply stated, says that any change in the amount of money in a system will change the price level. 
This theory begins with the equation of exchange:

MV=PQ,
where

M is the nominal quantity of money;
V is the velocity of money in final expenditures;
P is the general price level;
Q is an index of the real value of final expenditures.
*/
export fn quantity_theory_of_money(M, V, P, Q) boolean {
  return (MV)==(PQ)
}

/*
PPI = (Average Weighted Price in July 2023 / Average Weighted Price in January 2022) x 100 = ($120 / $100) x 100 = 120
*/
export fn producer_price_index(previous: f64, current: f64) f64 {
  return ((current - previous)/previous) * 100;
}


// exe=succeed
