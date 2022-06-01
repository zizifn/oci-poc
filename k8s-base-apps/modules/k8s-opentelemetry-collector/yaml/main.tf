resource "kubernetes_manifest" "namespace_opentelemetry_operator_system" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "Namespace"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/name" = "opentelemetry-operator"
        "control-plane" = "controller-manager"
      }
      "name" = "opentelemetry-operator-system"
    }
  }
}

resource "kubernetes_manifest" "customresourcedefinition_instrumentations_opentelemetry_io" {
  manifest = {
    "apiVersion" = "apiextensions.k8s.io/v1"
    "kind" = "CustomResourceDefinition"
    "metadata" = {
      "annotations" = {
        "controller-gen.kubebuilder.io/version" = "v0.8.0"
      }
      "labels" = {
        "app.kubernetes.io/name" = "opentelemetry-operator"
      }
      "name" = "instrumentations.opentelemetry.io"
    }
    "spec" = {
      "group" = "opentelemetry.io"
      "names" = {
        "kind" = "Instrumentation"
        "listKind" = "InstrumentationList"
        "plural" = "instrumentations"
        "shortNames" = [
          "otelinst",
          "otelinsts",
        ]
        "singular" = "instrumentation"
      }
      "scope" = "Namespaced"
      "versions" = [
        {
          "additionalPrinterColumns" = [
            {
              "jsonPath" = ".metadata.creationTimestamp"
              "name" = "Age"
              "type" = "date"
            },
            {
              "jsonPath" = ".spec.exporter.endpoint"
              "name" = "Endpoint"
              "type" = "string"
            },
            {
              "jsonPath" = ".spec.sampler.type"
              "name" = "Sampler"
              "type" = "string"
            },
            {
              "jsonPath" = ".spec.sampler.argument"
              "name" = "Sampler Arg"
              "type" = "string"
            },
          ]
          "name" = "v1alpha1"
          "schema" = {
            "openAPIV3Schema" = {
              "description" = "Instrumentation is the spec for OpenTelemetry instrumentation."
              "properties" = {
                "apiVersion" = {
                  "description" = "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"
                  "type" = "string"
                }
                "kind" = {
                  "description" = "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"
                  "type" = "string"
                }
                "metadata" = {
                  "type" = "object"
                }
                "spec" = {
                  "description" = "InstrumentationSpec defines the desired state of OpenTelemetry SDK and instrumentation."
                  "properties" = {
                    "env" = {
                      "description" = "Env defines common env vars. There are four layers for env vars' definitions and the precedence order is: `original container env vars` > `language specific env vars` > `common env vars` > `instrument spec configs' vars`. If the former var had been defined, then the other vars would be ignored."
                      "items" = {
                        "description" = "EnvVar represents an environment variable present in a Container."
                        "properties" = {
                          "name" = {
                            "description" = "Name of the environment variable. Must be a C_IDENTIFIER."
                            "type" = "string"
                          }
                          "value" = {
                            "description" = "Variable references $(VAR_NAME) are expanded using the previously defined environment variables in the container and any service environment variables. If a variable cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. \"$$(VAR_NAME)\" will produce the string literal \"$(VAR_NAME)\". Escaped references will never be expanded, regardless of whether the variable exists or not. Defaults to \"\"."
                            "type" = "string"
                          }
                          "valueFrom" = {
                            "description" = "Source for the environment variable's value. Cannot be used if value is not empty."
                            "properties" = {
                              "configMapKeyRef" = {
                                "description" = "Selects a key of a ConfigMap."
                                "properties" = {
                                  "key" = {
                                    "description" = "The key to select."
                                    "type" = "string"
                                  }
                                  "name" = {
                                    "description" = "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
                                    "type" = "string"
                                  }
                                  "optional" = {
                                    "description" = "Specify whether the ConfigMap or its key must be defined"
                                    "type" = "boolean"
                                  }
                                }
                                "required" = [
                                  "key",
                                ]
                                "type" = "object"
                              }
                              "fieldRef" = {
                                "description" = "Selects a field of the pod: supports metadata.name, metadata.namespace, `metadata.labels['<KEY>']`, `metadata.annotations['<KEY>']`, spec.nodeName, spec.serviceAccountName, status.hostIP, status.podIP, status.podIPs."
                                "properties" = {
                                  "apiVersion" = {
                                    "description" = "Version of the schema the FieldPath is written in terms of, defaults to \"v1\"."
                                    "type" = "string"
                                  }
                                  "fieldPath" = {
                                    "description" = "Path of the field to select in the specified API version."
                                    "type" = "string"
                                  }
                                }
                                "required" = [
                                  "fieldPath",
                                ]
                                "type" = "object"
                              }
                              "resourceFieldRef" = {
                                "description" = "Selects a resource of the container: only resources limits and requests (limits.cpu, limits.memory, limits.ephemeral-storage, requests.cpu, requests.memory and requests.ephemeral-storage) are currently supported."
                                "properties" = {
                                  "containerName" = {
                                    "description" = "Container name: required for volumes, optional for env vars"
                                    "type" = "string"
                                  }
                                  "divisor" = {
                                    "anyOf" = [
                                      {
                                        "type" = "integer"
                                      },
                                      {
                                        "type" = "string"
                                      },
                                    ]
                                    "description" = "Specifies the output format of the exposed resources, defaults to \"1\""
                                    "pattern" = "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
                                    "x-kubernetes-int-or-string" = true
                                  }
                                  "resource" = {
                                    "description" = "Required: resource to select"
                                    "type" = "string"
                                  }
                                }
                                "required" = [
                                  "resource",
                                ]
                                "type" = "object"
                              }
                              "secretKeyRef" = {
                                "description" = "Selects a key of a secret in the pod's namespace"
                                "properties" = {
                                  "key" = {
                                    "description" = "The key of the secret to select from.  Must be a valid secret key."
                                    "type" = "string"
                                  }
                                  "name" = {
                                    "description" = "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
                                    "type" = "string"
                                  }
                                  "optional" = {
                                    "description" = "Specify whether the Secret or its key must be defined"
                                    "type" = "boolean"
                                  }
                                }
                                "required" = [
                                  "key",
                                ]
                                "type" = "object"
                              }
                            }
                            "type" = "object"
                          }
                        }
                        "required" = [
                          "name",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "exporter" = {
                      "description" = "Exporter defines exporter configuration."
                      "properties" = {
                        "endpoint" = {
                          "description" = "Endpoint is address of the collector with OTLP endpoint."
                          "type" = "string"
                        }
                      }
                      "type" = "object"
                    }
                    "java" = {
                      "description" = "Java defines configuration for java auto-instrumentation."
                      "properties" = {
                        "env" = {
                          "description" = "Env defines java specific env vars. There are four layers for env vars' definitions and the precedence order is: `original container env vars` > `language specific env vars` > `common env vars` > `instrument spec configs' vars`. If the former var had been defined, then the other vars would be ignored."
                          "items" = {
                            "description" = "EnvVar represents an environment variable present in a Container."
                            "properties" = {
                              "name" = {
                                "description" = "Name of the environment variable. Must be a C_IDENTIFIER."
                                "type" = "string"
                              }
                              "value" = {
                                "description" = "Variable references $(VAR_NAME) are expanded using the previously defined environment variables in the container and any service environment variables. If a variable cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. \"$$(VAR_NAME)\" will produce the string literal \"$(VAR_NAME)\". Escaped references will never be expanded, regardless of whether the variable exists or not. Defaults to \"\"."
                                "type" = "string"
                              }
                              "valueFrom" = {
                                "description" = "Source for the environment variable's value. Cannot be used if value is not empty."
                                "properties" = {
                                  "configMapKeyRef" = {
                                    "description" = "Selects a key of a ConfigMap."
                                    "properties" = {
                                      "key" = {
                                        "description" = "The key to select."
                                        "type" = "string"
                                      }
                                      "name" = {
                                        "description" = "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
                                        "type" = "string"
                                      }
                                      "optional" = {
                                        "description" = "Specify whether the ConfigMap or its key must be defined"
                                        "type" = "boolean"
                                      }
                                    }
                                    "required" = [
                                      "key",
                                    ]
                                    "type" = "object"
                                  }
                                  "fieldRef" = {
                                    "description" = "Selects a field of the pod: supports metadata.name, metadata.namespace, `metadata.labels['<KEY>']`, `metadata.annotations['<KEY>']`, spec.nodeName, spec.serviceAccountName, status.hostIP, status.podIP, status.podIPs."
                                    "properties" = {
                                      "apiVersion" = {
                                        "description" = "Version of the schema the FieldPath is written in terms of, defaults to \"v1\"."
                                        "type" = "string"
                                      }
                                      "fieldPath" = {
                                        "description" = "Path of the field to select in the specified API version."
                                        "type" = "string"
                                      }
                                    }
                                    "required" = [
                                      "fieldPath",
                                    ]
                                    "type" = "object"
                                  }
                                  "resourceFieldRef" = {
                                    "description" = "Selects a resource of the container: only resources limits and requests (limits.cpu, limits.memory, limits.ephemeral-storage, requests.cpu, requests.memory and requests.ephemeral-storage) are currently supported."
                                    "properties" = {
                                      "containerName" = {
                                        "description" = "Container name: required for volumes, optional for env vars"
                                        "type" = "string"
                                      }
                                      "divisor" = {
                                        "anyOf" = [
                                          {
                                            "type" = "integer"
                                          },
                                          {
                                            "type" = "string"
                                          },
                                        ]
                                        "description" = "Specifies the output format of the exposed resources, defaults to \"1\""
                                        "pattern" = "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
                                        "x-kubernetes-int-or-string" = true
                                      }
                                      "resource" = {
                                        "description" = "Required: resource to select"
                                        "type" = "string"
                                      }
                                    }
                                    "required" = [
                                      "resource",
                                    ]
                                    "type" = "object"
                                  }
                                  "secretKeyRef" = {
                                    "description" = "Selects a key of a secret in the pod's namespace"
                                    "properties" = {
                                      "key" = {
                                        "description" = "The key of the secret to select from.  Must be a valid secret key."
                                        "type" = "string"
                                      }
                                      "name" = {
                                        "description" = "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
                                        "type" = "string"
                                      }
                                      "optional" = {
                                        "description" = "Specify whether the Secret or its key must be defined"
                                        "type" = "boolean"
                                      }
                                    }
                                    "required" = [
                                      "key",
                                    ]
                                    "type" = "object"
                                  }
                                }
                                "type" = "object"
                              }
                            }
                            "required" = [
                              "name",
                            ]
                            "type" = "object"
                          }
                          "type" = "array"
                        }
                        "image" = {
                          "description" = "Image is a container image with javaagent auto-instrumentation JAR."
                          "type" = "string"
                        }
                      }
                      "type" = "object"
                    }
                    "nodejs" = {
                      "description" = "NodeJS defines configuration for nodejs auto-instrumentation."
                      "properties" = {
                        "env" = {
                          "description" = "Env defines nodejs specific env vars. There are four layers for env vars' definitions and the precedence order is: `original container env vars` > `language specific env vars` > `common env vars` > `instrument spec configs' vars`. If the former var had been defined, then the other vars would be ignored."
                          "items" = {
                            "description" = "EnvVar represents an environment variable present in a Container."
                            "properties" = {
                              "name" = {
                                "description" = "Name of the environment variable. Must be a C_IDENTIFIER."
                                "type" = "string"
                              }
                              "value" = {
                                "description" = "Variable references $(VAR_NAME) are expanded using the previously defined environment variables in the container and any service environment variables. If a variable cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. \"$$(VAR_NAME)\" will produce the string literal \"$(VAR_NAME)\". Escaped references will never be expanded, regardless of whether the variable exists or not. Defaults to \"\"."
                                "type" = "string"
                              }
                              "valueFrom" = {
                                "description" = "Source for the environment variable's value. Cannot be used if value is not empty."
                                "properties" = {
                                  "configMapKeyRef" = {
                                    "description" = "Selects a key of a ConfigMap."
                                    "properties" = {
                                      "key" = {
                                        "description" = "The key to select."
                                        "type" = "string"
                                      }
                                      "name" = {
                                        "description" = "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
                                        "type" = "string"
                                      }
                                      "optional" = {
                                        "description" = "Specify whether the ConfigMap or its key must be defined"
                                        "type" = "boolean"
                                      }
                                    }
                                    "required" = [
                                      "key",
                                    ]
                                    "type" = "object"
                                  }
                                  "fieldRef" = {
                                    "description" = "Selects a field of the pod: supports metadata.name, metadata.namespace, `metadata.labels['<KEY>']`, `metadata.annotations['<KEY>']`, spec.nodeName, spec.serviceAccountName, status.hostIP, status.podIP, status.podIPs."
                                    "properties" = {
                                      "apiVersion" = {
                                        "description" = "Version of the schema the FieldPath is written in terms of, defaults to \"v1\"."
                                        "type" = "string"
                                      }
                                      "fieldPath" = {
                                        "description" = "Path of the field to select in the specified API version."
                                        "type" = "string"
                                      }
                                    }
                                    "required" = [
                                      "fieldPath",
                                    ]
                                    "type" = "object"
                                  }
                                  "resourceFieldRef" = {
                                    "description" = "Selects a resource of the container: only resources limits and requests (limits.cpu, limits.memory, limits.ephemeral-storage, requests.cpu, requests.memory and requests.ephemeral-storage) are currently supported."
                                    "properties" = {
                                      "containerName" = {
                                        "description" = "Container name: required for volumes, optional for env vars"
                                        "type" = "string"
                                      }
                                      "divisor" = {
                                        "anyOf" = [
                                          {
                                            "type" = "integer"
                                          },
                                          {
                                            "type" = "string"
                                          },
                                        ]
                                        "description" = "Specifies the output format of the exposed resources, defaults to \"1\""
                                        "pattern" = "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
                                        "x-kubernetes-int-or-string" = true
                                      }
                                      "resource" = {
                                        "description" = "Required: resource to select"
                                        "type" = "string"
                                      }
                                    }
                                    "required" = [
                                      "resource",
                                    ]
                                    "type" = "object"
                                  }
                                  "secretKeyRef" = {
                                    "description" = "Selects a key of a secret in the pod's namespace"
                                    "properties" = {
                                      "key" = {
                                        "description" = "The key of the secret to select from.  Must be a valid secret key."
                                        "type" = "string"
                                      }
                                      "name" = {
                                        "description" = "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
                                        "type" = "string"
                                      }
                                      "optional" = {
                                        "description" = "Specify whether the Secret or its key must be defined"
                                        "type" = "boolean"
                                      }
                                    }
                                    "required" = [
                                      "key",
                                    ]
                                    "type" = "object"
                                  }
                                }
                                "type" = "object"
                              }
                            }
                            "required" = [
                              "name",
                            ]
                            "type" = "object"
                          }
                          "type" = "array"
                        }
                        "image" = {
                          "description" = "Image is a container image with NodeJS SDK and auto-instrumentation."
                          "type" = "string"
                        }
                      }
                      "type" = "object"
                    }
                    "propagators" = {
                      "description" = "Propagators defines inter-process context propagation configuration."
                      "items" = {
                        "description" = "Propagator represents the propagation type."
                        "enum" = [
                          "tracecontext",
                          "baggage",
                          "b3",
                          "b3multi",
                          "jaeger",
                          "xray",
                          "ottrace",
                          "none",
                        ]
                        "type" = "string"
                      }
                      "type" = "array"
                    }
                    "python" = {
                      "description" = "Python defines configuration for python auto-instrumentation."
                      "properties" = {
                        "env" = {
                          "description" = "Env defines python specific env vars. There are four layers for env vars' definitions and the precedence order is: `original container env vars` > `language specific env vars` > `common env vars` > `instrument spec configs' vars`. If the former var had been defined, then the other vars would be ignored."
                          "items" = {
                            "description" = "EnvVar represents an environment variable present in a Container."
                            "properties" = {
                              "name" = {
                                "description" = "Name of the environment variable. Must be a C_IDENTIFIER."
                                "type" = "string"
                              }
                              "value" = {
                                "description" = "Variable references $(VAR_NAME) are expanded using the previously defined environment variables in the container and any service environment variables. If a variable cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. \"$$(VAR_NAME)\" will produce the string literal \"$(VAR_NAME)\". Escaped references will never be expanded, regardless of whether the variable exists or not. Defaults to \"\"."
                                "type" = "string"
                              }
                              "valueFrom" = {
                                "description" = "Source for the environment variable's value. Cannot be used if value is not empty."
                                "properties" = {
                                  "configMapKeyRef" = {
                                    "description" = "Selects a key of a ConfigMap."
                                    "properties" = {
                                      "key" = {
                                        "description" = "The key to select."
                                        "type" = "string"
                                      }
                                      "name" = {
                                        "description" = "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
                                        "type" = "string"
                                      }
                                      "optional" = {
                                        "description" = "Specify whether the ConfigMap or its key must be defined"
                                        "type" = "boolean"
                                      }
                                    }
                                    "required" = [
                                      "key",
                                    ]
                                    "type" = "object"
                                  }
                                  "fieldRef" = {
                                    "description" = "Selects a field of the pod: supports metadata.name, metadata.namespace, `metadata.labels['<KEY>']`, `metadata.annotations['<KEY>']`, spec.nodeName, spec.serviceAccountName, status.hostIP, status.podIP, status.podIPs."
                                    "properties" = {
                                      "apiVersion" = {
                                        "description" = "Version of the schema the FieldPath is written in terms of, defaults to \"v1\"."
                                        "type" = "string"
                                      }
                                      "fieldPath" = {
                                        "description" = "Path of the field to select in the specified API version."
                                        "type" = "string"
                                      }
                                    }
                                    "required" = [
                                      "fieldPath",
                                    ]
                                    "type" = "object"
                                  }
                                  "resourceFieldRef" = {
                                    "description" = "Selects a resource of the container: only resources limits and requests (limits.cpu, limits.memory, limits.ephemeral-storage, requests.cpu, requests.memory and requests.ephemeral-storage) are currently supported."
                                    "properties" = {
                                      "containerName" = {
                                        "description" = "Container name: required for volumes, optional for env vars"
                                        "type" = "string"
                                      }
                                      "divisor" = {
                                        "anyOf" = [
                                          {
                                            "type" = "integer"
                                          },
                                          {
                                            "type" = "string"
                                          },
                                        ]
                                        "description" = "Specifies the output format of the exposed resources, defaults to \"1\""
                                        "pattern" = "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
                                        "x-kubernetes-int-or-string" = true
                                      }
                                      "resource" = {
                                        "description" = "Required: resource to select"
                                        "type" = "string"
                                      }
                                    }
                                    "required" = [
                                      "resource",
                                    ]
                                    "type" = "object"
                                  }
                                  "secretKeyRef" = {
                                    "description" = "Selects a key of a secret in the pod's namespace"
                                    "properties" = {
                                      "key" = {
                                        "description" = "The key of the secret to select from.  Must be a valid secret key."
                                        "type" = "string"
                                      }
                                      "name" = {
                                        "description" = "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
                                        "type" = "string"
                                      }
                                      "optional" = {
                                        "description" = "Specify whether the Secret or its key must be defined"
                                        "type" = "boolean"
                                      }
                                    }
                                    "required" = [
                                      "key",
                                    ]
                                    "type" = "object"
                                  }
                                }
                                "type" = "object"
                              }
                            }
                            "required" = [
                              "name",
                            ]
                            "type" = "object"
                          }
                          "type" = "array"
                        }
                        "image" = {
                          "description" = "Image is a container image with Python SDK and auto-instrumentation."
                          "type" = "string"
                        }
                      }
                      "type" = "object"
                    }
                    "resource" = {
                      "description" = "Resource defines the configuration for the resource attributes, as defined by the OpenTelemetry specification."
                      "properties" = {
                        "addK8sUIDAttributes" = {
                          "description" = "AddK8sUIDAttributes defines whether K8s UID attributes should be collected (e.g. k8s.deployment.uid)."
                          "type" = "boolean"
                        }
                        "resourceAttributes" = {
                          "additionalProperties" = {
                            "type" = "string"
                          }
                          "description" = "Attributes defines attributes that are added to the resource. For example environment: dev"
                          "type" = "object"
                        }
                      }
                      "type" = "object"
                    }
                    "sampler" = {
                      "description" = "Sampler defines sampling configuration."
                      "properties" = {
                        "argument" = {
                          "description" = "Argument defines sampler argument. The value depends on the sampler type. For instance for parentbased_traceidratio sampler type it is a number in range [0..1] e.g. 0.25."
                          "type" = "string"
                        }
                        "type" = {
                          "description" = "Type defines sampler type. The value can be for instance parentbased_always_on, parentbased_always_off, parentbased_traceidratio..."
                          "enum" = [
                            "always_on",
                            "always_off",
                            "traceidratio",
                            "parentbased_always_on",
                            "parentbased_always_off",
                            "parentbased_traceidratio",
                            "jaeger_remote",
                            "xray",
                          ]
                          "type" = "string"
                        }
                      }
                      "type" = "object"
                    }
                  }
                  "type" = "object"
                }
                "status" = {
                  "description" = "InstrumentationStatus defines status of the instrumentation."
                  "type" = "object"
                }
              }
              "type" = "object"
            }
          }
          "served" = true
          "storage" = true
          "subresources" = {
            "status" = {}
          }
        },
      ]
    }
  }
}

resource "kubernetes_manifest" "customresourcedefinition_opentelemetrycollectors_opentelemetry_io" {
  manifest = {
    "apiVersion" = "apiextensions.k8s.io/v1"
    "kind" = "CustomResourceDefinition"
    "metadata" = {
      "annotations" = {
        "cert-manager.io/inject-ca-from" = "opentelemetry-operator-system/opentelemetry-operator-serving-cert"
        "controller-gen.kubebuilder.io/version" = "v0.8.0"
      }
      "labels" = {
        "app.kubernetes.io/name" = "opentelemetry-operator"
      }
      "name" = "opentelemetrycollectors.opentelemetry.io"
    }
    "spec" = {
      "group" = "opentelemetry.io"
      "names" = {
        "kind" = "OpenTelemetryCollector"
        "listKind" = "OpenTelemetryCollectorList"
        "plural" = "opentelemetrycollectors"
        "shortNames" = [
          "otelcol",
          "otelcols",
        ]
        "singular" = "opentelemetrycollector"
      }
      "scope" = "Namespaced"
      "versions" = [
        {
          "additionalPrinterColumns" = [
            {
              "description" = "Deployment Mode"
              "jsonPath" = ".spec.mode"
              "name" = "Mode"
              "type" = "string"
            },
            {
              "description" = "OpenTelemetry Version"
              "jsonPath" = ".status.version"
              "name" = "Version"
              "type" = "string"
            },
            {
              "jsonPath" = ".metadata.creationTimestamp"
              "name" = "Age"
              "type" = "date"
            },
          ]
          "name" = "v1alpha1"
          "schema" = {
            "openAPIV3Schema" = {
              "description" = "OpenTelemetryCollector is the Schema for the opentelemetrycollectors API."
              "properties" = {
                "apiVersion" = {
                  "description" = "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"
                  "type" = "string"
                }
                "kind" = {
                  "description" = "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"
                  "type" = "string"
                }
                "metadata" = {
                  "type" = "object"
                }
                "spec" = {
                  "description" = "OpenTelemetryCollectorSpec defines the desired state of OpenTelemetryCollector."
                  "properties" = {
                    "args" = {
                      "additionalProperties" = {
                        "type" = "string"
                      }
                      "description" = "Args is the set of arguments to pass to the OpenTelemetry Collector binary"
                      "type" = "object"
                    }
                    "config" = {
                      "description" = "Config is the raw JSON to be used as the collector's configuration. Refer to the OpenTelemetry Collector documentation for details."
                      "type" = "string"
                    }
                    "env" = {
                      "description" = "ENV vars to set on the OpenTelemetry Collector's Pods. These can then in certain cases be consumed in the config file for the Collector."
                      "items" = {
                        "description" = "EnvVar represents an environment variable present in a Container."
                        "properties" = {
                          "name" = {
                            "description" = "Name of the environment variable. Must be a C_IDENTIFIER."
                            "type" = "string"
                          }
                          "value" = {
                            "description" = "Variable references $(VAR_NAME) are expanded using the previously defined environment variables in the container and any service environment variables. If a variable cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. \"$$(VAR_NAME)\" will produce the string literal \"$(VAR_NAME)\". Escaped references will never be expanded, regardless of whether the variable exists or not. Defaults to \"\"."
                            "type" = "string"
                          }
                          "valueFrom" = {
                            "description" = "Source for the environment variable's value. Cannot be used if value is not empty."
                            "properties" = {
                              "configMapKeyRef" = {
                                "description" = "Selects a key of a ConfigMap."
                                "properties" = {
                                  "key" = {
                                    "description" = "The key to select."
                                    "type" = "string"
                                  }
                                  "name" = {
                                    "description" = "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
                                    "type" = "string"
                                  }
                                  "optional" = {
                                    "description" = "Specify whether the ConfigMap or its key must be defined"
                                    "type" = "boolean"
                                  }
                                }
                                "required" = [
                                  "key",
                                ]
                                "type" = "object"
                              }
                              "fieldRef" = {
                                "description" = "Selects a field of the pod: supports metadata.name, metadata.namespace, `metadata.labels['<KEY>']`, `metadata.annotations['<KEY>']`, spec.nodeName, spec.serviceAccountName, status.hostIP, status.podIP, status.podIPs."
                                "properties" = {
                                  "apiVersion" = {
                                    "description" = "Version of the schema the FieldPath is written in terms of, defaults to \"v1\"."
                                    "type" = "string"
                                  }
                                  "fieldPath" = {
                                    "description" = "Path of the field to select in the specified API version."
                                    "type" = "string"
                                  }
                                }
                                "required" = [
                                  "fieldPath",
                                ]
                                "type" = "object"
                              }
                              "resourceFieldRef" = {
                                "description" = "Selects a resource of the container: only resources limits and requests (limits.cpu, limits.memory, limits.ephemeral-storage, requests.cpu, requests.memory and requests.ephemeral-storage) are currently supported."
                                "properties" = {
                                  "containerName" = {
                                    "description" = "Container name: required for volumes, optional for env vars"
                                    "type" = "string"
                                  }
                                  "divisor" = {
                                    "anyOf" = [
                                      {
                                        "type" = "integer"
                                      },
                                      {
                                        "type" = "string"
                                      },
                                    ]
                                    "description" = "Specifies the output format of the exposed resources, defaults to \"1\""
                                    "pattern" = "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
                                    "x-kubernetes-int-or-string" = true
                                  }
                                  "resource" = {
                                    "description" = "Required: resource to select"
                                    "type" = "string"
                                  }
                                }
                                "required" = [
                                  "resource",
                                ]
                                "type" = "object"
                              }
                              "secretKeyRef" = {
                                "description" = "Selects a key of a secret in the pod's namespace"
                                "properties" = {
                                  "key" = {
                                    "description" = "The key of the secret to select from.  Must be a valid secret key."
                                    "type" = "string"
                                  }
                                  "name" = {
                                    "description" = "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
                                    "type" = "string"
                                  }
                                  "optional" = {
                                    "description" = "Specify whether the Secret or its key must be defined"
                                    "type" = "boolean"
                                  }
                                }
                                "required" = [
                                  "key",
                                ]
                                "type" = "object"
                              }
                            }
                            "type" = "object"
                          }
                        }
                        "required" = [
                          "name",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "envFrom" = {
                      "description" = "List of sources to populate environment variables on the OpenTelemetry Collector's Pods. These can then in certain cases be consumed in the config file for the Collector."
                      "items" = {
                        "description" = "EnvFromSource represents the source of a set of ConfigMaps"
                        "properties" = {
                          "configMapRef" = {
                            "description" = "The ConfigMap to select from"
                            "properties" = {
                              "name" = {
                                "description" = "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
                                "type" = "string"
                              }
                              "optional" = {
                                "description" = "Specify whether the ConfigMap must be defined"
                                "type" = "boolean"
                              }
                            }
                            "type" = "object"
                          }
                          "prefix" = {
                            "description" = "An optional identifier to prepend to each key in the ConfigMap. Must be a C_IDENTIFIER."
                            "type" = "string"
                          }
                          "secretRef" = {
                            "description" = "The Secret to select from"
                            "properties" = {
                              "name" = {
                                "description" = "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
                                "type" = "string"
                              }
                              "optional" = {
                                "description" = "Specify whether the Secret must be defined"
                                "type" = "boolean"
                              }
                            }
                            "type" = "object"
                          }
                        }
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "hostNetwork" = {
                      "description" = "HostNetwork indicates if the pod should run in the host networking namespace."
                      "type" = "boolean"
                    }
                    "image" = {
                      "description" = "Image indicates the container image to use for the OpenTelemetry Collector."
                      "type" = "string"
                    }
                    "imagePullPolicy" = {
                      "description" = "ImagePullPolicy indicates the pull policy to be used for retrieving the container image (Always, Never, IfNotPresent)"
                      "type" = "string"
                    }
                    "maxReplicas" = {
                      "description" = "MaxReplicas sets an upper bound to the autoscaling feature. If MaxReplicas is set autoscaling is enabled."
                      "format" = "int32"
                      "type" = "integer"
                    }
                    "mode" = {
                      "description" = "Mode represents how the collector should be deployed (deployment, daemonset, statefulset or sidecar)"
                      "enum" = [
                        "daemonset",
                        "deployment",
                        "sidecar",
                        "statefulset",
                      ]
                      "type" = "string"
                    }
                    "nodeSelector" = {
                      "additionalProperties" = {
                        "type" = "string"
                      }
                      "description" = "NodeSelector to schedule OpenTelemetry Collector pods. This is only relevant to daemonset, statefulset, and deployment mode"
                      "type" = "object"
                    }
                    "podAnnotations" = {
                      "additionalProperties" = {
                        "type" = "string"
                      }
                      "description" = "PodAnnotations is the set of annotations that will be attached to Collector and Target Allocator pods."
                      "type" = "object"
                    }
                    "podSecurityContext" = {
                      "description" = "PodSecurityContext holds pod-level security attributes and common container settings. Some fields are also present in container.securityContext.  Field values of container.securityContext take precedence over field values of PodSecurityContext."
                      "properties" = {
                        "fsGroup" = {
                          "description" = <<-EOT
                          A special supplemental group that applies to all containers in a pod. Some volume types allow the Kubelet to change the ownership of that volume to be owned by the pod: 
                           1. The owning GID will be the FSGroup 2. The setgid bit is set (new files created in the volume will be owned by FSGroup) 3. The permission bits are OR'd with rw-rw---- 
                           If unset, the Kubelet will not modify the ownership and permissions of any volume. Note that this field cannot be set when spec.os.name is windows.
                          EOT
                          "format" = "int64"
                          "type" = "integer"
                        }
                        "fsGroupChangePolicy" = {
                          "description" = "fsGroupChangePolicy defines behavior of changing ownership and permission of the volume before being exposed inside Pod. This field will only apply to volume types which support fsGroup based ownership(and permissions). It will have no effect on ephemeral volume types such as: secret, configmaps and emptydir. Valid values are \"OnRootMismatch\" and \"Always\". If not specified, \"Always\" is used. Note that this field cannot be set when spec.os.name is windows."
                          "type" = "string"
                        }
                        "runAsGroup" = {
                          "description" = "The GID to run the entrypoint of the container process. Uses runtime default if unset. May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence for that container. Note that this field cannot be set when spec.os.name is windows."
                          "format" = "int64"
                          "type" = "integer"
                        }
                        "runAsNonRoot" = {
                          "description" = "Indicates that the container must run as a non-root user. If true, the Kubelet will validate the image at runtime to ensure that it does not run as UID 0 (root) and fail to start the container if it does. If unset or false, no such validation will be performed. May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
                          "type" = "boolean"
                        }
                        "runAsUser" = {
                          "description" = "The UID to run the entrypoint of the container process. Defaults to user specified in image metadata if unspecified. May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence for that container. Note that this field cannot be set when spec.os.name is windows."
                          "format" = "int64"
                          "type" = "integer"
                        }
                        "seLinuxOptions" = {
                          "description" = "The SELinux context to be applied to all containers. If unspecified, the container runtime will allocate a random SELinux context for each container.  May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence for that container. Note that this field cannot be set when spec.os.name is windows."
                          "properties" = {
                            "level" = {
                              "description" = "Level is SELinux level label that applies to the container."
                              "type" = "string"
                            }
                            "role" = {
                              "description" = "Role is a SELinux role label that applies to the container."
                              "type" = "string"
                            }
                            "type" = {
                              "description" = "Type is a SELinux type label that applies to the container."
                              "type" = "string"
                            }
                            "user" = {
                              "description" = "User is a SELinux user label that applies to the container."
                              "type" = "string"
                            }
                          }
                          "type" = "object"
                        }
                        "seccompProfile" = {
                          "description" = "The seccomp options to use by the containers in this pod. Note that this field cannot be set when spec.os.name is windows."
                          "properties" = {
                            "localhostProfile" = {
                              "description" = "localhostProfile indicates a profile defined in a file on the node should be used. The profile must be preconfigured on the node to work. Must be a descending path, relative to the kubelet's configured seccomp profile location. Must only be set if type is \"Localhost\"."
                              "type" = "string"
                            }
                            "type" = {
                              "description" = <<-EOT
                              type indicates which kind of seccomp profile will be applied. Valid options are: 
                               Localhost - a profile defined in a file on the node should be used. RuntimeDefault - the container runtime default profile should be used. Unconfined - no profile should be applied.
                              EOT
                              "type" = "string"
                            }
                          }
                          "required" = [
                            "type",
                          ]
                          "type" = "object"
                        }
                        "supplementalGroups" = {
                          "description" = "A list of groups applied to the first process run in each container, in addition to the container's primary GID.  If unspecified, no groups will be added to any container. Note that this field cannot be set when spec.os.name is windows."
                          "items" = {
                            "format" = "int64"
                            "type" = "integer"
                          }
                          "type" = "array"
                        }
                        "sysctls" = {
                          "description" = "Sysctls hold a list of namespaced sysctls used for the pod. Pods with unsupported sysctls (by the container runtime) might fail to launch. Note that this field cannot be set when spec.os.name is windows."
                          "items" = {
                            "description" = "Sysctl defines a kernel parameter to be set"
                            "properties" = {
                              "name" = {
                                "description" = "Name of a property to set"
                                "type" = "string"
                              }
                              "value" = {
                                "description" = "Value of a property to set"
                                "type" = "string"
                              }
                            }
                            "required" = [
                              "name",
                              "value",
                            ]
                            "type" = "object"
                          }
                          "type" = "array"
                        }
                        "windowsOptions" = {
                          "description" = "The Windows specific settings applied to all containers. If unspecified, the options within a container's SecurityContext will be used. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence. Note that this field cannot be set when spec.os.name is linux."
                          "properties" = {
                            "gmsaCredentialSpec" = {
                              "description" = "GMSACredentialSpec is where the GMSA admission webhook (https://github.com/kubernetes-sigs/windows-gmsa) inlines the contents of the GMSA credential spec named by the GMSACredentialSpecName field."
                              "type" = "string"
                            }
                            "gmsaCredentialSpecName" = {
                              "description" = "GMSACredentialSpecName is the name of the GMSA credential spec to use."
                              "type" = "string"
                            }
                            "hostProcess" = {
                              "description" = "HostProcess determines if a container should be run as a 'Host Process' container. This field is alpha-level and will only be honored by components that enable the WindowsHostProcessContainers feature flag. Setting this field without the feature flag will result in errors when validating the Pod. All of a Pod's containers must have the same effective HostProcess value (it is not allowed to have a mix of HostProcess containers and non-HostProcess containers).  In addition, if HostProcess is true then HostNetwork must also be set to true."
                              "type" = "boolean"
                            }
                            "runAsUserName" = {
                              "description" = "The UserName in Windows to run the entrypoint of the container process. Defaults to the user specified in image metadata if unspecified. May also be set in PodSecurityContext. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
                              "type" = "string"
                            }
                          }
                          "type" = "object"
                        }
                      }
                      "type" = "object"
                    }
                    "ports" = {
                      "description" = "Ports allows a set of ports to be exposed by the underlying v1.Service. By default, the operator will attempt to infer the required ports by parsing the .Spec.Config property but this property can be used to open aditional ports that can't be inferred by the operator, like for custom receivers."
                      "items" = {
                        "description" = "ServicePort contains information on service's port."
                        "properties" = {
                          "appProtocol" = {
                            "description" = "The application protocol for this port. This field follows standard Kubernetes label syntax. Un-prefixed names are reserved for IANA standard service names (as per RFC-6335 and http://www.iana.org/assignments/service-names). Non-standard protocols should use prefixed names such as mycompany.com/my-custom-protocol."
                            "type" = "string"
                          }
                          "name" = {
                            "description" = "The name of this port within the service. This must be a DNS_LABEL. All ports within a ServiceSpec must have unique names. When considering the endpoints for a Service, this must match the 'name' field in the EndpointPort. Optional if only one ServicePort is defined on this service."
                            "type" = "string"
                          }
                          "nodePort" = {
                            "description" = "The port on each node on which this service is exposed when type is NodePort or LoadBalancer.  Usually assigned by the system. If a value is specified, in-range, and not in use it will be used, otherwise the operation will fail.  If not specified, a port will be allocated if this Service requires one.  If this field is specified when creating a Service which does not need it, creation will fail. This field will be wiped when updating a Service to no longer need it (e.g. changing type from NodePort to ClusterIP). More info: https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport"
                            "format" = "int32"
                            "type" = "integer"
                          }
                          "port" = {
                            "description" = "The port that will be exposed by this service."
                            "format" = "int32"
                            "type" = "integer"
                          }
                          "protocol" = {
                            "default" = "TCP"
                            "description" = "The IP protocol for this port. Supports \"TCP\", \"UDP\", and \"SCTP\". Default is TCP."
                            "type" = "string"
                          }
                          "targetPort" = {
                            "anyOf" = [
                              {
                                "type" = "integer"
                              },
                              {
                                "type" = "string"
                              },
                            ]
                            "description" = "Number or name of the port to access on the pods targeted by the service. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME. If this is a string, it will be looked up as a named port in the target Pod's container ports. If this is not specified, the value of the 'port' field is used (an identity map). This field is ignored for services with clusterIP=None, and should be omitted or set equal to the 'port' field. More info: https://kubernetes.io/docs/concepts/services-networking/service/#defining-a-service"
                            "x-kubernetes-int-or-string" = true
                          }
                        }
                        "required" = [
                          "port",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                      "x-kubernetes-list-type" = "atomic"
                    }
                    "replicas" = {
                      "description" = "Replicas is the number of pod instances for the underlying OpenTelemetry Collector"
                      "format" = "int32"
                      "type" = "integer"
                    }
                    "resources" = {
                      "description" = "Resources to set on the OpenTelemetry Collector pods."
                      "properties" = {
                        "limits" = {
                          "additionalProperties" = {
                            "anyOf" = [
                              {
                                "type" = "integer"
                              },
                              {
                                "type" = "string"
                              },
                            ]
                            "pattern" = "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
                            "x-kubernetes-int-or-string" = true
                          }
                          "description" = "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/"
                          "type" = "object"
                        }
                        "requests" = {
                          "additionalProperties" = {
                            "anyOf" = [
                              {
                                "type" = "integer"
                              },
                              {
                                "type" = "string"
                              },
                            ]
                            "pattern" = "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
                            "x-kubernetes-int-or-string" = true
                          }
                          "description" = "Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/"
                          "type" = "object"
                        }
                      }
                      "type" = "object"
                    }
                    "securityContext" = {
                      "description" = "SecurityContext will be set as the container security context."
                      "properties" = {
                        "allowPrivilegeEscalation" = {
                          "description" = "AllowPrivilegeEscalation controls whether a process can gain more privileges than its parent process. This bool directly controls if the no_new_privs flag will be set on the container process. AllowPrivilegeEscalation is true always when the container is: 1) run as Privileged 2) has CAP_SYS_ADMIN Note that this field cannot be set when spec.os.name is windows."
                          "type" = "boolean"
                        }
                        "capabilities" = {
                          "description" = "The capabilities to add/drop when running containers. Defaults to the default set of capabilities granted by the container runtime. Note that this field cannot be set when spec.os.name is windows."
                          "properties" = {
                            "add" = {
                              "description" = "Added capabilities"
                              "items" = {
                                "description" = "Capability represent POSIX capabilities type"
                                "type" = "string"
                              }
                              "type" = "array"
                            }
                            "drop" = {
                              "description" = "Removed capabilities"
                              "items" = {
                                "description" = "Capability represent POSIX capabilities type"
                                "type" = "string"
                              }
                              "type" = "array"
                            }
                          }
                          "type" = "object"
                        }
                        "privileged" = {
                          "description" = "Run container in privileged mode. Processes in privileged containers are essentially equivalent to root on the host. Defaults to false. Note that this field cannot be set when spec.os.name is windows."
                          "type" = "boolean"
                        }
                        "procMount" = {
                          "description" = "procMount denotes the type of proc mount to use for the containers. The default is DefaultProcMount which uses the container runtime defaults for readonly paths and masked paths. This requires the ProcMountType feature flag to be enabled. Note that this field cannot be set when spec.os.name is windows."
                          "type" = "string"
                        }
                        "readOnlyRootFilesystem" = {
                          "description" = "Whether this container has a read-only root filesystem. Default is false. Note that this field cannot be set when spec.os.name is windows."
                          "type" = "boolean"
                        }
                        "runAsGroup" = {
                          "description" = "The GID to run the entrypoint of the container process. Uses runtime default if unset. May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence. Note that this field cannot be set when spec.os.name is windows."
                          "format" = "int64"
                          "type" = "integer"
                        }
                        "runAsNonRoot" = {
                          "description" = "Indicates that the container must run as a non-root user. If true, the Kubelet will validate the image at runtime to ensure that it does not run as UID 0 (root) and fail to start the container if it does. If unset or false, no such validation will be performed. May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
                          "type" = "boolean"
                        }
                        "runAsUser" = {
                          "description" = "The UID to run the entrypoint of the container process. Defaults to user specified in image metadata if unspecified. May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence. Note that this field cannot be set when spec.os.name is windows."
                          "format" = "int64"
                          "type" = "integer"
                        }
                        "seLinuxOptions" = {
                          "description" = "The SELinux context to be applied to the container. If unspecified, the container runtime will allocate a random SELinux context for each container.  May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence. Note that this field cannot be set when spec.os.name is windows."
                          "properties" = {
                            "level" = {
                              "description" = "Level is SELinux level label that applies to the container."
                              "type" = "string"
                            }
                            "role" = {
                              "description" = "Role is a SELinux role label that applies to the container."
                              "type" = "string"
                            }
                            "type" = {
                              "description" = "Type is a SELinux type label that applies to the container."
                              "type" = "string"
                            }
                            "user" = {
                              "description" = "User is a SELinux user label that applies to the container."
                              "type" = "string"
                            }
                          }
                          "type" = "object"
                        }
                        "seccompProfile" = {
                          "description" = "The seccomp options to use by this container. If seccomp options are provided at both the pod & container level, the container options override the pod options. Note that this field cannot be set when spec.os.name is windows."
                          "properties" = {
                            "localhostProfile" = {
                              "description" = "localhostProfile indicates a profile defined in a file on the node should be used. The profile must be preconfigured on the node to work. Must be a descending path, relative to the kubelet's configured seccomp profile location. Must only be set if type is \"Localhost\"."
                              "type" = "string"
                            }
                            "type" = {
                              "description" = <<-EOT
                              type indicates which kind of seccomp profile will be applied. Valid options are: 
                               Localhost - a profile defined in a file on the node should be used. RuntimeDefault - the container runtime default profile should be used. Unconfined - no profile should be applied.
                              EOT
                              "type" = "string"
                            }
                          }
                          "required" = [
                            "type",
                          ]
                          "type" = "object"
                        }
                        "windowsOptions" = {
                          "description" = "The Windows specific settings applied to all containers. If unspecified, the options from the PodSecurityContext will be used. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence. Note that this field cannot be set when spec.os.name is linux."
                          "properties" = {
                            "gmsaCredentialSpec" = {
                              "description" = "GMSACredentialSpec is where the GMSA admission webhook (https://github.com/kubernetes-sigs/windows-gmsa) inlines the contents of the GMSA credential spec named by the GMSACredentialSpecName field."
                              "type" = "string"
                            }
                            "gmsaCredentialSpecName" = {
                              "description" = "GMSACredentialSpecName is the name of the GMSA credential spec to use."
                              "type" = "string"
                            }
                            "hostProcess" = {
                              "description" = "HostProcess determines if a container should be run as a 'Host Process' container. This field is alpha-level and will only be honored by components that enable the WindowsHostProcessContainers feature flag. Setting this field without the feature flag will result in errors when validating the Pod. All of a Pod's containers must have the same effective HostProcess value (it is not allowed to have a mix of HostProcess containers and non-HostProcess containers).  In addition, if HostProcess is true then HostNetwork must also be set to true."
                              "type" = "boolean"
                            }
                            "runAsUserName" = {
                              "description" = "The UserName in Windows to run the entrypoint of the container process. Defaults to the user specified in image metadata if unspecified. May also be set in PodSecurityContext. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
                              "type" = "string"
                            }
                          }
                          "type" = "object"
                        }
                      }
                      "type" = "object"
                    }
                    "serviceAccount" = {
                      "description" = "ServiceAccount indicates the name of an existing service account to use with this instance."
                      "type" = "string"
                    }
                    "targetAllocator" = {
                      "description" = "TargetAllocator indicates a value which determines whether to spawn a target allocation resource or not."
                      "properties" = {
                        "enabled" = {
                          "description" = "Enabled indicates whether to use a target allocation mechanism for Prometheus targets or not."
                          "type" = "boolean"
                        }
                        "image" = {
                          "description" = "Image indicates the container image to use for the OpenTelemetry TargetAllocator."
                          "type" = "string"
                        }
                        "prometheusCR" = {
                          "description" = "PrometheusCR defines the configuration for the retrieval of PrometheusOperator CRDs ( servicemonitor.monitoring.coreos.com/v1 and podmonitor.monitoring.coreos.com/v1 )  retrieval. All CR instances which the ServiceAccount has access to will be retrieved. This includes other namespaces."
                          "properties" = {
                            "enabled" = {
                              "description" = "Enabled indicates whether to use a PrometheusOperator custom resources as targets or not."
                              "type" = "boolean"
                            }
                          }
                          "type" = "object"
                        }
                      }
                      "type" = "object"
                    }
                    "tolerations" = {
                      "description" = "Toleration to schedule OpenTelemetry Collector pods. This is only relevant to daemonset, statefulset, and deployment mode"
                      "items" = {
                        "description" = "The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect> using the matching operator <operator>."
                        "properties" = {
                          "effect" = {
                            "description" = "Effect indicates the taint effect to match. Empty means match all taint effects. When specified, allowed values are NoSchedule, PreferNoSchedule and NoExecute."
                            "type" = "string"
                          }
                          "key" = {
                            "description" = "Key is the taint key that the toleration applies to. Empty means match all taint keys. If the key is empty, operator must be Exists; this combination means to match all values and all keys."
                            "type" = "string"
                          }
                          "operator" = {
                            "description" = "Operator represents a key's relationship to the value. Valid operators are Exists and Equal. Defaults to Equal. Exists is equivalent to wildcard for value, so that a pod can tolerate all taints of a particular category."
                            "type" = "string"
                          }
                          "tolerationSeconds" = {
                            "description" = "TolerationSeconds represents the period of time the toleration (which must be of effect NoExecute, otherwise this field is ignored) tolerates the taint. By default, it is not set, which means tolerate the taint forever (do not evict). Zero and negative values will be treated as 0 (evict immediately) by the system."
                            "format" = "int64"
                            "type" = "integer"
                          }
                          "value" = {
                            "description" = "Value is the taint value the toleration matches to. If the operator is Exists, the value should be empty, otherwise just a regular string."
                            "type" = "string"
                          }
                        }
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "upgradeStrategy" = {
                      "description" = "UpgradeStrategy represents how the operator will handle upgrades to the CR when a newer version of the operator is deployed"
                      "enum" = [
                        "automatic",
                        "none",
                      ]
                      "type" = "string"
                    }
                    "volumeClaimTemplates" = {
                      "description" = "VolumeClaimTemplates will provide stable storage using PersistentVolumes. Only available when the mode=statefulset."
                      "items" = {
                        "description" = "PersistentVolumeClaim is a user's request for and claim to a persistent volume"
                        "properties" = {
                          "apiVersion" = {
                            "description" = "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"
                            "type" = "string"
                          }
                          "kind" = {
                            "description" = "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"
                            "type" = "string"
                          }
                          "metadata" = {
                            "description" = "Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata"
                            "properties" = {
                              "annotations" = {
                                "additionalProperties" = {
                                  "type" = "string"
                                }
                                "type" = "object"
                              }
                              "finalizers" = {
                                "items" = {
                                  "type" = "string"
                                }
                                "type" = "array"
                              }
                              "labels" = {
                                "additionalProperties" = {
                                  "type" = "string"
                                }
                                "type" = "object"
                              }
                              "name" = {
                                "type" = "string"
                              }
                              "namespace" = {
                                "type" = "string"
                              }
                            }
                            "type" = "object"
                          }
                          "spec" = {
                            "description" = "Spec defines the desired characteristics of a volume requested by a pod author. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims"
                            "properties" = {
                              "accessModes" = {
                                "description" = "AccessModes contains the desired access modes the volume should have. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1"
                                "items" = {
                                  "type" = "string"
                                }
                                "type" = "array"
                              }
                              "dataSource" = {
                                "description" = "This field can be used to specify either: * An existing VolumeSnapshot object (snapshot.storage.k8s.io/VolumeSnapshot) * An existing PVC (PersistentVolumeClaim) If the provisioner or an external controller can support the specified data source, it will create a new volume based on the contents of the specified data source. If the AnyVolumeDataSource feature gate is enabled, this field will always have the same contents as the DataSourceRef field."
                                "properties" = {
                                  "apiGroup" = {
                                    "description" = "APIGroup is the group for the resource being referenced. If APIGroup is not specified, the specified Kind must be in the core API group. For any other third-party types, APIGroup is required."
                                    "type" = "string"
                                  }
                                  "kind" = {
                                    "description" = "Kind is the type of resource being referenced"
                                    "type" = "string"
                                  }
                                  "name" = {
                                    "description" = "Name is the name of resource being referenced"
                                    "type" = "string"
                                  }
                                }
                                "required" = [
                                  "kind",
                                  "name",
                                ]
                                "type" = "object"
                              }
                              "dataSourceRef" = {
                                "description" = "Specifies the object from which to populate the volume with data, if a non-empty volume is desired. This may be any local object from a non-empty API group (non core object) or a PersistentVolumeClaim object. When this field is specified, volume binding will only succeed if the type of the specified object matches some installed volume populator or dynamic provisioner. This field will replace the functionality of the DataSource field and as such if both fields are non-empty, they must have the same value. For backwards compatibility, both fields (DataSource and DataSourceRef) will be set to the same value automatically if one of them is empty and the other is non-empty. There are two important differences between DataSource and DataSourceRef: * While DataSource only allows two specific types of objects, DataSourceRef allows any non-core object, as well as PersistentVolumeClaim objects. * While DataSource ignores disallowed values (dropping them), DataSourceRef preserves all values, and generates an error if a disallowed value is specified. (Alpha) Using this field requires the AnyVolumeDataSource feature gate to be enabled."
                                "properties" = {
                                  "apiGroup" = {
                                    "description" = "APIGroup is the group for the resource being referenced. If APIGroup is not specified, the specified Kind must be in the core API group. For any other third-party types, APIGroup is required."
                                    "type" = "string"
                                  }
                                  "kind" = {
                                    "description" = "Kind is the type of resource being referenced"
                                    "type" = "string"
                                  }
                                  "name" = {
                                    "description" = "Name is the name of resource being referenced"
                                    "type" = "string"
                                  }
                                }
                                "required" = [
                                  "kind",
                                  "name",
                                ]
                                "type" = "object"
                              }
                              "resources" = {
                                "description" = "Resources represents the minimum resources the volume should have. If RecoverVolumeExpansionFailure feature is enabled users are allowed to specify resource requirements that are lower than previous value but must still be higher than capacity recorded in the status field of the claim. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#resources"
                                "properties" = {
                                  "limits" = {
                                    "additionalProperties" = {
                                      "anyOf" = [
                                        {
                                          "type" = "integer"
                                        },
                                        {
                                          "type" = "string"
                                        },
                                      ]
                                      "pattern" = "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
                                      "x-kubernetes-int-or-string" = true
                                    }
                                    "description" = "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/"
                                    "type" = "object"
                                  }
                                  "requests" = {
                                    "additionalProperties" = {
                                      "anyOf" = [
                                        {
                                          "type" = "integer"
                                        },
                                        {
                                          "type" = "string"
                                        },
                                      ]
                                      "pattern" = "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
                                      "x-kubernetes-int-or-string" = true
                                    }
                                    "description" = "Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/"
                                    "type" = "object"
                                  }
                                }
                                "type" = "object"
                              }
                              "selector" = {
                                "description" = "A label query over volumes to consider for binding."
                                "properties" = {
                                  "matchExpressions" = {
                                    "description" = "matchExpressions is a list of label selector requirements. The requirements are ANDed."
                                    "items" = {
                                      "description" = "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
                                      "properties" = {
                                        "key" = {
                                          "description" = "key is the label key that the selector applies to."
                                          "type" = "string"
                                        }
                                        "operator" = {
                                          "description" = "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
                                          "type" = "string"
                                        }
                                        "values" = {
                                          "description" = "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
                                          "items" = {
                                            "type" = "string"
                                          }
                                          "type" = "array"
                                        }
                                      }
                                      "required" = [
                                        "key",
                                        "operator",
                                      ]
                                      "type" = "object"
                                    }
                                    "type" = "array"
                                  }
                                  "matchLabels" = {
                                    "additionalProperties" = {
                                      "type" = "string"
                                    }
                                    "description" = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
                                    "type" = "object"
                                  }
                                }
                                "type" = "object"
                              }
                              "storageClassName" = {
                                "description" = "Name of the StorageClass required by the claim. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#class-1"
                                "type" = "string"
                              }
                              "volumeMode" = {
                                "description" = "volumeMode defines what type of volume is required by the claim. Value of Filesystem is implied when not included in claim spec."
                                "type" = "string"
                              }
                              "volumeName" = {
                                "description" = "VolumeName is the binding reference to the PersistentVolume backing this claim."
                                "type" = "string"
                              }
                            }
                            "type" = "object"
                          }
                          "status" = {
                            "description" = "Status represents the current information/status of a persistent volume claim. Read-only. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims"
                            "properties" = {
                              "accessModes" = {
                                "description" = "AccessModes contains the actual access modes the volume backing the PVC has. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1"
                                "items" = {
                                  "type" = "string"
                                }
                                "type" = "array"
                              }
                              "allocatedResources" = {
                                "additionalProperties" = {
                                  "anyOf" = [
                                    {
                                      "type" = "integer"
                                    },
                                    {
                                      "type" = "string"
                                    },
                                  ]
                                  "pattern" = "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
                                  "x-kubernetes-int-or-string" = true
                                }
                                "description" = "The storage resource within AllocatedResources tracks the capacity allocated to a PVC. It may be larger than the actual capacity when a volume expansion operation is requested. For storage quota, the larger value from allocatedResources and PVC.spec.resources is used. If allocatedResources is not set, PVC.spec.resources alone is used for quota calculation. If a volume expansion capacity request is lowered, allocatedResources is only lowered if there are no expansion operations in progress and if the actual volume capacity is equal or lower than the requested capacity. This is an alpha field and requires enabling RecoverVolumeExpansionFailure feature."
                                "type" = "object"
                              }
                              "capacity" = {
                                "additionalProperties" = {
                                  "anyOf" = [
                                    {
                                      "type" = "integer"
                                    },
                                    {
                                      "type" = "string"
                                    },
                                  ]
                                  "pattern" = "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
                                  "x-kubernetes-int-or-string" = true
                                }
                                "description" = "Represents the actual resources of the underlying volume."
                                "type" = "object"
                              }
                              "conditions" = {
                                "description" = "Current Condition of persistent volume claim. If underlying persistent volume is being resized then the Condition will be set to 'ResizeStarted'."
                                "items" = {
                                  "description" = "PersistentVolumeClaimCondition contails details about state of pvc"
                                  "properties" = {
                                    "lastProbeTime" = {
                                      "description" = "Last time we probed the condition."
                                      "format" = "date-time"
                                      "type" = "string"
                                    }
                                    "lastTransitionTime" = {
                                      "description" = "Last time the condition transitioned from one status to another."
                                      "format" = "date-time"
                                      "type" = "string"
                                    }
                                    "message" = {
                                      "description" = "Human-readable message indicating details about last transition."
                                      "type" = "string"
                                    }
                                    "reason" = {
                                      "description" = "Unique, this should be a short, machine understandable string that gives the reason for condition's last transition. If it reports \"ResizeStarted\" that means the underlying persistent volume is being resized."
                                      "type" = "string"
                                    }
                                    "status" = {
                                      "type" = "string"
                                    }
                                    "type" = {
                                      "description" = "PersistentVolumeClaimConditionType is a valid value of PersistentVolumeClaimCondition.Type"
                                      "type" = "string"
                                    }
                                  }
                                  "required" = [
                                    "status",
                                    "type",
                                  ]
                                  "type" = "object"
                                }
                                "type" = "array"
                              }
                              "phase" = {
                                "description" = "Phase represents the current phase of PersistentVolumeClaim."
                                "type" = "string"
                              }
                              "resizeStatus" = {
                                "description" = "ResizeStatus stores status of resize operation. ResizeStatus is not set by default but when expansion is complete resizeStatus is set to empty string by resize controller or kubelet. This is an alpha field and requires enabling RecoverVolumeExpansionFailure feature."
                                "type" = "string"
                              }
                            }
                            "type" = "object"
                          }
                        }
                        "type" = "object"
                      }
                      "type" = "array"
                      "x-kubernetes-list-type" = "atomic"
                    }
                    "volumeMounts" = {
                      "description" = "VolumeMounts represents the mount points to use in the underlying collector deployment(s)"
                      "items" = {
                        "description" = "VolumeMount describes a mounting of a Volume within a container."
                        "properties" = {
                          "mountPath" = {
                            "description" = "Path within the container at which the volume should be mounted.  Must not contain ':'."
                            "type" = "string"
                          }
                          "mountPropagation" = {
                            "description" = "mountPropagation determines how mounts are propagated from the host to container and the other way around. When not set, MountPropagationNone is used. This field is beta in 1.10."
                            "type" = "string"
                          }
                          "name" = {
                            "description" = "This must match the Name of a Volume."
                            "type" = "string"
                          }
                          "readOnly" = {
                            "description" = "Mounted read-only if true, read-write otherwise (false or unspecified). Defaults to false."
                            "type" = "boolean"
                          }
                          "subPath" = {
                            "description" = "Path within the volume from which the container's volume should be mounted. Defaults to \"\" (volume's root)."
                            "type" = "string"
                          }
                          "subPathExpr" = {
                            "description" = "Expanded path within the volume from which the container's volume should be mounted. Behaves similarly to SubPath but environment variable references $(VAR_NAME) are expanded using the container's environment. Defaults to \"\" (volume's root). SubPathExpr and SubPath are mutually exclusive."
                            "type" = "string"
                          }
                        }
                        "required" = [
                          "mountPath",
                          "name",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                      "x-kubernetes-list-type" = "atomic"
                    }
                    "volumes" = {
                      "description" = "Volumes represents which volumes to use in the underlying collector deployment(s)."
                      "items" = {
                        "description" = "Volume represents a named volume in a pod that may be accessed by any container in the pod."
                        "properties" = {
                          "awsElasticBlockStore" = {
                            "description" = "AWSElasticBlockStore represents an AWS Disk resource that is attached to a kubelet's host machine and then exposed to the pod. More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore"
                            "properties" = {
                              "fsType" = {
                                "description" = "Filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore TODO: how do we prevent errors in the filesystem from compromising the machine"
                                "type" = "string"
                              }
                              "partition" = {
                                "description" = "The partition in the volume that you want to mount. If omitted, the default is to mount by volume name. Examples: For volume /dev/sda1, you specify the partition as \"1\". Similarly, the volume partition for /dev/sda is \"0\" (or you can leave the property empty)."
                                "format" = "int32"
                                "type" = "integer"
                              }
                              "readOnly" = {
                                "description" = "Specify \"true\" to force and set the ReadOnly property in VolumeMounts to \"true\". If omitted, the default is \"false\". More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore"
                                "type" = "boolean"
                              }
                              "volumeID" = {
                                "description" = "Unique ID of the persistent disk resource in AWS (Amazon EBS volume). More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore"
                                "type" = "string"
                              }
                            }
                            "required" = [
                              "volumeID",
                            ]
                            "type" = "object"
                          }
                          "azureDisk" = {
                            "description" = "AzureDisk represents an Azure Data Disk mount on the host and bind mount to the pod."
                            "properties" = {
                              "cachingMode" = {
                                "description" = "Host Caching mode: None, Read Only, Read Write."
                                "type" = "string"
                              }
                              "diskName" = {
                                "description" = "The Name of the data disk in the blob storage"
                                "type" = "string"
                              }
                              "diskURI" = {
                                "description" = "The URI the data disk in the blob storage"
                                "type" = "string"
                              }
                              "fsType" = {
                                "description" = "Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified."
                                "type" = "string"
                              }
                              "kind" = {
                                "description" = "Expected values Shared: multiple blob disks per storage account  Dedicated: single blob disk per storage account  Managed: azure managed data disk (only in managed availability set). defaults to shared"
                                "type" = "string"
                              }
                              "readOnly" = {
                                "description" = "Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts."
                                "type" = "boolean"
                              }
                            }
                            "required" = [
                              "diskName",
                              "diskURI",
                            ]
                            "type" = "object"
                          }
                          "azureFile" = {
                            "description" = "AzureFile represents an Azure File Service mount on the host and bind mount to the pod."
                            "properties" = {
                              "readOnly" = {
                                "description" = "Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts."
                                "type" = "boolean"
                              }
                              "secretName" = {
                                "description" = "the name of secret that contains Azure Storage Account Name and Key"
                                "type" = "string"
                              }
                              "shareName" = {
                                "description" = "Share Name"
                                "type" = "string"
                              }
                            }
                            "required" = [
                              "secretName",
                              "shareName",
                            ]
                            "type" = "object"
                          }
                          "cephfs" = {
                            "description" = "CephFS represents a Ceph FS mount on the host that shares a pod's lifetime"
                            "properties" = {
                              "monitors" = {
                                "description" = "Required: Monitors is a collection of Ceph monitors More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it"
                                "items" = {
                                  "type" = "string"
                                }
                                "type" = "array"
                              }
                              "path" = {
                                "description" = "Optional: Used as the mounted root, rather than the full Ceph tree, default is /"
                                "type" = "string"
                              }
                              "readOnly" = {
                                "description" = "Optional: Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts. More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it"
                                "type" = "boolean"
                              }
                              "secretFile" = {
                                "description" = "Optional: SecretFile is the path to key ring for User, default is /etc/ceph/user.secret More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it"
                                "type" = "string"
                              }
                              "secretRef" = {
                                "description" = "Optional: SecretRef is reference to the authentication secret for User, default is empty. More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it"
                                "properties" = {
                                  "name" = {
                                    "description" = "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
                                    "type" = "string"
                                  }
                                }
                                "type" = "object"
                              }
                              "user" = {
                                "description" = "Optional: User is the rados user name, default is admin More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it"
                                "type" = "string"
                              }
                            }
                            "required" = [
                              "monitors",
                            ]
                            "type" = "object"
                          }
                          "cinder" = {
                            "description" = "Cinder represents a cinder volume attached and mounted on kubelets host machine. More info: https://examples.k8s.io/mysql-cinder-pd/README.md"
                            "properties" = {
                              "fsType" = {
                                "description" = "Filesystem type to mount. Must be a filesystem type supported by the host operating system. Examples: \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified. More info: https://examples.k8s.io/mysql-cinder-pd/README.md"
                                "type" = "string"
                              }
                              "readOnly" = {
                                "description" = "Optional: Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts. More info: https://examples.k8s.io/mysql-cinder-pd/README.md"
                                "type" = "boolean"
                              }
                              "secretRef" = {
                                "description" = "Optional: points to a secret object containing parameters used to connect to OpenStack."
                                "properties" = {
                                  "name" = {
                                    "description" = "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
                                    "type" = "string"
                                  }
                                }
                                "type" = "object"
                              }
                              "volumeID" = {
                                "description" = "volume id used to identify the volume in cinder. More info: https://examples.k8s.io/mysql-cinder-pd/README.md"
                                "type" = "string"
                              }
                            }
                            "required" = [
                              "volumeID",
                            ]
                            "type" = "object"
                          }
                          "configMap" = {
                            "description" = "ConfigMap represents a configMap that should populate this volume"
                            "properties" = {
                              "defaultMode" = {
                                "description" = "Optional: mode bits used to set permissions on created files by default. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. Defaults to 0644. Directories within the path are not affected by this setting. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
                                "format" = "int32"
                                "type" = "integer"
                              }
                              "items" = {
                                "description" = "If unspecified, each key-value pair in the Data field of the referenced ConfigMap will be projected into the volume as a file whose name is the key and content is the value. If specified, the listed keys will be projected into the specified paths, and unlisted keys will not be present. If a key is specified which is not present in the ConfigMap, the volume setup will error unless it is marked optional. Paths must be relative and may not contain the '..' path or start with '..'."
                                "items" = {
                                  "description" = "Maps a string key to a path within a volume."
                                  "properties" = {
                                    "key" = {
                                      "description" = "The key to project."
                                      "type" = "string"
                                    }
                                    "mode" = {
                                      "description" = "Optional: mode bits used to set permissions on this file. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
                                      "format" = "int32"
                                      "type" = "integer"
                                    }
                                    "path" = {
                                      "description" = "The relative path of the file to map the key to. May not be an absolute path. May not contain the path element '..'. May not start with the string '..'."
                                      "type" = "string"
                                    }
                                  }
                                  "required" = [
                                    "key",
                                    "path",
                                  ]
                                  "type" = "object"
                                }
                                "type" = "array"
                              }
                              "name" = {
                                "description" = "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
                                "type" = "string"
                              }
                              "optional" = {
                                "description" = "Specify whether the ConfigMap or its keys must be defined"
                                "type" = "boolean"
                              }
                            }
                            "type" = "object"
                          }
                          "csi" = {
                            "description" = "CSI (Container Storage Interface) represents ephemeral storage that is handled by certain external CSI drivers (Beta feature)."
                            "properties" = {
                              "driver" = {
                                "description" = "Driver is the name of the CSI driver that handles this volume. Consult with your admin for the correct name as registered in the cluster."
                                "type" = "string"
                              }
                              "fsType" = {
                                "description" = "Filesystem type to mount. Ex. \"ext4\", \"xfs\", \"ntfs\". If not provided, the empty value is passed to the associated CSI driver which will determine the default filesystem to apply."
                                "type" = "string"
                              }
                              "nodePublishSecretRef" = {
                                "description" = "NodePublishSecretRef is a reference to the secret object containing sensitive information to pass to the CSI driver to complete the CSI NodePublishVolume and NodeUnpublishVolume calls. This field is optional, and  may be empty if no secret is required. If the secret object contains more than one secret, all secret references are passed."
                                "properties" = {
                                  "name" = {
                                    "description" = "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
                                    "type" = "string"
                                  }
                                }
                                "type" = "object"
                              }
                              "readOnly" = {
                                "description" = "Specifies a read-only configuration for the volume. Defaults to false (read/write)."
                                "type" = "boolean"
                              }
                              "volumeAttributes" = {
                                "additionalProperties" = {
                                  "type" = "string"
                                }
                                "description" = "VolumeAttributes stores driver-specific properties that are passed to the CSI driver. Consult your driver's documentation for supported values."
                                "type" = "object"
                              }
                            }
                            "required" = [
                              "driver",
                            ]
                            "type" = "object"
                          }
                          "downwardAPI" = {
                            "description" = "DownwardAPI represents downward API about the pod that should populate this volume"
                            "properties" = {
                              "defaultMode" = {
                                "description" = "Optional: mode bits to use on created files by default. Must be a Optional: mode bits used to set permissions on created files by default. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. Defaults to 0644. Directories within the path are not affected by this setting. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
                                "format" = "int32"
                                "type" = "integer"
                              }
                              "items" = {
                                "description" = "Items is a list of downward API volume file"
                                "items" = {
                                  "description" = "DownwardAPIVolumeFile represents information to create the file containing the pod field"
                                  "properties" = {
                                    "fieldRef" = {
                                      "description" = "Required: Selects a field of the pod: only annotations, labels, name and namespace are supported."
                                      "properties" = {
                                        "apiVersion" = {
                                          "description" = "Version of the schema the FieldPath is written in terms of, defaults to \"v1\"."
                                          "type" = "string"
                                        }
                                        "fieldPath" = {
                                          "description" = "Path of the field to select in the specified API version."
                                          "type" = "string"
                                        }
                                      }
                                      "required" = [
                                        "fieldPath",
                                      ]
                                      "type" = "object"
                                    }
                                    "mode" = {
                                      "description" = "Optional: mode bits used to set permissions on this file, must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
                                      "format" = "int32"
                                      "type" = "integer"
                                    }
                                    "path" = {
                                      "description" = "Required: Path is  the relative path name of the file to be created. Must not be absolute or contain the '..' path. Must be utf-8 encoded. The first item of the relative path must not start with '..'"
                                      "type" = "string"
                                    }
                                    "resourceFieldRef" = {
                                      "description" = "Selects a resource of the container: only resources limits and requests (limits.cpu, limits.memory, requests.cpu and requests.memory) are currently supported."
                                      "properties" = {
                                        "containerName" = {
                                          "description" = "Container name: required for volumes, optional for env vars"
                                          "type" = "string"
                                        }
                                        "divisor" = {
                                          "anyOf" = [
                                            {
                                              "type" = "integer"
                                            },
                                            {
                                              "type" = "string"
                                            },
                                          ]
                                          "description" = "Specifies the output format of the exposed resources, defaults to \"1\""
                                          "pattern" = "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
                                          "x-kubernetes-int-or-string" = true
                                        }
                                        "resource" = {
                                          "description" = "Required: resource to select"
                                          "type" = "string"
                                        }
                                      }
                                      "required" = [
                                        "resource",
                                      ]
                                      "type" = "object"
                                    }
                                  }
                                  "required" = [
                                    "path",
                                  ]
                                  "type" = "object"
                                }
                                "type" = "array"
                              }
                            }
                            "type" = "object"
                          }
                          "emptyDir" = {
                            "description" = "EmptyDir represents a temporary directory that shares a pod's lifetime. More info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir"
                            "properties" = {
                              "medium" = {
                                "description" = "What type of storage medium should back this directory. The default is \"\" which means to use the node's default medium. Must be an empty string (default) or Memory. More info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir"
                                "type" = "string"
                              }
                              "sizeLimit" = {
                                "anyOf" = [
                                  {
                                    "type" = "integer"
                                  },
                                  {
                                    "type" = "string"
                                  },
                                ]
                                "description" = "Total amount of local storage required for this EmptyDir volume. The size limit is also applicable for memory medium. The maximum usage on memory medium EmptyDir would be the minimum value between the SizeLimit specified here and the sum of memory limits of all containers in a pod. The default is nil which means that the limit is undefined. More info: http://kubernetes.io/docs/user-guide/volumes#emptydir"
                                "pattern" = "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
                                "x-kubernetes-int-or-string" = true
                              }
                            }
                            "type" = "object"
                          }
                          "ephemeral" = {
                            "description" = <<-EOT
                            Ephemeral represents a volume that is handled by a cluster storage driver. The volume's lifecycle is tied to the pod that defines it - it will be created before the pod starts, and deleted when the pod is removed. 
                             Use this if: a) the volume is only needed while the pod runs, b) features of normal volumes like restoring from snapshot or capacity tracking are needed, c) the storage driver is specified through a storage class, and d) the storage driver supports dynamic volume provisioning through a PersistentVolumeClaim (see EphemeralVolumeSource for more information on the connection between this volume type and PersistentVolumeClaim). 
                             Use PersistentVolumeClaim or one of the vendor-specific APIs for volumes that persist for longer than the lifecycle of an individual pod. 
                             Use CSI for light-weight local ephemeral volumes if the CSI driver is meant to be used that way - see the documentation of the driver for more information. 
                             A pod can use both types of ephemeral volumes and persistent volumes at the same time.
                            EOT
                            "properties" = {
                              "volumeClaimTemplate" = {
                                "description" = <<-EOT
                                Will be used to create a stand-alone PVC to provision the volume. The pod in which this EphemeralVolumeSource is embedded will be the owner of the PVC, i.e. the PVC will be deleted together with the pod.  The name of the PVC will be `<pod name>-<volume name>` where `<volume name>` is the name from the `PodSpec.Volumes` array entry. Pod validation will reject the pod if the concatenated name is not valid for a PVC (for example, too long). 
                                 An existing PVC with that name that is not owned by the pod will *not* be used for the pod to avoid using an unrelated volume by mistake. Starting the pod is then blocked until the unrelated PVC is removed. If such a pre-created PVC is meant to be used by the pod, the PVC has to updated with an owner reference to the pod once the pod exists. Normally this should not be necessary, but it may be useful when manually reconstructing a broken cluster. 
                                 This field is read-only and no changes will be made by Kubernetes to the PVC after it has been created. 
                                 Required, must not be nil.
                                EOT
                                "properties" = {
                                  "metadata" = {
                                    "description" = "May contain labels and annotations that will be copied into the PVC when creating it. No other fields are allowed and will be rejected during validation."
                                    "properties" = {
                                      "annotations" = {
                                        "additionalProperties" = {
                                          "type" = "string"
                                        }
                                        "type" = "object"
                                      }
                                      "finalizers" = {
                                        "items" = {
                                          "type" = "string"
                                        }
                                        "type" = "array"
                                      }
                                      "labels" = {
                                        "additionalProperties" = {
                                          "type" = "string"
                                        }
                                        "type" = "object"
                                      }
                                      "name" = {
                                        "type" = "string"
                                      }
                                      "namespace" = {
                                        "type" = "string"
                                      }
                                    }
                                    "type" = "object"
                                  }
                                  "spec" = {
                                    "description" = "The specification for the PersistentVolumeClaim. The entire content is copied unchanged into the PVC that gets created from this template. The same fields as in a PersistentVolumeClaim are also valid here."
                                    "properties" = {
                                      "accessModes" = {
                                        "description" = "AccessModes contains the desired access modes the volume should have. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1"
                                        "items" = {
                                          "type" = "string"
                                        }
                                        "type" = "array"
                                      }
                                      "dataSource" = {
                                        "description" = "This field can be used to specify either: * An existing VolumeSnapshot object (snapshot.storage.k8s.io/VolumeSnapshot) * An existing PVC (PersistentVolumeClaim) If the provisioner or an external controller can support the specified data source, it will create a new volume based on the contents of the specified data source. If the AnyVolumeDataSource feature gate is enabled, this field will always have the same contents as the DataSourceRef field."
                                        "properties" = {
                                          "apiGroup" = {
                                            "description" = "APIGroup is the group for the resource being referenced. If APIGroup is not specified, the specified Kind must be in the core API group. For any other third-party types, APIGroup is required."
                                            "type" = "string"
                                          }
                                          "kind" = {
                                            "description" = "Kind is the type of resource being referenced"
                                            "type" = "string"
                                          }
                                          "name" = {
                                            "description" = "Name is the name of resource being referenced"
                                            "type" = "string"
                                          }
                                        }
                                        "required" = [
                                          "kind",
                                          "name",
                                        ]
                                        "type" = "object"
                                      }
                                      "dataSourceRef" = {
                                        "description" = "Specifies the object from which to populate the volume with data, if a non-empty volume is desired. This may be any local object from a non-empty API group (non core object) or a PersistentVolumeClaim object. When this field is specified, volume binding will only succeed if the type of the specified object matches some installed volume populator or dynamic provisioner. This field will replace the functionality of the DataSource field and as such if both fields are non-empty, they must have the same value. For backwards compatibility, both fields (DataSource and DataSourceRef) will be set to the same value automatically if one of them is empty and the other is non-empty. There are two important differences between DataSource and DataSourceRef: * While DataSource only allows two specific types of objects, DataSourceRef allows any non-core object, as well as PersistentVolumeClaim objects. * While DataSource ignores disallowed values (dropping them), DataSourceRef preserves all values, and generates an error if a disallowed value is specified. (Alpha) Using this field requires the AnyVolumeDataSource feature gate to be enabled."
                                        "properties" = {
                                          "apiGroup" = {
                                            "description" = "APIGroup is the group for the resource being referenced. If APIGroup is not specified, the specified Kind must be in the core API group. For any other third-party types, APIGroup is required."
                                            "type" = "string"
                                          }
                                          "kind" = {
                                            "description" = "Kind is the type of resource being referenced"
                                            "type" = "string"
                                          }
                                          "name" = {
                                            "description" = "Name is the name of resource being referenced"
                                            "type" = "string"
                                          }
                                        }
                                        "required" = [
                                          "kind",
                                          "name",
                                        ]
                                        "type" = "object"
                                      }
                                      "resources" = {
                                        "description" = "Resources represents the minimum resources the volume should have. If RecoverVolumeExpansionFailure feature is enabled users are allowed to specify resource requirements that are lower than previous value but must still be higher than capacity recorded in the status field of the claim. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#resources"
                                        "properties" = {
                                          "limits" = {
                                            "additionalProperties" = {
                                              "anyOf" = [
                                                {
                                                  "type" = "integer"
                                                },
                                                {
                                                  "type" = "string"
                                                },
                                              ]
                                              "pattern" = "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
                                              "x-kubernetes-int-or-string" = true
                                            }
                                            "description" = "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/"
                                            "type" = "object"
                                          }
                                          "requests" = {
                                            "additionalProperties" = {
                                              "anyOf" = [
                                                {
                                                  "type" = "integer"
                                                },
                                                {
                                                  "type" = "string"
                                                },
                                              ]
                                              "pattern" = "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
                                              "x-kubernetes-int-or-string" = true
                                            }
                                            "description" = "Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/"
                                            "type" = "object"
                                          }
                                        }
                                        "type" = "object"
                                      }
                                      "selector" = {
                                        "description" = "A label query over volumes to consider for binding."
                                        "properties" = {
                                          "matchExpressions" = {
                                            "description" = "matchExpressions is a list of label selector requirements. The requirements are ANDed."
                                            "items" = {
                                              "description" = "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
                                              "properties" = {
                                                "key" = {
                                                  "description" = "key is the label key that the selector applies to."
                                                  "type" = "string"
                                                }
                                                "operator" = {
                                                  "description" = "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
                                                  "type" = "string"
                                                }
                                                "values" = {
                                                  "description" = "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
                                                  "items" = {
                                                    "type" = "string"
                                                  }
                                                  "type" = "array"
                                                }
                                              }
                                              "required" = [
                                                "key",
                                                "operator",
                                              ]
                                              "type" = "object"
                                            }
                                            "type" = "array"
                                          }
                                          "matchLabels" = {
                                            "additionalProperties" = {
                                              "type" = "string"
                                            }
                                            "description" = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
                                            "type" = "object"
                                          }
                                        }
                                        "type" = "object"
                                      }
                                      "storageClassName" = {
                                        "description" = "Name of the StorageClass required by the claim. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#class-1"
                                        "type" = "string"
                                      }
                                      "volumeMode" = {
                                        "description" = "volumeMode defines what type of volume is required by the claim. Value of Filesystem is implied when not included in claim spec."
                                        "type" = "string"
                                      }
                                      "volumeName" = {
                                        "description" = "VolumeName is the binding reference to the PersistentVolume backing this claim."
                                        "type" = "string"
                                      }
                                    }
                                    "type" = "object"
                                  }
                                }
                                "required" = [
                                  "spec",
                                ]
                                "type" = "object"
                              }
                            }
                            "type" = "object"
                          }
                          "fc" = {
                            "description" = "FC represents a Fibre Channel resource that is attached to a kubelet's host machine and then exposed to the pod."
                            "properties" = {
                              "fsType" = {
                                "description" = "Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified. TODO: how do we prevent errors in the filesystem from compromising the machine"
                                "type" = "string"
                              }
                              "lun" = {
                                "description" = "Optional: FC target lun number"
                                "format" = "int32"
                                "type" = "integer"
                              }
                              "readOnly" = {
                                "description" = "Optional: Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts."
                                "type" = "boolean"
                              }
                              "targetWWNs" = {
                                "description" = "Optional: FC target worldwide names (WWNs)"
                                "items" = {
                                  "type" = "string"
                                }
                                "type" = "array"
                              }
                              "wwids" = {
                                "description" = "Optional: FC volume world wide identifiers (wwids) Either wwids or combination of targetWWNs and lun must be set, but not both simultaneously."
                                "items" = {
                                  "type" = "string"
                                }
                                "type" = "array"
                              }
                            }
                            "type" = "object"
                          }
                          "flexVolume" = {
                            "description" = "FlexVolume represents a generic volume resource that is provisioned/attached using an exec based plugin."
                            "properties" = {
                              "driver" = {
                                "description" = "Driver is the name of the driver to use for this volume."
                                "type" = "string"
                              }
                              "fsType" = {
                                "description" = "Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\", \"ntfs\". The default filesystem depends on FlexVolume script."
                                "type" = "string"
                              }
                              "options" = {
                                "additionalProperties" = {
                                  "type" = "string"
                                }
                                "description" = "Optional: Extra command options if any."
                                "type" = "object"
                              }
                              "readOnly" = {
                                "description" = "Optional: Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts."
                                "type" = "boolean"
                              }
                              "secretRef" = {
                                "description" = "Optional: SecretRef is reference to the secret object containing sensitive information to pass to the plugin scripts. This may be empty if no secret object is specified. If the secret object contains more than one secret, all secrets are passed to the plugin scripts."
                                "properties" = {
                                  "name" = {
                                    "description" = "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
                                    "type" = "string"
                                  }
                                }
                                "type" = "object"
                              }
                            }
                            "required" = [
                              "driver",
                            ]
                            "type" = "object"
                          }
                          "flocker" = {
                            "description" = "Flocker represents a Flocker volume attached to a kubelet's host machine. This depends on the Flocker control service being running"
                            "properties" = {
                              "datasetName" = {
                                "description" = "Name of the dataset stored as metadata -> name on the dataset for Flocker should be considered as deprecated"
                                "type" = "string"
                              }
                              "datasetUUID" = {
                                "description" = "UUID of the dataset. This is unique identifier of a Flocker dataset"
                                "type" = "string"
                              }
                            }
                            "type" = "object"
                          }
                          "gcePersistentDisk" = {
                            "description" = "GCEPersistentDisk represents a GCE Disk resource that is attached to a kubelet's host machine and then exposed to the pod. More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk"
                            "properties" = {
                              "fsType" = {
                                "description" = "Filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk TODO: how do we prevent errors in the filesystem from compromising the machine"
                                "type" = "string"
                              }
                              "partition" = {
                                "description" = "The partition in the volume that you want to mount. If omitted, the default is to mount by volume name. Examples: For volume /dev/sda1, you specify the partition as \"1\". Similarly, the volume partition for /dev/sda is \"0\" (or you can leave the property empty). More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk"
                                "format" = "int32"
                                "type" = "integer"
                              }
                              "pdName" = {
                                "description" = "Unique name of the PD resource in GCE. Used to identify the disk in GCE. More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk"
                                "type" = "string"
                              }
                              "readOnly" = {
                                "description" = "ReadOnly here will force the ReadOnly setting in VolumeMounts. Defaults to false. More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk"
                                "type" = "boolean"
                              }
                            }
                            "required" = [
                              "pdName",
                            ]
                            "type" = "object"
                          }
                          "gitRepo" = {
                            "description" = "GitRepo represents a git repository at a particular revision. DEPRECATED: GitRepo is deprecated. To provision a container with a git repo, mount an EmptyDir into an InitContainer that clones the repo using git, then mount the EmptyDir into the Pod's container."
                            "properties" = {
                              "directory" = {
                                "description" = "Target directory name. Must not contain or start with '..'.  If '.' is supplied, the volume directory will be the git repository.  Otherwise, if specified, the volume will contain the git repository in the subdirectory with the given name."
                                "type" = "string"
                              }
                              "repository" = {
                                "description" = "Repository URL"
                                "type" = "string"
                              }
                              "revision" = {
                                "description" = "Commit hash for the specified revision."
                                "type" = "string"
                              }
                            }
                            "required" = [
                              "repository",
                            ]
                            "type" = "object"
                          }
                          "glusterfs" = {
                            "description" = "Glusterfs represents a Glusterfs mount on the host that shares a pod's lifetime. More info: https://examples.k8s.io/volumes/glusterfs/README.md"
                            "properties" = {
                              "endpoints" = {
                                "description" = "EndpointsName is the endpoint name that details Glusterfs topology. More info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod"
                                "type" = "string"
                              }
                              "path" = {
                                "description" = "Path is the Glusterfs volume path. More info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod"
                                "type" = "string"
                              }
                              "readOnly" = {
                                "description" = "ReadOnly here will force the Glusterfs volume to be mounted with read-only permissions. Defaults to false. More info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod"
                                "type" = "boolean"
                              }
                            }
                            "required" = [
                              "endpoints",
                              "path",
                            ]
                            "type" = "object"
                          }
                          "hostPath" = {
                            "description" = "HostPath represents a pre-existing file or directory on the host machine that is directly exposed to the container. This is generally used for system agents or other privileged things that are allowed to see the host machine. Most containers will NOT need this. More info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath --- TODO(jonesdl) We need to restrict who can use host directory mounts and who can/can not mount host directories as read/write."
                            "properties" = {
                              "path" = {
                                "description" = "Path of the directory on the host. If the path is a symlink, it will follow the link to the real path. More info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath"
                                "type" = "string"
                              }
                              "type" = {
                                "description" = "Type for HostPath Volume Defaults to \"\" More info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath"
                                "type" = "string"
                              }
                            }
                            "required" = [
                              "path",
                            ]
                            "type" = "object"
                          }
                          "iscsi" = {
                            "description" = "ISCSI represents an ISCSI Disk resource that is attached to a kubelet's host machine and then exposed to the pod. More info: https://examples.k8s.io/volumes/iscsi/README.md"
                            "properties" = {
                              "chapAuthDiscovery" = {
                                "description" = "whether support iSCSI Discovery CHAP authentication"
                                "type" = "boolean"
                              }
                              "chapAuthSession" = {
                                "description" = "whether support iSCSI Session CHAP authentication"
                                "type" = "boolean"
                              }
                              "fsType" = {
                                "description" = "Filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#iscsi TODO: how do we prevent errors in the filesystem from compromising the machine"
                                "type" = "string"
                              }
                              "initiatorName" = {
                                "description" = "Custom iSCSI Initiator Name. If initiatorName is specified with iscsiInterface simultaneously, new iSCSI interface <target portal>:<volume name> will be created for the connection."
                                "type" = "string"
                              }
                              "iqn" = {
                                "description" = "Target iSCSI Qualified Name."
                                "type" = "string"
                              }
                              "iscsiInterface" = {
                                "description" = "iSCSI Interface Name that uses an iSCSI transport. Defaults to 'default' (tcp)."
                                "type" = "string"
                              }
                              "lun" = {
                                "description" = "iSCSI Target Lun number."
                                "format" = "int32"
                                "type" = "integer"
                              }
                              "portals" = {
                                "description" = "iSCSI Target Portal List. The portal is either an IP or ip_addr:port if the port is other than default (typically TCP ports 860 and 3260)."
                                "items" = {
                                  "type" = "string"
                                }
                                "type" = "array"
                              }
                              "readOnly" = {
                                "description" = "ReadOnly here will force the ReadOnly setting in VolumeMounts. Defaults to false."
                                "type" = "boolean"
                              }
                              "secretRef" = {
                                "description" = "CHAP Secret for iSCSI target and initiator authentication"
                                "properties" = {
                                  "name" = {
                                    "description" = "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
                                    "type" = "string"
                                  }
                                }
                                "type" = "object"
                              }
                              "targetPortal" = {
                                "description" = "iSCSI Target Portal. The Portal is either an IP or ip_addr:port if the port is other than default (typically TCP ports 860 and 3260)."
                                "type" = "string"
                              }
                            }
                            "required" = [
                              "iqn",
                              "lun",
                              "targetPortal",
                            ]
                            "type" = "object"
                          }
                          "name" = {
                            "description" = "Volume's name. Must be a DNS_LABEL and unique within the pod. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
                            "type" = "string"
                          }
                          "nfs" = {
                            "description" = "NFS represents an NFS mount on the host that shares a pod's lifetime More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs"
                            "properties" = {
                              "path" = {
                                "description" = "Path that is exported by the NFS server. More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs"
                                "type" = "string"
                              }
                              "readOnly" = {
                                "description" = "ReadOnly here will force the NFS export to be mounted with read-only permissions. Defaults to false. More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs"
                                "type" = "boolean"
                              }
                              "server" = {
                                "description" = "Server is the hostname or IP address of the NFS server. More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs"
                                "type" = "string"
                              }
                            }
                            "required" = [
                              "path",
                              "server",
                            ]
                            "type" = "object"
                          }
                          "persistentVolumeClaim" = {
                            "description" = "PersistentVolumeClaimVolumeSource represents a reference to a PersistentVolumeClaim in the same namespace. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims"
                            "properties" = {
                              "claimName" = {
                                "description" = "ClaimName is the name of a PersistentVolumeClaim in the same namespace as the pod using this volume. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims"
                                "type" = "string"
                              }
                              "readOnly" = {
                                "description" = "Will force the ReadOnly setting in VolumeMounts. Default false."
                                "type" = "boolean"
                              }
                            }
                            "required" = [
                              "claimName",
                            ]
                            "type" = "object"
                          }
                          "photonPersistentDisk" = {
                            "description" = "PhotonPersistentDisk represents a PhotonController persistent disk attached and mounted on kubelets host machine"
                            "properties" = {
                              "fsType" = {
                                "description" = "Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified."
                                "type" = "string"
                              }
                              "pdID" = {
                                "description" = "ID that identifies Photon Controller persistent disk"
                                "type" = "string"
                              }
                            }
                            "required" = [
                              "pdID",
                            ]
                            "type" = "object"
                          }
                          "portworxVolume" = {
                            "description" = "PortworxVolume represents a portworx volume attached and mounted on kubelets host machine"
                            "properties" = {
                              "fsType" = {
                                "description" = "FSType represents the filesystem type to mount Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\". Implicitly inferred to be \"ext4\" if unspecified."
                                "type" = "string"
                              }
                              "readOnly" = {
                                "description" = "Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts."
                                "type" = "boolean"
                              }
                              "volumeID" = {
                                "description" = "VolumeID uniquely identifies a Portworx volume"
                                "type" = "string"
                              }
                            }
                            "required" = [
                              "volumeID",
                            ]
                            "type" = "object"
                          }
                          "projected" = {
                            "description" = "Items for all in one resources secrets, configmaps, and downward API"
                            "properties" = {
                              "defaultMode" = {
                                "description" = "Mode bits used to set permissions on created files by default. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. Directories within the path are not affected by this setting. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
                                "format" = "int32"
                                "type" = "integer"
                              }
                              "sources" = {
                                "description" = "list of volume projections"
                                "items" = {
                                  "description" = "Projection that may be projected along with other supported volume types"
                                  "properties" = {
                                    "configMap" = {
                                      "description" = "information about the configMap data to project"
                                      "properties" = {
                                        "items" = {
                                          "description" = "If unspecified, each key-value pair in the Data field of the referenced ConfigMap will be projected into the volume as a file whose name is the key and content is the value. If specified, the listed keys will be projected into the specified paths, and unlisted keys will not be present. If a key is specified which is not present in the ConfigMap, the volume setup will error unless it is marked optional. Paths must be relative and may not contain the '..' path or start with '..'."
                                          "items" = {
                                            "description" = "Maps a string key to a path within a volume."
                                            "properties" = {
                                              "key" = {
                                                "description" = "The key to project."
                                                "type" = "string"
                                              }
                                              "mode" = {
                                                "description" = "Optional: mode bits used to set permissions on this file. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
                                                "format" = "int32"
                                                "type" = "integer"
                                              }
                                              "path" = {
                                                "description" = "The relative path of the file to map the key to. May not be an absolute path. May not contain the path element '..'. May not start with the string '..'."
                                                "type" = "string"
                                              }
                                            }
                                            "required" = [
                                              "key",
                                              "path",
                                            ]
                                            "type" = "object"
                                          }
                                          "type" = "array"
                                        }
                                        "name" = {
                                          "description" = "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
                                          "type" = "string"
                                        }
                                        "optional" = {
                                          "description" = "Specify whether the ConfigMap or its keys must be defined"
                                          "type" = "boolean"
                                        }
                                      }
                                      "type" = "object"
                                    }
                                    "downwardAPI" = {
                                      "description" = "information about the downwardAPI data to project"
                                      "properties" = {
                                        "items" = {
                                          "description" = "Items is a list of DownwardAPIVolume file"
                                          "items" = {
                                            "description" = "DownwardAPIVolumeFile represents information to create the file containing the pod field"
                                            "properties" = {
                                              "fieldRef" = {
                                                "description" = "Required: Selects a field of the pod: only annotations, labels, name and namespace are supported."
                                                "properties" = {
                                                  "apiVersion" = {
                                                    "description" = "Version of the schema the FieldPath is written in terms of, defaults to \"v1\"."
                                                    "type" = "string"
                                                  }
                                                  "fieldPath" = {
                                                    "description" = "Path of the field to select in the specified API version."
                                                    "type" = "string"
                                                  }
                                                }
                                                "required" = [
                                                  "fieldPath",
                                                ]
                                                "type" = "object"
                                              }
                                              "mode" = {
                                                "description" = "Optional: mode bits used to set permissions on this file, must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
                                                "format" = "int32"
                                                "type" = "integer"
                                              }
                                              "path" = {
                                                "description" = "Required: Path is  the relative path name of the file to be created. Must not be absolute or contain the '..' path. Must be utf-8 encoded. The first item of the relative path must not start with '..'"
                                                "type" = "string"
                                              }
                                              "resourceFieldRef" = {
                                                "description" = "Selects a resource of the container: only resources limits and requests (limits.cpu, limits.memory, requests.cpu and requests.memory) are currently supported."
                                                "properties" = {
                                                  "containerName" = {
                                                    "description" = "Container name: required for volumes, optional for env vars"
                                                    "type" = "string"
                                                  }
                                                  "divisor" = {
                                                    "anyOf" = [
                                                      {
                                                        "type" = "integer"
                                                      },
                                                      {
                                                        "type" = "string"
                                                      },
                                                    ]
                                                    "description" = "Specifies the output format of the exposed resources, defaults to \"1\""
                                                    "pattern" = "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
                                                    "x-kubernetes-int-or-string" = true
                                                  }
                                                  "resource" = {
                                                    "description" = "Required: resource to select"
                                                    "type" = "string"
                                                  }
                                                }
                                                "required" = [
                                                  "resource",
                                                ]
                                                "type" = "object"
                                              }
                                            }
                                            "required" = [
                                              "path",
                                            ]
                                            "type" = "object"
                                          }
                                          "type" = "array"
                                        }
                                      }
                                      "type" = "object"
                                    }
                                    "secret" = {
                                      "description" = "information about the secret data to project"
                                      "properties" = {
                                        "items" = {
                                          "description" = "If unspecified, each key-value pair in the Data field of the referenced Secret will be projected into the volume as a file whose name is the key and content is the value. If specified, the listed keys will be projected into the specified paths, and unlisted keys will not be present. If a key is specified which is not present in the Secret, the volume setup will error unless it is marked optional. Paths must be relative and may not contain the '..' path or start with '..'."
                                          "items" = {
                                            "description" = "Maps a string key to a path within a volume."
                                            "properties" = {
                                              "key" = {
                                                "description" = "The key to project."
                                                "type" = "string"
                                              }
                                              "mode" = {
                                                "description" = "Optional: mode bits used to set permissions on this file. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
                                                "format" = "int32"
                                                "type" = "integer"
                                              }
                                              "path" = {
                                                "description" = "The relative path of the file to map the key to. May not be an absolute path. May not contain the path element '..'. May not start with the string '..'."
                                                "type" = "string"
                                              }
                                            }
                                            "required" = [
                                              "key",
                                              "path",
                                            ]
                                            "type" = "object"
                                          }
                                          "type" = "array"
                                        }
                                        "name" = {
                                          "description" = "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
                                          "type" = "string"
                                        }
                                        "optional" = {
                                          "description" = "Specify whether the Secret or its key must be defined"
                                          "type" = "boolean"
                                        }
                                      }
                                      "type" = "object"
                                    }
                                    "serviceAccountToken" = {
                                      "description" = "information about the serviceAccountToken data to project"
                                      "properties" = {
                                        "audience" = {
                                          "description" = "Audience is the intended audience of the token. A recipient of a token must identify itself with an identifier specified in the audience of the token, and otherwise should reject the token. The audience defaults to the identifier of the apiserver."
                                          "type" = "string"
                                        }
                                        "expirationSeconds" = {
                                          "description" = "ExpirationSeconds is the requested duration of validity of the service account token. As the token approaches expiration, the kubelet volume plugin will proactively rotate the service account token. The kubelet will start trying to rotate the token if the token is older than 80 percent of its time to live or if the token is older than 24 hours.Defaults to 1 hour and must be at least 10 minutes."
                                          "format" = "int64"
                                          "type" = "integer"
                                        }
                                        "path" = {
                                          "description" = "Path is the path relative to the mount point of the file to project the token into."
                                          "type" = "string"
                                        }
                                      }
                                      "required" = [
                                        "path",
                                      ]
                                      "type" = "object"
                                    }
                                  }
                                  "type" = "object"
                                }
                                "type" = "array"
                              }
                            }
                            "type" = "object"
                          }
                          "quobyte" = {
                            "description" = "Quobyte represents a Quobyte mount on the host that shares a pod's lifetime"
                            "properties" = {
                              "group" = {
                                "description" = "Group to map volume access to Default is no group"
                                "type" = "string"
                              }
                              "readOnly" = {
                                "description" = "ReadOnly here will force the Quobyte volume to be mounted with read-only permissions. Defaults to false."
                                "type" = "boolean"
                              }
                              "registry" = {
                                "description" = "Registry represents a single or multiple Quobyte Registry services specified as a string as host:port pair (multiple entries are separated with commas) which acts as the central registry for volumes"
                                "type" = "string"
                              }
                              "tenant" = {
                                "description" = "Tenant owning the given Quobyte volume in the Backend Used with dynamically provisioned Quobyte volumes, value is set by the plugin"
                                "type" = "string"
                              }
                              "user" = {
                                "description" = "User to map volume access to Defaults to serivceaccount user"
                                "type" = "string"
                              }
                              "volume" = {
                                "description" = "Volume is a string that references an already created Quobyte volume by name."
                                "type" = "string"
                              }
                            }
                            "required" = [
                              "registry",
                              "volume",
                            ]
                            "type" = "object"
                          }
                          "rbd" = {
                            "description" = "RBD represents a Rados Block Device mount on the host that shares a pod's lifetime. More info: https://examples.k8s.io/volumes/rbd/README.md"
                            "properties" = {
                              "fsType" = {
                                "description" = "Filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#rbd TODO: how do we prevent errors in the filesystem from compromising the machine"
                                "type" = "string"
                              }
                              "image" = {
                                "description" = "The rados image name. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it"
                                "type" = "string"
                              }
                              "keyring" = {
                                "description" = "Keyring is the path to key ring for RBDUser. Default is /etc/ceph/keyring. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it"
                                "type" = "string"
                              }
                              "monitors" = {
                                "description" = "A collection of Ceph monitors. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it"
                                "items" = {
                                  "type" = "string"
                                }
                                "type" = "array"
                              }
                              "pool" = {
                                "description" = "The rados pool name. Default is rbd. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it"
                                "type" = "string"
                              }
                              "readOnly" = {
                                "description" = "ReadOnly here will force the ReadOnly setting in VolumeMounts. Defaults to false. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it"
                                "type" = "boolean"
                              }
                              "secretRef" = {
                                "description" = "SecretRef is name of the authentication secret for RBDUser. If provided overrides keyring. Default is nil. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it"
                                "properties" = {
                                  "name" = {
                                    "description" = "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
                                    "type" = "string"
                                  }
                                }
                                "type" = "object"
                              }
                              "user" = {
                                "description" = "The rados user name. Default is admin. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it"
                                "type" = "string"
                              }
                            }
                            "required" = [
                              "image",
                              "monitors",
                            ]
                            "type" = "object"
                          }
                          "scaleIO" = {
                            "description" = "ScaleIO represents a ScaleIO persistent volume attached and mounted on Kubernetes nodes."
                            "properties" = {
                              "fsType" = {
                                "description" = "Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\", \"ntfs\". Default is \"xfs\"."
                                "type" = "string"
                              }
                              "gateway" = {
                                "description" = "The host address of the ScaleIO API Gateway."
                                "type" = "string"
                              }
                              "protectionDomain" = {
                                "description" = "The name of the ScaleIO Protection Domain for the configured storage."
                                "type" = "string"
                              }
                              "readOnly" = {
                                "description" = "Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts."
                                "type" = "boolean"
                              }
                              "secretRef" = {
                                "description" = "SecretRef references to the secret for ScaleIO user and other sensitive information. If this is not provided, Login operation will fail."
                                "properties" = {
                                  "name" = {
                                    "description" = "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
                                    "type" = "string"
                                  }
                                }
                                "type" = "object"
                              }
                              "sslEnabled" = {
                                "description" = "Flag to enable/disable SSL communication with Gateway, default false"
                                "type" = "boolean"
                              }
                              "storageMode" = {
                                "description" = "Indicates whether the storage for a volume should be ThickProvisioned or ThinProvisioned. Default is ThinProvisioned."
                                "type" = "string"
                              }
                              "storagePool" = {
                                "description" = "The ScaleIO Storage Pool associated with the protection domain."
                                "type" = "string"
                              }
                              "system" = {
                                "description" = "The name of the storage system as configured in ScaleIO."
                                "type" = "string"
                              }
                              "volumeName" = {
                                "description" = "The name of a volume already created in the ScaleIO system that is associated with this volume source."
                                "type" = "string"
                              }
                            }
                            "required" = [
                              "gateway",
                              "secretRef",
                              "system",
                            ]
                            "type" = "object"
                          }
                          "secret" = {
                            "description" = "Secret represents a secret that should populate this volume. More info: https://kubernetes.io/docs/concepts/storage/volumes#secret"
                            "properties" = {
                              "defaultMode" = {
                                "description" = "Optional: mode bits used to set permissions on created files by default. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. Defaults to 0644. Directories within the path are not affected by this setting. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
                                "format" = "int32"
                                "type" = "integer"
                              }
                              "items" = {
                                "description" = "If unspecified, each key-value pair in the Data field of the referenced Secret will be projected into the volume as a file whose name is the key and content is the value. If specified, the listed keys will be projected into the specified paths, and unlisted keys will not be present. If a key is specified which is not present in the Secret, the volume setup will error unless it is marked optional. Paths must be relative and may not contain the '..' path or start with '..'."
                                "items" = {
                                  "description" = "Maps a string key to a path within a volume."
                                  "properties" = {
                                    "key" = {
                                      "description" = "The key to project."
                                      "type" = "string"
                                    }
                                    "mode" = {
                                      "description" = "Optional: mode bits used to set permissions on this file. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
                                      "format" = "int32"
                                      "type" = "integer"
                                    }
                                    "path" = {
                                      "description" = "The relative path of the file to map the key to. May not be an absolute path. May not contain the path element '..'. May not start with the string '..'."
                                      "type" = "string"
                                    }
                                  }
                                  "required" = [
                                    "key",
                                    "path",
                                  ]
                                  "type" = "object"
                                }
                                "type" = "array"
                              }
                              "optional" = {
                                "description" = "Specify whether the Secret or its keys must be defined"
                                "type" = "boolean"
                              }
                              "secretName" = {
                                "description" = "Name of the secret in the pod's namespace to use. More info: https://kubernetes.io/docs/concepts/storage/volumes#secret"
                                "type" = "string"
                              }
                            }
                            "type" = "object"
                          }
                          "storageos" = {
                            "description" = "StorageOS represents a StorageOS volume attached and mounted on Kubernetes nodes."
                            "properties" = {
                              "fsType" = {
                                "description" = "Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified."
                                "type" = "string"
                              }
                              "readOnly" = {
                                "description" = "Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts."
                                "type" = "boolean"
                              }
                              "secretRef" = {
                                "description" = "SecretRef specifies the secret to use for obtaining the StorageOS API credentials.  If not specified, default values will be attempted."
                                "properties" = {
                                  "name" = {
                                    "description" = "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
                                    "type" = "string"
                                  }
                                }
                                "type" = "object"
                              }
                              "volumeName" = {
                                "description" = "VolumeName is the human-readable name of the StorageOS volume.  Volume names are only unique within a namespace."
                                "type" = "string"
                              }
                              "volumeNamespace" = {
                                "description" = "VolumeNamespace specifies the scope of the volume within StorageOS.  If no namespace is specified then the Pod's namespace will be used.  This allows the Kubernetes name scoping to be mirrored within StorageOS for tighter integration. Set VolumeName to any name to override the default behaviour. Set to \"default\" if you are not using namespaces within StorageOS. Namespaces that do not pre-exist within StorageOS will be created."
                                "type" = "string"
                              }
                            }
                            "type" = "object"
                          }
                          "vsphereVolume" = {
                            "description" = "VsphereVolume represents a vSphere volume attached and mounted on kubelets host machine"
                            "properties" = {
                              "fsType" = {
                                "description" = "Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified."
                                "type" = "string"
                              }
                              "storagePolicyID" = {
                                "description" = "Storage Policy Based Management (SPBM) profile ID associated with the StoragePolicyName."
                                "type" = "string"
                              }
                              "storagePolicyName" = {
                                "description" = "Storage Policy Based Management (SPBM) profile name."
                                "type" = "string"
                              }
                              "volumePath" = {
                                "description" = "Path that identifies vSphere volume vmdk"
                                "type" = "string"
                              }
                            }
                            "required" = [
                              "volumePath",
                            ]
                            "type" = "object"
                          }
                        }
                        "required" = [
                          "name",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                      "x-kubernetes-list-type" = "atomic"
                    }
                  }
                  "type" = "object"
                }
                "status" = {
                  "description" = "OpenTelemetryCollectorStatus defines the observed state of OpenTelemetryCollector."
                  "properties" = {
                    "messages" = {
                      "description" = "Messages about actions performed by the operator on this resource. Deprecated: use Kubernetes events instead."
                      "items" = {
                        "type" = "string"
                      }
                      "type" = "array"
                      "x-kubernetes-list-type" = "atomic"
                    }
                    "replicas" = {
                      "description" = "Replicas is currently not being set and might be removed in the next version. Deprecated: use \"OpenTelemetryCollector.Status.Scale.Replicas\" instead."
                      "format" = "int32"
                      "type" = "integer"
                    }
                    "scale" = {
                      "description" = "Scale is the OpenTelemetryCollector's scale subresource status."
                      "properties" = {
                        "replicas" = {
                          "description" = "The total number non-terminated pods targeted by this OpenTelemetryCollector's deployment or statefulSet."
                          "format" = "int32"
                          "type" = "integer"
                        }
                        "selector" = {
                          "description" = "The selector used to match the OpenTelemetryCollector's deployment or statefulSet pods."
                          "type" = "string"
                        }
                      }
                      "type" = "object"
                    }
                    "version" = {
                      "description" = "Version of the managed OpenTelemetry Collector (operand)"
                      "type" = "string"
                    }
                  }
                  "type" = "object"
                }
              }
              "type" = "object"
            }
          }
          "served" = true
          "storage" = true
          "subresources" = {
            "scale" = {
              "labelSelectorPath" = ".status.scale.selector"
              "specReplicasPath" = ".spec.replicas"
              "statusReplicasPath" = ".status.scale.replicas"
            }
            "status" = {}
          }
        },
      ]
    }
  }
}

resource "kubernetes_manifest" "serviceaccount_opentelemetry_operator_system_opentelemetry_operator_controller_manager" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "ServiceAccount"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/name" = "opentelemetry-operator"
      }
      "name" = "opentelemetry-operator-controller-manager"
      "namespace" = "opentelemetry-operator-system"
    }
  }
}

resource "kubernetes_manifest" "role_opentelemetry_operator_system_opentelemetry_operator_leader_election_role" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "Role"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/name" = "opentelemetry-operator"
      }
      "name" = "opentelemetry-operator-leader-election-role"
      "namespace" = "opentelemetry-operator-system"
    }
    "rules" = [
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "configmaps",
        ]
        "verbs" = [
          "get",
          "list",
          "watch",
          "create",
          "update",
          "patch",
          "delete",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "configmaps/status",
        ]
        "verbs" = [
          "get",
          "update",
          "patch",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "events",
        ]
        "verbs" = [
          "create",
          "patch",
        ]
      },
    ]
  }
}

resource "kubernetes_manifest" "clusterrole_opentelemetry_operator_manager_role" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRole"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/name" = "opentelemetry-operator"
      }
      "name" = "opentelemetry-operator-manager-role"
    }
    "rules" = [
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "configmaps",
        ]
        "verbs" = [
          "create",
          "delete",
          "get",
          "list",
          "patch",
          "update",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "events",
        ]
        "verbs" = [
          "create",
          "patch",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "namespaces",
        ]
        "verbs" = [
          "list",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "serviceaccounts",
        ]
        "verbs" = [
          "create",
          "delete",
          "get",
          "list",
          "patch",
          "update",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "services",
        ]
        "verbs" = [
          "create",
          "delete",
          "get",
          "list",
          "patch",
          "update",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "apps",
        ]
        "resources" = [
          "daemonsets",
        ]
        "verbs" = [
          "create",
          "delete",
          "get",
          "list",
          "patch",
          "update",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "apps",
        ]
        "resources" = [
          "deployments",
        ]
        "verbs" = [
          "create",
          "delete",
          "get",
          "list",
          "patch",
          "update",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "apps",
        ]
        "resources" = [
          "replicasets",
        ]
        "verbs" = [
          "get",
          "list",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "apps",
        ]
        "resources" = [
          "statefulsets",
        ]
        "verbs" = [
          "create",
          "delete",
          "get",
          "list",
          "patch",
          "update",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "autoscaling",
        ]
        "resources" = [
          "horizontalpodautoscalers",
        ]
        "verbs" = [
          "create",
          "delete",
          "get",
          "list",
          "patch",
          "update",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "coordination.k8s.io",
        ]
        "resources" = [
          "leases",
        ]
        "verbs" = [
          "create",
          "get",
          "list",
          "update",
        ]
      },
      {
        "apiGroups" = [
          "opentelemetry.io",
        ]
        "resources" = [
          "instrumentations",
        ]
        "verbs" = [
          "get",
          "list",
          "patch",
          "update",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "opentelemetry.io",
        ]
        "resources" = [
          "opentelemetrycollectors",
        ]
        "verbs" = [
          "create",
          "delete",
          "get",
          "list",
          "patch",
          "update",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "opentelemetry.io",
        ]
        "resources" = [
          "opentelemetrycollectors/finalizers",
        ]
        "verbs" = [
          "get",
          "patch",
          "update",
        ]
      },
      {
        "apiGroups" = [
          "opentelemetry.io",
        ]
        "resources" = [
          "opentelemetrycollectors/status",
        ]
        "verbs" = [
          "get",
          "patch",
          "update",
        ]
      },
    ]
  }
}

