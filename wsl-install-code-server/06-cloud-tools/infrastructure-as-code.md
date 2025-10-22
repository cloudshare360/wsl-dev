# ☁️ Infrastructure as Code Tools

> 🏗️ **Modern IaC Stack** | 🚀 **Terraform + CDK + Pulumi** | 🔧 **Multi-Cloud Ready**

Complete Infrastructure as Code toolkit for modern cloud development and DevOps workflows.

## 🛠️ Tools Overview

| Tool | Language | Clouds | Strengths | Use Case |
|------|----------|---------|-----------|----------|
| **Terraform** | HCL | All | Mature, large ecosystem | Production infrastructure |
| **Terraform CDK** | TypeScript/Python | All | Code-first, type safety | Developer-friendly IaC |
| **Pulumi** | Multiple | All | Programming languages | Complex logic, teams |

## 🚀 Installation

### Terraform

```bash
# Install Terraform via HashiCorp repository
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt update && sudo apt install terraform

# Verify installation
terraform --version

# Add to PATH (already included in shell config)
echo 'export PATH="$HOME/.local/bin/terraform:$PATH"' >> ~/.bashrc

# Install Terraform Language Server for VS Code
curl -L -o /tmp/terraform-ls.zip \
  "https://releases.hashicorp.com/terraform-ls/0.32.7/terraform-ls_0.32.7_linux_amd64.zip"
sudo unzip /tmp/terraform-ls.zip -d /usr/local/bin/
sudo chmod +x /usr/local/bin/terraform-ls

# Configure Terraform completion
terraform -install-autocomplete
```

### Terraform CDK

```bash
# Install Terraform CDK via npm (requires Node.js)
npm install -g cdktf-cli

# Verify installation
cdktf --version

# Install common CDK providers
npm install -g @cdktf/provider-aws @cdktf/provider-google @cdktf/provider-azurerm

# Create CDK alias
echo 'alias cdk="cdktf"' >> ~/.bashrc
```

### Pulumi

```bash
# Install Pulumi
curl -fsSL https://get.pulumi.com | sh

# Add Pulumi to PATH
echo 'export PATH="$HOME/.pulumi/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

# Verify installation
pulumi version

# Install language support
# Python support
pip3 install pulumi pulumi-aws pulumi-gcp pulumi-azure

# Node.js support
npm install -g @pulumi/pulumi @pulumi/aws @pulumi/gcp @pulumi/azure
```

### Vault (HashiCorp)

```bash
# Install Vault for secrets management
sudo apt update && sudo apt install vault

# Verify installation
vault --version
```

### Packer (HashiCorp)

```bash
# Install Packer for image building
sudo apt install packer

# Verify installation
packer --version
```

## 🏗️ Getting Started Examples

### Terraform Example

```bash
# Create Terraform project
mkdir terraform-demo && cd terraform-demo

# Create main.tf
cat > main.tf << 'EOF'
terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "development"
}

# VPC
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "${var.environment}-vpc"
    Environment = var.environment
  }
}

# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${var.environment}-igw"
    Environment = var.environment
  }
}

# Public Subnet
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.environment}-public-subnet"
    Environment = var.environment
  }
}

# Private Subnet
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name        = "${var.environment}-private-subnet"
    Environment = var.environment
  }
}

# Route Table for Public Subnet
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name        = "${var.environment}-public-rt"
    Environment = var.environment
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# Data sources
data "aws_availability_zones" "available" {
  state = "available"
}

# Outputs
output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = aws_subnet.public.id
}

output "private_subnet_id" {
  description = "ID of the private subnet"
  value       = aws_subnet.private.id
}
EOF

# Create variables file
cat > terraform.tfvars << 'EOF'
aws_region  = "us-west-2"
environment = "development"
EOF

# Create outputs
cat > outputs.tf << 'EOF'
output "vpc_cidr" {
  description = "CIDR block of the VPC"
  value       = aws_vpc.main.cidr_block
}

output "availability_zones" {
  description = "List of availability zones"
  value       = data.aws_availability_zones.available.names
}
EOF

# Initialize and plan
terraform init
terraform plan
```

