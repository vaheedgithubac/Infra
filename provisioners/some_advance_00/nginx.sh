#!/bin/env bash

sudo dnf update
sudo dnf install nginx -y
sudo systemctl enable nginx
sudo systemctl start nginx
