# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import mapdata as mongodb with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

include:
  - {{ sls_package_install }}

mongodb-config-file-file-managed:
  file.managed:
    - name: {{ mongodb.mongod.config_file }}
    - source: {{ files_switch(['mongod.conf.tmpl.jinja'],
                              lookup='mongodb-config-file-file-managed'
                 )
              }}
    - mode: 644
    - user: root
    - group: {{ mongodb.rootgroup }}
    - makedirs: True
    - template: jinja
    - require:
      - sls: {{ sls_package_install }}
 {%- set mongod = mongodb.get('mongod', {}).get('config',{}) %}
 {%- if mongod %}
    - context:
        mongod: {{ mongod | json }}
{%- endif %}
    - defaults:
        mongod: {'storage': '/var/lib'}