### Terraform CDK Example (TypeScript)

```bash
# Create Terraform CDK project
mkdir cdktf-demo && cd cdktf-demo

# Initialize CDK project
cdktf init --template="typescript" --local

# Install AWS provider
npm install @cdktf/provider-aws

# Create main stack
cat > main.ts << 'EOF'
import { Construct } from "constructs";
import { App, TerraformStack, TerraformOutput } from "cdktf";
import { AwsProvider } from "@cdktf/provider-aws/lib/provider";
import { Vpc } from "@cdktf/provider-aws/lib/vpc";
import { Subnet } from "@cdktf/provider-aws/lib/subnet";
import { InternetGateway } from "@cdktf/provider-aws/lib/internet-gateway";
import { RouteTable } from "@cdktf/provider-aws/lib/route-table";
import { RouteTableAssociation } from "@cdktf/provider-aws/lib/route-table-association";
import { Route } from "@cdktf/provider-aws/lib/route";

class MyStack extends TerraformStack {
  constructor(scope: Construct, id: string) {
    super(scope, id);

    // AWS Provider
    new AwsProvider(this, "AWS", {
      region: "us-west-2",
    });

    // VPC
    const vpc = new Vpc(this, "vpc", {
      cidrBlock: "10.0.0.0/16",
      enableDnsHostnames: true,
      enableDnsSupport: true,
      tags: {
        Name: "cdktf-vpc",
        Environment: "development",
      },
    });

    // Internet Gateway
    const igw = new InternetGateway(this, "igw", {
      vpcId: vpc.id,
      tags: {
        Name: "cdktf-igw",
      },
    });

    // Public Subnet
    const publicSubnet = new Subnet(this, "public-subnet", {
      vpcId: vpc.id,
      cidrBlock: "10.0.1.0/24",
      availabilityZone: "us-west-2a",
      mapPublicIpOnLaunch: true,
      tags: {
        Name: "cdktf-public-subnet",
      },
    });

    // Route Table
    const publicRouteTable = new RouteTable(this, "public-rt", {
      vpcId: vpc.id,
      tags: {
        Name: "cdktf-public-rt",
      },
    });

    // Route
    new Route(this, "public-route", {
      routeTableId: publicRouteTable.id,
      destinationCidrBlock: "0.0.0.0/0",
      gatewayId: igw.id,
    });

    // Route Table Association
    new RouteTableAssociation(this, "public-rta", {
      subnetId: publicSubnet.id,
      routeTableId: publicRouteTable.id,
    });

    // Outputs
    new TerraformOutput(this, "vpc-id", {
      value: vpc.id,
    });

    new TerraformOutput(this, "public-subnet-id", {
      value: publicSubnet.id,
    });
  }
}

const app = new App();
new MyStack(app, "cdktf-demo");
app.synth();
EOF

# Build and deploy
npm run build
cdktf plan
```

### Pulumi Example (Python)

