#!/usr/bin/env perl
# @item 51 : don't ignore the file test operators
# @comment: a reference is a scalar value
# {
  # {
    # @title: 
    # @comment: 
    my $run = 0;
    if ($run) {
      my (
        $dev, $ino, $mode, $nlink, $uid,
        $gid, $rdev, $size, $atime, $mtime,
        $ctime, $blksize, $block, 
      ) = stat($filename);

      # or, perhaps they know how to avoid the extra variables that they don't 
      #   want, so they don't want, so they use a slice (item 9):
      my ($size) = (stat $filename)[7];
      
      # and indeed, it is if you use the -s file test operator, which tells you
      #   the file size in bytes:
      my $size = -s $filename;

      # almost all file tests use $_ by default:
      my @textfiles = grep {-T} glob "$dir_name/*";

      # if you want to find the files that haven't been modified in the past seven days,
      #   you look for a -M value that is greater than 7:
      my $old_files = grep {-M > 7 } glob '*';

      # in this example, if -M returns something less than zero, map gives an anonymous array
      #   that has the name of the file and the modification age in days; otherwise, it gives
      #   the empty list:
      # my @new_files = map {-M < 0 ? [$_,-M] : ()} glob '*';
    }
    # output {
      # --------------------
    # }
  # }
  
  # {
    # @title: reusing work
    # @comment: 
    my $run = 0;
    if ($run) {
      # if you want to find all of the files owned by the user running the program that are executable,
      #   you can combine the file tests in a grep:
      my @my_executables = grep {-o and -x} glob '*';

      # if you want to use another file test operator on the same file, you can use the virtual _ filehandle
      #   (the single underscore). It tells the file test operator to not call stat and instead reuse the information
      #   from the last file test or stat. Simply put the _ after the file test you want. Now you call only one stat
      #   for eacch item in the list:
      my @my_executables = grep {-o and -x} glob '*';
    }
    # output {
      # --------------------
    # }
  # }
  
  # {
    # @title: stacked file tests
    # @comment: 
    my $run = 0;
    if ($run) {
      # if you want to check that a file is both readable and writable by the current user, you list the -r and -w file
      #   tests before the file:
      if (-r -w $file) {
        print "File is readable and writable\n";
      }

      # notice that the equivalent long form does the test closest to the file first:
      if (-w $file and -r $file) {
        print "File is readable and writable\n";
      }

      # rewriting the example from the previous section, you'd have:
      my @my_executables = grep {-o -x} glob '*';
    }
    # output {
      # --------------------
    # }
  # }
# }
  
# @item 52 : always use the three-argument open
# @comment: 
# {
  # {
    # @title: 
    # @comment: 
    my $run = 0;
    if ($run) {
      # this allows the input operator to work on an open file, but also overwrites your data:
      $read_file = '+> important.txt';

      # they could even sneak in a pip, which tells open to run a command:
      $read_file = 'rm -rf / |'; # that's gonna hurt!

      # when you want to read a file, you ensure that you only read from a file:
      open my ($fh) , '<' , $read_file or die "test";

      # likewise, when you want to write to a file, you ensure that you get the right mode:
      open my ($fh) , '>' , $write_file or die "test";
      open my ($fh) , '>>' , $append_file or die "test";
    }
    # output {
      # --------------------
    # }
  # }
# }
  
