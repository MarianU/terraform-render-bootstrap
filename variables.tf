variable "cluster_name" {
  type        = string
  description = "Cluster name"
}

variable "api_servers" {
  type        = list(string)
  description = "List of URLs used to reach kube-apiserver"
}

variable "etcd_servers" {
  type        = list(string)
  description = "List of URLs used to reach etcd servers."
}

variable "networking" {
  type        = string
  description = "Choice of networking provider (flannel or calico or cilium)"
  default     = "flannel"
  validation {
    condition     = contains(["flannel","cilium","calico","kube-router"], var.networking)
    error_message = "Networking var must be one of flannel, cilium, calico or kube-router."
  }
}

variable "network_mtu" {
  type        = number
  description = "CNI interface MTU (only applies to calico)"
  default     = 1500
}

variable "network_encapsulation" {
  type        = string
  description = "Network encapsulation mode either ipip or vxlan (only applies to calico)"
  default     = "ipip"
}

variable "network_ip_autodetection_method" {
  type        = string
  description = "Method to autodetect the host IPv4 address (only applies to calico)"
  default     = "first-found"
}

variable "pod_cidr" {
  type        = string
  description = "CIDR IP range to assign Kubernetes pods"
  default     = "10.2.0.0/16"
}

variable "service_cidr" {
  type        = string
  description = <<EOD
CIDR IP range to assign Kubernetes services.
The 1st IP will be reserved for kube_apiserver, the 10th IP will be reserved for kube-dns.
EOD
  default     = "10.3.0.0/24"
}


variable "container_images" {
  type        = map(string)
  description = "Container images to use"

  default = {
    calico                  = "quay.io/calico/node:v3.20.2"
    calico_cni              = "quay.io/calico/cni:v3.20.2"
    cilium_agent            = "quay.io/cilium/cilium:v1.10.5"
    cilium_operator         = "quay.io/cilium/operator-generic:v1.10.5"
    coredns                 = "k8s.gcr.io/coredns/coredns:v1.8.4"
    flannel                 = "quay.io/coreos/flannel:v0.14.0"
    flannel_cni             = "quay.io/poseidon/flannel-cni:v0.4.2"
    kube_apiserver          = "k8s.gcr.io/kube-apiserver:v1.22.3"
    kube_controller_manager = "k8s.gcr.io/kube-controller-manager:v1.22.3"
    kube_scheduler          = "k8s.gcr.io/kube-scheduler:v1.22.3"
    kube_proxy              = "k8s.gcr.io/kube-proxy:v1.22.3"
    kube_router             = "docker.io/cloudnativelabs/kube-router:v1.3.1"
    kube_router_cni         = "docker.io/golang:alpine3.13"
  }
}


variable "trusted_certs_dir" {
  type        = string
  description = "Path to the directory on cluster nodes where trust TLS certs are kept"
  default     = "/usr/share/ca-certificates"
}

variable "enable_reporting" {
  type        = bool
  description = "Enable usage or analytics reporting to upstream component owners (Tigera: Calico)"
  default     = false
}

variable "enable_aggregation" {
  type        = bool
  description = "Enable the Kubernetes Aggregation Layer (defaults to true)"
  default     = true
}

variable "kube_router_use_proxy" {
  type        = bool
  description = "Enable proxy capability on kube-router (defaults to false, recommended), it will disable kube-proxy"
  default     = false
}

variable "daemonset_tolerations" {
  type        = list(string)
  description = "List of additional taint keys kube-system DaemonSets should tolerate (e.g. ['custom-role', 'gpu-role'])"
  default     = []
}

# unofficial, temporary, may be removed without notice

variable "external_apiserver_port" {
  type        = number
  description = "External kube-apiserver port (e.g. 6443 to match internal kube-apiserver port)"
  default     = 6443
}

variable "cluster_domain_suffix" {
  type        = string
  description = "Queries for domains with the suffix will be answered by kube-dns"
  default     = "cluster.local"
}
