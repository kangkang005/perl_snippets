#!/usr/bin/env perl
# @item 43 : understand the difference between my and local
# {
  # {
    # @title: global variables
  # }
  
  # {
    # @title: lexical (compile-time) scoping with my
    # @comment: 
    my $run = 0;
    if ($run) {
      $a = 3.1415926; # global
      {
        my $a = 2.7183; # lexical
        print "$a\n";       # 2.7183
      }
      print $a; # 3.1415926;
    }
    # output {
      # --------------------
      # 2.7183
      # 3.1415926
    # }
    
    # @comment: qualified names vs. my variables
    my $run = 0;
    if ($run) {
      {
        my $a = 3.1416; 
        $main::a = 2.7813;
        print "(inside) a = $a\n";
        print "(inside) main::a = $main::a\n";
        print "(inside) ::a= $::a\n";
      }
      print "(outside) a = $a\n"
    }
    # output {
      # --------------------
      # (inside) a       = 3.1416
      # (inside) main::a = 2.7813
      # (inside) ::a     = 2.7813
      # (outside) a      = 2.7813
    # }
    
    # @comment: soft reference vs. my variables
    my $run = 0;
    if ($run) {
      my $a = 3.1416;
      ${'a'} = 2.7183;
      print "my a = $a\n";
      print "{a} = ${'a'}\n";
    }
    # output {
      # --------------------
      # my a = 3.1416
      # {a}  = 2.7183
    # }
   
    # @comment: typeglobs vs. my variables
    my $run = 0;
    if ($run) {
      $a = 2.7183;
      my $a = 3.1416;
      *alias = *a;
      print "my a = $a\n";
      print "alias = $alias\n";
      print "{a} = ${'a'}\n";
      print "::a = $::a\n";
    }
    # output {
      # --------------------
      # my a  = 3.1416
      # alias = 2.7183
      # {a}   = 2.7183
      # ::a   = 2.7183
    # }
  # }
  
  # {
   # @title: run time scoping with local
    # @comment: your basic use of 'local'
    my $run = 0;
    if ($run) {
      $a = 3.1416; 
      {
        local $a = 2.7183; 
        print "$a\n";       # 2.7183
      }
      print "$a\n";       # 3.1416
    }
    # output {
      # --------------------
      # 2.7183
      # 3.1416
    # }
    
    # @comment: use a soft reference to take a peek into the symbol tabl:
    my $run = 0;
    if ($run) {
      $a = $b = 3.1416;
      {
        local $a = 2.7183;
        my $b = 2.7183;
        print "IN: local a = $a, my b = $b\n";
        print "IN: {a} = ${'a'}, {b} = ${'b'}\n";
      }
      print "OUT: local a = $a, my b = $b\n";
    }
    # output {
      # --------------------
      # IN: local a  = 2.7183, my b = 2.7183
      # IN: {a}      = 2.7183, {b}  = 3.1416
      # OUT: local a = 3.1416, my b = 3.1416
    # }
    
    # @comment: the most notorious example of this is the nested subroutine call:
    my $run = 0;
    if ($run) {
      $a = 3.1416;
      sub print_a { print "a = $a\n" }
    
      sub localize_a {
        print "entering localize_a\n";
        local $a = 2.7183;
        print_a();
        print "leaving localize_a\n";
      }
      print_a();
      localize_a();
      print_a();
    }
    # output {
      # --------------------
      # a = 3.1416
      # entering localize_a
      # a = 2.7183
      # leaving localize_a
      # a = 3.1416
    # }
  # }
  
  # {
    # @title: when to use my
  # }
    
  # {
    # @title: when to use local
    # @comment: you can use local in a number of other situations where you can't use my, such as on
    #           a variable in another package:
    my $run = 0;
    if ($run) {
      package foo;
      $a = 3.1416;
      {
        package main;
        local $foo::a = 2.7183;

        package foo;
        print "foo::a = $a\n";
      }
      package foo;
      print "foo::a = $a\n";
    }
    # output {
      # --------------------
      # foo::a = 2.7183
      # foo::a = 3.1416
    # }
    
    # @comment: you can also use local on elements of arrays and hashes. Yes, it's strange,
    #           but true. You can use local on a slice:
    my $run = 0;
    if ($run) {
      @a = qw(Jolly Green Giant);
      {
        local (@a[0,1]) = qw(Grumbly Purple);
        print "@a\n";
      }
      print "@a\n";
    }
    # output {
      # --------------------
      # Grumbly Purple Giant
      # Jolly Green Giant
    # }
  # }
  
  # {
    # @title: local and my as list operators
    # @comment: 
    my $run = 0;
    if ($run) {
      local $scalar = 3.1416;
      my $array = qw(Marry had a little lamb);
      local %hash = ( H => 1, He => 2, Li => 3 );
      local ( $foo, $bar, $bletch ) = @a; # list 3 elems from @a
    }
    # output {
      # --------------------
    # }
  # }
# }
  
