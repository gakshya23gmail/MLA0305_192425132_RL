library(DiagrammeR)

grViz("

digraph MDP {

graph [
layout = dot,
rankdir = TB,
bgcolor = white,
nodesep = 0.9,
ranksep = 1.4
]

node [
shape = box,
style = 'filled,rounded',
fontname = 'Times New Roman',
fontsize = 17,
width = 2.0,
height = 0.8,
penwidth = 2.5,
color = '#2C3E50'
]

MDP [label='Markov Decision\nProcess (MDP)', fillcolor='#FFD166']

S   [label='State (S)', fillcolor='#90CAF9']
P   [label='Policy π(s)', fillcolor='#A5D6A7']

A   [label='Action (A)', fillcolor='#FFCC80']
E   [label='Environment', fillcolor='#F48FB1']

NS  [label='Next State (S\\')', fillcolor='#CE93D8']
R   [label='Reward (R)', fillcolor='#80CBC4']

U   [label='Update\nValue Function', fillcolor='#64B5F6']

END [label='Optimal Policy', shape=ellipse,
fillcolor='#E6EE9C']

MDP -> S
MDP -> P

S -> A
P -> A

A -> E

E -> NS
E -> R

NS -> U
R -> U

U -> END

edge [
color = '#455A64',
penwidth = 2,
arrowsize = 0.9
]

}
")
