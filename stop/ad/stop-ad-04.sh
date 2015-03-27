# stop_ad_xx.sh

# export AWS_ACCESS_KEY="Your-Access-Key"
# export AWS_SECRET_KEY="Your-Secret-Key"

today=`date +"%d-%m-%Y","%T"`
logfile="/var/log/automatition-instances.log"

# Grab all Instance IDs for STOP action and export the IDs to a text file
aws ec2 describe-instances --filters Name=tag:bash-stoptime,Values=04-00 Name=tag:bash-profile,Values=ad --query Reservations[*].Instances[*].[InstanceId] --output text > /tmp/stop_ad_instance_info.txt

# Take list of stoping instances
for instance_id in $(cat /tmp/stop_ad_instance_info.txt)

do

# Stop instances
stopresult=$(aws ec2 stop-instances --instance-ids $instance_id)

# Put info into log file
echo Atempt to stop $today instances by AWS CLI with result $stoptresult --EMPTY FOR NO RESULT-- >> $logfile
done