```bash
# Create Pulumi project
mkdir pulumi-demo && cd pulumi-demo

# Initialize Pulumi project
pulumi new aws-python --yes

# Edit __main__.py
cat > __main__.py << 'EOF'
"""AWS infrastructure with Pulumi."""

import pulumi
import pulumi_aws as aws

# Create a VPC
vpc = aws.ec2.Vpc("main-vpc",
    cidr_block="10.0.0.0/16",
    enable_dns_hostnames=True,
    enable_dns_support=True,
    tags={
        "Name": "pulumi-vpc",
        "Environment": "development",
    })

# Create an Internet Gateway
igw = aws.ec2.InternetGateway("main-igw",
    vpc_id=vpc.id,
    tags={
        "Name": "pulumi-igw",
    })

# Create public subnet
public_subnet = aws.ec2.Subnet("public-subnet",
    vpc_id=vpc.id,
    cidr_block="10.0.1.0/24",
    availability_zone="us-west-2a",
    map_public_ip_on_launch=True,
    tags={
        "Name": "pulumi-public-subnet",
    })

# Create private subnet
private_subnet = aws.ec2.Subnet("private-subnet",
    vpc_id=vpc.id,
    cidr_block="10.0.2.0/24",
    availability_zone="us-west-2b",
    tags={
        "Name": "pulumi-private-subnet",
    })

# Create route table for public subnet
public_route_table = aws.ec2.RouteTable("public-rt",
    vpc_id=vpc.id,
    routes=[
        aws.ec2.RouteTableRouteArgs(
            cidr_block="0.0.0.0/0",
            gateway_id=igw.id,
        )
    ],
    tags={
        "Name": "pulumi-public-rt",
    })

# Associate route table with public subnet
aws.ec2.RouteTableAssociation("public-rta",
    subnet_id=public_subnet.id,
    route_table_id=public_route_table.id)

# Create NAT Gateway for private subnet
elastic_ip = aws.ec2.Eip("nat-eip",
    vpc=True,
    tags={
        "Name": "pulumi-nat-eip",
    })

nat_gateway = aws.ec2.NatGateway("nat-gw",
    allocation_id=elastic_ip.id,
    subnet_id=public_subnet.id,
    tags={
        "Name": "pulumi-nat-gw",
    })

# Route table for private subnet
private_route_table = aws.ec2.RouteTable("private-rt",
    vpc_id=vpc.id,
    routes=[
        aws.ec2.RouteTableRouteArgs(
            cidr_block="0.0.0.0/0",
            nat_gateway_id=nat_gateway.id,
        )
    ],
    tags={
        "Name": "pulumi-private-rt",
    })

# Associate route table with private subnet
aws.ec2.RouteTableAssociation("private-rta",
    subnet_id=private_subnet.id,
    route_table_id=private_route_table.id)

# Export values
pulumi.export("vpc_id", vpc.id)
pulumi.export("public_subnet_id", public_subnet.id)
pulumi.export("private_subnet_id", private_subnet.id)
pulumi.export("internet_gateway_id", igw.id)
pulumi.export("nat_gateway_id", nat_gateway.id)
EOF

# Deploy (requires Pulumi cloud account or local backend)
# pulumi up
```

## 🔧 Configuration and Best Practices

### Terraform Configuration

```bash
# Create terraform configuration directory
mkdir -p ~/.terraform.d/plugins

# Configure Terraform CLI
cat > ~/.terraformrc << 'EOF'
plugin_cache_dir = "$HOME/.terraform.d/plugin-cache"
disable_checkpoint = true
EOF

mkdir -p ~/.terraform.d/plugin-cache

# Global Terraform aliases
cat >> ~/.bashrc << 'EOF'

# Terraform aliases
alias tf='terraform'
alias tfi='terraform init'
alias tfp='terraform plan'
alias tfa='terraform apply'
alias tfd='terraform destroy'
alias tfs='terraform show'
alias tfv='terraform validate'
alias tff='terraform fmt'

EOF
```

### Terraform CDK Configuration

```bash
# Configure CDK CLI
cat >> ~/.bashrc << 'EOF'

# Terraform CDK aliases
alias cdk='cdktf'
alias cdki='cdktf init'
alias cdkp='cdktf plan'
alias cdka='cdktf apply'
alias cdkd='cdktf destroy'
alias cdks='cdktf synth'

EOF
```

### Pulumi Configuration

```bash
# Configure Pulumi
pulumi login --local  # For local state management

# Global Pulumi aliases
cat >> ~/.bashrc << 'EOF'

# Pulumi aliases
alias pu='pulumi'
alias pup='pulumi preview'
alias puu='pulumi up'
alias pud='pulumi destroy'
alias pus='pulumi stack'
alias puconf='pulumi config'

EOF

source ~/.bashrc
```

## 🧪 Verification and Testing

