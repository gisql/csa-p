#!/usr/bin/env bash

rm -f terraform.tfstate all.tf

for i in alb asg cwa dbpg dbsg dbsn ec2 ecc ecsn efs eip elb iamg iamgm iamgp iamip iamp iampa iamr iamrp iamu iamup igw kmsa kmsk lc \
        nacl nat nif r53r r53z rds rs rt rta s3 sg sn snss snst sqs vgw vpc; do
    terraforming ${i} >> all.tf
done

