# terraform-render-bootstrap

`terraform-render-bootstrap` is a Terraform module that renders TLS certificates, static pods, and manifests for bootstrapping a Kubernetes cluster.

## This Fork

Adds kube-router to the mix and a small change in the organization of manifests to enable the possibility to disable kube-proxy and use proxy feature of kube-router.
TODO: deploy an image with kube-router plugins so that we do not compile them on init.
WARNING: because of the modification the poseidon/typhoon is no longer compatible you need to use MarianU/typhoon fork.

## Audience

`terraform-render-bootstrap` is a low-level component of the [Typhoon](https://github.com/poseidon/typhoon) Kubernetes distribution. Use Typhoon modules to create and manage Kubernetes clusters across supported platforms. Use the bootstrap module if you'd like to customize a Kubernetes control plane or build your own distribution.

## Usage

Use the module to declare bootstrap assets. Check [variables.tf](variables.tf) for options and [terraform.tfvars.example](terraform.tfvars.example) for examples.

```hcl
module "bootstrap" {
  source = "git::https://github.com/poseidon/terraform-render-bootstrap.git?ref=SHA"

  cluster_name = "example"
  api_servers = ["node1.example.com"]
  etcd_servers = ["node1.example.com"]
}
```

Generate assets in Terraform state.

```sh
terraform init
terraform plan
terraform apply
```

To inspect and write assets locally (e.g. debugging) use the `assets_dist` Terraform output.

```
resource local_file "assets" {
  for_each = module.bootstrap.assets_dist
  filename = "some-assets/${each.key}"
  content = each.value
}
```

