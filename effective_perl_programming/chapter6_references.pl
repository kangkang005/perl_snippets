#!/usr/bin/env perl
# @item 58 : understand references and reference syntax
# @comment: a reference is a scalar value
# {
  # {
    # @title: creating references
    # @comment: 
    my $run = 0;
    if ($run) {
      # the backslash operator works on any kind of variable name:
      my $a          = 3.1416;
      my $scalar_ref = \$a;
      my $array_ref  = \%a;
      my $sub_ref    = \&a;
      my $glob_ref   = \*a;
      # it also works on array and hash elements:
      $array_elem_ref = \$a[0];
      $hash_elem_ref = \$a{'hello'};
      # it even works on literal values, although references to literal values are read-only:
      $one_ref = \1;
      $mode_ref = \oct('0755');
      # when you create a reference using the ampersand, you get back a CODE reference to the val subroutine itself:
      sub val {return 1..3};
      my $ref1 = \(&val);
      my $ref2 = \(val());
      my ($ref3) = \(val());
      my $ref4 = \(1..3);
      my $ref5 = \(1,2,3);
      # this is the customary method of creating a reference to a list of items.
      my $a_ref = [1..3];
      # $a_ref is now an ARRAY reference to an unnamed array containing the values 1,2 and 3.
      print ref $a_ref, "@$a_ref";
      # the anonymous hash constructor, which uses braces rather than brackets, works similarly:
      my $h_ref = {anonymous => 'user'};
      $h_ref->{'joe'} = 'bloe';
      $h_ref->{'john'} = 'public';
      # references to subroutines are sometimes called coderefs. Here you store a coderef in $greetings and then execute the reference code:
      my $greetings = sub{print "hello, world!\n"};
      $greetings->();
      # this style of subroutine creation is often used in signal handling, as in this interrupt handler:
      $SIG{INTR} = sub {print "not yet--I'm busy\n"};
      # the first call to some_sub() makes a copy of the entire contents of $string, while the second call copies only the reference to the string:
      my $string = 'a' x 1_000_000;
      some_sub($string);
      some_sub(\$string);
    }
    # output {
      # --------------------
      # ARRAY1 2 3
      # hello, world!
    # }
  # }
  
  # {
    # @title: using references
    # @comment: dereferencing uses the value that a reference points to. there are several difference forms of dereferencing syntax
    my $run = 0;
    if ($run) {
      my $a = 1;
      my $s_ref = \$a;
      print ${$s_ref};
      ${$s_ref} += 1;

      # array references work in a similar manner.
      my @a = 1..5;
      my $a_ref = \@a;
      print "@a";
      push @{$a_ref}, 6..10;
      
      # In this contrived example, you return the third value of one of two difference arrays based on the value of the variable $hi:
      my $ref1 = [1..5];
      my $ref2 = [6..10];
      my $val = ${
        if ($hi) { $ref2; }
        else {$ref1}
      }[2];
      print $val; # either 3 or 8
      
      # you can more than one $ if it's a reference to a reference. This example uses a reference to a scalar and a reference to a reference
      #   to print the world testing twice:
      my $a = 'testing';
      my $s_ref = \$a;
      my $s_ref_ref = \$s_ref;
      print "$$s_ref $$$s_ref"; 

      # this even applies to references to hashes:
      my $h_ref = { 'F'=>9,'C1'=>17,'Br'=>35 };
      print "The elements are",join ' ', keys %$h_ref, "\n";
      print "F's atomic number is $$h_ref{'F'}\n";

      ${$h_ref}{'F'}; # canonical form
      $$h_ref{'F'}; # scalar variable form
      $h_ref->{'F'}; # arrow form

      # you can cascade arrows
      $student->[1] = {'first'=>'joe','last'=>'bloe'};
      print $student->[1]->{'first'};
      print $student->[1]{'first'};
      
      # this reference to a scalar value results in SCALAR being printed:
      my $s_ref = \1;
      print ref $s_ref;
      
      # and this subroutine reference causes CODE to be printed:
      my $c_ref = sub {'code!'};
      print ref $c_ref;
    }
    # output {
      # --------------------
      # 11 2 3 4 53testing The elements areC1 Br F 
      # F's atomic number is 9
      # joejoeSCALARCODE
    # }
  # }
  
  # {
    # @title: autovivification
    # @comment: if you use a scalar with an undefined value as if it were a reference to another object,
    #           Perl automatically creates an object of the appropriate type and makes that scalar a reference
    #           to that type. This is called autovivification
    my $run = 0;
    if ($run) {
      undef $ref;
      $ref->[3] = 'four';
      
      # this can be especially handy for deep data structures, saving you the work of creating each level:
      use Data::Dumper;
      my $ds;
      $ds->{top}[0]{cats}[1]{name} = 'Buster';
      print Dumper($ds);
    }
    # output {
      # --------------------
      # $VAR1 = {
      #           'top' => [
      #                      {
      #                        'cats' => [
      #                                    undef,
      #                                    {
      #                                      'name' => 'Buster'
      #                                    }
      #                                  ]
      #                      }
      #                    ]
      #         };
    # }
  # }
  
  # {
    # @title: soft reference
    # @comment: the variable will be created if necessary. this is called a soft reference.
    my $run = 0;
    if ($run) {
      my $str = 'pi';
      ${$str} = 3.1416;
      print "pi = $pi\n";

      # you might even use literal string to create the soft reference:
      ${'e'.'e'} = 2.7183;
      print "ee = $ee\n"; # 2.7183

      # ${} = 'space';
      # ${' '} = 'space';
      # ${'  '} = 'two space';
      # ${'\0'} = 'null';
    }
    # output {
      # --------------------
      # pi = 3.1416
      # ee = 2.7183
    # }
  # }