# @item 44 : avoid using @_ directly unless you have to
# {
  # {
    # @title: lexical (compile-time) scoping with my
    # @comment:  the idiomatic way to read arguments passed to a subroutine is to use
    #           shift to get them one at a list assignment to read them all:
    my $run = 0;
    if ($run) {
      sub digits_gone {
        my ($str) = @_;
        $str =~ tr/0-9//d;  # remove digits from a string
        $str;               # return translated string
      }
      print digits_gone("test1234"); # test

      sub char_count {
        my $str = shift;
        my @char = @_;
        my @counts;
        for (@chars) {
          push @counts, eval "\$str =~ tr/$_//";
        }
        @counts; # return list of counts
      }
    }
    # output {
      # --------------------
      # test
    # }
  # }
# }
  
# @item 45 : use wantarray to write subroutine returning lists
  
# @item 46 : pass references instead of copies
# {
  # {
    # NOTE
    # @title: passing reference arguments
    # @comment:  
    my $run = 0;
    if ($run) {
      sub process_refs {
        my (@array_refs) = @_;  # refs to all arrays
        foreach my $ref (@array_refs) {
          # ... process array ...
          print "$ref\n";
          # ARRAY(0x558baa843a60)
          # HASH(0x558baa8434f0)
          # CODE(0x558baa820400)
        }
      }
      process_refs(\@array,\%hash,\&sub_name);

      process_big_string(\$string);
      sub process_big_string {
        my $string_ref = shift;

        $string_ref =~ s/\bPERL\b/Perl/g;
      }
    }
    # output {
      # --------------------
      # ARRAY(0x558baa843a60)
      # HASH(0x558baa8434f0)
      # CODE(0x558baa820400)
    # }
  # }
  
  # {
    # @title: returning reference arguments
    # @comment: here's a subroutine that reads in an entire and returns a reference to
    #           the scalar that has its contents
    my $run = 0;
    if ($run) {
      my $string_ref = slurp_file($file);
      print "The file was:\n$$string_ref\n";
      
      # NOTE
      # read the whole file at once
      sub slury_file {
        my $file = shift;
        open my ($fh), '<', $file or die;
        local $/;
        my $content = <$fh>;

        \$content;
      }

      my ( $array_ref, $hash_ref ) = make_data_struture();
      sub make_data_struture {
        # ...
        return \@array, \%hash;
      }
    }
    # output {
      # --------------------
    # }
  # }
  
  # {
    # @title: passing typeglobs for speed
    # @comment: here's an example of using typeglobs to contruct a subroutine that
    #         takes two arrays by reference.
    my $run = 0;
    if ($run) {
      local *a1 = shift; # create a private a1 and a2
      local *a2 = shift;
      
      # now, do whatever it is to @a1 and @a2 ..

      our @a = 1 .. 3;
      our @b = 4 .. 6;
      # two_arrays *a, *b;
    }
    # output {
      # --------------------
    # }
  # }
  
  # {
    # @title: using local * on reference arguments
    # @comment: one way to get around this problem is to alias variables to the arrays.
    #         assigning a reference to typeglob has the effect of creating an aliased
    #         vairable of the type appropriate to the reference:
    my $run = 1;
    if ($run) {
      sub max_v_local {
        local ( *a, *b ) = @_;
        my $n = @a > @b ? @a : @b;
        my @result;
        for ( my $i = 0 ; $i < $n ; $i++ ) {
          push @result, $a[$i] > $b[$i] ? $a[$i] : $b[$i];
        }
        @result;
      }
      # my @ary1 = qw(12 33 1 3);
      # my @ary2 = qw(20 4 100);
      # print max_v_local(@ary1,@ary2);
    }
    # output {
      # --------------------
    # }
  # }
  
  # {
    # @title: use hashes to pass named parameters.
    # @comment: 
    my $run = 0;
    if ($run) {
      sub uses_named_params {
        my %param = {
          foo => 'val1',
          bar => 'val2',
        };
        my %input = @_; # read in args as a hash

        # NOTE
        # combine params read in with defaults
        @param{ keys %input } = values %input;

        # now, use $param{foo}, $param{bar}, etc.
        # ....
      }
    }
    # output {
      # --------------------
    # }
    
    # @comment: 
    my $run = 1;
    if ($run) {
      sub uses_minus_params {
        my %param = ( -foo => 'val1', -bar => 'val2' );
        my %input;

        if ( substr($_[0],0,1) eq '-' ) {
          # NOTE
          # read in named params as a hash
          %input = @_;
        } else {
          my @name = qw(-foo -bar);
          # give positional params names and save in a hash
          # NOTE
          %input = map {$name[$_], $_[$_]} 0..$#_;
        }
        # overlay params on defaults 
        @param{keys %input} = values %input;
        # use $param{-foo}, $param{-bar}
        print %input;
      }
      uses_minus_params(-foo, 12);
      uses_minus_params(8888,100);
    }
  # }
# }
