#!/usr/bin/env bash

NOISE="u-50"  # feature/noise (z) distribution is a 50-D uniform

# BiGAN objective
OBJECTIVE="--encode_gen_weight 1 --encode_weight 0 --discrim_weight 0 --joint_discrim_weight 1"

# Latent Regressor (LR) objective
# OBJECTIVE="--encode_gen_weight 0 --encode_weight 1 --discrim_weight 1 --joint_discrim_weight 0"

# Joint Latent Regressor (Joint LR) objective
# OBJECTIVE="--encode_gen_weight 0.25 --encode_weight 1 --discrim_weight 1 --joint_discrim_weight 0"

python2 -u train_2gans.py \
    --encode --encode_normalize \
    --dataset mnist --crop_size 28 \
    --encode_net mnist_mlp \
    --discrim_net mnist_mlp \
    --gen_net deconvnet_mnist_mlp \
    --megabatch_gb 0.5 \
    --classifier --classifier_deploy \
    --nolog_gain --nogain --nobias --no_decay_gain \
    --deploy_iters 1000 \
    --disp_samples 400 \
    --disp_interval 25 \
    --epochs 200 --decay_epochs 200 \
    --optimizer adam \
    --repulsive
    --target_class 0 \
    --outlier_prop 0.1 \
    --repulsive_weight 0.1 \
    --noise ${NOISE} \
    ${OBJECTIVE} \
    $@
