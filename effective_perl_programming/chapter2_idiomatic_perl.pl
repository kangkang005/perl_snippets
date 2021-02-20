#!/usr/bin/env perl
# {
    # @comment: 
    my $run = 0;
    if ($run) {
      # swap $a and $b
      ($a,$b) = ($b,$a);

      # read line from files or standard input
      #   and print them out in sorted order
      print sort <>;

      # NOTE
      # print all the lines containing the word joebloe
      print grep /\bjoebloe\b/, <>;
      # or equaivalently:
      print grep(/\bjoebloe\b/, <>);

      # copy all the numbers in @n evenly
      #   divisiable by 5 int @div5
      my @div5 = grep {not $_%5} @n; 

      # one way of turning "123.234.0.1"
      # into the integer 0xb7ae0010
      $bin_addr = pack 'C4',split /\./, $str_addr;

      # print key-value pairs from %h one per line
      foreach my $key (sort keys %h) {
        print "$key: $h{$key}\n";
      }

      # another way to print key-value pairs
      print map "$_: $h{$_}\n", sort keys %h;
    }
# }
    
# @item 15 : use $_ for elegance and brevity
# @comment: a reference is a scalar value
# {
  # {
    # NOTE
    # @title: 
    # @comment: 
    my $run = 0;
    if ($run) {
      # $_ as a default argument
      print $_; # default argument for print
      print ; # ... same thing

      print "found it"
        if $_ =~ /Rosebud/; # matches and substitution
      print "found it"
        if /Rosebud/; # same thing

      $mod_time = -M $_;  # most filehandle tests
      $mod_time = -M;     # same thing

      foreach $_ (@list) {do_something($_)} # foreach
      foreach (@list) {do_something($_)}    # some thing

      while (defined($_=<STDIN>)) {
        # while: a special case
        print $_;
      }

      while (<STDIN>) { print } # same thing
    }
    # output {
      # --------------------
    # }
  # }
  
  # {
    # @title: $_ and the main package
    # @comment: before Perl 5.10, $_ was always in the package main
    my $run = 0;
    if ($run) {
      package foo;
      $_ = "ok\n"; # this still means $main::_

      package main;
      print; # prints "ok"
    }
    # output {
      # --------------------
    # }
  # }
  
  # {
    # @title: localizing $_
    # @comment: before Perl 5.10, you could only localize $_ with local.
    my $run = 0;
    if ($run) {
      { 
        local $_;
        # .. do stuff with your version of $_
        some_sub(); # uses your $_
      }

      # as of perl 5.10, you can have a lexical $_ so that your changes affect only
      #   the code that's in scope, and nothing outside that scope can see it.
      {
        # my $_;
        # .. do stuff with your version of $_
        some_sub(); # uses your $_
      }
    }
    # output {
      # --------------------
    # }
  # }
  
  # {
    # NOTE
    # @title: programming style and $_
    # @comment: 
    my $run = 0;
    if ($run) {
      while (<>) {
        foreach (split) { #2 and 3
          $w5++ if /^\w{5}$/ # 4
        }
      }
      # find files ending in .txt and less than 5000 bytes long
      @small_txt = 
        grep {/\.txt/ and (-s) < 5000} @files; # 5 and 6

      while (defined($line = <STDIN>)) {
        print $line if $line =~ /Perl/;
      }
      while (<STDIN>) {print if /Perl/};
    }
    # output {
      # --------------------
    # }
  # }
# }
  
# @item 16 : know Perl's other default argument
# @comment: 
# {
  # {
    # @title: @_ as a default
    # @comment: when you shift with no arguments in yout subroutine, you are really
    #           pulling thee left-most element from @_;
    my $run = 0;
    if ($run) {
      sub foo {
        my $x = shift;
        # ...
      }

      my @a = @{shift()};
      my @a = @{+shift};
    }
    # output {
      # --------------------
    # }
  # }
  
  # {
    # NOTE
    # @title: @ARGV as a default
    # @comment: outside of a subroutines, shift uses @ARGV as its default
    my $run = 0;
    if ($run) {
      foreach (shift) {
        if (/^-(.*)/) {
          process_option($1);
        } else {
          process_file($_);
        }
      }
    }
    # output {
      # --------------------
    # }
  # }
  
  # {
    # @title: STDIN as a default
    # @comment: unlike the rest of the file-test operatiors, which use $_ as a default,
    #           the -t operator uses the filehandle STDIN as a default
    my $run = 0;
    if ($run) {
      print "You're alive!" if -t STDIN;
      print "You're alive!" if -t;

      my $char = getc STDIN;
      my $char = getc ;
    }
    # output {
      # --------------------
    # }
  # }
# }
  
