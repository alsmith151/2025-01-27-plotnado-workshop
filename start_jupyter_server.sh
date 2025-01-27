#!/bin/bash
#SBATCH --job-name=jupyter
#SBATCH --output=jupyter.out
#SBATCH --error=jupyter.out
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=64G
#SBATCH --time=8:00:00
#SBATCH --partition=short


#### get/set tunneling info
XDG_RUNTIME_DIR=""
ipnport=$(shuf -i8000-9999 -n1)
host=$(hostname)

#### print tunneling instructions to jupyter-log-{jobid}.txt
echo -e "
    Copy/Paste this in your local terminal on VSCode to ssh tunnel with the server on the worker node.
    -----------------------------------------------------------------
    ssh -N -L $ipnport:localhost:$ipnport $USER@$host
    -----------------------------------------------------------------

    Look for the http://localhost:xxxx/?token=... in the output below for the link to the jupyter server.
    "


apptainer exec /ceph/project/milne_group/asmith/Projects/plotnado/plotnado.sif jupyter lab --no-browser --port=$ipnport




