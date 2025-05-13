FROM ubuntu

# Global setup
RUN apt upgrade
RUN apt update
RUN apt -y --fix-missing install curl procps git python3 pipx graphviz xorg-dev mesa-utils xvfb libgl1 freeglut3-dev libxrandr-dev libxinerama-dev libxcursor-dev libxi-dev libxext-dev inkscape pandoc texlive-xetex

# Set up Jupyter notebooks via pipx
RUN pipx install notebook
ENV PATH="/root/.local/bin:$PATH"
RUN mkdir /root/notebooks
RUN jupyter-notebook --generate-config --allow-root

# Get the unpublished julia packages
RUN git clone "https://github.com/AlgebraicJulia/AlgebraicRewriting.jl.git" /root/julia/AlgebraicJulia/AlgebraicRewriting
RUN git clone "https://github.com/AlgebraicJulia/StockFlow.jl.git" /root/julia/AlgebraicJulia/StockFlow
RUN git clone "https://github.com/AlgebraicJulia/AlgebraicPetri.jl.git" /root/julia/AlgebraicJulia/AlgebraicPetri
RUN git clone "https://github.com/AlgebraicJulia/DataMigrations.jl.git" /root/julia/AlgebraicJulia/DataMigrations
RUN git clone "https://github.com/AlgebraicJulia/AlgebraicABMs.jl.git" /root/julia/AlgebraicJulia/AlgebraicABMs/
RUN git clone "https://github.com/AlgebraicJulia/StateCharts.jl.git" /root/julia/AlgebraicJulia/StateCharts/

# Set up Julia and install packages
RUN curl -fsSL https://install.julialang.org | sh -s -- "-y"
RUN mkdir -p /root/julia
COPY AddPackages.jl /root/julia/AddPackages.jl
RUN DISPLAY=:0 xvfb-run -s '-screen 0 1024x768x24' /root/.juliaup/bin/julia --quiet /root/julia/AddPackages.jl
RUN mkdir -p /root/julia/examples/
COPY stockflow/ /root/julia/examples/stockflow
COPY algebraic-rewriting/ /root/julia/examples/algebraic-rewriting
COPY algebraic-abms/ /root/julia/examples/algebraic-abms

EXPOSE 8888

CMD ["jupyter-notebook", "--allow-root", "--notebook-dir=/root/julia/examples", "--ip='*'", "--port=8888", "--no-browser"]
