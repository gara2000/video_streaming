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
%{ if group.private ~}
ansible_ssh_common_args='-o ProxyCommand="ssh -W %h:%p -q ${group.bastion_user}@${group.bastion_host}"'
%{ endif ~}
%{ endfor ~}