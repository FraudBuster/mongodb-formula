# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as mongodb with context %}

mongodb-package-install-repo-managed:
  pkgrepo.managed:
    - name: {{ mongodb.repo.name }}
    - key_url: {{ mongodb.repo.gpgkey }}

mongodb-package-install-pkg-installed:
  pkg.installed:
    - name: {{ mongodb.pkg.name }}
