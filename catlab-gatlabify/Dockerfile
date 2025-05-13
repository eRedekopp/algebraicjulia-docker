FROM ubuntu

# Global setup
RUN apt update
RUN apt upgrade
RUN apt -y --fix-missing install curl procps git python3 pipx graphviz xorg-dev mesa-utils xvfb libgl1 freeglut3-dev libxrandr-dev libxinerama-dev libxcursor-dev libxi-dev libxext-dev inkscape pandoc texlive-xetex

# Set up Jupyter notebooks via pipx
RUN pipx install notebook
ENV PATH="/root/.local/bin:$PATH"
RUN mkdir /root/notebooks
RUN jupyter-notebook --generate-config --allow-root

# Download and install Julia
RUN curl -fsSL https://install.julialang.org | sh -s -- "-y"

# Get the unpublished julia packages. Put them in a location that will be visible
# to notebook users so that they can modify the code if needed.
RUN mkdir -p /root/julia/AlgebraicJulia/
RUN git clone --single-branch -b gatlabify "https://github.com/AlgebraicJulia/Catlab.jl.git" /root/julia/AlgebraicJulia/Catlab
RUN git clone --single-branch --depth 3 "https://github.com/AlgebraicJulia/AlgebraicRewriting.jl.git" /root/julia/AlgebraicJulia/AlgebraicRewriting
RUN git clone --single-branch --depth 3 "https://github.com/AlgebraicJulia/StockFlow.jl.git" /root/julia/AlgebraicJulia/StockFlow
RUN git clone --single-branch --depth 3 "https://github.com/AlgebraicJulia/AlgebraicPetri.jl.git" /root/julia/AlgebraicJulia/AlgebraicPetri
RUN git clone --single-branch --depth 3 "https://github.com/AlgebraicJulia/DataMigrations.jl.git" /root/julia/AlgebraicJulia/DataMigrations
RUN git clone --single-branch --depth 3 "https://github.com/AlgebraicJulia/AlgebraicABMs.jl.git" /root/julia/AlgebraicJulia/AlgebraicABMs/
RUN git clone --single-branch --depth 3 "https://github.com/AlgebraicJulia/StateCharts.jl.git" /root/julia/AlgebraicJulia/StateCharts/

# Change the version number for Catlab in the packages that depend on it
RUN for pkgname in AlgebraicRewriting StockFlow AlgebraicPetri DataMigrations AlgebraicABMs StateCharts; do sed -E -i 's/^(Catlab = ")[^"]*[0-9]+\.[0-9]+(\.[0-9]+)?[^"]*(")/\1~0.17\3/' /root/julia/AlgebraicJulia/$pkgname/Project.toml ; done

# Install the Julia packages we just cloned, plus any other
# packages that we want to get directly from Pkg.
COPY AddPackages.jl /root/julia/AddPackages.jl
RUN DISPLAY=:0 xvfb-run -s '-screen 0 1024x768x24' /root/.juliaup/bin/julia --quiet /root/julia/AddPackages.jl

# Add the example notebooks
RUN mkdir -p /root/julia/examples/
COPY stockflow/ /root/julia/examples/stockflow
COPY algebraic-rewriting/ /root/julia/examples/algebraic-rewriting
COPY algebraic-abms/ /root/julia/examples/algebraic-abms

ENV DISPLAY=":0"

EXPOSE 8888

CMD ["jupyter-notebook", "--allow-root", "--notebook-dir=/root/julia/", "--ip='*'", "--port=8888", "--no-browser"]
