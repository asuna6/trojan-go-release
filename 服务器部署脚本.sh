#!/bin/bash

git clone https://github.com/asuna6/caddy-ui.git
cd ./caddy-ui/
chmod a+wrx ./caddy
(./caddy gui &)

# 需要先配置好域名解析，否则caddy启动后无法自动获取Let's encrypt的域名证书
cat > ./Caddyfile <<EOF
caddy.kizuna.top {
    reverse_proxy /* 127.0.0.1:2020
    reverse_proxy /filebrowser 127.0.0.1:2021
    reverse_proxy /filebrowser/* 127.0.0.1:2021
}
        
jp.kizuna.top {
    reverse_proxy 127.0.0.1:2021
}
                
# jp.kizuna.top {
#    reverse_proxy 127.0.0.1:2020 127.0.0.1:2021 {
#        lb_policy first
#    }
# }
EOF

# 初始化脚本：git clone https://github.com/asuna6/trojan-go-release.git
# 同步脚本：cd ./trojan-go-release ; git pull
# 启动脚本：pkill trojan-go ; cd ./trojan-go-release && chmod 777 ./trojan-go && ./trojan-go
