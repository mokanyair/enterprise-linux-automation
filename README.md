# Enterprise Linux Automation

A production-inspired reference implementation for enterprise RHEL configuration, patching, compliance, and lifecycle automation using Red Hat Ansible Automation Platform.

This project demonstrates how platform engineering teams can move from individually executed scripts and playbooks to a governed automation operating model built around reusable Ansible content, source control, standardized Execution Environments, controlled credentials, inventories, RBAC, Job Templates, workflows, and auditable execution.

## Why this project exists

Enterprise automation is not simply about writing a playbook that works.

At scale, the larger challenge is creating a repeatable operating model that lets engineers automate infrastructure while maintaining standards around runtime consistency, access control, credentials, change execution, validation, and auditability.

This repository is an independently developed reference implementation that demonstrates those engineering patterns using synthetic infrastructure data. It does not contain employer, customer, or production configurations.

## Architecture

<img width="1200" height="687" alt="image" src="https://github.com/user-attachments/assets/ad016ad7-f0a2-4955-a314-4121231e7a93" />

## Execution Environment

The project includes a custom Execution Environment designed to provide a consistent automation runtime across development and controlled AAP execution.

The runtime includes:

- ansible-core
- ansible.posix
- community.general
- redhat.rhel_system_roles
- required Python dependencies
- required system packages

The Execution Environment is built using `ansible-builder`, validated, published to a container registry, registered in AAP, and attached to Job Templates.

## Engineering principles demonstrated

The repository is structured around several enterprise automation principles:

Reusable roles separate implementation logic from orchestration.

Variables allow the same automation content to support multiple environments without duplicating code.

Execution Environments standardize runtime dependencies and reduce configuration drift between development and production.

Credentials are externalized from Git and managed through platform controls.

AAP provides centralized RBAC, inventory management, controlled execution, logging, and auditability.

Validation is treated as part of automation rather than an afterthought.

## Enterprise operating model

A key design goal is to separate automation development from automation consumption.

Platform engineers maintain approved automation content and runtime standards, while application and infrastructure teams consume that automation through controlled AAP Job Templates and workflows.

This allows organizations to increase automation and self-service without giving up governance.