resource "kubernetes_manifest" "clusterrole_opentelemetry_operator_metrics_reader" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRole"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/name" = "opentelemetry-operator"
      }
      "name" = "opentelemetry-operator-metrics-reader"
    }
    "rules" = [
      {
        "nonResourceURLs" = [
          "/metrics",
        ]
        "verbs" = [
          "get",
        ]
      },
    ]
  }
}

resource "kubernetes_manifest" "clusterrole_opentelemetry_operator_proxy_role" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRole"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/name" = "opentelemetry-operator"
      }
      "name" = "opentelemetry-operator-proxy-role"
    }
    "rules" = [
      {
        "apiGroups" = [
          "authentication.k8s.io",
        ]
        "resources" = [
          "tokenreviews",
        ]
        "verbs" = [
          "create",
        ]
      },
      {
        "apiGroups" = [
          "authorization.k8s.io",
        ]
        "resources" = [
          "subjectaccessreviews",
        ]
        "verbs" = [
          "create",
        ]
      },
    ]
  }
}

resource "kubernetes_manifest" "rolebinding_opentelemetry_operator_system_opentelemetry_operator_leader_election_rolebinding" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "RoleBinding"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/name" = "opentelemetry-operator"
      }
      "name" = "opentelemetry-operator-leader-election-rolebinding"
      "namespace" = "opentelemetry-operator-system"
    }
    "roleRef" = {
      "apiGroup" = "rbac.authorization.k8s.io"
      "kind" = "Role"
      "name" = "opentelemetry-operator-leader-election-role"
    }
    "subjects" = [
      {
        "kind" = "ServiceAccount"
        "name" = "opentelemetry-operator-controller-manager"
        "namespace" = "opentelemetry-operator-system"
      },
    ]
  }
}

