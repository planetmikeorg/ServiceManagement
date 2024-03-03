## New Active Directory

The inventory file separates the domain controllers into two groups: `initial` for the first domain controller and `replicas` for additional domain controllers.


### Explanation

- In `create_forest.yml`, the playbook targets hosts in the `initial` group. It installs the AD DS role and then creates a new AD forest with the specified parameters.
- In `join_domain.yml`, the playbook targets hosts in the `replicas` group. It installs the AD DS role and then joins the additional domain controller to the existing domain.
- For each item in `reverse_zones`, the task creates a reverse lookup zone using the name (zone) and network_id (subnet) specified in the inventory.
### Usage

You can run these playbooks using the following commands:

```bash
ansible-playbook -i hosts.yml create_forest.yml
ansible-playbook -i hosts.yml join_domain.yml
```

These playbooks are now tailored to work with the inventory structure, where the domain controllers are categorized into `initial` and `replicas` groups, allowing for specific configurations for each type of controller.
