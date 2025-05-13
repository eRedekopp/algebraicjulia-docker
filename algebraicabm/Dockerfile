FROM ubuntu

# Global setup
RUN apt upgrade
RUN apt update
RUN apt -y --fix-missing install curl procps git python3 pipx graphviz xorg-dev mesa-utils xvfb libgl1 freeglut3-dev libxrandr-dev libxinerama-dev libxcursor-dev libxi-dev libxext-dev

# Set up Jupyter notebooks via pipx
RUN pipx install notebook
ENV PATH="/root/.local/bin:$PATH"
RUN mkdir /root/notebooks
RUN jupyter-notebook --generate-config --allow-root

# Get the unpublished julia packages
RUN git clone "https://github.com/AlgebraicJulia/AlgebraicABMs.jl.git" /root/AlgebraicABMs/
RUN git clone "https://github.com/AlgebraicJulia/StateCharts.jl.git" /root/StateCharts/

# Set up Julia and install packages
RUN curl -fsSL https://install.julialang.org | sh -s -- "-y"
RUN mkdir -p /root/julia
COPY AddPackages.jl /root/julia/AddPackages.jl
RUN DISPLAY=:0 xvfb-run -s '-screen 0 1024x768x24' /root/.juliaup/bin/julia --quiet /root/julia/AddPackages.jl
RUN mkdir -p /root/julia/examples/
COPY examples/AlgebraicABMs /root/julia/examples
COPY ["examples/SIR Petri.ipynb", "/root/julia/examples"]

EXPOSE 8888

CMD ["jupyter-notebook", "--allow-root", "--notebook-dir=/root/julia/examples", "--ip='*'", "--port=8888", "--no-browser"]