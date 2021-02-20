#!/usr/bin/env perl
# @item 1 : find the documentation for Perl and its modules
# @comment: 
# {
  # {
    # @title: 
    # @comment: 
    my $run = 0;
    if ($run) {
      # The perldoc command formats and displays the documentation it finds. To start, read perldoc's own documentation
      # % perldoc perldoc
      
      # The perltoc is the table of contents that shows you all of the page names:
      # % perldoc perltoc
      
      # You might be interested in perlsyn, the page that discusses general Perl syntax:
      # % perldoc perlsyn
      
      # If you want to read about Perl built-ins, you look in perlfunc:
      # % perldoc perlfunc
      
      # If you know the built-in that you want to read about, specify it along with the -f switch, which pulls out just
      #   the part for that function:
      # % perldoc -f split
      
      # You can also read module documentation with perldoc; just give it the module name:
      # % perldoc Pod::Simple
      
      # If you wonder where that module is installed, you can use the -l (letter ell) switch to get the file location:
      # % perldoc -l Pod::Simple
      
      # If you want to see the raw source, use the -m switch:
      # % perldoc -m Pod::Simple
      
      # The Perl documentation comes with several FAQ files that answer many common questions. You can read through them 
      #   online, but perldoc also has a nice feature to search them with the -q switch. If you wanted to find answers that
      #   deal with random numbers, for example, you can try:
      # % perldoc -q random
    }
    # output {
      # --------------------
    # }
  # }
# }
  
# @item 2 : enable new Perl features when you need them.
  
# @item 3 : enable strictures to promote better coding.
# @comment: 
# {
  # {
    # @title: declare your variables
    # @comment: 
    my $run = 0;
    if ($run) {
      # the strict vars pragma catched and prevents such errors by making you declare all of your variables in some fashion.
      #   There are three ways you can declare a variable. You can declare it with my or our:
      use strict;
      my @temp;
      our $temp;

      # use the full package specification:
      use strict 'vars';
      $main::name = 'Buster';

      # or list variables in use vars:
      use strict 'vars';
      use vars qw($bar);
      $bar = 5;
    }
    # output {
      # --------------------
    # }
  # }
  
  # {
    # @title: be careful with barewords
    # @comment: 
    my $run = 0;
    if ($run) {
    }
    # output {
      # --------------------
    # }
  # }
  
  # {
    # @title: avoid soft references
    # @comment: 
    my $run = 0;
    if ($run) {
      no strict 'refs';
      $not_array_ref = 'buster';
      @$not_array_ref = qw(1 2 3); # really @buster
      print "@buster\n";
    }
    # output {
      # --------------------
      # 123
    # }
  # }
# }
  
# @item 4 : understand what sigils are telling you.
# @comment: 
# {
  # {
    # @title: 
    # @comment: 
    my $run = 0;
    if ($run) {
      # the $ means you are working with a single value, which can be a scalar variable or a single element accessed in array or hash:
      $scalar;
      $array[3];
      $hash{'key'};

      # The @ means you are working with multiple values, so you'll use it with arrays or hashes, since they are the only collection types
      #   Perl has:
      @array;
      @array[0,2,6]; # an array slice
      @hash{qw(key1 key2)}; # a hash slice

      # sigil indentifier index
      # $       name        [3]
      # $name[3]
      
      # sigil indentifier index
      # $       name        {'Buster'}
      # $name{'Buster'}
    }
    # output {
      # --------------------
    # }
  # }
  
  # {
    # @title: be careful with barewords
    # @comment: 
    my $run = 0;
    if ($run) {
    }
    # output {
      # --------------------
    # }
  # }
  
  # {
    # @title: avoid soft references
    # @comment: 
    my $run = 0;
    if ($run) {
    }
    # output {
      # --------------------
    # }
  # }
# }
  
