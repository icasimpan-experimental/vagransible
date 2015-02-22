roles:
	ansible-playbook -v -i ansible.ini -l local install.yml

clean:
	vagrant destroy -f
	rm -rf roles

centos: roles
	vagrant up --no-provision centos6
	vagrant provision centos6
	
coreos: roles
	vagrant up --no-provision coreos
	vagrant provision coreos

ubuntu: roles
	vagrant up --no-provision ubuntu14
	vagrant provision ubuntu14
	
test:
	ansible-playbook --private-key=vagrant.rsa -i ansible.ini -l all playbooks/test_java.yml

all: roles centos ubuntu coreos test


vagrant-vmware-fusion:
	vagrant plugin install vagrant-vmware-fusion
	vagrant plugin license vagrant-vmware-fusion ~/Downloads/license.lic

vb_centos: roles
	vagrant up --no-provision centos6 --provider virtualbox
	vagrant provision centos6
	
vb_coreos: roles
	vagrant up --no-provision coreos --provider virtualbox
	vagrant provision coreos

vb_ubuntu: roles
	vagrant up --no-provision ubuntu14 --provider virtualbox
	vagrant provision ubuntu14
	
virtualbox: roles vb_centos vb_ubuntu vb_coreos test
	
vm_centos: roles
	vagrant up --no-provision centos6 --provider vmware_fusion
	vagrant provision centos6
	
vm_coreos: roles
	vagrant up --no-provision coreos --provider vmware_fusion
	vagrant provision coreos

vm_ubuntu: roles
	vagrant up --no-provision ubuntu14 --provider vmware_fusion
	vagrant provision ubuntu14
	
vmware: roles vm_centos vm_ubuntu vm_coreos test
