# scos-kube-bench

This repo sets up a cronjob in kubernetes to run [kube-bench](https://github.com/aquasecurity/kube-bench) every 24 hours. The job is located in the `kube-bench` namespace. 

The cronjob is running a docker image of a bash script (`kube-bench-wrapped.sh`) that collects the number of `FAIL` checks from the CIS Kubernetes security benchmarks. If there are no `FAIL` checks the script (and cronjob) will exit successfully with a 0 exit code, otherwie the script and cronjob will exit with a non-zero exit code, which will cause the pods with the kube-bench logs to have an `Error` status. 

The output of the `kube-bench` job will be in the logs of the pod corresponding to the last trigger of the cronjob. Note that the cronjob creates kubernetes `Jobs`, which create the pods that execute the `kube-bench` checks.

### Deployments

When deploying to staging and prod environments, the Jenkinsfile will build a docker image and upgrade the current cronjob or create a new one if none exists. Deploys to staging will happen automatically upon merges to master, and deploys to prod will trigger automatically upon new releases. 

Deploying to the dev environment requires a manual trigger with a specified docker tag in Jenkins. 