# @item 53 : consider different ways of reading from a stream
# @comment: 
# {
  # {
    # @title: 
    # @comment: 
    my $run = 0;
    if ($run) {
      # the implicit while (<>) form is equivalent in speed to the corresponding explicit code:
      open my ($fh) , '<' , $file or die "test";
      while (<$fh>) {
        # do something with $_
      }

      while (defined(my $line = <$fh>)) { # explicit version
        # do something with $line
      }

      # you can use a similar syntax with a foreach loop to read the entire file into memory in a
      #   single operation:
      foreach (<$fh>) {
        # do something with $_
      }

      # if you want to look at previous or succeeding line based on the current line, you want to 
      #   already have those lines. This example prints three adjacent lines when it finds a line 
      #   with "Shazam"
      my @f = <$fh>;
      foreach (0..$#f) {
        if ($f[$_]=~/\bShazam\b/) {
          my $lo = ($_>0) ? $_-1 : $_;
          my $hi = ($_<$#f) ? $_+1 : $_;
          print map {"$_:$f[$_]"} $lo..$hi;
        }
      }

      # you can still handle many of these situations with line-at-a-time input, although your code
      #   will definitely be more complex:
      my @fh;
      @f[0..2] = ("\n") x 3;
      for (;;) {
        # queue using a slice assignment
        @f[0..2] = (@f[1,2],scalar(<$fh>));
        last if not defined $f[1];
        if ($f[1]=~/\bShazam\b/) { # .. looking for Shazam
          print map {($_+$.-1).": $f[$_]"} 0..2;
        }
      }
      # maintaining a queue of lines of text with slice assignments makes this slower than the equivalent 
      #   all-at-once code, but this technique works for arbitrarily large input. The queue could also be 
      #   implemented with an index variable rather than a slice assignment, which would result in more
      #   complex but faster running code.
    }
    # output {
      # --------------------
    # }
  # }
  
  # {
    # @title: slurp a file
    # @comment: 
    my $run = 0;
    if ($run) {
      # if your goal is simply to read a file into memory as quickly as possible, you might consider clearing
      #   the line separator character and reading the entire file as a single string. This will read the 
      #   contents of a file or a file or stream much faster than either of the earlier alternatives:
      my $contents = do { 
        local $/;
        open my ($fh1), '<' , $file1 or die;
        <$fh>;
      };
      
      # you can also just use the File::Slurp module to do it for you, which lets you read the entire file 
      #   into a scalar to have it in one big chunk or read it into a an array to have it line-by-line:
      use File::Slurp;
      my $text = read_file('filename');
      my @lines = read_file('filename');
    }
    # output {
      # --------------------
    # }
  # }
  
  # {
    # @title: use read or sysread for maximum speed
    # @comment: 
    my $run = 0;
    if ($run) {
    }
    # output {
      # --------------------
    # }
  # }
# }
  
# @item 54 : open filehandles to and from strings
# @comment: 
# {
  # {
    # @title: read from a string
    # @comment: 
    my $run = 0;
    if ($run) {
      # if you have multiline string to process, don't reach for a regex to break it into lines.
      #   You can open a filehandle on a reference to a scalar, and then read from it as you 
      #   would any other filehandle：
      my $string = <<'MULTILINE';
      buster
      mimi
      roscoe
MULTILINE
      open my ($str_fh), '<', \$string;
      my @end_in_vowels = grep /[awiou]$/, <$str_fh>;

      # It gets even easier when you wrap your output operations in a subroutine. That subroutine doesn't
      #   care where the data come from as long as it can read from the filehandle it gets:
      my @matches = ends_in_vowel($str_fh);
      push @matches, ends_in_vowel($file_fh);
      push @matches, ends_in_vowel($socket);
      sub ends_in_vowel {
        my ($fh) = @_;
        grep /[awiou]$/, <$fh>;
      }
    }
    # output {
      # --------------------
    # }
  # }
  
  # {
    # @title: write to a string
    # @comment: 
    my $run = 0;
    if ($run) {
      # You can build up a string with a filehandle, too. Instead of opening the string for reading,
      #   you open it for writing:
      my $string = q{};
      open my ($str_fh), '>', \$string;
      print $str_fh "This goes into the string\n";

      # likewise, you can append to a string that already exists:
      my $string = q{};
      open my ($ftr_fh), '>>', \$string;
      print $str_fh "This goes at the end of the string\n";

      # You can shorten that a bit by declaring $string at the same time that you take a reference
      #   to it. It looks odd at first, but it works:
      open my ($str_fh), '>>', \my $string;
      print $str_fh "This goes at the end of the string\n";
    }
    # output {
      # --------------------
    # }
  # }
  
  # {
    # @title: seek and tell
    # @comment: 
    my $run = 1;
    if ($run) {
      # Open a string for reading, Move to location, and read a certain number of bytes.
      #   This can be really handy when you have an image file or other binary (non-line-oriented)
      #   format you want to work with:
      use Fcntl qw(:seek); # for the constants
      my $string = 'abcdefghijklmnopqrstuvwxyz';

      my $buffer;
      open my ($str_fh), '<', \$string;

      seek($str_fh,10,SEEK_SET); # move ten bytes from start
      my $read = read($str_fh,$buffer,4);
      print "I read [$buffer]\n";
      print "Now I am at position ", tell($str_fh), "\n";

      seek($str_fh,-7,SEEK_CUR); # move seven bytes back
      my $read = read($str_fh,$buffer,4);
      print "I read [$buffer]\n";
      print "Now I am at position ", tell($str_fh), "\n";

      # You can even replace parts of the string if you open the filehandle as read-write, using +< as the mode:
      use Fcntl qw(:seek); # for the constants
      my $string = 'abcdefghijklmnopqrstuvwxyz';

      my $buffer;
      open my ($str_fh), '+<', \$string;

      seek($str_fh,10,SEEK_CUR); # move 10 bytes from start
      print $str_fh '***';
      print "String is now:\n\t$string\n";

      read($str_fh,$buffer,3);
      print "I read [$buffer], and am now at ", tell($str_fh), "\n";
    }
    # output {
      # --------------------
      # I read [klmn]
      # Now I am at position 14
      # I read [hijk]
      # Now I am at position 11
      # String is now:
      #   abcdefghij***nopqrstuvwxyz
      # I read [nop], and am now at 16
    # }
  # }
# }
  
# @item 55 : make flexible output
# @comment: 
# {
  # {
    # @title: 
    # @comment: 
    my $run = 0;
    if ($run) {
      # When you use hard-coded (or assumed) filehandles in your code, you limit your program
      #   and frustrate your users. Some culprits look like these:
      print "This goes to standard output\n";
      print STDOUT "This goes to standard output too\n";
      print STDERR "This goes to standard error\n";

      # You don't need an object-oriented design to make this work, but it's a lot easier that way.
      #   When you need to output something in a method, get the output filehandle from the object.
      #   In this example, you call get_output_fh to fetch the destination for your data:
      sub output_method {
        my ($self,@args) = @_;
        my $output_fh = $self->get_output_fh;
        print $output_fh @args;
      }

      # to make that work, you need a way to set the output filehandle. That can be a set of regular
      #   accessor methods. get_output_fh returns STDOUT if you haven't set anything:
      sub get_output_fh {
        my ($self) = @_;
        return $self->{output_fh} || *STDOUT{IO};
      }

      sub set_output_fh {
        my ($self,$fh) = @_;
        $self->{ouput_fh} = $fh;
      }

      # With this as part of the published interface for your code, the other programmers have quite
      #   a bit of flexiblility when they want to change how your program outputs data:
      $obj->output_method("Hello stdout!\n");

      # capture the output in a string
      open my ($str_fh), '>', \$string;
      $obj->set_output_fh($str_fh);
      $obj->output_method("Hello string!\n");

      # send the data over the network
      # socket(my($socket), ...);
      $obj->set_output_fh($socket);
      $obj->output_method("Hello socket!\n");

      # output to a string and STDOUT at the same time
      # use IO::Tee;
      # my $tee = IO::Tee->new($str_fh,*STDOUT{IO});
      # $obj->set_output_fh($tee);
      # $obj->output_method("Hello all of you!\n");
      
      # send the data nowhere
      # use IO::Null;
      # my $null_fh = IO::Null->new;
      # $obj->set_output_fh($null_fh);
      # $obj->output_method("Hello? Anyone there?\n");

      # decide at run time: interactive sessions use stdout,
      #  non-interactive session use a null filehandle
      # use IO::Interactive;
      # $obj->set_output_fh(interactive());
      # $obj->output_method("Hello, maybe!\n");
      
      # You just have to shuffle some filehandles around as you temporarily make a
      #   string (item 54) as the output filehandle:
      sub as_string {
        my ($self, @args) = @_;
        my $string = '';
        open my ($str_fh), '>', \$string;
        my $old_fh = $self->get_output_fh;
        $self->set_output_fh($str_fh);
        $self->output_method(@args);

        # store the previous fh
        $self->set_output_fh($old_fh);
        $string;
      }

      # If you want to have a feature to turn off all ouput, that's almost trivial now.
      #   You just a null filehandle to suppress all output:
      $obj->set_output_fh(IO::Null->new) if $config->{be_quiet};
    }
    # output {
      # --------------------
    # }
  # }
# }
  
# @item 56 : use File::Spec or Path::Class to work with paths
# @comment: 
# {
  # {
    # @title: Use File::Spec for portability
    # @comment: 
    my $run = 0;
    if ($run) {
      # The FIle::Spec module comes with Perl, and the most convenient way to use it is
      #   through its function interface. It automatically imports severall subroutines into
      #   the current namespace:
      use File::Spec::Functions;
      # To construct a new path, you need the volumn (maybe), the directory, and the filename.
      #   The volumn and filename are easy:
      my $volumn = 'C:';
      my $file = 'perl.exe';

      # the rootdir function gets you started, and the catdir puts everything together according
      #   to the local system:
      my $directory = catdir(rootdir(),qw(strawberry perl bin));

      # now that you have all three parts, you can put them together with catpath:
      my $full_path = catpath($volumn,$directory,$file);

      # on UNIX-like filesystems, catpath ignores the argument for the volumn, so if you don't
      #   care about that portion, you can use undef as a placeholder:
      my $full_path = catpath(undef,$directory,$file);
    }
    # output {
      # --------------------
    # }
  # }
  
  # {
    # @title: Use Path::Class if you can
    # @comment: 
    my $run = 0;
    if ($run) {
      # The Path::Class module is a wrapper around File::Spec and provides convenience methods for
      #   things that are terribly annoying to work out yourself. To start, you construct a file
      #   or a directory object. On Windows, you just give file your Windows path, and it figures it
      #   out. The file function assumes that the path is for the local system:
      # use Path::Class qw(file dir);
      # my $file = file('C:/strawberry/perl/bin/perl.exe');
      
      # If you aren't on Windows but still need to work with a Windows path, you use foreign_file instead:
      my $file = foreign_file("Win32","C:/strawberry/perl/bin/perl.exe");

      # now $file does everything correctly for a Windows path. If you need to go the other way and translate
      #   it into a path suitable for another system, you can use the as_foreign method:
      # /strawberry/perl
      my $unix_path = $file->as_foreign("Unix");

      # To get a filehandle for reading, call open with no arguments. It's really just a wrapper around IO::File,
      #   so it's just like calling IO::File->new:
      my $read_fh = $file->open or die "Could not open $file: $!";

      # If you want to create a new file, you start with a file object. That doesn't create the file, since the object
      #   simply deals with paths. When you call open and pass it the >, the file is created for you and you get back
      #   a write filehandle:
      my $file = file('new_file');
      my $fh = $file->open('>');
      print $fh "Put this line in the file\n";

      # You can get the directory that contains the file, and then open a directory handle:
      my $dir = $file->dir;
      my $dh = $dir->open or die "Could not open the $dir: $!";

      # If you already have a directory object, it's easy to get its parent directory:
      my $parent = $dir->parent;

      # You read from the directory handle with readdir, as normal, and get the name of the file.
      #   As with any readdir operation, you get only the filename, so you have to add the directory
      #   portion yourself. That's not a problem when you use file to put it together for you:
      while (my $filename = readdir($dh)) {
        next if $filename =! /^\.\.?$/;
        my $file = file($dir,$file);
        print "Found $file\n";
      }
    }
    # output {
      # --------------------
    # }
  # }
# }
  
# @item 57 : leave most of the data on disk to save memory
# @comment: 
# {
  # {
    # @title: Read files line-by-line
    # @comment: 
    my $run = 0;
    if ($run) {
      # you could read an entire file into an array:
      open my ($fh), '<', $file or die;
      my @lines = <$fh>;

      # However, if you don't need all of the data at once, read only as much as you need for the next operation:
      open my ($fh), '<', $file or die;
      while (<$fh>) {
        # .. do something with the line
      }
    }
    # output {
      # --------------------
    # }
  # }
  
  # {
    # @title: Store large hashes in DBM files
    # @comment: 
    my $run = 0;
    if ($run) {
      use Fcntl; # For O_RDWR, O_CREAT, etc
      my ($lookup_file,$data_file) = @ARGV;
      my $lookup = build_lookup($lookup_file);
      open my ($data_fh), '<', $data_file or die;
      while (<$data_fh>) {
        chomp;
        my @row = split;
        if (exists $lookup->{$row[0]}) {
          print "@row\n";
        }
      }

      sub build_lookup {
        my ($file) = @_;
        open my ($lookup_fh), '<', $lookup_file or die;

        require SDBM_File;
        tie(my %lookup, 'SDBM_File',"lookup.$$", O_RDWR | O_CREAT, 0666) 
          or die
          "Couldn't tie SDBM file 'filename': $!; aborting";
        while (<$lookup_file_handle>) {
          chomp;
          my ($key,$value) = $value;
        }
        return \%lookup;
      }
      # SDBM_File is a Perl implementementation of DBM that doesn't scale very well. If you have
      #   NDBM_File or GDBM_File available on your system, opt for those instead.
    }
    # output {
      # --------------------
    # }
  # }
  
  # {
    # @title: read files as if they were arrays
    # @comment: 
    my $run = 0;
    if ($run) {
      # If key-based lookup by way of a hash isn't flexible enough, you can use Tie::File to treat a 
      #   file's lines as an array, even though you don't have them in memory. You can navigate the file
      #   as if it were a normal array. You can access any line in the file at any time, like in this
      #   random fortune printing program:
      use Tie::File;
      tie my @fortunes, 'Tie::File', $fortune_file
        or die "Unable to tie $fortune_file";
      foreach (1..0) {
        print $fortunes[rand @fortunes];
      }
    }
    # output {
      # --------------------
    # }
  # }
  
  # {
    # @title: use temporary files and directories
    # @comment: 
    my $run = 0;
    if ($run) {
      # If these prebuilt solutions don't work for you, you can always write temporary files
      #   yourself. The File::Temp module helps by automatically creating a unique temporary
      #   file name and by cleaning up the file after you are done with it. This can be especially
      #   handy if you need to completely create a new version of a file, but replace it only
      #   once you're done creating it:
      use File::Temp qw(tempfile);
      my ($fh,$file_name) = tempfile();
      while (<>) {
        print {$fh} uc $_;
      }
      $fh->close;
      rename $file_name => $final_name;

      # File::Temp can even create a temporary directory that you can use to store multiple
      #   files in. You can fetch several Web pages and store them for later processing:
      use File::Temp qw(tempdir);
      use File::Spec::Functions; 
      use LWP::Simple qw(getstore);

      my ($temp_dir) = tempdir(CLEANUP=>1);
      my %searches = (
        google => 'http://www.google.com/#h1=en&q=perl',
        yahoo => 'http://search.yahoo.com/search?p=perl',
        microsoft => 'http://www.bing.com/search?q=perl',
      );
      foreach my $search (keys %searches) {
        getstore ($searches{$search},
          catfile($temp_dir,$search));
      }
      # There's one caution with File::Temp: it opens its files in binary mode. If you need
      #   line-ending translations or a different encoding (Item 63), you have the use 
      #   binmode on the filehandle yourself.
    }
    # output {
      # --------------------
    # }
  # }
# }
