ipsec auto --up west-east
# state #1(STATE_PARENT_I3), #2, #3, #4, and #5
ipsec status | grep STATE_
ipsec whack --rekey-ipsec --name west-east/1x0
ipsec whack --rekey-ipsec --name west-east/2x0
ipsec whack --rekey-ipsec --name west-east/3x0
ipsec whack --rekey-ipsec --name west-east/4x0
sleep 45
# state #1(STATE_PARENT_I3) #6, #7, #8  and #9 in STATE_V2_IPSEC_I
# anything other state is a sign of regression
ipsec status | grep STATE_
# this is complex grep line susceptible to changes to log lines.
# until we find better one keep this.
# May be once the bug is fixed comment it out?
grep -E  "Message ID:|emit IKEv2 Delete Payload|exchange type:|**emit ISAKMP Message|**parse ISAKMP Message" /tmp/pluto.log
echo done
