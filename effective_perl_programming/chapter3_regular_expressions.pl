#!/usr/bin/env perl
# @item 28 : know the precedure of regular expression operators
#
# @item 29 : use regular expression captures
# {
  # @title: the capture variables: $1, $2, $3
  my $run = 0;
  if ($run) {
    $_ = 'http://www.perl.org/index.html';
    if (m#^http://([^/]+)(.*)#) {
      print "host = $1\n";
      print "path = $2\n";
    }
  }
  # output {
    # --------------------
    # host = www.perl.org
    # path = /index.html
  # }

  my $run = 0;
  if ($run) {
    $_ = 'ftp://ftp.uu.net/pub/systems';
    if (m#^ftp://([^/]+)((/[^/]*)+)#) {
      print "host     = $1\n";
      print "path     = $2\n";
      print "fragment = $3\n";
    }
  }
  # output {
  # --------------------
  # host = ftp.uu.net
  # path = /pub/systems
  # fragment = /systems
  # }

  my $run = 0;
  if ($run) {
    $_ = 'ftp://ftp.uu.net/pub';
    if (m#^((http)|(ftp)|(file):)#) {
      print "protocol = $1\n";
      print "http     = $2\n";
      print "ftp      = $3\n";
      print "file     = $4\n";
    }
  }
  # output {
  # --------------------
  # protocol = ftp
  # http     = 
  # ftp      = ftp
  # file     = 
  # }

  my $run = 0;
  if ($run) {
    # NOTE
    $_ = 'ftp://ftp.uu.net/pub';
    if (m#^([^:]+)://(.*)#) {
      print "\$1, \$2 = $1, $2\n"; # $1, $2 = ftp, ftp.uu.net/pub
      # local
      {
        # $1 and $2 start with the values from outside
        print "\$1, \$2 = $1, $2\n"; # $1, $2 = ftp, ftp.uu.net/pub
        if ( $2 =~ m#([^/]+)(.*)# ) {
          print "\$1, \$2 = $1, $2\n" # $1, $2 = ftp.uu.net, /pub
        }
      }
      # on exit from the block, the old $1 and $2 are back
      print "\$1, \$2 = $1, $2\n" # $1, $2 = ftp, ftp.uu.net/pub
    }
  }
  # output {
    # --------------------
    # $1, $2 = ftp, ftp.uu.net/pub
    # $1, $2 = ftp, ftp.uu.net/pub
    # $1, $2 = ftp.uu.net, /pub
    # $1, $2 = ftp, ftp.uu.net/pub
  # }

  # @title: numbered backreferences
  my $run = 0;
  if ($run) {
    $_ = '"stuff","more"';
    # NOTE
    if (m#(['"])(.*?)\1#) {
      print "matched = $2\n";
    }
  }
  # output {
    # --------------------
    # matched = stuff
  # }
  
  # @title: captures in substitutions
  # @comment: swap two words using a substitution
  my $run = 0;
  if ($run) {
    $_ = 'I  am';
    # NOTE
    if (s/(\S+)\s+(\S+)/$2 $1/) {
      print "$_\n"; # am I
    }
    # @comment: eliminate whitespace
    if (s/\s+//) {
      print; # amI
    }
  }
  # output {
    # --------------------
    # am I
    # amI
  # }
  
  # @title: matching in list context
  my $run = 0;
  if ($run) {
    $_ = 'Model : MX23';
    my ($name, $value) = /^([^:]*?)\s*:\s*(.*)/i;
    print "key   = $name\n";
    print "value = $value\n";

    # NOTE
    my ($slice) = (/^([^:]*?)\s*:\s*(.*)/i)[1];
    print "slice = $slice\n";

    my ($nocapture) = /^(?:[^:]*?)\s*:\s*(.*)/i;
    print "nocapture = $nocapture\n";
  }
  # output {
    # --------------------
    # key   = Model
    # value = MX23
    # slice = MX23
    # nocapture = MX23
  # }
# }
  
# @item 30 : use more precise whitespace character classes
# {
  # @title: horizontal whitespace
  my $run = 1;
  if ($run) {
  }
  # output {
    # --------------------
  # }
# }
    
# @item 30 : use more precise whitespace character classes
# {
  # @title: horizontal whitespace
  my $run = 1;
  if ($run) {
  }
  # output {
    # --------------------
  # }
# }

