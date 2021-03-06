#!/bin/bash
#
# 该build基于registry.fit2cloud.com/public/python:3
utils_dir=$(pwd)
project_dir=$(dirname "$utils_dir")
release_dir=${project_dir}/release

# 安装依赖包
command -v git || yum -y install git

# 打包
cd "${project_dir}" || exit 3
rm -rf "${release_dir:?}/*"
to_dir="${release_dir}/jumpserver"
mkdir -p "${to_dir}"
git archive --format tar HEAD | tar x -C "${to_dir}"

if [[ $(uname) == 'Darwin' ]];then
  alias sedi="sed -i ''"
else
  alias sedi='sed -i'
fi

# 修改版本号文件
if [[ -n ${VERSION} ]]; then
  sedi "s@VERSION = .*@VERSION = \"${VERSION}\"@g" "${to_dir}/apps/jumpserver/const.py"
fi

