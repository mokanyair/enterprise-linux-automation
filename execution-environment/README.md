# Enterprise Automation Execution Environment

This directory defines the reproducible runtime used to execute the automation
content in this repository with Red Hat Ansible Automation Platform.

## Runtime design

The Execution Environment uses:

- Red Hat AAP 2.7 minimal RHEL 9 base image
- ansible-core 2.16 runtime stream
- Version-pinned Ansible collections
- Version-pinned Python dependencies
- Explicit system dependencies
- Red Hat Automation Hub for certified content
- Ansible Galaxy for applicable community content

## Dependency management

Ansible collections are declared in:

`requirements.yml`

Python dependencies are declared in:

`requirements.txt`

System-level dependencies are declared in:

`bindep.txt`

The generated Ansible Builder `context/` directory is intentionally excluded
from source control.

## Authentication

Credentials, registry passwords, and Automation Hub tokens are never stored
in this repository.

Automation Hub authentication must be supplied externally at build time.

Example:

```bash
read -s -p "Automation Hub token: " \
ANSIBLE_GALAXY_SERVER_AUTOMATION_HUB_TOKEN
echo
export ANSIBLE_GALAXY_SERVER_AUTOMATION_HUB_TOKEN

ansible-builder build \
  -f execution-environment.yml \
  -t enterprise-linux-ee:1.0 \
  --container-runtime docker \
  --build-arg \
  ANSIBLE_GALAXY_SERVER_AUTOMATION_HUB_TOKEN="$ANSIBLE_GALAXY_SERVER_AUTOMATION_HUB_TOKEN"
```

The token value must never be committed to Git, written into the EE definition,
or included in documentation.

For automated build pipelines, use the organization's approved secrets
management mechanism rather than storing credentials in source control.

## Runtime flow

Git-controlled automation content
-> versioned Execution Environment
-> AAP Job Template / Workflow
-> approved Inventory and Credentials
-> managed RHEL systems