resource "kubernetes_manifest" "clusterrolebinding_opentelemetry_operator_manager_rolebinding" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRoleBinding"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/name" = "opentelemetry-operator"
      }
      "name" = "opentelemetry-operator-manager-rolebinding"
    }
    "roleRef" = {
      "apiGroup" = "rbac.authorization.k8s.io"
      "kind" = "ClusterRole"
      "name" = "opentelemetry-operator-manager-role"
    }
    "subjects" = [
      {
        "kind" = "ServiceAccount"
        "name" = "opentelemetry-operator-controller-manager"
        "namespace" = "opentelemetry-operator-system"
      },
    ]
  }
}

resource "kubernetes_manifest" "clusterrolebinding_opentelemetry_operator_proxy_rolebinding" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRoleBinding"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/name" = "opentelemetry-operator"
      }
      "name" = "opentelemetry-operator-proxy-rolebinding"
    }
    "roleRef" = {
      "apiGroup" = "rbac.authorization.k8s.io"
      "kind" = "ClusterRole"
      "name" = "opentelemetry-operator-proxy-role"
    }
    "subjects" = [
      {
        "kind" = "ServiceAccount"
        "name" = "opentelemetry-operator-controller-manager"
        "namespace" = "opentelemetry-operator-system"
      },
    ]
  }
}

