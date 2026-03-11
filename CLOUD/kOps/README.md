# kOps와 Envoy Gateway를 이용한, 2048 Game 배포 Hands On을 진행했습니다.

# Hands On 흐름
EC2 생성 → 도구 설치 → kOps 클러스터 생성 → Envoy Gateway 설치 → 2048 게임 배포 성공

## architecture 흐름
```
브라우저 → ELB → Envoy Gateway → HTTPRoute → Service → Pod(2048 게임)
```

## 설치한 도구
| 도구 | 버전 | 용도 |
|------|------|------|
| AWS CLI | v2.34.5 | AWS 리소스 CLI 관리 |
| kubectl | v1.35.2 | Kubernetes 클러스터 제어 |
| kOps | v1.34.1 | AWS에 K8s 클러스터 생성 |

## 배포한 리소스 (a.yaml)
| 리소스 | 이름 | 역할 |
|--------|------|------|
| Namespace | game-2048 | 리소스 격리 공간 |
| Deployment | deployment-2048 | Pod 생성 및 관리 |
| Service | service-2048 | Pod 내부 네트워크 연결 (ClusterIP) |
| GatewayClass | eg | Envoy 컨트롤러 지정 |
| Gateway | gateway-2048 | 외부 트래픽 진입점 (ELB 생성) |
| HTTPRoute | route-2048 | 라우팅 규칙 (/ → service-2048) |

## 실습을 통해 배운 kubectl 명령어
```bash
kubectl get pods -n <namespace>        # Pod 목록 조회
kubectl get pods -A                    # 전체 namespace Pod 조회
kubectl describe pod <이름> -n <ns>    # Pod 상세 정보 (트러블슈팅)
kubectl logs <pod이름> -n <ns>         # 로그 조회
kubectl logs -f <pod이름> -n <ns>      # 실시간 로그
kubectl exec -it <pod이름> -n <ns> -- sh  # Pod 내부 접속
kubectl apply -f a.yaml               # 리소스 생성/수정
kubectl delete -f a.yaml              # 리소스 삭제
kubectl get gateway -n <ns>           # ELB 주소 확인
```

## 실습을 통해 배운 핵심 개념
- **Namespace**: 리소스를 논리적으로 묶는 공간. `-n` 옵션으로 지정
- **kOps**: AWS에 Kubernetes 클러스터를 자동으로 생성해주는 도구
- **GatewayClass → Gateway → HTTPRoute**: 역할 분리 (인프라팀 → 플랫폼팀 → 개발자)
- **환경변수**: `export`로 설정한 변수는 터미널 닫으면 날아감 → `~/.bashrc`에 저장해야 영구 유지
- **경량 컨테이너**: bash 없는 경우 많음 → `sh` 사용
