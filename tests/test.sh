#!/bin/sh
SITE=test.yml
ansible-galaxy install ajsalminen.httpd_site
ansible-playbook -i $INVENTORY tests/$SITE --syntax-check
ansible-playbook -i $INVENTORY tests/$SITE --connection=local --become
  # Rerun for idempotency check.
ansible-playbook -i $INVENTORY tests/$SITE --connection=local --become \
| grep -q 'changed=0.*failed=0' \
&& (echo 'Idempotence test: pass' && exit 0) \
|| (echo 'Idempotence test: fail' && exit 1)
