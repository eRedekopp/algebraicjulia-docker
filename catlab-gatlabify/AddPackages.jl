using Pkg

# Do this first because a bunch of other packages depend on it
Pkg.develop(path="/root/julia/AlgebraicJulia/Catlab")

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
    "NetworkLayout",
    "Revise"
])

# None right now, because they're broken and won't precompile correctly
localpkgs = []

foreach(
    p -> Pkg.develop(path="/root/julia/AlgebraicJulia/$p"),
    localpkgs
)
Pkg.precompile.([
    localpkgs;
    "Catlab"
])
