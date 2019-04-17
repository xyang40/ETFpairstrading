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

df = CSV.File("files\\"*tickers[1]*".csv") |> DataFrame
df = df[:, [Symbol("Date"), Symbol("Adj Close")]]
for ticker in tickers[2:end,]
    #println(ticker)
    curr = CSV.File("files\\"*ticker*".csv") |> DataFrame
    #println(curr)
    join(df, curr[:, [Symbol("Date"), Symbol("Adj Close")]], on = :Date, makeunique=true)
    #df[:ticker] = curr[:,[Symbol("Adj Close")]]

end
