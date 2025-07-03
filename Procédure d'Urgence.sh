aws iam put-user-policy --user-name app_user \
--policy-name EMERGENCY_LOCKDOWN \
--policy-document '{"Version":"2012-10-17","Statement":[{"Effect":"Deny","Action":"*","Resource":"*"}]}'