resource "kubernetes_manifest" "service_opentelemetry_operator_system_opentelemetry_operator_controller_manager_metrics_service" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "Service"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/name" = "opentelemetry-operator"
        "control-plane" = "controller-manager"
      }
      "name" = "opentelemetry-operator-controller-manager-metrics-service"
      "namespace" = "opentelemetry-operator-system"
    }
    "spec" = {
      "ports" = [
        {
          "name" = "https"
          "port" = 8443
          "protocol" = "TCP"
          "targetPort" = "https"
        },
      ]
      "selector" = {
        "app.kubernetes.io/name" = "opentelemetry-operator"
        "control-plane" = "controller-manager"
      }
    }
  }
}

resource "kubernetes_manifest" "service_opentelemetry_operator_system_opentelemetry_operator_webhook_service" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "Service"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/name" = "opentelemetry-operator"
      }
      "name" = "opentelemetry-operator-webhook-service"
      "namespace" = "opentelemetry-operator-system"
    }
    "spec" = {
      "ports" = [
        {
          "port" = 443
          "protocol" = "TCP"
          "targetPort" = 9443
        },
      ]
      "selector" = {
        "app.kubernetes.io/name" = "opentelemetry-operator"
        "control-plane" = "controller-manager"
      }
    }
  }
}

