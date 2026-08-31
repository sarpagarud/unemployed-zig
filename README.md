# unemployed-zig

## Unemployment
Unemployment is the state of wanting work but lacking a job. Unemployed [ˌʌnɪmˈplɔɪd] is without a paid job but available to work. 
The unemployed are not unemployable. Most face temporary barriers—economy, skills gaps, location, trust etc. not permanent inability.  

> [!NOTE]
> The whole purpose of unemployed zig repo is to understand unemployment.  
> And learn Zig programming language at the same time.  
> Code Samples are from https://codeberg.org/ziglang/zig/src/branch/master/doc  
> Repository may contain human generated as well as AI generated code.  

## Installation

```bash
lsb_release -a
```

```bash
wget https://ziglang.org/download/0.16.0/zig-x86_64-linux-0.16.0.tar.xz
unzip zig-x86_64-linux-0.16.0.tar.xz
cd zig-x86_64-linux-0.16.0
export PATH="$PATH:~/zig-x86_64-linux-0.16.0"
zig fetch --save git+https://github.com/sarpagarud/zig-core
```

## Run

```bash
zig run ~/samples/basic/hello.zig
```

## Build

```bash
zig build-exe ~/samples/basic/hello.zig
```

## Measurement 

[https://en.wikipedia.org/wiki/Unemployment](https://en.wikipedia.org/wiki/Unemployment)

$$
Unemployment Rate = \dfrac{Unemployed Workers}{Total Labor Force} \times 100
$$

## Types of Unemployment
- cyclical or Keynesian unemployment
- frictional unemployment
- structural unemployment
- classical unemployment
- seasonal unemployment
- hardcore unemployment
- hidden unemployment
- Real wage unemployment
- Long-term unemployment

## Methods to calculate the unemployment rate
- Labour Force Sample Surveys are the most preferred method of unemployment rate calculation since they give the most comprehensive results and enables calculation of unemployment by different group categories such as race and gender. This method is the most internationally comparable.
- Official Estimates are determined by a combination of information from one or more of the other three methods. The use of this method has been declining in favor of labour surveys.
- Social Insurance Statistics, such as unemployment benefits, are computed based on the number of persons insured representing the total labour force and the number of persons who are insured that are collecting benefits. This method has been heavily criticized because of the expiration of benefits before the person finds work.
- Employment Office Statistics are the least effective since they include only a monthly tally of unemployed persons who enter employment offices. This method also includes those who are not unemployed by the ILO definition.

### Calculate
- LU1: Unemployment rate: [persons in unemployment / labour force] × 100
- LU2: Combined rate of time-related underemployment and unemployment: [(persons in time-related underemployment + persons in unemployment) / labour force] x 100
- LU3: Combined rate of unemployment and potential labour force: [(persons in unemployment + potential labour force) / (extended labour force)] × 100
- LU4: Composite measure of labour underutilization: [(persons in time-related underemployment + persons in unemployment + potentiallabour force) / (extended labour force)] × 100

### Six alternate measures of unemployment
- U1: Percentage of labor force unemployed 15 weeks or longer.
- U2: Percentage of labor force who lost jobs or completed temporary work.
- U3: Official unemployment rate, per the ILO definition, occurs when people are without jobs and they have actively looked for work within the past four weeks.[72]
- U4: U3 + "discouraged workers", or those who have stopped looking for work because current economic conditions make them believe that no work is available for them.
- U5: U4 + other "marginally attached workers," or "loosely attached workers", or those who "would like" and are able to work but have not looked for work recently.
- U6: U5 + Part-time workers who want to work full-time, but cannot for economic reasons (underemployment).

[Check](https://github.com/sarpagarud/unemployed-zig/blob/main/src/lib/calculations.zig) to see calculations

## Unemployment Rate (IMF)
[LUR](https://www.imf.org/external/datamapper/LUR@WEO/OEMDC/USA)
<a href="https://www.imf.org/external/datamapper/LUR@WEO/OEMDC/USA" target="_blank" rel="noopener noreferrer">Unemployment Rate IMF Page</a>

## Sources
- ILOSTAT
- BLS
- OECD and Eurostat
- National Statistical Offices
- World Bank
- IMF
