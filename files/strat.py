import pandas as pd
import sys
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.collections import LineCollection
from sklearn import cluster, covariance, manifold

import seaborn as sns
import networkx as nx

etfs = {"EWJ":"Japan","EWZ":"Brazil","FXI":"China","EWY":"South Korea",
"EWT":"Taiwan","EWH":"Hong Kong","EWC":"Canada","EWG":"Germany",
"EWU":"United Kingdom","EWA":"Australia","EWW":"Mexico","EWL":"Switzerland",
"EWP":"Spain","EWQ":"France","EIDO":"Indonesia","ERUS":"Russia","EWS":"Singapore",
"EWM":"Malaysia","EZA":"South Africa","THD":"Thailand",
"ECH":"Chile","EWI":"Italy","TUR":"Turkey","EPOL":"Poland","EPHE":"Philippines",
"EWD":"Sweden","EWN":"Netherlands","EPU":"Peru","ENZL":"New Zealand",
"EIS":"Israel","EWO":"Austria","EIRL":"Ireland","EWK":"Belgium"}

symbols, names = np.array(sorted(etfs.items())).T

df = pd.read_csv("C:\\Users\\Xi\\Desktop\\Projects\\ETFpairstrading\\files\\ALL.csv")
del df['Date']

cols = df.columns
edge_model = covariance.GraphicalLassoCV(alphas=[0.001, 20], cv=10)


#df /= df.std(axis=0)
edge_model.fit(df)

p = edge_model.precision_
c = edge_model.covariance_

#corr = dataframe.corr()
#sns.heatmap(p)
#xticklabels=p.columns.values,
#yticklabels=p.columns.values)

#using covariance
#_, labels = cluster.affinity_propagation(c)
#n_labels = labels.max()
n_labels = 6
labels = np.array([0,1,2,4,5,1,3,0,3,5,6,2,2,1,2,1,2,2,1,2,2,2,2,1,1,2,0,1,0,6,1,1,4])
for i in range(n_labels + 1):
    print('Cluster %i: %s' % ((i + 1), ', '.join(names[labels == i])))

p = pd.DataFrame(p, columns=cols, index=cols)
links = p.stack().reset_index()
links.columns = ['var1', 'var2','value']

links=links.loc[ (abs(links['value']) > 0.005) &  (links['var1'] != links['var2']) ]

# Build your graph
G=nx.from_pandas_edgelist(links,'var1','var2', create_using=nx.Graph())
 
# Plot the network:
nx.draw(G, with_labels=True, node_color='red', node_size=800, edge_color='black', linewidths=1, font_size=15)



'''
#clustering
node_position_model = manifold.LocallyLinearEmbedding(
    n_components=2, eigen_solver='dense', n_neighbors=6)
embedding = node_position_model.fit_transform(df.T).T

# Visualization
plt.figure(1, facecolor='w', figsize=(10, 8))
plt.clf()
ax = plt.axes([0., 0., 1., 1.])
plt.axis('off')

# Display a graph of the partial correlations
partial_correlations = p.copy()
d = 1 / np.sqrt(np.diag(partial_correlations))
partial_correlations *= d
partial_correlations *= d[:, np.newaxis]
non_zero = (np.abs(np.triu(partial_correlations, k=1)) > 0.02)

# Plot the nodes using the coordinates of our embedding
plt.scatter(embedding[0], embedding[1], s=100 * d ** 2, c=labels,
            cmap=plt.cm.nipy_spectral)

# Plot the edges
start_idx, end_idx = np.where(non_zero)
# a sequence of (*line0*, *line1*, *line2*), where::
#            linen = (x0, y0), (x1, y1), ... (xm, ym)
segments = [[embedding[:, start], embedding[:, stop]]
            for start, stop in zip(start_idx, end_idx)]
values = np.abs(partial_correlations[non_zero])
lc = LineCollection(segments,
                    zorder=0, cmap=plt.cm.hot_r,
                    norm=plt.Normalize(0, .7 * values.max()))
lc.set_array(values)
lc.set_linewidths(15 * values)
ax.add_collection(lc)

# Add a label to each node. The challenge here is that we want to
# position the labels to avoid overlap with other labels
for index, (name, label, (x, y)) in enumerate(
        zip(names, labels, embedding.T)):

    dx = x - embedding[0]
    dx[index] = 1
    dy = y - embedding[1]
    dy[index] = 1
    this_dx = dx[np.argmin(np.abs(dy))]
    this_dy = dy[np.argmin(np.abs(dx))]
    if this_dx > 0:
        horizontalalignment = 'left'
        x = x + .002
    else:
        horizontalalignment = 'right'
        x = x - .002
    if this_dy > 0:
        verticalalignment = 'bottom'
        y = y + .002
    else:
        verticalalignment = 'top'
        y = y - .002
    plt.text(x, y, name, size=10,
             horizontalalignment=horizontalalignment,
             verticalalignment=verticalalignment,
             bbox=dict(facecolor='w',
                       edgecolor=plt.cm.nipy_spectral(label / float(n_labels)),
                       alpha=.6))

plt.xlim(embedding[0].min() - .15 * embedding[0].ptp(),
         embedding[0].max() + .10 * embedding[0].ptp(),)
plt.ylim(embedding[1].min() - .03 * embedding[1].ptp(),
         embedding[1].max() + .03 * embedding[1].ptp())

plt.show()
'''