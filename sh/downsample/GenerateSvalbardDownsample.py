import numpy as np 

svb_cov = np.loadtxt("svalbard_cov.txt")

dsfactor = 2.0/svb_cov

np.savetxt("downsample_factor.txt", dsfactor, delimiter="\n", fmt="%f")
