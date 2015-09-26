{% from "bacula/map.jinja" import bacula with context -%}

bacula-client:
  pkg.installed:
    - name: {{ bacula.client.pkg }}
    {% if bacula.client.version is defined -%}
    - version: {{ bacula.client.version }}
    {%- endif %}
  service.running:
    - name: {{ bacula.client.service }}
    - enable: True
    - require:
      - pkg: bacula-client

{{ bacula.client.config }}:
  file.managed:
    - source: salt://bacula/files/bacula-fd.conf
    - template: jinja
    - require:
      - pkg: bacula-client
    - watch_in:
      - service: bacula-client
