# Enterprise Linux Automation Architecture

## Purpose

The architecture separates automation into independently governed layers rather
than coupling configuration logic, credentials, inventory, dependencies, and
execution into a single script.

## Logical architecture

```mermaid
flowchart TB

    ENG["Platform / Infrastructure Engineer"]
    SCM["Git Source Control"]

    subgraph AAP["Red Hat Ansible Automation Platform"]
        PROJECT["Project"]
        INV["Inventory"]
        CREDS["Credentials"]
        RBAC["RBAC"]
        SURVEY["Surveys / Runtime Inputs"]
        EE["Execution Environment"]
        JT["Job Template"]
        WF["Workflow"]
        AUDIT["Execution History"]
    end

    subgraph MANAGED["Managed Infrastructure"]
        PROD["Production RHEL"]
        DEV["Development RHEL"]
    end

    ENG --> SCM
    SCM --> PROJECT

    PROJECT --> JT
    INV --> JT
    CREDS --> JT
    EE --> JT
    RBAC --> JT
    SURVEY --> JT

    JT --> WF
    WF --> PROD
    WF --> DEV
    WF --> AUDIT
