# Failures

This document records the notes from fixing the failures encountered as part of the CIS Benchmarking.

### [FAIL] 2.1.4 Ensure that the --read-only-port argument is set to 0 (Scored)

If using a Kubelet config file, edit the file to set `readOnlyPort` to 0.
If using command line arguments, edit the kubelet service file /etc/systemd/system/kubelet.service.d/10-kubeadm.conf on each worker node and set the below parameter in KUBELET_SYSTEM_PODS_ARGS variable.
`--read-only-port=0`

// readOnlyPort is the read-only port for the Kubelet to serve on with
// no authentication/authorization (set to 0 to disable)
ReadOnlyPort int32

### [FAIL] 2.1.6 Ensure that the --protect-kernel-defaults argument is set to true (Scored)

If using a Kubelet config file, edit the file to set `protectKernelDefaults`: true.
If using command line arguments, edit the kubelet service file /etc/systemd/system/kubelet.service.d/10-kubeadm.conf on each worker node and set the below parameter in KUBELET_SYSTEM_PODS_ARGS variable.
`--protect-kernel-defaults=true`

- _Causes nodes to enter NotReady state due to kernel defaults not matching_
- _Can be fixed, but may go out of date if AWS changes its kernel defaults_
- _If set to false, kubelet will attempt to make them match_
- <https://github.com/kubernetes/kubernetes/blob/master/pkg/kubelet/apis/config/types.go>

// protectKernelDefaults, if true, causes the Kubelet to error if kernel
// flags are not as it expects. Otherwise the Kubelet will attempt to modify
// kernel flags to match its expectation.
ProtectKernelDefaults bool

--protect-kernel-defaults
Default kubelet behaviour for kernel tuning. If set, kubelet errors if any of kernel tunables is different than kubelet defaults. (DEPRECATED: This parameter should be set via the config file specified by the Kubelet's --config flag. See https://kubernetes.io/docs/tasks/administer-cluster/kubelet-config-file/ for more information.

### [FAIL] 2.1.9 Ensure that the --event-qps argument is set to 0 (Scored)

If using a Kubelet config file, edit the file to set `eventRecordQPS`: 0.
If using command line arguments, edit the kubelet service file /etc/systemd/system/kubelet.service.d/10-kubeadm.conf on each worker node and set the below parameter in KUBELET_SYSTEM_PODS_ARGS variable.
`--event-qps=0`

// eventBurst is the maximum size of a burst of event creations, temporarily
// allows event creations to burst to this number, while still not exceeding
// eventRecordQPS. Only used if eventRecordQPS > 0.
EventBurst int32

### [FAIL] 2.1.10 Ensure that the --tls-cert-file and --tls-private-key-file arguments are set as appropriate (Scored)

If using a Kubelet config file, edit the file to set `tlsCertFile` to the location of the certificate file to use to identify this Kubelet, and `tlsPrivateKeyFile` to the location of the corresponding private key file.
If using command line arguments, edit the kubelet service file /etc/systemd/system/kubelet.service.d/10-kubeadm.conf on each worker node and set the below parameters in KUBELET_CERTIFICATE_ARGS variable.
--tls-cert-file=<path/to/tls-certificate-file> --tls-private-key-file=<path/to/tls-key-file>

- _Do not have access to these files on the Master_
- _Rule is no longer relevant due to the use of TLS bootstrapping_


### [FAIL] 2.2.5 Ensure that the proxy kubeconfig file permissions are set to 644 or more restrictive (Scored)

Run the below command (based on the file location on your system) on the each worker node. For example,
`chmod 644 <proxy kubeconfig file>`

### [FAIL] 2.2.6 Ensure that the proxy kubeconfig file ownership is set to root:root (Scored)

Run the below command (based on the file location on your system) on the each worker node. For example,
`chown root:root <proxy kubeconfig file>`

/etc/kubernetes/kubelet/kubelet-config.json
