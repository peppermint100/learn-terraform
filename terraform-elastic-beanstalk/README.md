## Resources

### Requirements
- RDS
- SG For RDS
- IAM
- WAS
- VPC
- 
```
vpc, iam, was file은 이미 생성이 되어 있다고 가정하여, resouce 대신 data 이용
```

### Security Groups
- SG for Load Balancer
- SG for Elastic Beanstalk EC2 Instances

### Load Balancer
- Application Load Balancer for Shared LB Configuration

### Target Group
- Connect Elastic Beanstalk With Load Balancer
- Health Check
```
elsatic beanstalk에 shared load balancer를 연결하면 자동으로 target group을
생성해준다. 하지만 terraform의 elastic beanstalk data에서 해당 target group의
arn을 알아낼 방법이 없어, target group을 새로 생성해주고 manual하게 load balancer
에 등록해주어야 한다.
```

### Elastic Beanstalk
- Platform
- Security Group
- Shared Load Balancer
- VPC 
- Instance Min, Max
- Instance Type
- Rolling
- Enhanced Health Reporting
- Notification Email
