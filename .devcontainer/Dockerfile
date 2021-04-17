# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.163.1/containers/ubuntu/.devcontainer/base.Dockerfile

# [Choice] Ubuntu version: bionic, focal
ARG VARIANT="focal"
FROM mcr.microsoft.com/vscode/devcontainers/base:0-${VARIANT}

ARG TF_VERSION
ARG TG_VERSION
ARG LOCAL_BIN='/root/.local/bin'
ENV LOCAL_BIN=${LOCAL_BIN}
ENV TF_VERSION=${TF_VERSION}
ENV TG_VERSION=${TG_VERSION}
ENV AWS_PAGER=""
ENV PATH = "$PATH:/root/bin"
# [Optional] Uncomment this section to install additional OS packages.
# RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends <your-package-list-here>

RUN wget -O terraform.zip "https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip" \
    && unzip terraform.zip \
    && mv terraform /usr/bin/ \
    && rm terraform.zip

RUN wget -O terragrunt https://github.com/gruntwork-io/terragrunt/releases/download/${TG_VERSION}/terragrunt_linux_arm64 \
    && chmod +x terragrunt \
    && mv terragrunt /usr/bin/

# install pre-commit
RUN apt update && export DEBIAN_FRONTEND=noninteractive \
    && apt -y install --no-install-recommends python3-pip gawk \
    && curl https://pre-commit.com/install-local.py | python3 - \
    && wget -O terraform-docs https://github.com/terraform-docs/terraform-docs/releases/download/v0.12.1/terraform-docs-v0.12.1-linux-amd64 \
        && chmod +x terraform-docs \
        &&  mv terraform-docs /usr/bin/ \
    && wget -O tfsec https://github.com/tfsec/tfsec/releases/download/v0.39.21/tfsec-linux-amd64 \
        && chmod +x tfsec \
        && mv tfsec /usr/bin/ \
    && wget -O tflint.zip https://github.com/terraform-linters/tflint/releases/download/v0.26.0/tflint_linux_amd64.zip \
        && unzip tflint.zip \
        && mv tflint /usr/bin/ \
        && rm tflint.zip \
    && python3 -m pip install -U checkov 

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && bash -e ./aws/install -i ~/.local/aws-cli -b ${LOCAL_BIN} \
    && echo "complete -C '${LOCAL_BIN}/aws_completer' aws" >> /root/.bashrc \
    && rm awscliv2.zip \
    && rm -rf ./aws

CMD ["/bin/bash"]