resource "kubernetes_manifest" "deployment_opentelemetry_operator_system_opentelemetry_operator_controller_manager" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/name" = "opentelemetry-operator"
        "control-plane" = "controller-manager"
      }
      "name" = "opentelemetry-operator-controller-manager"
      "namespace" = "opentelemetry-operator-system"
    }
    "spec" = {
      "replicas" = 1
      "selector" = {
        "matchLabels" = {
          "app.kubernetes.io/name" = "opentelemetry-operator"
          "control-plane" = "controller-manager"
        }
      }
      "template" = {
        "metadata" = {
          "labels" = {
            "app.kubernetes.io/name" = "opentelemetry-operator"
            "control-plane" = "controller-manager"
          }
        }
        "spec" = {
          "containers" = [
            {
              "args" = [
                "--secure-listen-address=0.0.0.0:8443",
                "--upstream=http://127.0.0.1:8080/",
                "--logtostderr=true",
                "--v=0",
              ]
              "image" = "gcr.io/kubebuilder/kube-rbac-proxy:v0.11.0"
              "name" = "kube-rbac-proxy"
              "ports" = [
                {
                  "containerPort" = 8443
                  "name" = "https"
                  "protocol" = "TCP"
                },
              ]
              "resources" = {
                "limits" = {
                  "cpu" = "500m"
                  "memory" = "128Mi"
                }
                "requests" = {
                  "cpu" = "5m"
                  "memory" = "64Mi"
                }
              }
            },
            {
              "args" = [
                "--metrics-addr=127.0.0.1:8080",
                "--enable-leader-election",
              ]
              "image" = "ghcr.io/open-telemetry/opentelemetry-operator/opentelemetry-operator:0.51.0"
              "livenessProbe" = {
                "httpGet" = {
                  "path" = "/healthz"
                  "port" = 8081
                }
                "initialDelaySeconds" = 15
                "periodSeconds" = 20
              }
              "name" = "manager"
              "ports" = [
                {
                  "containerPort" = 9443
                  "name" = "webhook-server"
                  "protocol" = "TCP"
                },
              ]
              "readinessProbe" = {
                "httpGet" = {
                  "path" = "/readyz"
                  "port" = 8081
                }
                "initialDelaySeconds" = 5
                "periodSeconds" = 10
              }
              "resources" = {
                "limits" = {
                  "cpu" = "200m"
                  "memory" = "256Mi"
                }
                "requests" = {
                  "cpu" = "100m"
                  "memory" = "64Mi"
                }
              }
              "volumeMounts" = [
                {
                  "mountPath" = "/tmp/k8s-webhook-server/serving-certs"
                  "name" = "cert"
                  "readOnly" = true
                },
              ]
            },
          ]
          "serviceAccountName" = "opentelemetry-operator-controller-manager"
          "terminationGracePeriodSeconds" = 10
          "volumes" = [
            {
              "name" = "cert"
              "secret" = {
                "defaultMode" = 420
                "secretName" = "opentelemetry-operator-controller-manager-service-cert"
              }
            },
          ]
        }
      }
    }
  }
}

