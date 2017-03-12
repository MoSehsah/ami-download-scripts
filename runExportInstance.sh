# run instance and get json output
instance=$(aws ec2 run-instances \
  --image-id ami-6197aa16 \
  --key-name MyKeyPair \
  --instance-type t2.micro \
  --query Instances[0]
  )

#define query function
query() {
  jp -u "$2" <<<"$1"
}

#get instance_id
instance_id=$(query "$instance" InstanceId)

echo $instance_id

#loop untill instance is running
while state=$(aws ec2 describe-instances --instance-ids $instance_id --output text --query 'Reservations[*].Instances[*].State.Name'); test "$state" = "pending"; do
  sleep 1; echo -n '.'
done; echo " $state"

#Stop Instance

aws ec2 stop-instances --instance-ids $instance_id


#loop untill instance is stopped
while state=$(aws ec2 describe-instances --instance-ids $instance_id --output text --query 'Reservations[*].Instances[*].State.Name'); test "$state" = "stopping"; do
  sleep 1; echo -n '.'
done; echo " $state"


exportTask=$(aws ec2 create-instance-export-task --instance-id $instance_id --target-environment vmware \
--export-to-s3-task DiskImageFormat=VMDK,ContainerFormat=ova,S3Bucket=automatic-aws-export,S3Prefix=tibcoexport)

exportTaskId=$(query "$exportTask" ExportTaskId)
