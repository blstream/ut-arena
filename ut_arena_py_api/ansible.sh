#!/usr/bin/env bash
ansible-playbook -i scripts/ansible/hosts scripts/ansible/provision.yml --ask-become-pass