# }
  
# @item 59 : compare reference types to prototypes
# @comment: 
# {
  # {
    # @title: the ref operator
    # @comment: 
    my $run = 0;
    if ($run) {
      my $array_ref = \@array;
      my $type = ref $array_ref; # $type is 'ARRAY'
      print $type;
    }
    # output {
      # --------------------
      # ARRAY
    # }
  # }
  
  # {
    # @title: comparing types
    # @comment: 
    my $run = 0;
    if ($run) {
      sub count_matches {
        my ($regex,$array_ref) = @_;
        # ref of empty anonymous array
        my $ARRAY_TYPE = ref [];
        
        # ref of empty anonymous regex
        my $REGEX_TYPE = ref qr//;
        
        # ref of empty anonymous hash
        my $HASH_TYPE = ref {};
        
        # ref of empty anonymous hash
        my $CODE_TYPE = ref sub {};

        die "First argument needs to be a regex reference"
          unless ref $regex eq $REGEX_TYPE;
        die "Second argument needs to be a array reference"
          unless ref $regex eq $ARRAY_TYPE;
        
        my $matches = grep /$regex/, @$array_ref;
      }
    }
    # output {
      # --------------------
    # }
  # }
# }
  
# @item 60 : create arrays of arrays with reference
# @comment: perl has no lists per se, but an array containing array references does the trick. this is commonly called an array of arrays or just AoA.
# {
  # {
    # @title: 
    # @comment: 
    my $run = 0;
    if ($run) {
      # an array of refs to arrays
      my @a = ([1,2],[3,4]);
      print "$a[1][0]\n"; # gives 3
      
      # a ref to an array of refs to arrays
      my $a = [[1,2],[3,4]];
      print "$a->[1][0]\n"; # gives 3

      my $max = 5;
      my $matrix;
      for (my $i = 1 ; $i < $max ; $i++ ) {
        for (my $j = 0 ; $j < $max ; $j++ ) {
          $matrix->[$i][$j] = $i * $j;
        }
      }

      # you need the -> after $matrix because it's a reference
      my $format = ' %2d' x @{$matrix};
      printf " i/j $format\n", 0 .. $max;
      for my $i (0..$max-1) {
        printf "%2d:  $format\n", $i, @{$matrix->[$i]};
      }

      # suppose you want quick access to lines of text:
      my @lines;
      while (<>) {
        chomp;
        push @lines, [split];
      }
      # In this case, @lines is an array (not a reference), so you don't use a leading -> :
      my $third_on_seventh = $lines[6][2];
      # How many words are on line 15 in the file?
      my $count = @{$lines[14]};
      # Which line has the most words? you can use a Schwartzian Transform (item 22) to 
      #     sort the indices for @lines to avoid creating a copy of your data
      my ($most_words) = 
        map { $_-> [0] }
        sort { $b->[1] <=> $a->[1] }
        map { [ $_, scalar @{$lines[$_]}] } 0 .. $#lines;
      print "Line $most_words is the longest with ",
        scalar @{$line[$most_words]}, " words\n";

      # you could do it as one long list operation, and you might enjoy puzzling out this 
      #   variation on the Schwartzian Transform
      printf "Line %s is the longest with %s words\n",
        map {@$_}
        sort {$b->[1] <=> $a->[1]}
        map {state $l = 0; [$l++,scalar @$_]}
        map {[split]}
        <>;
    }
    # output {
      # --------------------
      # 3
      # 3
      #  i/j   0  1  2  3  4
      #  0:    0  0  0  0  0
      #  1:    0  1  2  3  4
      #  2:    0  2  4  6  8
      #  3:    0  3  6  9 12
      #  4:    0  4  8 12 16
      # Line 0 is the longest with  words
      # Line  is the longest with  words
    # }
  # }