resource "kubernetes_manifest" "certificate_opentelemetry_operator_system_opentelemetry_operator_serving_cert" {
  manifest = {
    "apiVersion" = "cert-manager.io/v1"
    "kind" = "Certificate"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/name" = "opentelemetry-operator"
      }
      "name" = "opentelemetry-operator-serving-cert"
      "namespace" = "opentelemetry-operator-system"
    }
    "spec" = {
      "dnsNames" = [
        "opentelemetry-operator-webhook-service.opentelemetry-operator-system.svc",
        "opentelemetry-operator-webhook-service.opentelemetry-operator-system.svc.cluster.local",
      ]
      "issuerRef" = {
        "kind" = "Issuer"
        "name" = "opentelemetry-operator-selfsigned-issuer"
      }
      "secretName" = "opentelemetry-operator-controller-manager-service-cert"
      "subject" = {
        "organizationalUnits" = [
          "opentelemetry-operator",
        ]
      }
    }
  }
}

resource "kubernetes_manifest" "issuer_opentelemetry_operator_system_opentelemetry_operator_selfsigned_issuer" {
  manifest = {
    "apiVersion" = "cert-manager.io/v1"
    "kind" = "Issuer"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/name" = "opentelemetry-operator"
      }
      "name" = "opentelemetry-operator-selfsigned-issuer"
      "namespace" = "opentelemetry-operator-system"
    }
    "spec" = {
      "selfSigned" = {}
    }
  }
}

