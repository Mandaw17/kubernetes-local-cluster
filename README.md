## Steps to build a kubernetes cluster locally with Vagrant

This teaches how to set up locaally a k8s cluster with vagrant. Some parts of the process may still be automated but are left to help people understand the whole process.


#### First, you have to install VirtualBox and Vagrant.

## 1- Clone the repo

## 2- Run vagrant command to execute Vagrantfile instructions

```
vagrant up 
```
This will execute instructions in the Vagrantfile:
- create VMs
- install dependancies
- init cluster

## 3- Install CNI

For this example, we choosed Calico

First, ssh into your control-plane

```
vagrant ssh control-plane
```
Then

```
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml

```

You can then check if you cluster is ready. (It might take some ime to get to Ready status)

```
kubectl get nodes
```

#### Before leaving let's copy the init command output. The latter will allow worker nodes to join the cluster

```
cat kubeinit.log
```

## 4- Join workers to the cluster

Once our control-plane is ready and running, we ssh to our workers to join the cluster.

```
vagrant ssh worker1
vagrant ssh worker2
```

Then paste the join command copied from kubeinit.log file:

```
kubeadm join 192.168.56.10:6443 --token XXX --discovery-token-ca-cert-hash sha256:XXX
```

Congratulations ! Your cluster is now up and running.