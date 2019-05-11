import pandas as pd
from sklearn import covariance

etfs = {"EWJ":"Japan","EWZ":"Brazil","FXI":"China","EWY":"South Korea",
"EWT":"Taiwan","EWH":"Hong Kong","EWC":"Canada","EWG":"Germany",
"EWU":"United Kingdom","EWA":"Australia","EWW":"Mexico","EWL":"Switzerland",
"EWP":"Spain","EWQ":"France","EIDO":"Indonesia","ERUS":"Russia","EWS":"Singapore",
"EWM":"Malaysia","EZA":"South Africa","THD":"Thailand",
"ECH":"Chile","EWI":"Italy","TUR":"Turkey","EPOL":"Poland","EPHE":"Philippines",
"EWD":"Sweden","EWN":"Netherlands","EPU":"Peru","ENZL":"New Zealand",
"EIS":"Israel","EWO":"Austria","EIRL":"Ireland","EWK":"Belgium"}

df = pd.read_csv("C:\\Users\\Xi\\Desktop\\Projects\\ETFpairstrading\\files\\ALL.csv")
del df['Date']
edge_model = covariance.GraphicalLassoCV(cv=20)


#df /= df.std(axis=0)
edge_model.fit(df)

p = edge_model.precision_

print(p)