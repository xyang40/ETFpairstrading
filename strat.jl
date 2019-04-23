using CSV
using DataFrames
using Statistics
using Lasso

function glasso(S, λ, maxiter=10, tol=1e-5)
    if  λ == 0
        return S, inv(S)
    else
        W = deepcopy(S)
        _, p = size(W)

        W_0 = zeros(p, p)
        for iter in 1:maxiter
            for dim in 1:p
                W11 = W[1:end.!=dim, 1:end.!=dim]
                S12 = S[dim, 1:end.!=dim]

                f = Lasso.fit(LassoPath, sqrt(W11), inv(sqrt(W11))*S12)
                coefs = f.coefs[1:end,end]

                W_0[dim, 1:end.!=dim] = coefs
                W_0[1:end.!=dim, dim] = coefs
                W_0[dim, dim] = S[dim, dim]
            end
            W = deepcopy(W_0)
        end

        Θ = Array{Float64}(undef, p, p)
        for dim in 1:p
            coefs = inv(W[1:end.!=dim, 1:end.!=dim])*W[1:end.!=dim, dim]
            Θ[dim, dim] = 1.0/(W[dim, dim] - W[dim, 1:end.!=dim]'coefs)
            Θ[1:end.!=dim, dim] = -Θ[dim, dim]*coefs
            Θ[dim, 1:end.!=dim] = -Θ[dim, dim]*coefs
        end

        return W, Θ
    end
end



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
data = convert(Matrix, df[:,2:end])

S = cov(data)
rho = 0.01
#Theta = glasso(S, rho, 100)
