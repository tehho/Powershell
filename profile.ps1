Set-Location -Path C:/project

function kubectl-context {
  param (
  )

  if (($args.Count -eq 0) -or ($args[0] -eq "--list") -or ($args[0] -eq "-l"))
  {
    kubectl config get-contexts
  }
  else {
    kubectl config use-context $args[0]
    kubectl config set-context --current --namespace=kube-system
    kubectl get pods
  }
}

function kubectl-namespace {
  param (
  )

  if (($args.Count -eq 0) -or ($args[0] -eq "--list") -or ($args[0] -eq "-l"))
  {
    kubectl get namespaces
  }
  else {
    $namespace = $args[0]
    kubectl config set-context --current --namespace="$namespace"
    kubectl get pods
  }
}

function kubectl-namespace-kube-system {
  param (
  )

  kubectl-namespace "kube-system"
}

function kubectl-get-pods {
  param (
  )
  
  kubectl get pods
}

Set-Alias kx kubectl-context
Set-Alias kn kubectl-namespace

Set-Alias kgpo kubectl-get-pods

Set-Alias k kubectl

Set-Alias tf terrform