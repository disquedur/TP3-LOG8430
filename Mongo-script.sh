#!/bin/bash

# Tableau des modes YCSB à exécuter
modes=("load" "run")

# Tableau des workloads YCSB à exécuter
#workloads=("workloada" "workloadb" "workloadc")
workloads=("workloada" "workloadb" "workloadc")

# Boucle à travers chaque mode (load et run)
for mode in "${modes[@]}"; do
  # Boucle à travers chaque workload (A, B, et C)
  for workload in "${workloads[@]}"; do
    # Créer un répertoire pour les sorties de ce mode et de ce workload s'il n'existe pas déjà
    output_dir="output/${mode}/${workload}"
    mkdir -p "$output_dir"
    # Répéter le test 10 fois pour chaque combinaison de mode et de workload
    for i in {1..10}; do
      echo "Exécution $mode pour $workload, essai $i"
      # Construire la commande, en sauvegardant les sorties dans le nouveau répertoire
      CMD="sudo ./bin/ycsb $mode mongodb -s -P workloads/$workload -p mongodb.url=mongodb://localhost:27017/ycsb?w=0 > ${output_dir}/result$i.txt"

      # Exécuter la commande
      eval $CMD
    done
  done
done
