clc; close all; clear;

% Read image
image = imread('pic.png');

[prob, I, H_2] = imgstats(image);
