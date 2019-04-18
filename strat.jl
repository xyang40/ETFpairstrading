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

frame = DataFrame()
df = CSV.File("C:\\Users\\Xi\\Desktop\\Projects\\ETFpairstrading\\files\\"*tickers[1]*".csv") |> DataFrame
#df = df[:, [Symbol("Date"), Symbol("Adj Close")]]
df = df[:, [Symbol("Adj Close")]]
push!(frame, df')
#matrix = Matrix(2013, 0)
for ticker in tickers[2:end,]
    println(ticker)
    curr = CSV.File("C:\\Users\\Xi\\Desktop\\Projects\\ETFpairstrading\\files\\"*ticker*".csv") |> DataFrame
    #println(curr)
    #join(df, curr[:, [Symbol("Date"), Symbol("Adj Close")]], on = :Date, makeunique=true)
    #df[:ticker] = curr[:,[Symbol("Adj Close")]]
    adjclose = curr[:, [Symbol("Adj Close")]]
    df = [df adjclose]
end
