%{ for group in groups ~}
[${group.name}]
%{for host in group.hosts ~}
${host}
%{endfor}
%{ endfor ~}