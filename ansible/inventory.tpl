%{ for group in groups ~}
[${group.name}]
%{for host in group.hosts ~}
${host}
%{endfor}
%{ endfor ~}
%{ for group in groups ~}
[${group.name}:vars]
ansible_ssh_private_key_file = ${group.key_file}
ansible_user = ${group.user}
%{ endfor ~}