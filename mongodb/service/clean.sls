# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as mongodb with context %}

mongodb-service-clean-service-dead:
  service.dead:
    - name: {{ mongodb.service.name }}
    - enable: False
