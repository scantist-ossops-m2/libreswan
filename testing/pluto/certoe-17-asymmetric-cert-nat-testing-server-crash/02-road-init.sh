/testing/guestbin/swan-prep --x509
ipsec certutil -D -n east
cp policies/* /etc/ipsec.d/policies/
echo "192.1.2.0/24"  >> /etc/ipsec.d/policies/private-or-clear
ipsec start
../../guestbin/wait-until-pluto-started
ipsec whack --impair suppress-retransmits

# give OE policies time to load
../../guestbin/wait-for.sh --match 'loaded 2' -- ipsec auto --status

# establish a baseline: one trap, no state and nothing up
../../guestbin/ipsec-kernel-policy.sh
../../guestbin/ipsec-kernel-state.sh
ipsec whack --trafficstatus
ipsec whack --shuntstatus
echo "initdone"
