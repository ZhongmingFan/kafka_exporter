#!/bin/bash

# 部署监控对象
object=kafka
object_versions=("3.5.1" "2.1.1" "2.0.1" "0.11.0-1-r1" "0.10.2-1-r3")
value_file="bitnami_values.yaml"

for version in "${object_versions[@]}"; do
    version_suffix="v$(echo "$version" | grep -Eo '[0-9]{1,2}\.[0-9]{1,2}' | tr '.' '-')"

    helm install $object-$version_suffix --namespace $object -f ./values/bitnami_values.yaml ./$object \
    --set image.tag=$version \
    --set commonLabels.object_version=$version_suffix

    sleep 1
done

