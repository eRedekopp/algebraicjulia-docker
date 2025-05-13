using Pkg
Pkg.add.([
    "AlgebraicRewriting",
    "Catlab",
    "GATlab",
    "Graphs",
    "Reexport",
    "StatsBase",
    "AlgebraicPetri",
    "CairoMakie",
    "Colors",
    "DataMigrations",
    "Distributions",
    "Documenter",
    "GLMakie",
    "GeometryBasics",
    "GraphPlot",
    "Literate",
    "Makie",
    "NetworkLayout",
    "CompetingClocks",
    "DataStructures",
    "IJulia"
])

Pkg.develop(path="/root/AlgebraicABMs")
#Pkg.develop(path="/root/StateCharts")
