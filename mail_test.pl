use strict;
use warnings;
use utf8;
use MIME::Lite;
use Encode qw(encode);

&sendMail('Title test', 'Body test'); # Title, Body
print "Done\n";

sub sendMail {
	my ($send_subject, $send_body) = @_;
	
	# Sender, Destination, Cc
	my $send_from    = '<mail>';
	my $send_to      = '<mail>';
	my $send_cc      = '<mail>';

	# SMTP information
	my $host         = '<SMTP Host>';
	my $user         = '<User>';
	my $pass         = '<Password>';

	my $msg = MIME::Lite->new (
		From    => $send_from,
		To      => $send_to,
		Cc      => $send_cc,
		Subject => encode( 'MIME-Header', $send_subject ),
		Type    => 'multipart/mixed',
	);

	$msg->attach (
		Type => 'TEXT',
		Data => Encode::encode( 'utf8', $send_body ),
	);
	
	MIME::Lite->send (
		'smtp',
		$host, 
		Timeout  => 60, 
		AuthUser => $user, 
		AuthPass => $pass, 
	);

	$msg->send;
}
