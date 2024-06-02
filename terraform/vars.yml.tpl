%{ for key, value in ansible_vars ~}
%{ if can(value[0])}
${ key }:
%{ for val in value ~}
    - ${ val }
%{ endfor ~}
%{ else }
${ key }: ${ value }
%{ endif }
%{ endfor ~}
%{ for key, value in additional_vars~}
%{ if can(value[0])}
${ key }:
%{ for val in value ~}
    - ${ val }
%{ endfor ~}
%{ else }
${ key }: ${ value }
%{ endif }
%{ endfor ~}