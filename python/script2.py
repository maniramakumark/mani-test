#Write a python script to list all S3 buckets which have public access.

import boto3

def check_public_buckets(name):
    try:
        response_acl = s3.get_bucket_acl(Bucket=name)
        grants_acl = response_acl.get('Grants', [])
        for grant in grants_acl:
            grantee = grant.get('Grantee', {})
            permission = grant.get('Permission', '')

            if (
                grantee.get('Type') == 'Group' and
                grantee.get('URI') == 'http://acs.amazonaws.com/groups/global/AllUsers' and
                permission == 'READ'
            ):
                return True
        try:
            policy_status = s3.get_bucket_policy_status(Bucket=name)
            if policy_status['PolicyStatus']['IsPublic']:
                return True
        except NoSuchBucketPolicy:
            pass
    except Exception as e:
        print("Error checking public access ")

    return False


s3 = boto3.client('s3')
all_buckets = s3.list_buckets()
buckets = all_buckets.get('Buckets', [])
for bucket in buckets:
    if check_public_buckets(bucket['Name']):
        print(bucket['Name'])
#    else:
#        print("No")
#if check_public_buckets('ci-transactions-data'):
#    print('ci-transactions-data')
        

