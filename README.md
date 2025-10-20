# Kubernetes in Docker

**Kubernetes ( 簡稱為 K8s ) 是用於自動部署、擴充和管理「容器化（containerized）應用程式」的開源系統。**
> From [Kubernetes - Wiki](https://zh.wikipedia.org/zh-tw/Kubernetes)

**kind is a tool for running local Kubernetes clusters using Docker container “nodes”.kind was primarily designed for testing Kubernetes itself, but may be used for local development or CI.**
> From [kind](https://kind.sigs.k8s.io/)

本研究根據 [infra-kubernetes](https://github.com/eastmoon/infra-kubernetes) 為基礎，調查 Kubernetes in Docker 的實務方式。

## 環境

執行環境必要功能：

+ Golong 語言
+ Docker 服務
+ Kind 服務

本專案基於 ISA 專案結構設計，並修該 ISA 管理服務容器以符合使用 Kind 功能，啟動環境請使用以下指令。

```
# 啟動開發環境
do dev
# 進入開發容器
do dev --into
```

## 介紹

+ ```isa exec defualt```，建置叢集並配置一個 Pod 與 Service
    - 配置檔參考 [default.yaml](./app/configs/default.yaml)
    - 主要流程
        + [create-cluster](./app/configs/kube/creaate-cluster.sh)，運用 Kind 建立叢集，並配合 isa 指令掛載網路以確保 kubectl 可正常運作
        + [launch-k8s-pod](./app/configs/kube/launch-k8s-pod.sh)，運用 kubectl 建立 Pod
        + [launch-k8s-service](./app/configs/kube/launch-k8s-service.sh)，運用 kubectl 建立 Service
+ ```bash check-kind-service.sh```，檢查服務啟動狀態
+ ```bash into-kind-service.sh```，進入啟動中的服務
    - 使用 ```crictl pods``` 檢閱目前啟動 pod 列表
    - 使用 ```crictl images``` 檢閱目前下載的映像檔列表

## 文獻

+ [Kubernetes in Docker](https://kind.sigs.k8s.io/)
    - [kindest/node](https://hub.docker.com/r/kindest/node/)
    - [Initial - kind](https://kind.sigs.k8s.io/docs/design/initial/)
    - [Configuration - kind](https://kind.sigs.k8s.io/docs/user/configuration/)
    - [Ingress - kind](https://kind.sigs.k8s.io/docs/user/ingress/)
    - [LoadBalancer - kind](https://kind.sigs.k8s.io/docs/user/loadbalancer/)
+ 文獻