# @item 31 : use named captures to label matches
# {
  my $run = 0;
  if ($run) {
    $_ = 'Buster and Mini';
    if (/(\S+) and (\S+)/) {
      my ($first,$second) = ($1,$2);
      print "first        = $first\n";
      print "second       = $second\n";
    }
  }
  # output {
    # --------------------
    # first        = Buster
    # second       = Mini
  # }

  my $run = 0;
  if ($run) {
    $_ = 'Buster and Mini';
    # NOTE
    if (/(?<first>\S+) (and|or) (?<second>\S+)/) {
      my ($first,$second) = ( $+{first}, $+{second} );
      print "first        = $first\n";
      print "second       = $second\n";
    }
  }
  # output {
    # --------------------
    # first        = Buster
    # second       = Mini
  # }

  my $run = 0;
  if ($run) {
    $_ = 'Buster and Buster';
    if (/(?<first>\S+) (and|or) \k<first>/) {
      my ($first,$third) = ( $+{first}, $3 );
      print "first        = $first\n";
      print "third        = $third\n";
    }
  }
  # output {
    # --------------------
    # first       = Buster
    # third       = 
  # }

  my $run = 0;
  if ($run) {
    $_ = 'Buster and Buster';
    if (/(?<first>\S+) (and|or) \g1/) {
      my ($first,$third) = ( $+{first}, $3 );
      print "first       = $first\n";
      print "third       = $third\n";
    }
  }
  # output {
    # --------------------
    # first       = Buster
    # third       = 
  # }

  my $run = 0;
  if ($run) {
    $_ = 'Buster and Buster';
    if (/(?<first>\S+) (and|or) \g1/) {
      my ($first,$third) = ( $+{first}, $3 );
      print "first       = $first\n";
      print "third       = $third\n";
    }
  }
  # output {
    # --------------------
    # first       = Buster
    # third       = 
  # }

  my $run = 0;
  if ($run) {
    $_ = 'Buster and Buster';
    if (/(?<first>\S+) (and|or) \g{-2}/) {
      my ($first,$third) = ( $+{first}, $3 );
      print "first       = $first\n";
      print "third       = $third\n";
    }
  }
  # output {
    # --------------------
    # first       = Buster
    # third       = 
  # }
# }
  
# @item 32 : use nocapturing parantheses when you need only grouping
# {
  # @title: 
  my $run = 0;
  if ($run) {
    # map
    my @headers = ("Subject: :re: math" , "subject: :re: English");
    my @subjects = map { /subject:\s+(?:re:\s*)?(.*)/i } @headers;
    print "@subjects\n";

    my $string = '1:2; 3: 4 ;5';
    # without nocapture
    my @items = split /\s*(:|;)\s*/,$string;
    print "@items\n";
    # NOTE
    # use nocapture
    my @items = split /\s*(?::|;)\s*/,$string;
    print "@items\n";
  }
  # output {
    # --------------------
    # :re: math :re: English
    # 1 : 2 ; 3 : 4 ; 5
    # 1 2 3 4 5
  # }
# }
  
