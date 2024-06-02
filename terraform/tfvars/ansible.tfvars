ansible_vars = {
    context = "{{ playbook_dir }}"
    html_file = "index.html"
    servers = [
        "http",
        "rtmp"
    ]
    dependencies = ["libnginx-mod-rtmp"]
    enabled_modules = ["ngx_rtmp_module.so"]
    email = "devops@intuitivesoft.cloud"
    http_port = 80
    rtmp_port = 1935 
}