resource "kubernetes_manifest" "mutatingwebhookconfiguration_opentelemetry_operator_mutating_webhook_configuration" {
  manifest = {
    "apiVersion" = "admissionregistration.k8s.io/v1"
    "kind" = "MutatingWebhookConfiguration"
    "metadata" = {
      "annotations" = {
        "cert-manager.io/inject-ca-from" = "opentelemetry-operator-system/opentelemetry-operator-serving-cert"
      }
      "labels" = {
        "app.kubernetes.io/name" = "opentelemetry-operator"
      }
      "name" = "opentelemetry-operator-mutating-webhook-configuration"
    }
    "webhooks" = [
      {
        "admissionReviewVersions" = [
          "v1",
        ]
        "clientConfig" = {
          "service" = {
            "name" = "opentelemetry-operator-webhook-service"
            "namespace" = "opentelemetry-operator-system"
            "path" = "/mutate-opentelemetry-io-v1alpha1-instrumentation"
          }
        }
        "failurePolicy" = "Fail"
        "name" = "minstrumentation.kb.io"
        "rules" = [
          {
            "apiGroups" = [
              "opentelemetry.io",
            ]
            "apiVersions" = [
              "v1alpha1",
            ]
            "operations" = [
              "CREATE",
              "UPDATE",
            ]
            "resources" = [
              "instrumentations",
            ]
          },
        ]
        "sideEffects" = "None"
      },
      {
        "admissionReviewVersions" = [
          "v1",
        ]
        "clientConfig" = {
          "service" = {
            "name" = "opentelemetry-operator-webhook-service"
            "namespace" = "opentelemetry-operator-system"
            "path" = "/mutate-opentelemetry-io-v1alpha1-opentelemetrycollector"
          }
        }
        "failurePolicy" = "Fail"
        "name" = "mopentelemetrycollector.kb.io"
        "rules" = [
          {
            "apiGroups" = [
              "opentelemetry.io",
            ]
            "apiVersions" = [
              "v1alpha1",
            ]
            "operations" = [
              "CREATE",
              "UPDATE",
            ]
            "resources" = [
              "opentelemetrycollectors",
            ]
          },
        ]
        "sideEffects" = "None"
      },
      {
        "admissionReviewVersions" = [
          "v1",
        ]
        "clientConfig" = {
          "service" = {
            "name" = "opentelemetry-operator-webhook-service"
            "namespace" = "opentelemetry-operator-system"
            "path" = "/mutate-v1-pod"
          }
        }
        "failurePolicy" = "Ignore"
        "name" = "mpod.kb.io"
        "rules" = [
          {
            "apiGroups" = [
              "",
            ]
            "apiVersions" = [
              "v1",
            ]
            "operations" = [
              "CREATE",
              "UPDATE",
            ]
            "resources" = [
              "pods",
            ]
          },
        ]
        "sideEffects" = "None"
      },
    ]
  }
}

