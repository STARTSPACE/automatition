# start_wd_xx.sh

# export AWS_ACCESS_KEY="Your-Access-Key"
# export AWS_SECRET_KEY="Your-Secret-Key"

today=`date +"%d-%m-%Y","%T"`
logfile="/var/log/automatition-instances.log"

# Grab all Instance IDs for START action and export the IDs to a text file
aws ec2 describe-instances --filters Name=tag:bash-starttime,Values=18-00 Name=tag:bash-profile,Values=wd --query Reservations[*].Instances[*].[InstanceId] --output text > ~/tmp/start_wd_instance_info.txt

# Take list of starting instances
for instance_id in $(cat ~/tmp/start_wd_instance_info.txt)

do

# Start instances
startresult=$(aws ec2 start-instances --instance-ids $instance_id)

# Put info into log file
echo Atempt to start $today instances by AWS CLI with result $startresult --EMPTY FOR NO RESULT-- >> $logfile
done
