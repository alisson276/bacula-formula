{% from "bacula/map.jinja" import bacula with context -%}

bacula-storage:
  pkg.installed:
    - name: {{ bacula.storage.pkg }}
    {% if bacula.storage.version is defined -%}
    - version: {{ bacula.storage.version }}
    {%- endif %}
  service.running:
    - name: {{ bacula.storage.service }}
    - enable: True
    - require:
      - pkg: bacula-storage

{{ bacula.storage.config }}:
  file.managed:
    - source: salt://bacula/files/bacula-fd.conf
    - template: jinja
    - require:
      - pkg: bacula-storage
    - watch_in:
      - service: bacula-storage
