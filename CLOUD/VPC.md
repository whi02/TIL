# VPC

### VPC (Virtual Private Cloud) 란?

Private Network를 활용하여 네트워크망을 구성하고 내부에 각종 Resource를 탑재할 수 있는 서비스 ( EC2, ELB 등)

VPC에 들어 가는 리소스(EC2 등)들은 고유의 사설 IP와 Interface를 반드시 갖게 된다.

외부에 공개될 리소스일 경우, 공인 IP를 보유할 수 있다.

### AWS 사용자 정의 네트워크 VPC에서 사용하는 사설 IP

AWS VPC는 On-premise와 동일한 대역의 사설 IP를 사용할 수 있다.
모든 AWS 계정은 위의 사설 IP 대역을 사용할 수 있다.

다만 다른 점이 있다면 원래 규정된 사설 IP 범위와는 다르게 /16 ~ /28비트의 서브넷 마스크만을 허용한다는 것이 있다. 

즉 VPC를 생성할 수 있는 가장 큰 대역은 /16이며, 가장 작은 대역은 /28입니다.

On-premise : 자체 서버에서 운영되는 시스템


AWS Cloud 내에는 IDC의 집합인 'Region'이 존재하고 Region은 IDC인 다수의 'Availability Zone(AZ)'으로 이루어진다. 그중에서 VPC는 Region에 상응하는 규모의 네트워크를 뜻한다는 것을 알 수 있다.