resource "kubernetes_manifest" "validatingwebhookconfiguration_opentelemetry_operator_validating_webhook_configuration" {
  manifest = {
    "apiVersion" = "admissionregistration.k8s.io/v1"
    "kind" = "ValidatingWebhookConfiguration"
    "metadata" = {
      "annotations" = {
        "cert-manager.io/inject-ca-from" = "opentelemetry-operator-system/opentelemetry-operator-serving-cert"
      }
      "labels" = {
        "app.kubernetes.io/name" = "opentelemetry-operator"
      }
      "name" = "opentelemetry-operator-validating-webhook-configuration"
    }
    "webhooks" = [
      {
        "admissionReviewVersions" = [
          "v1",
        ]
        "clientConfig" = {
          "service" = {
            "name" = "opentelemetry-operator-webhook-service"
            "namespace" = "opentelemetry-operator-system"
            "path" = "/validate-opentelemetry-io-v1alpha1-instrumentation"
          }
        }
        "failurePolicy" = "Fail"
        "name" = "vinstrumentationcreateupdate.kb.io"
        "rules" = [
          {
            "apiGroups" = [
              "opentelemetry.io",
            ]
            "apiVersions" = [
              "v1alpha1",
            ]
            "operations" = [
              "CREATE",
              "UPDATE",
            ]
            "resources" = [
              "instrumentations",
            ]
          },
        ]
        "sideEffects" = "None"
      },
      {
        "admissionReviewVersions" = [
          "v1",
        ]
        "clientConfig" = {
          "service" = {
            "name" = "opentelemetry-operator-webhook-service"
            "namespace" = "opentelemetry-operator-system"
            "path" = "/validate-opentelemetry-io-v1alpha1-instrumentation"
          }
        }
        "failurePolicy" = "Ignore"
        "name" = "vinstrumentationdelete.kb.io"
        "rules" = [
          {
            "apiGroups" = [
              "opentelemetry.io",
            ]
            "apiVersions" = [
              "v1alpha1",
            ]
            "operations" = [
              "DELETE",
            ]
            "resources" = [
              "instrumentations",
            ]
          },
        ]
        "sideEffects" = "None"
      },
      {
        "admissionReviewVersions" = [
          "v1",
        ]
        "clientConfig" = {
          "service" = {
            "name" = "opentelemetry-operator-webhook-service"
            "namespace" = "opentelemetry-operator-system"
            "path" = "/validate-opentelemetry-io-v1alpha1-opentelemetrycollector"
          }
        }
        "failurePolicy" = "Fail"
        "name" = "vopentelemetrycollectorcreateupdate.kb.io"
        "rules" = [
          {
            "apiGroups" = [
              "opentelemetry.io",
            ]
            "apiVersions" = [
              "v1alpha1",
            ]
            "operations" = [
              "CREATE",
              "UPDATE",
            ]
            "resources" = [
              "opentelemetrycollectors",
            ]
          },
        ]
        "sideEffects" = "None"
      },
      {
        "admissionReviewVersions" = [
          "v1",
        ]
        "clientConfig" = {
          "service" = {
            "name" = "opentelemetry-operator-webhook-service"
            "namespace" = "opentelemetry-operator-system"
            "path" = "/validate-opentelemetry-io-v1alpha1-opentelemetrycollector"
          }
        }
        "failurePolicy" = "Ignore"
        "name" = "vopentelemetrycollectordelete.kb.io"
        "rules" = [
          {
            "apiGroups" = [
              "opentelemetry.io",
            ]
            "apiVersions" = [
              "v1alpha1",
            ]
            "operations" = [
              "DELETE",
            ]
            "resources" = [
              "opentelemetrycollectors",
            ]
          },
        ]
        "sideEffects" = "None"
      },
    ]
  }
}