# @item 5 : know your variable namespaces.
# @comment: 
# {
  # {
    # @title: 
    # @comment: 
    my $run = 0;
    if ($run) {
      my $a = 1; # set scalar $a = 1;
      my @a = (1,2,3); # @a = (1,2,3) but $a is still 1

      # also, each package in a Perl program defines its own set of namespaces. For example,
      #   $a in package main is independent of $a in package foo:
      $a = 1; # set scalar $main::a=1
      package foo; # default package is now foo
      $a = 3.1416; # $foo::a is 3.1426; $main::a still 1

      my $a = 1;
      my @a = (1,2,3);
      my %a = (a=>97,b=>98);
      $a[3] = 4; # $a is still 1; @a is (1,2,3,4) now
      $a{'c'} = 99; # $a, @a still the same;
                    # %a has three key-value pairs now
      print "\$a = $a\n";
      print "\@a = @a\n";
      print "\%a = %a\n";
                   
      # define a subroutine named "hi" to see the different ways you can call it:
      sub hi {
        my $name = shift;
        return "hi, $name\n";
      }

      # you can call the subroutine using the "old-style" syntax, including the ampersand and the parentheses:
      print &hi("Fred");
      
      # this style isn't seen as often in new code. Instead, you'll see subroutines called with only parentheses:
      print hi("Fred");

      # the parantheses give perl enough information to know that it is a subroutine. If hi has been declared or
      #   defined before you use it, even the parantheses are optional:
      print hi "Fred";
    }
    # output {
      # --------------------
      # $a = 1
      # @a = 1 2 3 4
      # %a = %a
      # hi, Fred
      # hi, Fred
      # hi, Fred
    # }
  # }
# }
  
# @item 6 : know the different betweenn string and numeric comparison
# @comment: 
# {
  # {
    # @title: 
    # @comment: 
    my $run = 0;
    if ($run) {
      'a' lt 'b';           # true
      'a' eq 'A';           # false == capitalization
      'joseph' eq 'joseph'; # false == spaces count

      # numeric comparison operatiors use punctuation and look algebra, or like C:
      0 < 5;      # true
      10 == 10.0; # true

      '10' gt '2';    # false == '1' sorts before '2'
      '10.0' eq '10'; # false == different strings
      'abc' == 'def'; # true == both look like 0 to ==

      # Perl's sort operator uses string comparison by default. Don't use string comparisons to sort numbers (item 22)!
      # One way around the confusion of eq and == is to avoid both of them. Instead of getting it right, let Perl think
      #   about it for you by using the smart match operator, ~~(item 23)
      if (123 ~~ '456') {} # number and numish: false
      if ('123.0' ~~ 123) {} # string and number: true
      if ('Mimi' ~~ 456) {} # string and number: false
      # otherwise, the smart match will make a string comparison using the eq operator:
      if ('Mimi' ~~ 'Mimi') {} # string and string: true

      # in the following case, you start with a string but convert it to a number by using it with a numberic operator, forcing
      #   a numeric comparison with the == operator:
      if (('123'+0)~~'123.0') {} # number and numish: true

      my $var = '123';
      if (($var+0)~~'123.0') {} # number and numish: true
      
      my $var2 = '123';
      $var2 + 0;
      if ($var2~~'123.0') {} # number and numish: true

      # however, if you start with a number but make it into a string, Perl sees it only as a string and forces eq semantics on it.
      my $var3 = 123;
      $var3 = "$var3";
      if ($var3 ~~ '123.0') {} # string and numish, eq. false
    }
    # output {
      # --------------------
    # }
  # }
# }
  
