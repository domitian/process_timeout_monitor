# author surendra
# email: bobba.surendra@gmail.com

# This program starts a program and kills it after specific time

use Proc::ProcessTable;

my $process_object = new Proc::ProcessTable;
my $process_alive = 0;
my $time_allowed = 10;
$pid = fork();

if ($pid == 0){
	`./testing`;
	exit();
}
print "this is parent process";
while($process_alive == "0"){
	my $check_for_child_process = 0;
	sleep 1;
	print "waking up after 1 seconds to check to kill the child process or not\n";
	foreach $p (@{$process_object->table()}){
		if ($p->fname =~ /testing/){
			$check_for_child_process = 1;
			my $memory = $p->size/(1024*1024);
			my $time = time() - $p->start;
			print "the memory used by process is $memory Mb\n"; 
			print "the time is $time";
			if($time > 10){
				$p->kill(9);
				print "i the parent killed child\n";
				$process_alive = 1;
			}
			else{
				print "not yet killing\n";
			}
		}
	}
	if ($check_for_child_process == "0" and $process_alive == "0"){
		print "the child killed itself so breaking away from loop\n";
		$process_alive = 1;
	}
}

