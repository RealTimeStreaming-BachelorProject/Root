# Check if .env is in directory
if ! test -f ".env"; then
    echo "No .env found. You need to manually add it."
    exit 2
fi

# LoadBalancer
server_loadbalancer="admin@10.123.252.246"
ssh $server_loadbalancer rm -rf LoadBalancer_DriverService # Folder might already exist
ssh $server_loadbalancer git clone https://github.com/RealTimeStreaming-BachelorProject/LoadBalancer_DriverService.git
ssh $server_loadbalancer sudo docker-compose -f ./LoadBalancer_DriverService/docker-compose.yml build
ssh $server_loadbalancer sudo docker-compose -f ./LoadBalancer_DriverService/docker-compose.yml up -d


# DriverService
server_driver="admin@10.123.252.250"
ssh $server_driver rm -rf DriverService # Folde r might already exist
ssh $server_driver git clone https://github.com/RealTimeStreaming-BachelorProject/DriverService.git
scp .env $server_driver:~/DriverService
ssh $server_driver sudo docker-compose -f ./DriverService/docker-compose.yml build
ssh $server_driver sudo docker-compose -f ./DriverService/docker-compose.yml up -d

# DriverService 2
# server_driver2="admin@10.123.252.246"
# ssh $server_driver2 rm -rf DriverService # Folder might already exist
# ssh $server_driver2 git clone https://github.com/RealTimeStreaming-BachelorProject/DriverService.git
# scp .env $server_driver2:~/DriverService
# ssh $server_driver2 sudo docker-compose -f ./DriverService/docker-compose.yml build
# ssh $server_driver2 sudo docker-compose -f ./DriverService/docker-compose.yml up -d

# Artillery.io
server_test="admin@10.123.252.251"
ssh $server_test rm -rf ClientTestingTool # Folder might already exist
ssh $server_test git clone https://github.com/RealTimeStreaming-BachelorProject/ClientTestingTool.git
ssh $server_test sudo docker-compose -f ./ClientTestingTool/loadtest/docker-compose.yml build
ssh $server_test sudo docker-compose -f ./ClientTestingTool/loadtest/docker-compose.yml run test_runner \
 "npm run testcase_2"
scp $server_test:/opt/reports/report.html ./