# @item 7 : know which values are false and test them accordingly
# @comment: 
# {
  # {
    # @title: 
    # @comment: 
    my $run = 0;
    if ($run) {
      # the basic test is this: 0, '0', undef, and '' (the empty string) are false. everything else is true.
      # more precisely, when you use a quantity in boolean context (a term sometimes used to refer to conditionals 
      #   in control expressions, such as the ?: operator, ||, and &&), it is first converted to a string (item 8)
      
      # there is one problem, though. If there is a file named 0 in the current directory, it also appears to be false,
      #   causing the loop to terminate early. To avoid this, use the defined operator to test specifically for undef:
      while (defined(my $file = glob('*'))) {
        # do_something($file);
        print "$file\n";
      }

      while (defined($_=<STDIN>)) { # implicitly done
        # do_something($_);
      }

      # if you want to use another variable to hold the line you just read, you have to do the defined check yourself:
      while (defined(my $line=<STDIN>)) { 
        # do_something($line);
      }
    }
    # output {
      # --------------------
      # effective_perl_programming
      # effective_perl_programming.pl
      # learnxinyminutes.pl
      # perl_one_line.md
      # perl_one_line_ch.md
    # }
  # }
  
  # {
    # @title: the end of the array
    # @comment: 
    my $run = 0;
    if ($run) {
      # instead, ensure that you go through all of the elements by using foreach, and skip those that aren't defined:
      my @cats = ("tomy","kelly",undef,'skyewei');
      foreach my $cat (@cats) {
        next unless defined $cat;
        print "I have a cat named $cat\n";
      }

      # if you need to know the last element of the array, don't look for undef values. The $#cats syntax gives you the last element.
      for (my $i=0;$i<=$#cats;$i+=2) {
        next unless defined $cat[$i];
        print "I have a cat named $cat[$i]\n";
      }
    }
    # output {
      # --------------------
      # I have a cat named tomy
      # I have a cat named kelly
      # I have a cat named skyewei
    # }
  # }
  
  # {
    # @title: hash values
    # @comment: 
    my $run = 0;
    if ($run) {
      my %hash;
      if ($hash{'foo'}) {}         # false
      if (defined $hash{'foo'}) {} # also false
      if (exists $hash{'foo'}) {}  # also false

      # once you assign to a key, even with a false or undefined value, the key exists:
      $hash{'foo'} = '';
      if ($hash{'foo'}) {}         # still false
      if (defined $hash{'foo'}) {} # now true
      if (exists $hash{'foo'}) {}  # now true
    }
    # output {
      # --------------------
    # }
  # }
# }
  
# @item 8 : understand conversions between strings and numbers
# @comment: 
# {
  # {
    # @title: 
    # @comment: 
    my $run = 0;
    if ($run) {
      my $n = 0 + '123'; # 123
      my $n = 0 + '123abc'; # also 123 -- trailing stuff
                            # ignored
      my $n = 0 + '\n123'; # also 123 -- leading whitespaceS
      my $n = 0 + 'a123'; # 0 -- no number at beginning
      my $n = 0 + '\x{2165}'; # 0 -- Roman numerals aren't numbers

      my $n = 0 + "0x123"; # 0 -- looks like number 0
      my $n = 0 + oct("0x123"); # 291 -- oct converts octal and hex to decimal
      print "mode (octal): "; # prompt for file mode
    }
    # output {
      # --------------------
    # }
  # }
  
  # {
    # @title: strings and numbers at the same time
    # @comment: 
    my $run = 0;
    if ($run) {
      # for example, the bitwise numeric operators act on the whole numeric value if applied to a number,
      #   but character-wise if applied to a string:
      my $a = 123;
      my $b = 234;
      my $c = $a & $b; # number 106

      $a = "$a";
      $b = "$b";
      my $d = $a & $b;  # string "020"

      # the error variable $! is an example of a variable with a "magic" property.
      open "$!\n";  # "no such file or directory"
      print 0 + $!, "\n"; # "2" (or whatever)
    }
    # output {
      # --------------------
    # }
  # }
  
  # {
    # @title: create your own dualvar
    # @comment: 
    my $run = 0;
    if ($run) {
      # you don't need to use Perl's internal conversion to create "dualvars" — variables that have
      #   different string and numeric values depending on context. Here's a subroutine that returns both
      #   a numeric error code and an error string, all in one normal scalar values:
      use Scalar::Util qw(dualvar);
      sub some_sub {
        # ... 
        if ($error) {
          return dualvar(-1,
            'You are not allowed to do that'
          );
        }
      }
    }
    # output {
      # --------------------
    # }
  # }