### Create Verification Script

```bash
cat > ~/verify-iac-tools.sh << 'EOF'
#!/bin/bash

echo "🏗️ Infrastructure as Code Tools Verification"
echo "============================================"

# Terraform
echo -e "\n🔧 Terraform:"
if command -v terraform >/dev/null 2>&1; then
    terraform_version=$(terraform --version | head -1)
    echo "✅ $terraform_version"
    
    # Test basic functionality
    if terraform --help >/dev/null 2>&1; then
        echo "✅ Terraform CLI working"
    else
        echo "❌ Terraform CLI not working"
    fi
else
    echo "❌ Terraform not installed"
fi

# Terraform CDK
echo -e "\n📦 Terraform CDK:"
if command -v cdktf >/dev/null 2>&1; then
    cdktf_version=$(cdktf --version)
    echo "✅ CDK for Terraform: $cdktf_version"
else
    echo "❌ Terraform CDK not installed"
fi

# Pulumi
echo -e "\n🚀 Pulumi:"
if command -v pulumi >/dev/null 2>&1; then
    pulumi_version=$(pulumi version)
    echo "✅ $pulumi_version"
    
    # Check Pulumi backend
    backend=$(pulumi whoami 2>/dev/null || echo "not-logged-in")
    echo "Backend: $backend"
else
    echo "❌ Pulumi not installed"
fi

# Vault
echo -e "\n🔐 Vault:"
if command -v vault >/dev/null 2>&1; then
    vault_version=$(vault --version)
    echo "✅ $vault_version"
else
    echo "❌ Vault not installed"
fi

# Packer
echo -e "\n📦 Packer:"
if command -v packer >/dev/null 2>&1; then
    packer_version=$(packer --version)
    echo "✅ Packer $packer_version"
else
    echo "❌ Packer not installed"
fi

# AWS CLI (for cloud providers)
echo -e "\n☁️ Cloud CLIs:"
if command -v aws >/dev/null 2>&1; then
    aws_version=$(aws --version 2>&1 | cut -d' ' -f1)
    echo "✅ $aws_version"
else
    echo "❌ AWS CLI not installed"
fi

# Check for common providers
echo -e "\n📚 Provider Availability:"
providers=("aws" "google" "azurerm" "kubernetes")
for provider in "${providers[@]}"; do
    if find ~/.terraform.d/plugin-cache -name "*$provider*" 2>/dev/null | grep -q .; then
        echo "✅ $provider provider cached"
    else
        echo "ℹ️ $provider provider not cached (will download on first use)"
    fi
done

echo -e "\n✅ IaC Tools Verification Complete!"
EOF

chmod +x ~/verify-iac-tools.sh
~/verify-iac-tools.sh
```

## 🚀 Advanced Workflows

### Multi-Tool Comparison Project

```bash
# Create comparison project
mkdir iac-comparison && cd iac-comparison

# Create same infrastructure with all three tools
mkdir terraform terraform-cdk pulumi

echo "# IaC Tool Comparison

This project demonstrates creating the same AWS infrastructure using:
- Terraform (HCL)
- Terraform CDK (TypeScript)  
- Pulumi (Python)

## Infrastructure Components
- VPC with public and private subnets
- Internet Gateway
- NAT Gateway
- Route tables and associations
- Security groups

## Usage
\`\`\`bash
# Terraform
cd terraform && terraform init && terraform plan

# Terraform CDK
cd terraform-cdk && npm install && cdktf plan

# Pulumi
cd pulumi && pulumi up
\`\`\`

## Comparison

| Feature | Terraform | Terraform CDK | Pulumi |
|---------|-----------|---------------|--------|
| Language | HCL | TypeScript | Python |
| Type Safety | Limited | Full | Full |
| Loops/Logic | Limited | Full | Full |
| Ecosystem | Massive | Growing | Good |
| Learning Curve | Medium | Low | Low |
| State Management | Built-in | Built-in | Cloud/Local |
" > README.md
```

