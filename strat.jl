using CSV
using DataFrames

etfs = Dict("EWJ"=>"Japan","EWZ"=>"Brazil","FXI"=>"China","EWY"=>"South Korea",
"INDA"=>"India","EWT"=>"Taiwan","EWH"=>"Hong Kong","EWC"=>"Canada","EWG"=>"Germany",
"EWU"=>"United Kingdom","EWA"=>"Australia","EWW"=>"Mexico","EWL"=>"Switzerland",
"EWP"=>"Spain","EWQ"=>"France","EIDO"=>"Indonesia","ERUS"=>"Russia","EWS"=>"Singapore",
"EWM"=>"Malaysia","EZA"=>"South Africa","KSA"=>"Saudi Arabia","THD"=>"Thailand",
"ECH"=>"Chile","EWI"=>"Italy","TUR"=>"Turkey","EPOL"=>"Poland","EPHE"=>"Philippines",
"EWD"=>"Sweden","EWN"=>"Netherlands","EPU"=>"Peru","ENZL"=>"New Zealand",
"EIS"=>"Israel","EWO"=>"Austria","EIRL"=>"Ireland","EWK"=>"Belgium","QAT"=>"Qatar",
"UAE"=>"UAE","EDEN"=>"Denmark")

#CSV.read()

df = CSV.File("files\\ech.csv") |> DataFrame

#Date	Open	High	Low	Close	Adj Close	Volume
