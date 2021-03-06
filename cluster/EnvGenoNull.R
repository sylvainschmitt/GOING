#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)
if (length(args)==0)
  stop("At least one argument must be supplied (simulation).n", call.=FALSE)
simulation <- as.character(args[1])
print(paste("Simulation number is", simulation))
library(rstan)
options(mc.cores = 1)
rstan_options(auto_write = T)
load("../save/dataEnvNull.Rdata")
model <- stan_model("../models/AnimalLog.stan")
fit <- sampling(model, chains = 1, data = mdata[[simulation]], save_warmup = F,
                     control = list(adapt_delta = 0.99, max_treedepth = 12))
save(fit, file = paste0("../save/EnvGenoNull/simulation", simulation, ".Rdata"))