# }
  
# @item 9 : know the difference between lists and arrays
# @comment: 
# {
  # {
    # @title: 
    # @comment: a list is an orderd collection of scalars.
    #           an array is a variable that contains a list, but isn't the list itself.
    my $run = 0;
    if ($run) {
      (localtime)[5]; # the year
      $array[5];
      (localtime)[5,4,3]; # the year, month, and day
      @array[5,4,3];
    }
    # output {
      # --------------------
    # }
  # }
  
  # {
    # @title: the comma operator
    # @comment: 
    my $run = 0;
    if ($run) {
      # although you can have an array, which is a variable, in a scalar context, there's no such thing as a list 
      #   in scalar context. If you use an array in a scalar context, you get the number of elements in the array:
      my @array = qw(Buster Mimi Roscoe);
      my $count = @array;

      foreach (qw(Buster Mimi Roscoe)) {}

      my $scalar = (1,2,3);
    }
    # output {
      # --------------------
    # }
  # }
  
  # {
    # @title: assignment in list context
    # @comment: 
    my $run = 1;
    if ($run) {
      # if you had written it with grouping parantheses to show the order of the operation, it would look like:
      my $elements = (my @array = localtime);

      # a list assignment in scalar context returns the number of elements on the righthand side.
      # however, since the rule is right associative, you can actually provide no elements in the list in the 
      #   middle that you are assigning to:
      my $elements = () = localtime;
      # sometimes this is known as the goatse operator and written without spaces so it resembles a goat's head
      #   (or maybe something else):
      my $elements =()= localtime;
      print "$elements\n";

      # you assign to the empty list to set the context, then save the result of the assignments:
      my $count =()= m/(...)/g;
      my $count =()= split /:/, $line;
    }
    # output {
      # --------------------
      # 9
    # }
  # }
# }
  
# @item 10 : don't assign undef when you want an empty array.
# @comment: 
# {
  # {
    # @title: 
    # @comment: 
    my $run = 0;
    if ($run) {
      my $toast = undef;
      undef $history;

      # the simplest way to avoid this is to assign the empty list () to array variables when you want to clear them:
      my @going_gone = ();
      # you can also use the undef function:
      undef @going_gone;

      # the defined operator is the only way to distinguish undef from 0 or the empty string ''. The defined operator will
      #   work on any value, and will return true as long as the variable is not undefined:
      if (defined($a)) {}
      # if (defined(@a)) {}

      # You can assign undef to an element of an array, but that doesn't change the size of the array, it just replaces the 
      #   value for a given element or set of elements, creating a potentially sparse array:
      $sparse[3] = undef;
      @sparse[1,5,7] = ();

      # you can eat up quite a bit of memory by adding undefined values to an array:
      @sparse[0..99] = ();

      # note that undef is a perfectly reasonable element value. You cannot shorten an array by assigning undef values to
      #   elements at the end of the array.
      my @a = 1..10;
      $a[9] = undef;
      print scalar(@a), "\n"; # "10"

      # to actually shorten an array without assigning a whole new value to it, you must use one of the array operators like pop:
      my $val = pop @a;
      print scalar(@a), "\n"; # "9"
      # or splice:
      splice @a, -2;
      print scalar(@a), "\n"; # "7"
      # or assign to $#array_name:
      $#a = 4;
      print scalar(@a), "\n"; # "5"
      
      # or you can use the undef operator to reset the hash to a pristine state.
      my %unked = (U=>'235',Pu=>238);
      undef %unked;
      if (keys %unked) {
        print "this won't print either\n";
      }
      # if (defined %unked) {
      #   print "Nor will this\n";
      # }

      # in other to remove elements from a hash you must use the delete operator,
      #   which you can use on hash slices as well as single elements:
      my %spacers = (
        hushand  => "George",
        wife     => "jane",
        daughter => "judy",
        son      => "elroy",
      );
      delete $spacers{'hushand'};
      if (exists $spacers{'hushand'}) {
        print "won't print because 'hushand' is gone\n";
      }
      delete @spacers{'daughter', 'son'};
    }
    # output {
      # --------------------
    # }
  # }
