local x=197601
while `x' <=201912 {

quietly{
if `x' != 197601 & `x' != 197801 & `x' != 198507 & `x' != 198510 & `x' != 199401 & `x' != 199506 & `x' != 199507 & `x' != 199508 & `x' != 199509 {

use merg`x', replace
keep if age >= 16
* drop if mis0 == 1

gen str1 lfs0 = "E" if status0 == 1 | status0 == 2
replace lfs0 = "U" if status0 == 3
replace lfs0 = "I" if status0 == 4 | status0 == 5 | status0 == 6 | status0 == 7
replace lfs0 = "U" if status0 == 4 & `x' > 198901
replace lfs0 = "M" if lfs0 == ""
gen str1 lfs1 = "E" if status1 == 1 | status1 == 2
replace lfs1 = "U" if status1 == 3
replace lfs1 = "I" if status1 == 4 | status1 == 5 | status1 == 6 | status1 == 7
replace lfs1 = "U" if status1 == 4 & `x' > 198900
replace lfs1 = "M" if lfs1 == ""

gen str2 lfs2 = lfs0 + lfs1

sort lfs2
replace fweight0 = 0 if fweight0 == .
replace fweight1 = 0 if fweight1 == .
gen weight = (fweight0+fweight1)/2
egen double flows = sum(weight), by(lfs2)
replace flows = flows/1000
if `x' > 199400 {replace flows = flows/100}

sort lfs2
quietly by lfs2:  gen duplic = cond(_N==1,0,_n)
drop if duplic > 1
keep lfs2 flows

gen date = `x'
reshape wide flows, i(date) j(lfs2) string

gen flowEE = flowsEE/(flowsEE+flowsEI+flowsEU+flowsEM)
gen flowEI = flowsEI/(flowsEE+flowsEI+flowsEU+flowsEM)
gen flowEU = flowsEU/(flowsEE+flowsEI+flowsEU+flowsEM)
gen flowEM = flowsEM/(flowsEE+flowsEI+flowsEU+flowsEM)
gen flowUE = flowsUE/(flowsUE+flowsUI+flowsUU+flowsUM)
gen flowUI = flowsUI/(flowsUE+flowsUI+flowsUU+flowsUM)
gen flowUU = flowsUU/(flowsUE+flowsUI+flowsUU+flowsUM)
gen flowUM = flowsUM/(flowsUE+flowsUI+flowsUU+flowsUM)
gen flowIE = flowsIE/(flowsIE+flowsII+flowsIU+flowsIM)
gen flowII = flowsII/(flowsIE+flowsII+flowsIU+flowsIM)
gen flowIU = flowsIU/(flowsIE+flowsII+flowsIU+flowsIM)
gen flowIM = flowsIM/(flowsIE+flowsII+flowsIU+flowsIM)
gen flowME = flowsME/(flowsME+flowsMI+flowsMU)
gen flowMI = flowsMI/(flowsME+flowsMI+flowsMU)
gen flowMU = flowsMU/(flowsME+flowsMI+flowsMU)
drop flows*
}

else {
clear
set obs 1
gen date = `x'
gen flowEE = .
gen flowEI = .
gen flowEU = .
gen flowEM = .
gen flowUE = .
gen flowUU = .
gen flowUI = .
gen flowUM = .
gen flowIE = .
gen flowIU = .
gen flowII = .
gen flowIM = .
gen flowME = .
gen flowMU = .
gen flowMI = .
}

if `x' >= 197602 {
    append using flows
    }
    
save "flows.dta", replace
}
 
local x = `x' + 1
if (`x'-13)/100 == int((`x'-13)/100) {
    local x = `x' + 88
    noisily display (`x'-1)/100}
    }

sort date

gen flowMM = 0

save "flows.dta", replace