# @item 33 : watch out the match variables
# {
  # @title: 
  my $run = 0;
  if ($run) {
    'My cat is Buster Bean' =~ m/Buster/;
    print <<"HERE";
     Prematch  : $`
     Match     : $&
     Postmatch : $'
HERE
  }
  # output {
    # --------------------
    # Prematch  : My cat is 
    # Match     : Buster
    # Postmatch :  Bean
  # }
  
  # @title: use the /p flag
  my $run = 0;
  if ($run) {
    # NOTE
    'My cat is Buster Bean.' =~ m/\s\w+\sBean/p;
    print "Prematch  : ${^PREMATCH}\n";
    print "Match     : ${^MATCH}\n";
    print "Postmatch : ${^POSTMATCH}\n";
  }
  # output {
    # --------------------
    # Prematch  : My cat is
    # Match     :  Buster Bean
    # Postmatch : .
  # }
# }
  
# @item 34 : avoid greed when parsimony is best
# {
  # @title: 
  # @comment: match a single-quoted string the nogreedy way
  my $run = 0;
  if ($run) {
    $_ = "This 'test' isn't sucessful?";
    my ($str) = /('.*?')/;
    print "$str"; # 'test'
  }
  # output {
    # --------------------
    # 'test'
  # }
# }

# @item 35 : use zero-width assertions to match positions in string
  
# @item 36 : avoid using regular expressions for simple string operations
# {
  # {
    # @title: compare strings with string-comparsion operators
    # @comment: 
    my $run = 0;
    if ($run) {
      # the fast way
      my $answer = "yes";
      if ( $answer eq "yes" ) { print "test\n" }
      # the fast way
      my $answer = "YES";
      if ( lc($answer) eq "yes" ) { print "test\n" }
    }
    # output {
      # --------------------
      # test
      # test
    # }
  # }
  
  # {
    # @title: find substrings with index and rindex
    # @comment: 
    my $run = 1;
    if ($run) {
      my $big_str = "this is string string";
      my $little_str = "str";
      # fast
      my $pos = index $big_str,$little_str;
      print "index = $pos\n";
      my $pos = rindex $big_str,$little_str;
      print "rindex = $pos\n";
    }
    # output {
      # --------------------
      # index = 8
      # rindex = 15
    # }
  # }
  
  # {
    # @title: extract and modify substrings with substr
    # @comment: 
    my $run = 0;
    if ($run) {
      # fast
      my $perl = substr "It's a Perl World",7,4;
      my $perl_world = substr "It's a Perl World",7;
      print "extract : $perl\n";
      print "extract : $perl_world\n";
      # change the world
      my $world = "It's a Perl World";
      substr($world,7,4) = 'Mad Mad Mad';
      print "replace : $world\n";
      # NOTE
      # look for perl, then replace it
      my $world = "It's a Perl World";
      substr($world,index($world,"Perl"),length("Perl")) = 'Mad Mad Mad';
      print "replace : $world\n";
    }
    # output {
      # --------------------
      # extract : Perl
      # extract : Perl World
      # replace : It's a Mad Mad Mad World
      # replace : It's a Mad Mad Mad World
    # }
  # }
# }
  
# @item 37 : make regular expressions readable
# {
  # {
    # @title: add whitespace and comments to regular expressions
    # @comment: the /x flag, which you can apply to both pattern matched and substitutions, 
    #           tells the regular-expression parser to ignore whitespace 
    #           (so long as it isn't preceded by a backslash), including comments.
    my $run = 0;
    if ($run) {
      # NOTE
      $_ = "Testing
      one
      two"; # $_ contains embedded newlines
      my ($str) = m/
        ( # start of $1
        " # start of double-quoted string

        (?:
          \\\W | # special char, \+
          \\x[0-9a-fA-F]{2} | # hex, \xDE
          \\[0-3][0-7]{2} | # octal \0377
          [^"\\] # ordinary char
        )*

        "
      ) # end of $1
      /x;
      print "$str\n";
    }
    # output {
      # --------------------
    # }
  # }
  
  # {
    # @title: break complex regular expressions into pieces
    # @comment: with qr// (item 40), you can create the subpatterns that you compose into a larger regular expressions
    my $run = 1;
    if ($run) {
      # NOTE
      my $num = qr/[0-9]+/;
      my $word = qr/[a-zA-Z_]+/;
      my $space = qr/[ ]+/;
      $_ = "Testing 1 2 3";
      my @split = /($num | $word | $space)/gxo;
      print join(":",@split),"\n";
    }
    # output {
      # --------------------
      # Testing: :1: :2: :3
    # }

    my $run = 0;
    if ($run) {
      # NOTE
      my $whole = do {
        # escaped char like \", \$
        my $spec_ch = qr/\\ \W/x;
        
        # hex escape: \xab
        my $hex_ch = qr/\\x [0-9a-fA-F]{2} /x;
        
        # oct escape: \123
        my $oct_ch = qr/\\ [0-3][0-7]{2} /x;
        
        # ordinary char
        my $char = qr/[^\"\\]/;

        qr/ 
          (
            "
            (?: $spec_ch | $hex_ch | $oct_ch | $char) *
            "
          )
        /xo;
      };
      # ... and here's the actual regular expression ...
      my ($str) = /$whole/o;
      print "The regexp is---\n$whole\n---\n";
    }
    # output {
      # --------------------
      # The regexp is---
      # (?^x: 
      #           (
      #             "
      #             (?: (?^x:\\ \W) | (?^x:\\x [0-9a-fA-F]{2} ) | (?^x:\\ [0-3][0-7]{2} ) | (?^:[^\"\\])) *
      #             "
      #           )
      #         )
      # ---
    # }
  # }
# }
  
# @item 38 : avoid unnecessary backtracking
# {
  # {
    # @title: use a character class ([abc]) instead of alternation
    # @comment: 
    my $run = 0;
    if ($run) {
      while (<>) {
        push @avr, m'([$@%&]\w+)'g
      }
    }
    # output {
      # --------------------
    # }
  # }
# }
  
# @item 39 : compile regexes only once.
# {
  # {
    # @title: 
    # @comment: Perl reuses the complied from again and again during run time:
    my $run = 0;
    if ($run) {
      # count occurences of magic_word in @big_long_list
      foreach (@big_long_list) {
        $count += /\bmagic_word\b/o; # compile once
      }
    }
    # output {
      # --------------------
    # }
  # }
# }
  
# @item 40 : pre-compile regular expressions
# {
  # {
    # @title: 
    # @comment: you can compile $regex into your match or substitution operators just as you could with strings.
    my $run = 0;
    if ($run) {
      my $regex = qr/Buster(.*)Mini/si;
      # count occurences of magic_word in @big_long_list
      foreach (@big_long_list) {
        $count += /$regex/; # compile once
      }
    }
    # output {
      # --------------------
    # }
  # }
# }
  
# @item 41 : benchmark your regular expressions
  
# @item 42 : don't reinvent the regexp
  
# @reference : advanced perl programming
# @chapter5 : eval
#{
  # {
    # @title: 
    # @comment: you can compile $regex into your match or substitution operators just as you could with strings.
    my $run = 0;
    if ($run) {
      sub generate_part2 {
        # 参数处理
        my ($col1, $col2);
        foreach $arg (@ARGV) {
          # NOTE
          if (($col1,$col2) = ($arg =~ /^(\d+)-(\d+)/)) {
            $col1--;
            $offset = $col2 - $col1;
            add_range($col1,$offset);
          } elsif (($col1,$col2) = ($arg =~ /^(\d+)+(\d+)/)) {
            $col1--;
            add_range($col1,$offset);
          } elsif ($size = ($arg =~ /-s(\d+)/)) {
            # 空操作
          } elsif ($arg =~ /^-d/) {
            $debugging = 1;
          } else {
            # 必须是一个文件名
            push (@files,$arg);
          }
        }
      }
    }
    # output {
      # --------------------
    # }
  # }
# }
