#!/bin/bash
#SBATCH --job-name=jupyter
#SBATCH --output=jupyter_%j.log
#SBATCH --error=jupyter_%j.log
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10G
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
    ssh -fN -L $ipnport:localhost:$ipnport $USER@$host
    -----------------------------------------------------------------    

    Look for the http://localhost:$ipnport/?token=... in the output below for the link to the jupyter server.


    To end the session:
    -----------------------------------------------------------------
    - Cancel the SLURM job: 
      scancel $SLURM_JOB_ID
      
    - Kill the SSH tunnel: 
      pkill -f "ssh -fN -L $ipnport"
    -----------------------------------------------------------------
    "


apptainer exec /ceph/project/milne_group/asmith/Projects/plotnado/plotnado.sif jupyter lab --no-browser --port=$ipnport