# }
  
# @item 61 : don't confuse anonymous arrays with list literals
# @comment: the anonymous array constructor, [], looks very much like the parantheses that surround list literals
# {
  # {
    # @title: 
    # @comment: 
    my $run = 0;
    if ($run) {
      # if you didn't have [], you might try:
      {my @arr = 0..9; $aref = \@arr}
      print "$$aref[4]\n"; # gives 4
      # or perhaps:
      my $aref = do {\(my @arr = 0..9)};
      # but you do have []:
      my $aref = [0..9];
      print "$aref->[3]\n";
    }
    # output {
      # --------------------
      # 4
      # 3
    # }
  # }
# }

# @item 62 : build C-style structs with anonymous hashes
# @comment: 
# {
  # {
    # @title: 
    # @comment: 
    my $run = 0;
    if ($run) {
      $student{'last'} = 'Smith';
      $student{'first'} = 'John';
      $student{'bday'} = '01/08/72';

      # omit the quotation
      $student{last} = 'Smith';

      # using anonymous hash constructors to create them
      my $student1 = {
        last => 'Smith',
        first => 'John',
        bday => '01/08/72',
      };
      
      # using the arrow syntax to access the members of your "structures" makes things look even more like C or C++
      $student2 = {};
      $student2->{last} = 'Smith';
      $student2->{first} = 'John';
      $student2->{bday} = '01/08/72';

      # since you are now manipulating scalars, not hashes, passing them into subroutines is more efficient, 
      #   and passing more than one at a time is no problem:
      sub roommates {
        my ($roomie1,$roomie2) = @_;
        # ... 
        print "$roomie1->{first}\n";
        print "$roomie2->{bday}\n" 
      }
      roommates($student1,$student2);
    }
    # output {
      # --------------------
      # John
      # 01/08/72
    # }
  # }
# }
  
# @item 63 : be careful with circular data structures
# @comment: 
# {
  # {
    # @title: 
    # @comment: reference counting fails when objects point to one another in a circular or
    #           self-referential fashion. Consider the following example:
    my $run = 0;
    if ($run) {
      package Circular;
      sub new {
        my $class = shift;
        return bless {name=>shift}, $class;
      }
      sub DESTROY {
        my $self = shift;
        print "$self->{name}: nuked\n";
      }

      # perl eventually destroys these objects. At the very end of a thread of execution,
      #   perl makes a pass with a "mark-sweep" garbage collector, this final pass destroys 
      #   all of the objects created by the interpreter, accessible or otherwise. If you run
      #   the example above, you will see the final pass in action:
      #     the end
      #     b: nuked
      #     a: nuked
      package main;
      {
        my $a = Circular->new('a');
        my $b = Circular->new('b');
        $a->{next} = $b;
        $b->{next} = $a;
      }
      print "the end\n";

      # here, we save a link into the circular data structure in the variable $head.
      #   since there is only a single cycle in the structure, breaking a single link is
      #   enough to allow Perl to reclaim all the objects in it. If this doesn't seem thorough
      #   enough, you can handle them all yourself:
      package main;
      {
        my $a = Circular->new('a');
        my $b = Circular->new('b');
        $a->{next} = $b;
        $b->{next} = $a;
        $head = $a;
      }
      undef $head->{next};
      undef $head;

      # here you traverse the structure and explicitly destroy every one of the troublesome 
      #   references. You are destroying references to the objects you want to delete so that
      #   their reference counts go to zero. There is no way to explicitly destroy an object in Perl
      #   regardless of its reference count; if there were, it could be a horrendous source of bugs and crashes.
      while ($head) {
        my $next = $head->{next};
        undef $head->{next};
        $head = $next;
      }
      undef $head;
      print "the end\n";
      
      # another approach is to do the work in two passes, in a fashion somewhat like that of
      #   a mark-sweep collector.First, acquire a list or "catalog" of the references that you
      #   need to destroy:
      my $ptr = $head;
      do {
        push @refs, \$head->{next};
        $head = $head->{next};
      } while ( $ptr != $head );
      $ptr = $head = undef;

      # this loop traverses the self-referential structure and collects a list of references to all the references
      #   you need to destroy. The next pass just traverses the list and destroys them:
      foreach (@refs) {
        print "preemtive strike on $$_\n";
        undef $$_;
      }
      # a two-pass approach is extravagant in the case of a simple circular list like this one, but in the case of a graph-like
      #   structure containing many cycles, it may be the only alternative.
    }
    # output {
      # --------------------
      # the end
      # b: nuked
      # a: nuked
      # the end
      # b: nuked
      # a: nuked
    # }
  # }
