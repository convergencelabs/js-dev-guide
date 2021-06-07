# Kubernetes
[Kubernetes](https://kubernetes.io/) is the *de facto* standard in [OCI](https://opencontainers.org/) container orchestration. It provides cluster management, software defined networking, software defined storage. Kubernetes will manage deploying containers across a cluster of nodes and make a best effort to make sure the containers you want running stay running. There are several popular kubernetes distributions. If you are new to Kubernetes we recommend taking a look at the following options:

* [k3d](https://k3d.io/): Will run a single node Kubernetes cluster.
* [kops](https://github.com/kubernetes/kops): Will automate deployment Kubernetes to the cloud.
* [okd](https://www.okd.io/): A full-fledged open source Kubernetes, it's a bit more heavy weight but comes with everything you need. Take a look at [minishift](https://www.okd.io/minishift/) for a single node deployment of OKD.
* [Rancher RKE2](https://github.com/rancher/rke2): RKE2 is a production grade Kubernetes implementation that simplifies installation and upgrade of Kubernetes.

For other Kubernetes distributions and other related software check out the [Cloud Native Computing Foundation Landscape](https://landscape.cncf.io/).

## Convergence in Kubernetes
[Convergence Labs](https://convergencelabs.com) runs our Convergence instance in Kubernetes. However, due to the complexity of Kubernetes, Convergence Labs only provides support for Kubernetes deployments as part of our [commercial support package](https://convergence.io/support/). We are happy to answer basic question, but in depth support requires a paid plan.

We hope to release a Helm Chart to simply installation in Kubernetes in the future.