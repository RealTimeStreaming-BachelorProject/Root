# DriverService
ssh admin@10.123.252.250 rm -rf DriverService # Folder might already exist
ssh admin@10.123.252.250 git clone https://github.com/RealTimeStreaming-BachelorProject/DriverService.git
ssh admin@10.123.252.250 sudo docker-compose -f ./DriverService/docker-compose.yml build
ssh admin@10.123.252.250 sudo docker-compose -f ./DriverService/docker-compose.yml up -d

# Artillery.io
ssh admin@10.123.252.251 rm -rf ClientTestingTool # Folder might already exist
ssh admin@10.123.252.251 git clone https://github.com/RealTimeStreaming-BachelorProject/ClientTestingTool.git
ssh admin@10.123.252.251 sudo docker-compose -f ./ClientTestingTool/loadtest/docker-compose.yml build
ssh admin@10.123.252.251 sudo docker-compose -f ./ClientTestingTool/loadtest/docker-compose.yml run test_runner "./tests/driverService/driverservice.loadtest.yml" "--target http://10.123.252.250:5002"
# TODO: ^Above command doesn't execute --target argument.