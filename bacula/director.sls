{% from "bacula/map.jinja" import bacula with context -%}

bacula-director:
  pkg.installed:
    - name: {{ bacula.director.pkg }}
    {% if bacula.director.version is defined -%}
    - version: {{ bacula.director.version }}
    {%- endif %}
  service.running:
    - name: {{ bacula.director.service }}
    - enable: True
    - require:
      - pkg: bacula-director

{{ bacula.director.config }}:
  file.managed:
    - source: salt://bacula/files/bacula-dir.conf
    - template: jinja
    - require:
      - pkg: bacula-director
    - watch_in:
      - service: bacula-director