### Infrastructure Testing

```bash
# Create testing framework
cat > ~/test-infrastructure.sh << 'EOF'
#!/bin/bash

# Infrastructure testing script

test_terraform() {
    echo "🧪 Testing Terraform configuration..."
    
    if [ ! -f "main.tf" ]; then
        echo "❌ No main.tf found"
        return 1
    fi
    
    # Validate syntax
    if terraform validate; then
        echo "✅ Terraform syntax valid"
    else
        echo "❌ Terraform syntax invalid"
        return 1
    fi
    
    # Check formatting
    if terraform fmt -check; then
        echo "✅ Terraform formatting correct"
    else
        echo "⚠️ Terraform formatting needs fixing"
        terraform fmt
    fi
    
    # Security scan (if tfsec is installed)
    if command -v tfsec >/dev/null 2>&1; then
        tfsec .
    else
        echo "ℹ️ Install tfsec for security scanning: go install github.com/aquasecurity/tfsec/cmd/tfsec@latest"
    fi
}

test_cdktf() {
    echo "🧪 Testing Terraform CDK configuration..."
    
    if [ ! -f "package.json" ]; then
        echo "❌ No package.json found"
        return 1
    fi
    
    # Build
    if npm run build; then
        echo "✅ CDK build successful"
    else
        echo "❌ CDK build failed"
        return 1
    fi
    
    # Synthesize
    if cdktf synth; then
        echo "✅ CDK synthesis successful"
    else
        echo "❌ CDK synthesis failed"
        return 1
    fi
}

test_pulumi() {
    echo "🧪 Testing Pulumi configuration..."
    
    if [ ! -f "Pulumi.yaml" ]; then
        echo "❌ No Pulumi.yaml found"
        return 1
    fi
    
    # Preview
    if pulumi preview; then
        echo "✅ Pulumi preview successful"
    else
        echo "❌ Pulumi preview failed"
        return 1
    fi
}

case "$1" in
    terraform|tf)
        test_terraform
        ;;
    cdktf|cdk)
        test_cdktf
        ;;
    pulumi|pu)
        test_pulumi
        ;;
    all)
        test_terraform
        echo -e "\n"
        test_cdktf
        echo -e "\n"
        test_pulumi
        ;;
    *)
        echo "Usage: $0 {terraform|cdktf|pulumi|all}"
        ;;
esac
EOF

chmod +x ~/test-infrastructure.sh
```

## 📊 Resource Management

### State Management

```bash
# Create state management helper
cat > ~/manage-iac-state.sh << 'EOF'
#!/bin/bash

# State management for IaC tools

manage_terraform_state() {
    local action=$1
    
    case "$action" in
        backup)
            echo "📦 Backing up Terraform state..."
            cp terraform.tfstate terraform.tfstate.backup.$(date +%Y%m%d_%H%M%S)
            ;;
        restore)
            echo "🔄 Restoring Terraform state..."
            if [ -f "terraform.tfstate.backup" ]; then
                cp terraform.tfstate.backup terraform.tfstate
            else
                echo "❌ No backup found"
            fi
            ;;
        clean)
            echo "🧹 Cleaning Terraform cache..."
            rm -rf .terraform
            rm -f .terraform.lock.hcl
            ;;
        *)
            echo "Usage: manage_terraform_state {backup|restore|clean}"
            ;;
    esac
}

manage_pulumi_state() {
    local action=$1
    
    case "$action" in
        export)
            echo "📤 Exporting Pulumi state..."
            pulumi stack export --file state.json
            ;;
        import)
            echo "📥 Importing Pulumi state..."
            if [ -f "state.json" ]; then
                pulumi stack import --file state.json
            else
                echo "❌ No state.json found"
            fi
            ;;
        *)
            echo "Usage: manage_pulumi_state {export|import}"
            ;;
    esac
}

case "$1" in
    terraform)
        manage_terraform_state $2
        ;;
    pulumi)
        manage_pulumi_state $2
        ;;
    *)
        echo "Usage: $0 {terraform|pulumi} {action}"
        echo ""
        echo "Terraform actions: backup, restore, clean"
        echo "Pulumi actions: export, import"
        ;;
esac
EOF

chmod +x ~/manage-iac-state.sh
```

