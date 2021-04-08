# CPS-labor-market-flows

This repository contains code for calculating labor market transition rates in Current Population Survey (CPS) data following the approach in [Shimer (2012)](https://www.sciencedirect.com/science/article/pii/S1094202512000063). The data from 1967-06 to 1975-12 were tabulated by Joe Ritter and made available by Hoyt Bleakley.

1. All data is produced by running `Main.ipynb`.
2. `CPS_END_YEAR` and `CPS_END_MONTH` controls the the time range (the first period is 1967-01).
3. `P.p` contains the discrete time transition probabilities (EE,EU,EI,UE,UU,UI,IE,IU,II).
4. `Q.p` contains the continuous time transition rates (EE,EU,EI,UE,UU,UI,IE,IU,II).