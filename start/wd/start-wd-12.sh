# export AWS_ACCESS_KEY="Your-Access-Key"
# export AWS_SECRET_KEY="Your-Secret-Key"

today=`date +"%d-%m-%Y","%T"`
logfile="/awslog/automation-instances.log"

# Grab all Instance IDs for REBOOT action and export the IDs to a text file
sudo aws ec2 describe-instances --filters Name=tag:start-time,Values=12-00 Name=tag:bash-profile,Values=wd --query Reservations[*].Instances[*].[InstanceId] --output text > ~/tmp/start_wd_instance_info.txt 2>&1

# Take list of rebooting instances
for instance_id in $(cat ~/tmp/start_wd_instance_info.txt)

do

# Reboot instances
rebootresult=$(sudo aws ec2 start-instances --instance-ids $instance_id)

# Put info into log file
echo Atempt to start $today instances by AWS CLI with result $rebootresult --EMPTY FOR NO RESULT-- >> $logfile
done
