# need to install processtable.pm module for perl which is 141 kb
# tutorial from http://docstore.mik.ua/orelly/perl/sysadmin/ch04_03.htm and methods from http://search.cpan.org/~jwb/Proc-ProcessTable-0.51/Process/Process.pm
use Proc::ProcessTable;

$proc_obj = new Proc::ProcessTable;

@proc_table = $proc_obj->table( );

foreach $p (@{$proc_obj->table()}){
	if ($p->fname =~ /testing/){
		my $proc_time = $p->start-time();
		my $proc_pid = $p->pid;
		my $proc_memory = $p->size;
		#converting to kb and mb
		$proc_memory = $proc_memory/(1024*1024);
		print "proc time is $proc_time";
		print "virtual memory used is $proc_memory";
		$p->kill(9);
	}
}
