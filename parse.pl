use warnings;
use HTML::TableExtract;
use XML::Writer;
use IO::File;

my $outputFile;
sub main {

     usage() if ( $#ARGV + 1 <= 1);
     
     my $s = readDumpFile($ARGV[0]);
     $outputFile = $ARGV[1];
     $s =~ s!.+(<div onmouseout.+?<script).+!$1!s;
     @parsed = (parseHtml($s));
     output(@parsed);
}

sub usage {
    print "\nUsage: parse.pl dump_file output_file\n";
    exit;
}

sub parseHtml {
   my @r;	
   my ($html) = @_;
   my $te = HTML::TableExtract->new(keep_html=>1, br_translate=>0);
   $te->parse($html);

   foreach my $ts ($te->table_states ) {
       my @rows = $ts->rows;
       foreach (@rows) {
            foreach (@$_) {
                my $s = "$1|$2|$3|$4|$5\n" if ($_ and  $_ =~ m!pvm=(\d+).+<b>(.+?)<br/>(.+?)</b>(.+)</font>.+</b>(.+?)(?:</|$)!);
		next  if (!$s);
                $s =~ s!<br/>! !g;
		push @r, $s;
	    }
      }
   }
  return sort @r;
}

sub readDumpFile {
    my ($file) = @_;
    my $s = do {
       local $/ = undef;
       open my $handle, '<', $file
	  or die "can't open $file: $!";
       <$handle>;
    };
   return $s;
}

sub output {
  
   my $writer = XML::Writer->new(OUTPUT => 'self', NEWLINES => 0);
   my $element; 

   $writer->startTag("week");
  my $i;
   while ($#_ + 1) {
     
       $element = $_[0];
       my $code = substr $element, 0, 6;
       $writer->startTag("day", name => ++$i, 
		year => "20".substr( $code, 0, 2), 
		month => substr( $code, 2, 2), 
                date => substr( $code, 4, 2));
       my @daysClasses = grep(/^$code/, @_);
       for my $e (@daysClasses) {
           $writer->startTag("class");
           $writer->startTag("time");
           my @vals = split(/\|/, $e);
           $writer->characters($vals[1] );
           $writer->endTag("time");
           $writer->startTag("subject");
           $writer->characters($vals[2]);
           $writer->endTag("subject");
           $writer->startTag("room");
           $writer->characters($vals[3]);
           $writer->endTag("room");
           $writer->startTag("teacher");
           chomp $vals[4];
           $writer->characters($vals[4]);
           $writer->endTag("teacher");
           $element = shift @_;
           $writer->endTag("class");
       }

       $writer->endTag("day");
   }
   $writer->endTag("week");
   $writer->end();
   open FH, ">$outputFile" or die("Can't open $outputFile $!");
   print FH $writer->to_string;
   close FH;
   
}

main();
