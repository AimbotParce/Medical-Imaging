import os
import numpy as np
import nibabel as nib
import matplotlib.pyplot as plt
from sklearn.linear_model import LinearRegression

os.chdir(os.path.abspath(os.path.dirname(__file__)))

folder = "Dades Pràctica 4/"

photons = [1, 3]
names = ["Primary", "Total"]
cutoffs = [0.02, 0.1, 0.3, 0.5, 0.7, 0.9]


rec_coef = {}
contrast_rec = {}

for name, photon in zip(names, photons):
    rec_coef[name] = []
    contrast_rec[name] = []
    for cutoff in cutoffs:
        file = os.path.join(folder, "resultats_%d_%.2f.txt" % (photon, cutoff))
        with open(file, "r") as f:
            line = f.readlines()[12].strip()

        vals = line.split("\t")
        rec_coef[name].append(float(vals[1]))
        contrast_rec[name].append(float(vals[2]))


rec_fig, rec_ax = plt.subplots()
contrast_fig, contrast_ax = plt.subplots()
rec_ax.set_xlabel("Cutoff")
rec_ax.set_ylabel("Recuperation coefficient")
contrast_ax.set_xlabel("Cutoff")
contrast_ax.set_ylabel("Contrast recovery")

for name in names:
    rec_ax.plot(cutoffs, rec_coef[name], "o", label=name)
    contrast_ax.plot(cutoffs, contrast_rec[name], "o", label=name)

rec_ax.legend(loc="lower right")
contrast_ax.legend(loc="lower right")
rec_fig.savefig("recuperation_coeff.png")
contrast_fig.savefig("contrast_recovery.png")

plt.show()