# }
  
# @item 64 : use map and grep to manipulate complex data structures
# @comment: perl's map and grep operators are perfect choices for chores like these
# {
  # {
    # @title: slicing with map
    # @comment: 
    my $run = 1;
    if ($run) {
      open my ($points), '<', 'points'
        or die "couldn't read points data: $!\n";

      while (<$point>) {
        next if /^\s*#.*$/;   # skip comments
        push @xyz, [split];
      }

      foreach my $pt (@xyz) {
        print "point ", $i++,
          ": x = $pt->[0], y = $pt->[1], ",
          "z = $pt->[2]\n";
      }

      # you could write a loop using an explicit index, or perhaps a C-style for loop:
      for ($i=0;$i<@xyz;$i++) {
        push @x,$xyz[$i][0];
      }
      # but, really, this is a natural application for map:
      my @x = map {$_->[0]} @xyz;
    } 
    # output {
      # --------------------
    # }
  # }
  
  # {
    # @title: nesting with map
    # @comment: 
    my $run = 0;
    if ($run) {
      # use [] inside map to create more deeply nested structures:
      my @xyz = map {[$x[$_], $y[$_], $z[$_]]} 0..$#x;
      # you can no doubt envision a host of variations on the slicing and nesting
      #   themes, For example, switching the x(0th) and y(1st) coordinates:
      my @yxz = map {[$_->[1], $_->[0], $_[2]]} @xyz;
      # you can do the same thing with a slice that rearranges the elements, which is a bit nicer to look at:
      my @yxz = map {
        [@$_[1,0,2]]
      } @xyz;
      # or, perhaps you create a new list containing the magnitudes of the points:
      my @mag = map {
        sqrt( $_->[0] * $_->[0] +
              $_->[1] * $_->[1] +
              $_->[2] * $_->[2]
        ) 
      } @xyz;
      # the Schwartzian Transform (item 22) is an application that uses both slicing and nesting operations with map:
      my @sorted_by_mtime = 
        map { $_->[0] }     # slice
        sort { $a->[1] <=> $b->[1] } 
        map { [$_, -M $_] }   # nest
        @files;
    }
    # output {
      # --------------------
    # }
  # }
  
  # {
    # @title: selecting with grep
    # @comment: suppose that you would like to filter @xyz so that it contains only points whose y coordinates are greater than
    #           their x coordinates. You could write a loop (how did you guess we were going to say that?)
    my $run = 0;
    if ($run) {
      foreach $pt (@xyz) {
        if ($pt->[1] > $pt->[0]) {
          push @y_gt_x, $pt;
        }
      }
      # but this time, you have a task that is perfectly suited to grep:
      my @y_gt_x = grep {$_->[1] > $_->[0]} @xyz;
      # of course, you can combine map and grep ——— for example, to gather the x
      #   coordinates of the points with y greater than x;
      my @x = map {$_->[0]} grep {$_->[1] > $_->[0]} @xyz;
      my @x = map {$_->[0] > $_->[1] ? ($_->[0]):()} @xyz;
    }
    # output {
      # --------------------
    # }
  # }
# }
