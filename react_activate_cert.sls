{% set version = salt.pillar.get('version') %}

run_activate_command:
  cmd.run:
    - name: /usr/local/bin/vault_pki.py activate {{ version }}

update_current_file:
  file.managed:
    - name: /etc/vault_pki/live/{{ grains['id'] }}/current
    - mode: 0644
    - user: root
    - group: cert-access
    - contents: "{{ version }}"
    - require:
      - cmd: run_activate_command
    #- watch_in:
    #  - nginx
