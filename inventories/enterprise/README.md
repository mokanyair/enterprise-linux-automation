# Enterprise Inventory Design

This inventory is a synthetic reference implementation used to demonstrate
enterprise Ansible inventory architecture.

All hostnames, IP addresses, environment names, application names, schedules,
and infrastructure identifiers in this directory are examples and do not
represent an employer or customer environment.

## Inventory dimensions

Hosts are grouped across multiple operational dimensions:

- Environment:
  `env_production`, `env_development`
- Application tier:
  `role_web`, `role_app`, `role_database`
- Region:
  `region_us_east_1`
- Operating system:
  `os_rhel9`
- Application:
  `app_payments`, `app_shared_services`

A managed host can therefore inherit automation behavior from multiple
enterprise contexts without duplicating host definitions.

The IP addresses in `host_vars/` use documentation-only address space and are
not production endpoints.

Connection identities and authentication material are intentionally excluded
from inventory and should be supplied through Red Hat Ansible Automation
Platform credentials.