# }
  
# @item 11 : avoid a slice when you want an element
# @comment: 
# {
  # {
    # @title: 
    # @comment: 
    my $run = 0;
    if ($run) {
      # To access element $n of array @a, you use the syntax $a[$n], not @a[$n].
      #   This may seem peculiar. However, it is a consistent syntax. Scalar values, not 
      #   variables, begin with $, even when those values come from an array or hash.
      my @giant = qw(fee fie foe fum);
      my @queue = ($giant[1],$giant[2]);

      # you can even use an array to provide indexing:
      my @fifo = (1,2);
      my @queue = @giant[@fifo];
      print "@queue\n";

      # now, @a[1] is as much a slice as are @a[1,2], @a[2,10], @a[5,3,1],
      #   @a[3..7], and so on: @a[1] is a list, not a scalar value. It is just
      #   a list of one element.
    }
    # output {
      # --------------------
      # fie foe
    # }
  # }
  
  # {
    # @title: lvalue slices
    # @comment: 
    my $run = 0;
    if ($run) {
      ($giant[1],$giant[2]) = ("tweedle","dee");
      @giant[1,2]=("tweedle","dee");

      # Unintentionally evaluating an operator in a list context can produce dramatic (and unfortunate)
      #   results. A good example is the line-input operator, which assigned to a slice or even assigned 
      #   in list context causes the entirely of STDIN to be evaluated immediately:
      @info[0] = <STDIN>;
      ($info[0]) = <STDIN>;
      # This reads all the lines from standard input, assigns the first one to element 0 of @info, and
      #   ignores the res! Assigning <STDIN> to @info[0] evaluate <STDIN> in a list context. In a list 
      #   context, <STDIN> reads all the lines from standard input and returns them as a list.
    }
    # output {
      # --------------------
    # }
  # }
  
  # {
    # @title: don't confuse slices and elements
    # @comment: 
    my $run = 0;
    if ($run) {
    }
    # output {
      # --------------------
    # }
  # }
  
  # {
    # @title: slicing for fun and profit
    # @comment: 
    my $run = 0;
    if ($run) {
      my ($uid,$gid) = (stat $file)[4,5];
      my $last = (sort @list)[-1];
      my $field_two = (split /:/)[1];

      # however, slices can be put to some pretty interesting (and weird) uses. For example,
      #   here are two slightly different ways to reverse elements 5 through 9 of @list:
      @list[5..9] = reverse @list[5..9];
      @list[reverse 5..9] = @list[5..9];

      # slice provide a handly way to swap two element:
      @a[$n,$m] = @a[$m,$n]; # swap $a[$m] and $a[$n]
      @item{'old','new'} = @item{'new','old'}; # swap $item{old} and $item{new}
    }
    # output {
      # --------------------
    # }
  # }
  
  # {
    # @title: use slices to reorder arrays
    # @comment: slices are also used in sorting (item 22)
    my $run = 0;
    if ($run) {
      @name = @name[sort{$uid[$a]<=>$uid[$b]} 0..$#name];
    }
    # output {
      # --------------------
    # }
  # }
  
  # {
    # @title: create hashes quicktly and easily
    # @comment: 
    my $run = 0;
    if ($run) {
      # creating a hash with 26 elements keyed "A" through "Z" with values of 1 through 26 is easy:
      @char_num{'A'..'Z'} = 1..26;

      # overlaying all of the matching elements from an existing hash with those from a new one, 
      #   while also adding any elements that exist only in the new hash, is simple:
      @new{'A'..'Z'} = 1..26;
      @old{keys %new} = values %new;
      print keys %new;

      # This task can be accomplished more tersely, but also less efficiently:
      %old = (%old,%new);

      # "Subtracting" one hash from another is just a matter of deleting from a hash using a list of keys:
      delete @name{keys %invalid};

      # the preceding one-line statement replaces the more wordy:
      foreach $key (keys %invalid) {
        delete $name{$Key};
      }
    }
    # output {
      # --------------------
      # OWESJLTXHGYCMDKABRUVPFIZQN
    # }
  # }
# }
  
# @item 12 : understand context and how it affects operations
# @comment: 
# {
  # {
    # @title: numbers and string context
    # @comment: the arithmetic operators treat data as numbers, while the string operators treat data as strings:
    my $run = 0;
    if ($run) {
      my $result = '123'+'345'; # 468
      print "$result\n";
      my $result = 123+345; # '123456'
      print "$result\n";

      if ('12' lt '2') {print "12 is less than 2!\n";}

      if ('foo' == 'bar') {print "Oh noes! foo is bar!\n";}
    }
    # output {
      # --------------------
      # 468
      # 468
      # 12 is less than 2!
      # Oh noes! foo is bar!
    # }
  # }
  
  # {
    # @title: scalar and list context
    # @comment: 
    my $run = 0;
    if ($run) {
      # the while condition is in scalar context, but the foreach condition is in list context, because that is
      #   the way they are defined:
      while (SCALAR CONTEXT HERE) {}
      foreach (LIST CONTEXT HERE) {}
    }
    # output {
      # --------------------
    # }
  # }
  
  # {
    # @title: context by assignment
    # @comment: 
    my $run = 0;
    if ($run) {
      my ($n)    = ('a','b','c'); # $n is 'a'
      my ($n,$m) = ('a','b','c'); # $n is 'a', $m is 'b'
      my @array  = ('a','b','c');
      my @lines  = <STDIN>; # reads all lines

      my $single_line = <STDIN>; # read only one line
      my $n = ('a','b','c'); # $n is 'c'
      print $n;
    }
    # output {
      # --------------------
      # c
    # }
  # }
  
  # {
    # @title: void context
    # @comment: 
    my $run = 0;
    if ($run) {
      some_sub(@args);
      grep {/foo/} @array;
      1+2;
    }
    # output {
      # --------------------
    # }
  # }
# }
  
# @item 14 : handle big numbers with bignum
# @comment: 
# {
  # {
    # @title: get all of the digits
    # @comment: 
    my $run = 0;
    if ($run) {
      use bignum;
      my $factorial = 1;
      foreach my $num (1..$ARGV[0]) {
        $factorial *= $num;
      }
      print "$factorial\n";
    }
    # output {
      # --------------------
    # }
  # }
  
  # {
    # @title: Limiting bignum's effect
    # @comment: 
    my $run = 0;
    if ($run) {
      # if you want bignum for most of the program, you can turn it off within a scope with no:
      {
        no bignum;
        # numbers in here are the regular sort
        my $sum = $n + $m;
      }
      
      # if you want to use bignum for a small portion of the program, you can enable it lexically:
      {
        use bignum;
        # numbers in here are the bignum sort
        my $sum = $n + $m;
      }

      # if you need bignum for only certain objects in your program, you can create those objects yourself
      #   and deal with them as you would any other object, so their special handling applies only to certain
      #   numbers:
      use Math::BigInt;
      my $big_factorial = Math::BigInt->new(1);
      foreach my $num (1..$ARGV[0]) {
        $big_factorial *= $num;
      }
      print "$big_factorial\n";
    }
    # output {
      # --------------------
    # }
  # }
# }