# @item 17 : know common shorthand and syntax quirks
# @comment: 
# {
  # {
    # NOTE
    # @title: swap values with list assignments
    # @comment: 
    my $run = 0;
    if ($run) {
      ($a,$b) = ($b,$a); # swap $a and $B
      ($c,$a,$b) = ($a,$b,$c); # rotate $a, $b and $c
      @a[1,3,5] = @a[5,3,1]; # shuffle some elements
      # you can rearrange the indices so you swap the even-and odd-numbered elements in an array
      @a[map{$_*2+1,$_*2} 0 .. ($#a/2)] = @2;
    }
    # output {
      # --------------------
    # }
  # }
  
  # {
    # NOTE
    # @title: force a list context with [] or ()[]
    # @comment: 
    my $run = 1;
    if ($run) {
      # split $_ on + up to :
      $_ = "key value1+value2";
      my ($str) = /([^:]*)/;
      my @words = split /\+/, $str;
      print "$str\n";
      print "@words\n";
      my $str = /([^:]*)/;
      print "$str\n";

      # to write this in a single expression without the use of the temporary $str,
      #   you have to resort to trickery, since the pattern match would not return the 
      #   right kind of value in the scalar context imposed by split. The inside of a 
      #   literal slice is in list context:
      my @words = split /\+/, (/([^:]*)/)[0];

      # NOTE
      # if you want to take are reference to a list literal in a single step, 
      #   use the anonymous array constructor []
      $str = "key value1+value2";
      my $wordlist_ref = [split /\++/,$str];
      print "$wordlist_ref\n";
      print "@$wordlist_ref\n";
    }
    # output {
      # --------------------
      # key value1+value2
      # key value1 value2
      # 1
      # ARRAY(0x560029ae7580)
      # key value1 value2
    # }
  # }
  
  # {
    # @title: use => to make key-value pairs
    # @comment: the => (fat away) operator is a synonym for the comma operator
    my $run = 0;
    if ($run) {
      my %elements = {
        'Ag' => 47,
        'Au' => 79,
        'Pt' => 78,
      };
      # it's a little nicer when you don't have to quote the keys
      my %elements = {
        Ag => 47,
        Au => 79,
        Pt => 78,
      };
      # NOTE
      my %elements = qw(
        Ag 47
        Au 79
        Pt 78
      );
    }
    # output {
      # --------------------
    # }
  # }
  
  # {
    # @title: use the => operator to simulate named parameters
    # @comment: %params has a default value for align:
    my $run = 0;
    if ($run) {
      sub img {
        # NOTE
        my %params = (align => 'middle',@_);
        print "$params{align}\n";
        print "$params{src}\n";
        # write out the keys and values of the hash as an HTML tag
        print "<img ",
          (
            join ' ', map{ "$_=\"$params{$_}\""}
              keys %params
          ),
          ">";
      }
      img(src=>'icon.gif',align=>'top');
      # <img src="icon.gif" align="top">
    }
    # output {
      # --------------------
      # <img src="icon.gif" align="top">
    # }
  # }
  
  # {
    # @title: use => to show direction
    # @comment: 
    my $run = 0;
    if ($run) {
      rename "$file.c"=>"$file.c.old";
    }
    # output {
      # --------------------
    # }
  # }
  
  # {
    # @title: watch what you put inside {}
    # @comment: 
    my $run = 0;
    if ($run) {
      sub func_returning_aryref {
        my @ary = qw(87 90);
        return \@ary;
      }
      # these uses do what you probably mean, since you give Perl a hint that
      #   func_returning_aryref is a subroutine name:
      my @a = @{func_returning_aryref()}; # parenthese
      print "@a\n";
      my @a = @{&func_returning_aryref}; # ampersand
      my @a = @{+func_returning_aryref}; # unary plus
      my $hashref = eval {
        return {key_value_pairs()} # ok
      };
      my $hashref = eval {
        +{key_value_pairs()}
      };
    }
    # output {
      # --------------------
    # }
  # }
  
  # {
    # @title: use @{[]} or eval {} to make a copy of a list
    # @comment: 
    my $run = 0;
    if ($run) {
      # sometimes you may want to perform a destructive operation on a copy
      #   of a list rather than on the original. For instance, if you want to
      #   find which .h files that are missing, you can change the names of the
      #   .c files to .h files and check which ones exist:
      my @cfiles_copy = @cfiles;
      my @missing_h = 
        grep {s/\.c$/\.h/ and not !-e } @{[@cfiles_copy]};

      # perl doesn't give you a function for making copies of things, but if you
      #   need to make an unnamed copy of a list, you can put the list inside the
      #   anonymous list constructor [], then immediately dereference it:
      my @missing_h = 
        grep {s/\.c$/\.h/ and not !-e } eval {@cfiles};

      # you could just as well save the element to another variable in the grep:
      my @missing_h = grep {
        my $h = $_;
        $h =~ s/\.c$/\.h/ and !(-e $h)
      } @cfiles;

      # if you need a completely disconnected, deep copy, use dclone from Storable:
      use Storable qw(dclone);
      my $copy_ref = dclone(\@array);
    }
    # output {
      # --------------------
    # }
  # }
# }
  
# @item 18 : avoid excessive punctuation
# @comment: 
# {
  # {
    # @title: call subroutines without parantheses
    # @comment: 
    my $run = 0;
    if ($run) {
      &myfunc(1,2,3);
      myfunc(1,2,3);
      # myfunc 1,2,3 ;

      # you can also forward-declare the subroutine name, and define it later. Perl
      #   now knows that myfunc is a subroutine, so it can parse the source correctly:
      use subs qw(myfunc);
      myfunc 1,2,3;
      sub myfunc {};
    }
    # output {
      # --------------------
    # }
  # }
  
  # {
    # @title: use and and or instead of && and ||
    # @comment: 
    my $run = 0;
    if ($run) {
      print("hello, ") && print "goodbye.";
      print "hello, " and print "goodbye.";

      (my $size = -s $file) || die "$file has zero size.\n";
      my $size = -s $file or die "$file has zero size.\n";

      # (my $word =~ /magic/) || $mode = 'peon';
      my $word =~ /magic/ or $mode = 'peon';

      open(my($fh), '>', $file)
        || die "Could not open $file: $!";

      open my($fh), '>', $file 
        or die "Could not open $file: $!";

      last if /^__END__$/;
    }
    # output {
      # --------------------
      #  has zero size.
      # hello, goodbye.hello, goodbye.
    # }
  # }
# }
  
# @item 19 : format lists for easy maintenance
# @comment: 
# {
  # {
    # @title: 
    # @comment: 
    my $run = 0;
    if ($run) {
      my @cats = (
        'Buster Bean',
        'Mini',
        'Roscoe',
      );

      # you can even comment out an item temporarily
      my @cats = (
        'Buster Bean',
        # 'Mini',
        'Roscoe',
      );
      print "@cats\n"; # Buster Bean Roscoe

      my %spacers = (
        bushand  => "George",
        wife     => "Jane",
        daughter => "Judy",
        son      => "Elroy",
      );

      my %spacers = qw(
        bushand  George,
        wife     Jane,
        daughter Judy,
        son      Elroy,
      );
    }
    # output {
      # --------------------
      # Buster Bean Roscoe
    # }
  # }
# }
  
# @item 20 : use foreach, map, and grep as appropriate
# @comment: 
# {
  # {
    # @title: use foreach to iterate read-only over element of a list
    # @comment: 
    my $run = 0;
    if ($run) {
      foreach my $cost (@cost) {
        $total += $cost;
      }

      foreach my $file (glob '*') {
        print "$file\n" if -T $file;
      }

      foreach ( 1 .. 10 ) { # print the first 10 squares
        print "$_: ", $_ * $_, "\n";
      }

      for (@lines) { # print the first line beginning with From:
        print, last if /^From:/;
      }
    }
    # output {
      # --------------------
      # effective_perl_programming.pl
      # learnxinyminutes.pl
      # perl_one_line.md
      # perl_one_line_ch.md
      # points
      # 1: 1
      # 2: 4
      # 3: 9
      # 4: 16
      # 5: 25
      # 6: 36
      # 7: 49
      # 8: 64
      # 9: 81
      # 10: 100
    # }
  # }
  
  # {
    # @title: use map to create a list based on the contents of another list
    # @comment: 
    my $run = 0;
    if ($run) {
      # remember that most file test operators use $_ by default(item 51)
      my @sizes = map {-s} @files;
      my @sizes = map -s, @files;

      # this map finds all of the filenames (without the extensions) that end in
      #   .txt. Since the match operator is in list context, it returns the list of
      #   things that match in the parentheses:
      my @stem = map {/(.*\.txt$)/} @files;
      
      # this map does a similar thing to find the From: address in a list of e-mail
      #   headers. It returns only for those elements where the match succeeds:
      my ($from) = map /^From:\s+(.*)$/, @message_lines;

      # in this example, you save the value of $_ in $x so you can modify it:
      my @elems = ("test12","demo24");
      my @digitless = map {
        (my $x = $_) =~ tr/0-9//d;
        $x
      } @elems;
      print "@digitless\n";
    }
    # output {
      # --------------------
      # test demo
    # }
  # }
  
  # {
    # @title: use foreach to modify elements of a list
    # @comment: 
    my $run = 0;
    if ($run) {
      # if you actually want to modify the elements in a list, use foreach.
      # multiply all the elements of @nums by 2
      my @nums = qw(1 2 3 4);
      foreach my $num (@nums) {
        $num *= 2;
      }
      print "@nums\n";
      
      # strip digits from elements of @arys
      foreach (@arys) { tr/0-9//d }
      
      # slower version using s///
      foreach (@elems) { s/\d//g }
      
      # uppercase $str1, $str2 and $str3
      foreach ($str1,$str2,$str3) { 
        $_ = uc $_;
      }
    }
    # output {
      # --------------------
      # 2 4 6 8
    # }
  # }
  
  # {
    # @title: use grep to select elements in a list
    # @comment: 
    my $run = 0;
    if ($run) {
      # here's a conventional use of grep in a list context:
      my @lines = qw(
        joseph
        cd
        joseph
      );
      print grep /joseph/i, @lines; # josephjoseph

      # in a scalar context, grep returns a count of the selected elements rather
      #   than the elements themselves:
      my @array = qw(
        undef
        test
        undef
      );
      my $has_false = grep !$_, @array;
      print "$has_false\n"; # 0 
      my $has_undef = grep !defined($_), @array;
      print "$has_undef\n"; # 0
    }
    # output {
      # --------------------
    # }
  # }
  
  # {
    # @title: know the different ways to quote strings
    # @comment: 
    my $run = 0;
    if ($run) {
      # you can specify Unicode code points with \x{} (item 74)
      # "there be pirates! \x{2620}";
      
      # and you can use Unicide character names if you use the charnames module:
      # use charnames;
      # my $str = "there be pirates! \N{SKULL AND CROSSBONES}";
      
      # the elements of arrays and slices are interpolated by joining them with
      #   the contents of the $" special variable——normally a single space:
      my @n = 1 .. 3;
      print "testing @n\n"; # testing 1 2 3
      
      # if your variable name appears next to other legal identifier characters,
      #   you can use {} to delimit the name:
      print "testing @{n}sies\n"; # testing 1 2 3sies

      # the \u, \U, \l, \L, \E escape work to change the case of characters in a 
      #   double-quoted string:
      my $v = "very";
      print "I am \u$v \U$v\E tired!\n"; # I am Very VERY tired!
    }
    # output {
      # --------------------
      # testing 1 2 3
      # testing 1 2 3sies
      # I am Very VERY tired!
    # }
  # }
  
  # {
    # @title: alternative quoting:q, qq, and qw
    # @comment: 
    my $run = 0;
    if ($run) {
        # just prefix your favorite character with q for a single-quoted string, or
        #   qq for a double-quoted string:
        q*A 'starring' role*;  # A 'starring' role
        qq|DOn't "quote" me!|; # Don't "quote" me!
      
        # if you use your new delimiter in the string, you still have to escape it,
        #   although you avoid this situation if you can choose a different delimiter:
        qq<Don't "quote" me!>;
        qq[Don't "quote" me!];
        qq{Don't "quote" me!};
        qq(Don't "quote" me!);
        qq<Don't << quote >> me!>; # Don't << quote >> me!:w
      }
    # output {
      # --------------------
    # }
  # }
  
  # {
    # @title: use q{} and/or qq{} to quote source code
    # @comment: 
    my $run = 0;
    if ($run) {
      # 
      use Benchmark;
      our $b = 1.234;
      timethese(
        1_000_000,
        {
          control => q{ my $a = $b},
          sin     => q{ my $a = sin $b},
          log     => q{ my $a = log $b},
        }
      )
    }
    # output {
      # --------------------
    # }
  # }
  
  # {
    # @title: create comma-less, quote-less with qw()
    # @comment: 
    my $run = 0;
    if ($run) {
      @ISA = qw(Foo Bar Bletch);
      print "@ISA\n";
      @ISA = qw('Foo','Bar','Bletch');
      print "@ISA\n";
      @ISA = qw(Foo,Bar,Bletch);
      print "@ISA\n";
    }
    # output {
      # --------------------
      # Foo Bar Bletch
      # 'Foo','Bar','Bletch'
      # Foo,Bar,Bletch
    # }
  # }
  
  # {
    # @title: alternative quoting:"here doc" strings
    # @comment: 
    my $run = 0;
    if ($run) {
      print <<EOT;  # ends statement = comment ignored!
      Dear $j $h,

      You may have just won $m!
EOT

      print <<'XYZZY';  # single-quoted this time ... 
      Dear $j $h,

      You may have just won $m!
XYZZY

      # print <<"HERE", <<"THERE";  
      # This is in the HERE here doc
# HERE
      # This is in the THERE here doc
# THERE

      # some_sub( <<"HERE", <<"THERE" );
      # This is in the HERE here doc
# HERE
      # This is in the THERE here doc
# THERE
    }
    # output {
      # --------------------
    # }
  # }
# }
  
# @item 22 : learn the myriad ways of sorting
# @comment: 
# {
  # {
    # @title: 
    # @comment: 
    my $run = 0;
    if ($run) {
      my @elements = sort qw(
        hydrogen
        helium
        lithium
      );
      print "@elements\n"; # helium hydrogen lithium

      print join ' ', sort 1..10; # 1 10 2 3 4 5 6 7 8 9
      print join ' ', sort qw(my Dog has Fless); # Dog Fless has my
    }
    # output {
      # --------------------
      # helium hydrogen lithium
      # 1 10 2 3 4 5 6 7 8 9Dog Fless has my
    # }
  # }
  
  # {
    # @title: comparison (sort) subroutines
    # @comment: 
    my $run = 0;
    if ($run) {
      # here you have used a named subroutine,utf8ly,
      sub utf8ly {$a cmp $b}
      my @list = sort utf8ly @list;
      # just place the body of the subroutine right where the name of the sort subroutine would go:
      my @list = sort {$a cmp $b} (16,1,8,2,4,32);
      # replace the cmp operator with <==> to sort numberically:
      my @list = sort {$a <=> $b} (16,1,8,2,4,32); # 1 2 4 8 16 32
      print "@list\n";
      my @list = sort {$b <=> $a} (16,1,8,2,4,32); # 32 16 8 4 2 1
      print "@list\n";
      # you can sort with case-insentivity by lowercasing each string before you do the comparison:
      my @list = sort {lc($a) cmp lc($b)} qw(This is a test); # ('a', 'is', 'test', 'This')
      # you can turn an ascending sort into a descending one by swapping $a and $b:
      my @list = sort {$b cmp $a} @list;
      # you can even use $a and $b to compute values to use for the comparison, like sorting filenames based on their
      #   modification times:
      my @list = sort {-M $a <=> -M $b} @files;
      # someting that comes up from time to tome is the need to sort the keys of a hash according to their corresponding values.
      #   There is a neat idiom for doing this by using $a and $b to access the value:
      my %elems = (B=>5,Be=>4,H=>1,He=>2,Li=>3);
      print sort {$elems{$a} <=> $elems{$b}} keys %elems; # H He Li Be B
      # finally, you may want to sort on multiply keys
      my @first = qw(John Jane Bill Sue Carol);
      my @last = qw(Smith Smith Jones Jones Smith);
      # sort by @last then sort by @first
      my @index = sort {
        $last[$a] cmp $last[$b] # last name, then
          or
        $first[$a] cmp $first[$b] # first name
      } 0..$#first;
      print "@index\n"; # 2 3 4 1 0
      for (@index) {
        print "$last[$_],$first[$_]\n" # Jone, Bill
      } # Jones, Sue
        # Smith, Carol, etc.
    } 
    # output {
      # --------------------
      # 1 2 4 8 16 32
      # 32 16 8 4 2 1
      # H He Li Be B
      # 2 3 4 1 0
      # Jones,Bill
      # Jones,Sue
      # Smith,Carol
      # Smith,Jane
      # Smith,John
    # }
  # }
  
  # {
    # @title: advanced sorting: the mundane ways
    # @comment: 
    my $run = 0;
    if ($run) {
      # let's sort on the third field, the uid, of a password entry:
      open my ($passwd), '<', '/etc/passwd' or die;
      my @by_uid = 
        sort {(split /:/, $a)[2] <=> (split /:/, $b)[2]}
        <$passwd>;
      print "@by_uid\n";

      # In the preceding example, you could create a hash of the comparison value before performing the sort, and then sort the hash by its values:
      open my ($passwd), '<', '/etc/passwd' or die;
      my @passwd = <$passwd>;
      # key is whole line, value is uid
      # $_ is key, (split /:/)[2] is value
      my %lines = map {$_,(split /:/)[2]} @passwd;
      my @lines_sorted_by_uid = 
        sort {$lines{$a} <=> $lines{$b}} keys %lines;
    }
    # output {
      # --------------------
      # root:x:0:0:root:/root:/bin/bash
      #  daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
      #  bin:x:2:2:bin:/bin:/usr/sbin/nologin
      #  sys:x:3:3:sys:/dev:/usr/sbin/nologin
      #  sync:x:4:65534:sync:/bin:/bin/sync
    # }
  # }
  
  # {
    # @title: advanced sorting: the cool ways
    # @comment: 
    my $run = 0;
    if ($run) {
      # 1: sorting with the orcish maneuver("|| cache")
      # old way
      my @sorted = sort {-M $a <=> -M $b} @files;
      # here it is using the orcish maneuver:
      my @sorted = 
        sort {($m{$a} ||= -M $a) <=> ($m{$b} ||= -M $b)}
        @files; # $m{$a} = $m{$a} || -M $a
        
      # 2: the schwarizian transform
      # first, start with the filenames
      my @names = glob('*');
      # and now, turn the names into a same-length list of two-element anonymous lists:
      my @names_and_ages = map {[$_,-M]} @names;
      print "@names_and_ages\n"; # ARRAY(0x559b429fc3e8) ARRAY(0x559b42a06c98) ARRAY(0x559b42a21470) ARRAY(0x559b42a218d8) ARRAY(0x559b42a21ea8) ARRAY(0x559b42a220a0)
      # In the next step, sort this list of references using a sort block:
      my @sorted_names_and_ages = 
        sort {$a->[1] <=> $b->[1]} @names_and_ages;
      # now all you need to do is to extract the original names from each tuple. Simple enough, with one more map:
      my @sorted_names = map {$_->[0]} @sorted_names_and_ages;
      # and that's it. But that's much too wordy for the seasoned Perl hacker, so here it is all put together as a
      #   schwarizian transform
      my @sorted_names = 
        map {$_->[0]}     # 4. extract original names
        sort { $a->[1]
                <=>
               $b->[1]}   # 3. sort [name, key] tuple
        map {[$_,-M]}     # 2. create [name,key] tuple
        @files;           # 1. the input data
        
      # here's the password file sorted by the third field using a schwarizian transform:
      open my ($passwd), '<', '/etc/passwd' or die;
      my @by_uid = 
        map { $_->[0] }
        sort { $a->[1] <=> $b->[1] }
        map { [$_,(split /:/)[2]] } <$password>;
    }
    # output {
      # --------------------
    # }
  # }
# }
  
# @item 23 : make work easier with smart matching
# @comment: Perl 5.10 introduced the smart match operator, ~~.
# {
  # {
    # @title: 
    # @comment: 
    my $run = 0;
    if ($run) {
      no warnings 'experimental::smartmatch';
      # First, consider the simple task of checking that a key exists in a hash, or an
      #   element in an array. It's easy to make these conditions:
      if (exists $hash{$key}) { }
      if (grep{$_ eq $name} @cats) { }

      # A smart match makes them look a bit nicer, and more consistent, even though it handles
      #   different tasks:
      # if ($key~~%hash) {}
      # if ($name~~@cats) {}

      # Next, consider how you would check that some key in a hash matches a
      #   regex. You would have to go through all of the keys yourself:
      my $matched = 0;
      foreach my $key (keys %hash) {
        do {$matched = 1; last} if $key =~ /$regex/;
      }
      if ($matched) {
        print "One of the keys matched!\n"
      }

      # That's too much work. You could hide all of that in a subroutine to make the 
      #   program flow more pleasing. but in Perl 5.10, that work is always built in:
      if (%hash ~~ /$regex/) {
        print "One of the keys matched!" 
      }

      # If you want to chek if an array element matches a regex, the condition looks
      #   almost the same:
      if (@array ~~ /$regex/) {
        print "One of the element matched!" 
      }
      
      # Seveal other operations that would otherwise take a lot of work become almost
      #   trivial with the smart match:
      %hash1~~%hash2;    # the hashes have the same keys
      @array1~~@array2;  # the arrays are the same
      %hash~~@keys;      # one the elements in @keys is a key in %hash
      $scalar~~$code_ref; # $code_ref->($scalar) is true
    }
    # output {
      # --------------------
    # }
  # }
# }
  
# @item 24 : use given-when to make a switch statement
# @comment: 
# {
  # {
    # @title: Type less
    # @comment: 
    my $run = 0;
    if ($run) {
      my $dog = 'Spot';
      if ($dog eq 'Fido') {}
      elsif ($dog eq 'Rover') {}
      elsif ($dog eq 'Spot') {}
      else {}

      # Instead, you can use given-when, which handles most of typing for you:
      # given ($dog) {
      #   when ('Fido') { }
      #   when ('Rover') { }
      #   when ('Spot') { }
      #   default { };
      # };

      # given ($dog) {
      #   my $_ = $dog;
      #   when ('Fido') { }
      #   when ('Rover') { }
      #   when ('Spot') { }
      #   default { };
      # };
    }
    # output {
      # --------------------
    # }
  # }
  
  # {
    # @title: smart matching
    # @comment: 
    my $run = 0;
    if ($run) {
      no warnings 'experimental::smartmatch';
      # unless you have an explicit comparison in when, perl's really using smart matching, the ~~(item 23)
      # given ($dog) {
      #   when ($_~~'Fido') { }
      #   when ($_~~'Rover') { }
      #   when ($_~~'Spot') { }
      #   default { }
      # }
      
      # if you use something else in the smart match, you get a different comparison, The perlsyn documentation has a table 
      #   of all of the possibilities, but here are some interesting ones:
      $dog ~~ /$regx/; # $dog matches the regex
      $dog ~~ %Dogs;  # $dog is a key in %Dogs
      $dog ~~ @Dogs;  # $dog is an element in @Dogs
      @Dogs ~~ /$regex/;  # one item in @Dogs matches regex
      %Dogs ~~ /$regex/;  # one key in @Dogs matches regex

      # the when block adds the extra magic of assuming that the operated on the lefthand
      #   side is the topic, $_. These two are the same:
      # when (RHS) {}
      # when ($_~~RHS) {}
    }
    # output {
      # --------------------
    # }
  # }
  
  # {
    # @title: multiple branches
    # @comment: 
    my $run = 0;
    if ($run) {
      # there is an implicit break at the end of each when block that tells it ti break out of the loop:
      # given ($dog) {
      #   when ('Fido') { break}
      #   when ('Rover') { break}
      #   when ('Spot') { break}
      #   default { }
      # }
      
      # however, with a continue, you can run one when block and then try the next one, too, In this example, you can test the name in $dog in each when:
      # given ($dog) {
      #   when (/o/) { continue}
      #   when (/t/) { continue}
      #   when (/d/) { continue}
      #   default { }
      # }
    }
    # output {
      # --------------------
    # }
  # }
  
  # {
    # @title: intermingling code
    # @comment: 
    my $run = 0;
    if ($run) {
      # with given-when you can inset any code you like around the when portions, including code that changes the topic:
      # my $dog = 'Spot';
      # given ($dog) {
      #   print "I'm working with {$_}";
      #   when (/o/) { continue}
      #   print "Continuing to look for a t";
      #   when (/t/) { continue}
      #   $_ =~ tr/p/d/;
      #   when (/d/) { continue}
      #   default { }
      # }
    }
    # output {
      # --------------------
    # }
  # }
  
  # {
    # @title: switching over a list 
    # @comment: you can use when in a foreach loop, too. It does the same thing as in a given, although you get to try
    #           the condition for each item in the input list:
    my $run = 0;
    if ($run) {
      # my $count = 0;
      # foreach (@array) {
      #   when (/[aeiou]$/) {$vowels_count++}
      #   when (/[^aeiou]$/) {$count++}
      # }
      # print "\@array contains $count words enfing in consonants and $vowels_count words ending in vowels";
    }
    # output {
      # --------------------
    # }
  # }
# }
  
# @item 25 : use do {} to create inline subroutines
# @comment: 
# {
  # {
    # @title: 
    # @comment: 
    my $run = 0;
    if ($run) {
      # The do {} syntax lets you group several statements as a single expression. It's
      #   a bit like an inline subroutine. For example, to quickly read in an entire file,
      #   you can localize the input record separator $/(item 43), open the file with a 
      #   lexical filehandle (item 52), read the data, and store it in a scalar, all in one block:
      #
      #   with the do block, local and my are scoped to just that block; they don't affect anything
      #     else. The last evaluated expression, <$fh>, is the return value of the block, just as it would
      #     be for a conentional subroutine. You assign that value once to $file, which you declare outside
      #     the block to give it the proper scope.
      # my $file = do {
      #   local $/;
      #   open my ($fh), '<',$filename or die;
      #   <$fh>;
      # };

      # Consider the same thing without do {}. You want to make some things short term inside the block,
      #   but you have to end up with the contents outside the block. You have to do some extra work to 
      #   assign the $file, which you have to type twice:
      # my $file;
      # {
      #   local $/;
      #   open my ($fh), '<',$filename or die;
      #   $file = join '', <$fh>;
      # }

      # You can save some code in chains of if-elsif-else blocks that you might use simply to set the right
      #   values. Suppose you need to select the localizaion for thousands and decimal separators. You could  
      #   declare some variables, and then assign to those variable based on the right conditions:
      my ($thousands_sep, $decimal_sep);
      my $locale = "China";
      if ($locale eq "China") {
        ($thousands_sep, $decimal_sep) = qw(。 ，);
      } elsif ($locale eq "English") {
        ($thousands_sep, $decimal_sep) = qw(. ,);
      }
      print "$thousands_sep  $decimal_sep\n"; # 。  ，

      # that's a bit sloppy, because you have to type the variables several times, making the code dense an obscuring
      #   the task. With a do, you can use the fact that the last evaluated expression is the result, so you can get
      #   rid of the extra variable typing:
      my $locale = "China";
      my ($thousands_sep, $decimal_sep) = do {
        if ($locale eq "China") { qw(。 ，) } 
        elsif ($locale eq "English") { qw(. ,) }
      };
      print "$thousands_sep  $decimal_sep\n"; # 。  ，
      
      # Sometimes you might want to use a do to move some error handing out of the way to de-emphasize it. For instance,
      #   if you have to go through a list of files but don't want to stop because you can't open one of them, you can
      #   catch the failure in open and run an expression on the righthand side of the or:
      foreach my $file (@files) {
        open my ($fh), '<', $file or do {warn "xxx";next};
        # do stuff
      }
      # if you do {} gets much longer than a couple of statements, you're better off moving it into its own subroutine, so
      #   don't overuse the idiom
      
      # There's another use for do, although it's rather rare. Sometimes you want to run your while block before you test the
      #   condition for the first time. Consider prompting users for a string, and continuing to prompt them until they type
      #   it correctly. You need to get their first input before you can test it, so you repeat some code:
      # print "Type 'hello': ";
      # chomp(my $typed=<STDIN>);
      # while ($typed ne 'hello') {
      #   print "Type 'hello': ";
      #   chomp($typed=<STDIN>);
      # }
      
      # you can eliminate the duplicate code by using while as an expression modifier for a do {} when you need run some code 
      #   before you check the condition:
      # my $typed;
      # do {
      #   print "Type 'hello': ";
      #   chomp($typed=<STDIN>);
      # } while ($typed ne 'hello');
      # you did need to declare $typed, which is a bit ugly, but it's not as ugly as the previous example.
    }
    # output {
      # --------------------
    # }
  # }
# }
  
# @item 26 : use List::Util and List::MoreUtils for easy list manipulation
# @comment: 
# {
  # {
    # @title: find the maximum value quickly
    # @comment: 
    my $run = 0;
    if ($run) {
      # if you need to find the maximum number in a list, you can easily do it yourself in pure Perl:
      my @numbers = 0..1000;
      my $max     = $numbers[0];
      foreach (@numbers) {
        $max = $_ if $_ > $max;
      }

      # but in pure Perl that's relatively slow. The List::Util module, which comes
      #   with Perl, provides a max routine implemented in C that does it for you:
      use List::Util qw(max);
      my $max_number = max(0..1000);
      print "$max_number\n";

      # The maxstr routine does the same thing for strings:
      use List::Util qw(maxstr);
      my $max_number = maxstr(qw(Fido Spot Rover));
      print "$max_number\n";

      # similarly, you could easily sum a list of numbers yourself in pure Perl:
      my $sum = 0;
      foreach (1..1000) {
        $sum += $_;
      }

      # but it's much easier and faster with List::Util's sum:
      use List::Util qw(sum);
      my $sum = sum(1..1000);
      print "$sum\n";
    }
    # output {
      # --------------------
      # 1000
      # Spot
      # 500500
    # }
  # }
  
  # {
    # @title: reduce a list
    # @comment: 
    my $run = 0;
    if ($run) {
      # there's another way to sum numbers. List::Util's reduce function, again implemented in C,
      #   can do it for you much faster and with a more-pleasing syntax:
      use List::Util qw(reduce);
      my $sum = reduce{$a + $b} 1..1000;
      print "$sum\n";

      # Knowing that, you can come up with other reductions that don't already have their own functions,
      #   such as taking the product of all of the numbers:
      my $product = reduce {$a * $b} 1..10;
      print "$product\n";
    }
    # output {
      # --------------------
      # 500500
      # 3628800
      # Inf
    # }
  # }
  
  # {
    # @title: determine if any element matches
    # @comment: 
    my $run = 0;
    if ($run) {
      my @list = qw(10001 1212 3 12);
      # for instance, you can easily check that @list contains an element that is greater than 1,000:
      my $found_a_match = grep {$_>1000} @list;
      
      # however, what if @list has 100 million elements, and the first element is 1,001? The preceding
      #   code will still check every item even though you already have your answer. You could fix this 
      #   by terminating the loop yourself, but do you really want to write that much code?
      my $found_a_match = 0;
      foreach my $elem (@list) {
        $found_a_match = $elem if $elem > 1000;
        last if $found_a_match;
      }

      # List::Util's first routine does all of this for you, and also tells you what the value was. It
      #   has the advantage, however, of stopping one it knows the answer. It doesn't need to scan the
      #   entire list to see if one of the numbers is larger than 1,000:
      use List::Util qw(first);
      my $found_a_match = first{ $_ > 1000 } @list;
      print "$found_a_match\n";

      # In the List::MoreUtils module, which you have to install from CPAN yourself in most cases, there
      #   are additional convenience functions:
      use List::MoreUtils qw(any all none notall);
      my $found_a_match = any { $_ > 1000 } @list;
      print "$found_a_match\n";
      my $all_greater   = all { $_ > 1000 } @list;
      print "$all_greater\n";
      my $none_greater  = none { $_ > 1000 } @list;
      print "$none_greater\n";
      my $all_greater   = notall { $_ % 2 } @list;
      print "$found_a_match\n";
    }
    # output {
      # --------------------
      # 10001
      # 1


      # 1
    # }
  # }
  
  # {
    # @title: iterate over more than one list at a time
    # @comment: 
    my $run = 0;
    if ($run) {
      my @a = qw(1 2 3 4);
      my @b = qw(4 3 2 1);
      my @c;
      foreach my $i (0..$#a) {
        my ($a,$b) = ($a[$i],$b[$i]);
        push @c, $a + $b;
      }
      print "\@c = @c\n";

      # Instead of all that extra code to handle the arrays, use the pairwise routine in List::MoreUtils:
      use List::MoreUtils qw(pairwise);
      my @c = pairwise{$a+$b} @a, @b;
      print "\@c = @c\n";

      # the pairwise routine is fine if you have two arrays, but if you have more than two, you can make an
      #   iterator with each_array, which brings back a little of the work but is still easier:
      use List::MoreUtils qw(each_array);
      my $ea = each_array(@a,@b,@c);
      my @d;
      while (my ($a,$b,$c) = $ea->()) {
        push @d, $a+$b+$c;
      }
      print "\@d = @d\n";
    }
    # output {
      # --------------------
      # @c = 5 5 5 5
      # @c = 5 5 5 5
      # @d = 10 10 10 10
    # }
  # }
  
  # {
    # @title: merge arrays
    # @comment: 
    my $run = 0;
    if ($run) {
      # if you need to merge two or more arrays, you can do it the hard way, but
      #   List::MoreUtils can make it easy with its mesh routine:
      use List::MoreUtils qw(mesh);
      my @odds  = qw/1 3 5 7 9/;
      my @evens = qw/2 4 6 8 10/;
      my @numbers = mesh @odds, @evens; # returns 1 2 3 4 ...
      print "@numbers\n";
    }
    # output {
      # --------------------
      # 1 2 3 4 5 6 7 8 9 10
    # }
  # }
# }
  
# @item 27 : use autodie to simplify error handling
# @comment: 
# {
  # {
    # @title: 
    # @comment: 
    my $run = 0;
    if ($run) {
      open my ($fh), '<', $file
        or die "Could not open $file: $!";

      # to save yourself the typing, you can use autodie pragma (included with 
      #   Perl starting with 5.10.1, but also on CPAN so you can install it yourself):
      use autodie;
      open my ($fh), '<', $file; # automatically dies for you

      # by itself, autodie applies to all of the functions it handles, mostly all of the
      #   built-ins that interact with the system. if you want it to apply only to certain
      #   functions, you can tell autodie to handle those specific functions only, or
      #   all of the functions in a group:
      use autodie qw(open close); # only specific function
      use autodie qw(:filesys);   # all functions from group

      # you don't have to apply autodie to your entire file either. It's a lexical pragma, 
      #   like strict, that applies only within its scope:
      {
        use autodie;
        open my ($fh), '<', $file; # automatically dies for you
      }

      # alternatively, you can apply autodie to the entire file and turn it off within a scope:
      use autodie;
      {
        no autodie; # back to normal in this scope
        chdir('/usr/local/') or die "Could not change to $dir";
      }

      # When autodie a raises an error for you, it sets $@, the eval error variable, to an instance of an autodie::exception object:
      use autodie;
      eval {open my ($fh), '<', $file};
      my $error = $@; # always save $@ right away
                      # in case it changes
      
      # you can query the error to see where it came from. autodie is smart enough to know how to classify the errors so you have some
      #   flexibility in how you handle them. The autodie::exception object knows how to deal with the smart match operator(item 23), 
      #   so you can have a hierarchy of handlers going from specific to general. You can match against the specific sort of error or
      #   the error type (these are listed in the autodie documentation):
      use autodie;
      eval {open my ($fh), '<', $file};
      my $error = $@; # always save $@ right away
                      # in case it changes
      # given ($error) {
      #   when (undef) { print "No error";}
      #   when ('open') { print "error from open";}
      #   when (':io') { print "non-open, IO error";}
      #   when (':all') { print "all other autodie errors";}
      #   default { print "not an autodie error at all";}
      # }
    }
    # output {
      # --------------------
    # }
  # }
# }
