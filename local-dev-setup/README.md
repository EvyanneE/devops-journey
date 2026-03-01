# Automated Local Development Environment and Service Validation (In Progress)

Provisioned an Ubuntu-based development environment using a configurable Bash script.

## Features

- User and permission configuration
- Automated package installation
- Repository cloning with correct permissions
- PostgreSQL database creation and initialisation
- Service troubleshooting using `systemctl`
- Logging
- Error handling

## Files Included

- `setup-dev-env.sh`

- `logs/` – Log analysis output from `setup-dev-env.sh`

## Outcome

Reproducible environment setup with built-in service validation and troubleshooting. Developed foundational Linux provisioning, service management, log analysis and bash automation skills.

## Notes

### Managing Users

- `sudo adduser <username>` - add a user
- `sudo userdel <username>` - delete a user
- `sudo vim /etc/passwd` - see all users
- `sudo passwd <username>` - change the password

### Creating Groups

- `sudo groupadd <group name>` - make a group
- `sudo groupdel <group name>` - delete a group
- `sudo vim /etc/group` - see all groups

### Change Permissions and Ownership

- `sudo chmod < three-digit code for read write, or execute permissions for file owner, group member or other> <folder/file> -R` - set permissions for a file or a folder and its subfolders.
- `sudo chown -R <user/group> <folder/file>` - set an owner for a file or a folder

## References

- Many thanks to **Eli the Computer Guy** for his YouTube video explaining users, groups and permissions in Linux: https://www.youtube.com/watch?v=zRw0SKaXSfI