## 🔗 Integration with Other Tools

### VS Code Extensions

```bash
# Install VS Code extensions for IaC (if code-server is running)
if command -v code-server >/dev/null 2>&1; then
    echo "📦 Installing IaC VS Code extensions..."
    
    # Terraform
    code-server --install-extension hashicorp.terraform
    
    # Pulumi
    code-server --install-extension pulumi.pulumi-lsp
    
    # AWS
    code-server --install-extension amazonwebservices.aws-toolkit-vscode
    
    # Azure
    code-server --install-extension ms-vscode.vscode-azure-account
    
    # Google Cloud
    code-server --install-extension googlecloudtools.cloudcode
    
    echo "✅ IaC extensions installed"
fi
```

### Aliases and Functions

```bash
# Add comprehensive IaC aliases
cat >> ~/.bashrc << 'EOF'

# === Infrastructure as Code Aliases ===

# Terraform
alias tf='terraform'
alias tfi='terraform init'
alias tfiu='terraform init -upgrade'
alias tfp='terraform plan'
alias tfpo='terraform plan -out=tfplan'
alias tfa='terraform apply'
alias tfaa='terraform apply -auto-approve'
alias tfap='terraform apply tfplan'
alias tfd='terraform destroy'
alias tfda='terraform destroy -auto-approve'
alias tfs='terraform show'
alias tfss='terraform show -json'
alias tfv='terraform validate'
alias tff='terraform fmt'
alias tfr='terraform fmt -recursive'
alias tfo='terraform output'
alias tfoj='terraform output -json'
alias tfw='terraform workspace'
alias tfwl='terraform workspace list'
alias tfws='terraform workspace select'
alias tfwn='terraform workspace new'

# Terraform CDK
alias cdk='cdktf'
alias cdki='cdktf init'
alias cdkp='cdktf plan'
alias cdka='cdktf apply'
alias cdkaa='cdktf apply --auto-approve'
alias cdkd='cdktf destroy'
alias cdks='cdktf synth'
alias cdkv='cdktf validate'

# Pulumi
alias pu='pulumi'
alias pui='pulumi install'
alias pup='pulumi preview'
alias puu='pulumi up'
alias puuy='pulumi up --yes'
alias pud='pulumi destroy'
alias pudy='pulumi destroy --yes'
alias pus='pulumi stack'
alias pusl='pulumi stack ls'
alias pusn='pulumi stack select'
alias pusc='pulumi stack init'
alias pusr='pulumi stack rm'
alias puco='pulumi config'
alias pucos='pulumi config set'
alias pucog='pulumi config get'
alias puo='pulumi output'
alias puoj='pulumi output --json'

# Quick functions
terraform_init_apply() {
    terraform init && terraform plan && terraform apply
}

cdktf_build_apply() {
    npm run build && cdktf plan && cdktf apply
}

pulumi_quick_deploy() {
    pulumi preview && pulumi up --yes
}

alias tfia='terraform_init_apply'
alias cdkba='cdktf_build_apply'
alias puqd='pulumi_quick_deploy'

EOF

source ~/.bashrc
```

This comprehensive Infrastructure as Code setup provides:

1. **🏗️ Complete IaC Toolkit** - Terraform, Terraform CDK, and Pulumi
2. **📚 Working Examples** - Real-world infrastructure patterns
3. **🧪 Testing Framework** - Validation and testing scripts
4. **🔧 Configuration Management** - Best practices and automation
5. **📊 State Management** - Backup, restore, and migration tools
6. **🚀 Productivity Aliases** - Quick commands for daily workflows
7. **🔗 VS Code Integration** - Extensions and language support

All tools are production-ready with proper verification, testing, and management capabilities.