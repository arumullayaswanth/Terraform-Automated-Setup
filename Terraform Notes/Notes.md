# <span style="color: #FF5733;">Terraform</span>

---

### <span style="color: #3498DB;">What Is Terraform?</span>  
Terraform is an IAC tool, used primarily by DevOps teams to automate various infrastructure tasks. The provisioning of cloud resources, for instance, is one of the main use cases of Terraform. It’s a cloud-agnostic, open-source provisioning tool written in the Go language and created by HashiCorp.  

Terraform allows you to describe your complete infrastructure in the form of code. Even if your servers come from different providers such as AWS or Azure, Terraform helps you build and manage these resources in parallel across providers. Think of Terraform as connective tissue and common language that you can utilize to manage your entire IT stack.  

---

### <span style="color: #2ECC71; text-decoration: underline;">Benefits of Infrastructure-as-Code (IaC)</span>  

IaC replaces standard operating procedures and manual effort required for IT resource management with lines of code. Instead of manually configuring cloud nodes or physical hardware, IaC automates the process infrastructure management through source code.  

Here are several of the major key benefits of using an IaC solution like Terraform:  

- **<span style="color: #E74C3C;">Speed and Simplicity.</span>** IaC eliminates manual processes, thereby accelerating the delivery and management lifecycles. IaC makes it possible to spin up an entire infrastructure architecture by simply running a script.  
- **<span style="color: #9B59B6;">Team Collaboration.</span>** Various team members can collaborate on IaC software in the same way they would with regular application code through tools like Github. Code can be easily linked to issue tracking systems for future use and reference.  
- **<span style="color: #F39C12;">Error Reduction.</span>** IaC minimizes the probability of errors or deviations when provisioning your infrastructure. The code completely standardizes your setup, allowing applications to run smoothly and error-free without the constant need for admin oversight.  
- **<span style="color: #1ABC9C;">Disaster Recovery.</span>** With IaC you can actually recover from disasters more rapidly. Because manually constructed infrastructure needs to be manually rebuilt. But with IaC, you can usually just re-run scripts and have the exact same software provisioned again.  
- **<span style="color: #E67E22;">Enhanced Security.</span>** IaC relies on automation that removes many security risks associated with human error. When an IaC-based solution is installed correctly, the overall security of your computing architecture and associated data improves massively.

<!-- terraform-structure.md -->

<h2 style="color:#4CAF50;">Basic Terraform Folder Structure 🌿</h2>

<pre>
projectname/
    |
    |-- provider.tf
    |-- version.tf
    |-- backend.tf
    |-- main.tf
    |-- variables.tf
    |-- terraform.tfvars
    |-- outputs.tf
</pre>



## <span style="color: #33FF57; font-style: italic;">Give Terraform Files Logical Names</span>

Terraform tutorials online often demonstrate a directory structure consisting of three files: 

- **main.tf**: contains all providers, resources and data sources  
- **variables.tf**: contains all defined variables  
- **output.tf**: contains all output resources  

The issue with this structure is that most logic is stored in the single main.tf file which therefore becomes pretty complex and long. Terraform, however, does not mandate this structure, it only requires a directory of Terraform files. Since the filenames do not matter to Terraform I propose to use a structure that enables users to quickly understand the code. Personally I prefer the following structure:

- **provider.tf**: contains the terraform block and provider block  
- **data.tf**: contains all data sources  
- **variables.tf**: contains all defined variables  
- **locals.tf**: contains all local variables  
- **output.tf**: contains all output resources  

---

# <span style="color: #3357FF; text-decoration: underline;">Important Terraform Commands</span>

## <span style="color: #FF33F5; background-color: #F0F0F0; padding: 3px;">Version</span>

`terraform –version`  
Shows terraform version installed  

## <span style="color: #33FFF5; border-bottom: 2px solid #33FFF5;">Initialize Infrastructure</span>

`terraform init`  
Initialize a working directory  

`terraform init -input=true`  
Ask for input if necessary  

`terraform init -lock=false`  
Disable locking of state files during state-related operations  

`terraform plan`  
Creates an execution plan (dry run)  

`terraform apply`  
Executes changes to the actual environment  

`terraform apply –auto-approve`  
Apply changes without being prompted to enter "yes"  

`terraform destroy –auto-approve`  
Destroy/cleanup without being prompted to enter "yes"  

## <span style="color: #F5FF33; font-weight: bold;">Terraform Workspaces</span>

`terraform workspace new`  
Create a new workspace and select it  

`terraform workspace select`  
Select an existing workspace  

`terraform workspace list`  
List the existing workspaces  

`terraform workspace show`  
Show the name of the current workspace  

`terraform workspace delete`  
Delete an empty workspace  

## <span style="color: #8A2BE2;">Terraform Import</span>

`terraform import aws_instance.example i-abcd1234(instance id)`  
#import an AWS instance with ID i-abcd1234 into aws_instance resource named "foo"

---

# <span style="color: #FF4500; font-family: monospace;">Statefile</span>

## <span style="color: #DC143C;">What is state and why is it important in Terraform?</span>

> "Terraform must store state about your managed infrastructure and configuration. This state is used by Terraform to map real world resources to your configuration, keep track of metadata, and to improve performance for large infrastructures. This state file is extremely important; it maps various resource metadata to actual resource IDs so that Terraform knows what it is managing. This file must be saved and distributed to anyone who might run Terraform."

## <span style="color: #228B22;">Remote State:</span>

> "By default, Terraform stores state locally in a file named terraform.tfstate. When working with Terraform in a team, use of a local file makes Terraform usage complicated because each user must make sure they always have the latest state data before running Terraform and make sure that nobody else runs Terraform at the same time."

> "With remote state, Terraform writes the state data to a remote data store, which can then be shared between all members of a team."


# <span style="color: #FF5733;">State Lock</span>

> "If supported by your backend, Terraform will lock your state for all operations that could write state. This prevents others from acquiring the lock and potentially corrupting your state."

> "State locking happens automatically on all operations that could write state. You won't see any message that it is happening. If state locking fails, Terraform will not continue. You can disable state locking for most commands with the -lock flag but it is not recommended."

---

# <span style="color: #33FF57; background-color: #F0F0F0; padding: 3px;">Setting up our S3 Backend</span>

Create a new file in your working directory labeled `backend.tf`

```hcl
terraform {
  backend "s3" {
    encrypt        = true    
    bucket         = "sample"
    dynamodb_table = "terraform-state-lock-dynamo"
    key            = "terraform.tfstate"
    region         = "us-east-1"
  }
}
