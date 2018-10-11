# Ansible Role: Nginx

[![Build Status](https://travis-ci.org/geerlingguy/ansible-role-nginx.svg?branch=master)](https://travis-ci.org/geerlingguy/ansible-role-nginx)

Installs Nginx on RedHat/CentOS, Debian/Ubuntu, Archlinux, FreeBSD or OpenBSD servers.

This role installs and configures the latest version of Nginx from the Nginx yum repository (on RedHat-based systems), apt (on Debian-based systems), pacman (Archlinux), pkgng (on FreeBSD systems) or pkg_add (on OpenBSD systems). You will likely need to do extra setup work after this role has installed Nginx, like adding your own [virtualhost].conf file inside `/etc/nginx/conf.d/`, describing the location and options to use for your particular website.

## Requirements

None.

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml`):

    nginx_vhosts: []

A list of vhost definitions (server blocks) for Nginx virtual hosts. Each entry will create a separate config file named by `server_name`. If left empty, you will need to supply your own virtual host configuration. See the commented example in `defaults/main.yml` for available server options. If you have a large number of customizations required for your server definition(s), you're likely better off managing the vhost configuration file yourself, leaving this variable set to `[]`.

    nginx_vhosts:
      - listen: "443 ssl http2"
        server_name: "example.com"
        server_name_redirect: "www.example.com"
        root: "/var/www/example.com"
        index: "index.php index.html index.htm"
        error_page: ""
        access_log: ""
        error_log: ""
        state: "present"
        template: "{{ nginx_vhost_template }}"
        filename: "example.com.conf"
        extra_parameters: |
          location ~ \.php$ {
              fastcgi_split_path_info ^(.+\.php)(/.+)$;
              fastcgi_pass unix:/var/run/php5-fpm.sock;
              fastcgi_index index.php;
              fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
              include fastcgi_params;
          }
          ssl_certificate     /etc/ssl/certs/ssl-cert-snakeoil.pem;
          ssl_certificate_key /etc/ssl/private/ssl-cert-snakeoil.key;
          ssl_protocols       TLSv1.1 TLSv1.2;
          ssl_ciphers         HIGH:!aNULL:!MD5;


## Example Playbook

    - hosts: server
      roles:
        - { role: geerlingguy.nginx }

## License

MIT / BSD

## Author Information

This role was created in 2014 by [Jeff Geerling](https://www.jeffgeerling.com/), author of [Ansible for DevOps](https://www.ansiblefordevops.com/).
