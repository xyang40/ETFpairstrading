using CSV
using DataFrames
using Statistics
using DelimitedFiles

using GraphLasso,  Distributions, RDatasets

etfs = Dict("EWJ"=>"Japan","EWZ"=>"Brazil","FXI"=>"China","EWY"=>"South Korea",
"EWT"=>"Taiwan","EWH"=>"Hong Kong","EWC"=>"Canada","EWG"=>"Germany",
"EWU"=>"United Kingdom","EWA"=>"Australia","EWW"=>"Mexico","EWL"=>"Switzerland",
"EWP"=>"Spain","EWQ"=>"France","EIDO"=>"Indonesia","ERUS"=>"Russia","EWS"=>"Singapore",
"EWM"=>"Malaysia","EZA"=>"South Africa","THD"=>"Thailand",
"ECH"=>"Chile","EWI"=>"Italy","TUR"=>"Turkey","EPOL"=>"Poland","EPHE"=>"Philippines",
"EWD"=>"Sweden","EWN"=>"Netherlands","EPU"=>"Peru","ENZL"=>"New Zealand",
"EIS"=>"Israel","EWO"=>"Austria","EIRL"=>"Ireland","EWK"=>"Belgium")

#tickers = [k for k in keys(etfs)]

df = CSV.File("C:\\Users\\Xi\\Desktop\\Projects\\ETFpairstrading\\files\\ALL.csv") |> DataFrame
data = convert(Array, df[:,2:end])

S = cov(data)
rho = 0.01
#print(typeof(S))
#print(S)
Theta = GraphLasso.graphlasso(S, 1.0; tol=1e-6, penalize_diag=true)
