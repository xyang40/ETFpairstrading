using CSV
using DataFrames

etfs = Dict("EWJ"=>"Japan","EWZ"=>"Brazil","FXI"=>"China","EWY"=>"South Korea",
"EWT"=>"Taiwan","EWH"=>"Hong Kong","EWC"=>"Canada","EWG"=>"Germany",
"EWU"=>"United Kingdom","EWA"=>"Australia","EWW"=>"Mexico","EWL"=>"Switzerland",
"EWP"=>"Spain","EWQ"=>"France","EIDO"=>"Indonesia","ERUS"=>"Russia","EWS"=>"Singapore",
"EWM"=>"Malaysia","EZA"=>"South Africa","THD"=>"Thailand",
"ECH"=>"Chile","EWI"=>"Italy","TUR"=>"Turkey","EPOL"=>"Poland","EPHE"=>"Philippines",
"EWD"=>"Sweden","EWN"=>"Netherlands","EPU"=>"Peru","ENZL"=>"New Zealand",
"EIS"=>"Israel","EWO"=>"Austria","EIRL"=>"Ireland","EWK"=>"Belgium")

tickers = [k for k in keys(etfs)]

df = CSV.File("C:\\Users\\Xi\\Desktop\\Projects\\ETFpairstrading\\files\\ALL.csv") |> DataFrame
print(size(df))
