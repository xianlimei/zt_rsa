# Setup actions for Xilinx/AWS runtime stage, should be run for any new shell.

# Script must be sourced from a bash shell or it will not work
# When being sourced $0 will be the interactive shell and $BASH_SOURCE_ will contain the script being sourced
# When being run $0 and $_ will be the same.
script=${BASH_SOURCE[0]}
if [ $script == $0 ]; then
    echo "ERROR: You must source this script"
    exit 2
fi

# source /opt/Xilinx/SDx/2018.3.op2405991/settings64.sh
# reinstallation and setting XRT for 2018.2-built XCLBIN on 2018.3-instance
export VIVADO_TOOL_VERSION=2018.2
# reinstallation itself is commented as needed only once on 2018.3-instance
# if [ $USER != "root" ]; then
#   echo "This will reinstall XRT to 2018.2 compliant with built XCLBIN kernel"
#   echo "(https://github.com/aws/aws-fpga/blob/master/SDAccel/docs/XRT_installation_instructions.md)"
#   read -p "Press [Enter] if agree, [Ctrl-C] otherwise"
#   curl -s https://s3.amazonaws.com/aws-fpga-developer-ami/1.5.0/Patches/XRT_2018_2_XDF_RC5/xrt_201802.2.1.0_7.5.1804-xrt.rpm -o xrt_201802.2.1.0_7.5.1804-xrt.rpm
#   curl -s https://s3.amazonaws.com/aws-fpga-developer-ami/1.5.0/Patches/XRT_2018_2_XDF_RC5/xrt_201802.2.1.0_7.5.1804-aws.rpm -o xrt_201802.2.1.0_7.5.1804-aws.rpm
#   sudo yum remove -y xrt-aws
#   sudo yum remove -y xrt
#   sudo yum install -y xrt_201802.2.1.0_7.5.1804-xrt.rpm
#   sudo yum install -y xrt_201802.2.1.0_7.5.1804-aws.rpm
#   rm xrt_201802.2.1.0_7.5.1804-xrt.rpm
#   rm xrt_201802.2.1.0_7.5.1804-aws.rpm
# fi

if [[ -z "$AWS_FPGA_REPO_DIR" ]]; then
	export AWS_FPGA_REPO_DIR=/home/centos/src/project_data/aws-fpga
	echo "AWS_FPGA_REPO_DIR is not set, setting it to $AWS_FPGA_REPO_DIR location by default (meaning runtime on AWS F1 instance)."
	echo "In case AWS FPGA tools location is different, please set it accordingly:"
	echo "export AWS_FPGA_REPO_DIR=$AWS_FPGA_REPO_DIR"
	echo "And clone AWS FPGA tools there as follows:"
	echo "git clone --recurse-submodules https://github.com/aws/aws-fpga.git \$AWS_FPGA_REPO_DIR"
fi
echo "AWS_FPGA_REPO_DIR is set to $AWS_FPGA_REPO_DIR"


if [ $USER = "root" ]; then
# Activation of XRT (Xilinx/AWS runtime)
source $AWS_FPGA_REPO_DIR/sdaccel_runtime_setup.sh
# Alternative way to activate Xilinx/AWS runtime: using XRT, pre-installed separtely on AWS F1 development AMI.
# It could be outdated comparing with AWS github repo.
# source /opt/xilinx/xrt/setup.sh
fi

export AWS_PLATFORM=/home/centos/src/project_data/aws-fpga/SDAccel/aws_platform/xilinx_aws-vu9p-f1-04261818_dynamic_5_0/xilinx_aws-vu9p-f1-04261818_dynamic_5_0.xpfm

export OPENSSL_DIR=/home/centos/src/project_data/openssl
echo "OPENSSL_DIR, needed for OpenSSL use cases of RSA accelerator, is set to $OPENSSL_DIR."
