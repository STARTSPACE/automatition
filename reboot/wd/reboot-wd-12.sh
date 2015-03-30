# reboot_wd_xx.sh

# export AWS_ACCESS_KEY="Your-Access-Key"
# export AWS_SECRET_KEY="Your-Secret-Key"

today=`date +"%d-%m-%Y","%T"`
logfile="/var/log/automatition-instances.log"

# Grab all Instance IDs for REBOOT action and export the IDs to a text file
aws ec2 describe-instances --filters Name=tag:bash-reboottime,Values=12-00 Name=tag:bash-profile,Values=wd --query Reservations[*].Instances[*].[InstanceId] --output text > ~/tmp/reboot_wd_instance_info.txt

# Take list of rebooting instances
for instance_id in $(cat ~/tmp/reboot_wd_instance_info.txt)

do

# Reboot instances
rebootresult=$(aws ec2 reboot-instances --instance-ids $instance_id)

# Put info into log file
echo Atempt to reboot $today instances by AWS CLI with result $rebootresult --EMPTY FOR NO RESULT-- >> $logfile
done
