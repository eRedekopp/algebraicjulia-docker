using Pkg

Pkg.add.([
    "PrettyTables",
    "GraphViz",
    "StructEquality",
    "Colors",
    "CompetingClocks",
    "Luxor",
    "Plots",
    "GeometryBasics",
    "Literate",
    "StatsBase",
    "GATlab",
    "Catlab",
    "Graphs",
    "DataStructures",
    "LabelledArrays",
    "Distributions",
    "CairoMakie",
    "GLMakie",
    "OrdinaryDiffEq",
    "Documenter",
    "Reexport",
    "Makie",
    "GraphPlot",
    "IJulia",
    "NetworkLayout"
])

localpkgs = [
    "AlgebraicRewriting",
    "StockFlow",
    "AlgebraicABMs",
    "StateCharts",
    "AlgebraicPetri",
    "DataMigrations"
]

foreach(
    p -> Pkg.devlop(path="/root/julia/AlgebraicJulia"),
    localpkgs
)
Pkg.precompile.([
    localpkgs;
])
