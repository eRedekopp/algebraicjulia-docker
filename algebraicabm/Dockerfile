FROM julia

# Global setup
RUN apt upgrade
RUN apt update
RUN mkdir /root/notebooks
COPY examples/ /root/notebooks/examples

# Add graphviz binaries
RUN apt -y install graphviz --fix-missing

# Set up Jupyter notebooks via pipx
RUN apt -y install python3 pipx
RUN pipx install notebook
ENV PATH /root/.local/bin:$PATH
RUN jupyter-notebook --generate-config --allow-root

# Set up Julia and install packages
RUN mkdir /root/julia
COPY AddPackages.jl /root/julia/AddPackages.jl
RUN julia --quiet /root/julia/AddPackages.jl

EXPOSE 8888

CMD ["jupyter-notebook", "--allow-root", "--notebook-dir=/root/notebooks", "--ip='*'", "--port=8888", "--no-browser"]
