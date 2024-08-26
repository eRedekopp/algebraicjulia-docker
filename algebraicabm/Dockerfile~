
FROM julia

# Global setup
RUN apt update
RUN mkdir /root/notebooks
COPY examples/ /root/notebooks/examples

# Set up Anaconda / Jupyter Notebooks
#RUN apt install wget
#RUN wget https://repo.anaconda.com/archive/Anaconda3-2024.02-1-Linux-x86_64.sh
#RUN sh Anaconda3-2024.02-1-Linux-x86_64.sh -b
#RUN rm -f Anaconda3-2024.02-1-Linux-x86_64.sh
#ENV PATH /root/anaconda3/bin:$PATH
#RUN jupyter notebook --generate-config --allow-root

# Add graphviz binaries
RUN apt -y install graphviz

# Set up Jupyter notebooks via pipx
RUN apt -y install python3 pipx
RUN pipx install notebook
ENV PATH /root/.local/bin:$PATH
RUN jupyter-notebook --generate-config --allow-root

# Set up Julia / StockFlow
RUN mkdir /root/julia
COPY AddPackages.jl /root/julia/AddPackages.jl
RUN julia --quiet /root/julia/AddPackages.jl

EXPOSE 8888

CMD ["jupyter-notebook", "--allow-root", "--notebook-dir=/root/notebooks", "--ip='*'", "--port=8888", "--no-browser"]
#CMD ["jupyter", "notebook", "--allow-root", "--notebook-dir=/root/notebooks", "--ip='*'", "--port=8888", "--no-browser"]
