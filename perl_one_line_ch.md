# 用 Perl 实现的有用的单行程序                     1   28 2012 | 版本 1.08
------------------------                    -----------   ------------

由 Peteris Krumins 编译 (peter@catonmat.net, @pkrumins on Twitter)
http://www.catonmat.net -- good coders code, great reuse

此文件最新版的总可以在下面的这个链接里获得:

    http://www.catonmat.net/download/perl1line.txt

此文件也有其它语言的:	
This file is also available in other languages:
	 中文： https://github.com/vinian/perl1line.txt
	 (如果您想翻译的话, 请与我 peter@catonmat.net 联系)

Github 上的 Perl 单行程序:	 
 
    https://github.com/pkrumins/perl1line.txt

	你可以在 Github 上给我发送推送请求! 我接受问题修复,
	新的单行代码,翻译和其它所有相关东西.

在这个文件的基础上,我还写了一本 "Perl 单行程序" 的电子书,
它对这个文件里的所有单行做了解释.从下面这个链接里获取它:

    http://www.catonmat.net/blog/perl-book/

这些单行程序可以同时在 UNIX 系统和 Windows 系统使用.很可能你的 UNIX 系统
已经安装好了 Perl. 对 Windows 用户,您可以从下面链接获取草莓 Perl:

    http://www.strawberryperl.com/

目录:

    1. 文件 Spacing
    2. 行号
    3. 计算
    4. 生成字符串和数组
    5. 文本转换和替换
    6. 选择性的打印和删除某些行
    7. 实用的正则
    8. Perl 诀窍


# 文件 SPACING 
------------

## 对一个文件的每行使用两个换行符
    perl -pe '$\="\n"'
    perl -pe 'BEGIN { $\="\n" }'
    perl -pe '$_ .= "\n"'
    perl -pe 's/$/\n/'

## 除空行以外,对文件的每行使用两个换行符
    perl -pe '$_ .= "\n" unless /^$/'
    perl -pe '$_ .= "\n" if /\S/'

## 对一个文件每行使用三个换行符
    perl -pe '$\="\n\n"'
    perl -pe '$_.="\n\n"'

## 给一个文件加入多个换行符
    perl -pe '$_.="\n"x7'

## 给每一行都前加入一个空行
    perl -pe 's//\n/'

## 去掉所有空行
    perl -ne 'print unless /^$/'
    perl -lne 'print if length'
    perl -ne 'print if /\S/'

## 对于所有连续的空行,只保留一行空行,其它的全部去掉
    perl -00 -pe ''
    perl -00pe0

## 将所有的空行压缩/展开为多个连续的空行
    perl -00 -pe '$_.="\n"x4'

## 对一个文件的每 10 行,都使用 Tab 键分隔开
    perl -lpe '$\ = $. % 10 ? "\t" : "\n"'


行号
--------------

## 给文件的每行都加上行号
    perl -pe '$_ = "$. $_"'

## 给文件的非空行加上行号
    perl -pe '$_ = ++$a." $_" if /./'

## 给非空白行加上行号并打印(丢掉空行)
    perl -ne 'print ++$a." $_" if /./'

## 给所有行都加上行号,但只打印非空行的行号
    perl -pe '$_ = "$. $_" if /./'

## 只给与某个正则匹配的行加上行号,打印其它未修改的
    perl -pe '$_ = ++$a." $_" if /regex/'

## 打印只包含某个正则的行,并在它们行首顺序添加行号
    perl -ne 'print ++$a." $_" if /regex/'

## 给与正则匹配的行加上行号并打印
    perl -pe '$_ = "$. $_" if /regex/'

## 给所有行使用指定的格式添加行号(模拟 cat -n)
    perl -ne 'printf "%-5d %s", $., $_'

## 打印一个文件的总行数(模拟 wc -l)
    perl -lne 'END { print $. }'
    perl -le 'print $n=()=<>'
    perl -le 'print scalar(()=<>)'
    perl -le 'print scalar(@foo=<>)'
    perl -ne '}{print $.'
    perl -nE '}{say $.'

## 打印一个文件非空白行的总和
    perl -le 'print scalar(grep{/./}<>)'
    perl -le 'print ~~grep{/./}<>'
    perl -le 'print~~grep/./,<>'
    perl -E 'say~~grep/./,<>'

## 打印一个文件空白行的总和
    perl -lne '$a++ if /^$/; END {print $a+0}'
    perl -le 'print scalar(grep{/^$/}<>)'
    perl -le 'print ~~grep{/^$/}<>'
    perl -E 'say~~grep{/^$/}<>'

## 打印一个文件里匹配某个正则的行的总数(模拟 grep -c)
    Print the number of lines in a file that match a pattern (emulate grep -c)
    perl -lne '$a++ if /regex/; END {print $a+0}'
    perl -nE '$a++ if /regex/; END {say $a+0}'


计算
------------

## 判断一个数是否是质数
    perl -lne '(1x$_) !~ /^1?$|^(11+?)\1+$/ && print "$_ is prime"'

## 对一行的所有字段求和
    perl -MList::Util=sum -alne 'print sum @F'

## 对所有行的所有字段求和
    perl -MList::Util=sum -alne 'push @S,@F; END { print sum @S }'
    perl -MList::Util=sum -alne '$s += sum @F; END { print $s }'

## 打乱一行所有字段的顺序
    perl -MList::Util=shuffle -alne 'print "@{[shuffle @F]}"'
    perl -MList::Util=shuffle -alne 'print join " ", shuffle @F'

## 打印一行中的最小的元素
    perl -MList::Util=min -alne 'print min @F'

## 打印所有行最小的元素
    perl -MList::Util=min -alne '@M = (@M, @F); END { print min @M }'
    perl -MList::Util=min -alne '$min = min @F; $rmin = $min unless defined $rmin && $min > $rmin; END { print $rmin }'

## 打印一行中最大的元素
    perl -MList::Util=max -alne 'print max @F'

## 打印所有行里最大的元素
    perl -MList::Util=max -alne '@M = (@M, @F); END { print max @M }'

## 用每个字段的绝对值替换其当前值
    perl -alne 'print "@{[map { abs } @F]}"'

## 打印每一行总的字段(单词)个数
    perl -alne 'print scalar @F'

## 在每行行首前打印该行总的字段和
    perl -alne 'print scalar @F, " $_"'

## 计算所有行字段数的总和
    perl -alne '$t += @F; END { print $t}'

## 打印匹配某个正则的字段总个数
    perl -alne 'map { /regex/ && $t++ } @F; END { print $t }'
    perl -alne '$t += /regex/ for @F; END { print $t }'
    perl -alne '$t += grep /regex/, @F; END { print $t }'

## 打印匹配某个正则的总行数
    perl -lne '/regex/ && $t++; END { print $t }'

## 打印圆周率，保留 n 位有效数字
    perl -Mbignum=bpi -le 'print bpi(n)'

## 打印圆周率，保留 39 位有效数字
    perl -Mbignum=PI -le 'print PI'

## 打印指数,保留 n 位有效数字
    perl -Mbignum=bexp -le 'print bexp(1,n+1)'

## 打印指数,保留 39 位有效数字
    perl -Mbignum=e -le 'print e'

## 打印系统 UNIX 时间 (从 UTC 1970.1.1 00:00:00 到现在的秒数)
    perl -le 'print time'

## 打印格林威治时间和本机的系统时间
    perl -le 'print scalar gmtime'
    perl -le 'print scalar localtime'

## 以 小时:分钟:秒 的格式打印本机系统时间
    perl -le 'print join ":", (localtime)[2,1,0]'

## 打印昨天的时间
    perl -MPOSIX -le '@now = localtime; $now[3] -= 1; print scalar localtime mktime @now'

## 打印 14 个月 9 天 7 秒前的时间
    perl -MPOSIX -le '@now = localtime; $now[0] -= 7; $now[4] -= 14; $now[7] -= 9; print scalar localtime mktime @now'

## 在每行的行首加上时间戳(格林威治时间，本地时间)
    tail -f logfile | perl -ne 'print scalar gmtime," ",$_'
    tail -f logfile | perl -ne 'print scalar localtime," ",$_'

## 计算 5 的阶乘
    perl -MMath::BigInt -le 'print Math::BigInt->new(5)->bfac()'
    perl -le '$f = 1; $f *= $_ for 1..5; print $f'

## 计算最大公约数
    perl -MMath::BigInt=bgcd -le 'print bgcd(@list_of_numbers)'

## 使用 Euclid 算法计算 20 和 35 的最大公约数
    perl -le '$n = 20; $m = 35; ($m,$n) = ($n,$m%$n) while $n; print $m'

## 计算 35，20，8 的最小公倍数
    perl -MMath::BigInt=blcm -le 'print blcm(35,20,8)'

## 使用 Euclid 公式( n*m/gcd(n,m) )计算 20 和 35 的最小公倍数
    perl -le '$a = $n = 20; $b = $m = 35; ($m,$n) = ($n,$m%$n) while $n; print $a*$b/$m'

## 在 5-15 间生成 10 个随机数，不包含 15
    perl -le '$n=10; $min=5; $max=15; $, = " "; print map { int(rand($max-$min))+$min } 1..$n'

## 找到并打印列表中所有的排列
    perl -MAlgorithm::Permute -le '$l = [1,2,3,4,5]; $p = Algorithm::Permute->new($l); print @r while @r = $p->next'

## 产生幂集
    perl -MList::PowerSet=powerset -le '@l = (1,2,3,4,5); for (@{powerset(@l)}) { print "@$_" }'

## 将 IP 地址转换为无符号的数字
    perl -le '$i=3; $u += ($_<<8*$i--) for "127.0.0.1" =~ /(\d+)/g; print $u'
    perl -le '$ip="127.0.0.1"; $ip =~ s/(\d+)\.?/sprintf("%02x", $1)/ge; print hex($ip)'
    perl -le 'print unpack("N", 127.0.0.1)'
    perl -MSocket -le 'print unpack("N", inet_aton("127.0.0.1"))'

## 将一个无符号的数字转换成 IP 地址
    perl -MSocket -le 'print inet_ntoa(pack("N", 2130706433))'
    perl -le '$ip = 2130706433; print join ".", map { (($ip>>8*($_))&0xFF) } reverse 0..3'
    perl -le '$ip = 2130706433; $, = "."; print map { (($ip>>8*($_))&0xFF) } reverse 0..3'


# 生成字符串和数组
----------------------------------

## 生成并打印字母
    perl -le 'print a..z'
    perl -le 'print ("a".."z")'
    perl -le '$, = ","; print ("a".."z")'
    perl -le 'print join ",", ("a".."z")'

## 生成并打印所有 "a" 到 "zz" 间的字符	
    perl -le 'print ("a".."zz")'
    perl -le 'print "aa".."zz"'

## 创建一个十六进制的数组
    @hex = (0..9, "a".."f")

## 使用十六进制数组,将一个十进制数转换为十六进制
    perl -le '$num = 255; @hex = (0..9, "a".."f"); while ($num) { $s = $hex[($num%16)&15].$s; $num = int $num/16 } print $s'
    perl -le '$hex = sprintf("%x", 255); print $hex'
    perl -le '$num = "ff"; print hex $num'

## 随机生成 8 个字符组成的密码
    perl -le 'print map { ("a".."z")[rand 26] } 1..8'
    perl -le 'print map { ("a".."z", 0..9)[rand 36] } 1..8'

## 生成定长的字符串
    perl -le 'print "a"x50'

## 创建一个重复的数组
    perl -le '@list = (1,2)x20; print "@list"'

## 利用字符串生成数组
    @months = split ' ', "Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec"
    @months = qw/Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec/

## 使用数组生成字符串
    @stuff = ("hello", 0..9, "world"); $string = join '-', @stuff

## 将字符串中的字符转换成其 ASCII 码对应的数字
    perl -le 'print join ", ", map { ord } split //, "hello world"'

## 将一列 ASCII 数字转换成一个字符串
    perl -le '@ascii = (99, 111, 100, 105, 110, 103); print pack("C*", @ascii)'
    perl -le '@ascii = (99, 111, 100, 105, 110, 103); print map { chr } @ascii'

## 使用 1 到 100 间的奇数生成一个数组
    perl -le '@odd = grep {$_ % 2 == 1} 1..100; print "@odd"'
    perl -le '@odd = grep { $_ & 1 } 1..100; print "@odd"'

## 使用 1 到 100 间的偶数生成一个数组
    perl -le '@even = grep {$_ % 2 == 0} 1..100; print "@even"'

## 求字符串的长度
    perl -le 'print length "one-liners are great"'

## 显示数组中元素的个数
    perl -le '@array = ("a".."z"); print scalar @array'
    perl -le '@array = ("a".."z"); print $#array + 1'


# 文本转换和替换
--------------------------------

## 对字符串做 ROT13 变换
    'y/A-Za-z/N-ZA-Mn-za-m/'

## 对一个文件做 ROT13 变换
    perl -lpe 'y/A-Za-z/N-ZA-Mn-za-m/' file

## 使用 Base64 编码字符串
    perl -MMIME::Base64 -e 'print encode_base64("string")'
    perl -MMIME::Base64 -0777 -ne 'print encode_base64($_)' file

## 使用 Base64 解码字符串
    perl -MMIME::Base64 -le 'print decode_base64("base64string")'
    perl -MMIME::Base64 -ne 'print decode_base64($_)' file

## URL 转义字符串
    perl -MURI::Escape -le 'print uri_escape($string)'

## URL 反转义一个字符串
    perl -MURI::Escape -le 'print uri_unescape($string)'

## HTML 编码一个字符串
    perl -MHTML::Entities -le 'print encode_entities($string)'

## HTML 解码一个字符串
    perl -MHTML::Entities -le 'print decode_entities($string)'

## 将所有文本转换为大写格式
    perl -nle 'print uc'
    perl -ple '$_=uc'
    perl -nle 'print "\U$_"'

## 将所有文本转换为小写格式
    perl -nle 'print lc'
    perl -ple '$_=lc'
    perl -nle 'print "\L$_"'

## 对每一行的首字母大写
    perl -nle 'print ucfirst lc'
    perl -nle 'print "\u\L$_"'

## 反转字母的大小写
    perl -ple 'y/A-Za-z/a-zA-Z/'

## 使用骆驼规则处理每行
    perl -ple 's/(\w+)/\u$1/g'
    perl -ple 's/(?<!['])(\w+)/\u\1/g'

## 丢掉行首的空白字符(空白符，制表符)
    perl -ple 's/^[ \t]+//'
    perl -ple 's/^\s+//'

## 丢掉行尾的空白字符(空白符，制表符)
    perl -ple 's/[ \t]+$//'

## 丢掉行首和行尾的空白符
    perl -ple 's/^[ \t]+|[ \t]+$//g'

## 将 UNIX 新行转换成 DOS/Windows 格式新行
    perl -pe 's|\n|\r\n|'

## 将 DOS/Windows 格式的新行转换成 UNIX 格式的新行
    perl -pe 's|\r\n|\n|'

## 转换 UNIX 格式新行到 Mac 格式新行
    perl -pe 's|\n|\r|'

## 使用 "bar" 替换(查找并替换)每行中最开始的 "foo"
    perl -pe 's/foo/bar/'

## 使用 "bar" 替换(查找并替换)每行中所有的 "foo"
    perl -pe 's/foo/bar/g'

## 当一行中出现 "baz" 时,使用 "foo" 替换(查找并替换)最开始的一个 "bar"
    perl -pe '/baz/ && s/foo/bar/'

## 修改文件中出现 "baz" 的行使用 "foo" 替换(查找并替换)最开始的一个 "bar"
    perl -i.orig -lpe 'BEGIN {$findstr = shift @ARGV; $str= shift @ARGV; $rep = shift @ARGV}; /$findstr/ && s/$str/$rep/;' 'baz' 'foo' 'bar' file

## 使用二进制对文件打补丁(查找指定的数组,将其替换为十六进制的数)
    perl -pi -e 's/\x89\xD8\x48\x8B/\x90\x90\x48\x8B/g' file


# 选择性的打印和删除某些行
------------------------------------------------

## 打印文件的第一行(模拟 head -1)
    perl -ne 'print; exit'

## 打印文件的前十行(模拟 head -10)
    perl -ne 'print if $. <= 10'
    perl -ne '$. <= 10 && print'
    perl -ne 'print if 1..10'

## 打印文件的最后一行(模拟 tail -1)
    perl -ne '$last = $_; END { print $last }'
    perl -ne 'print if eof'

## 打印文件的最后十行(模拟 tail -10)
    perl -ne 'push @a, $_; @a = @a[@a-10..$##a]; END { print @a }'

## 只打印匹配某个正则的行
    perl -ne '/regex/ && print'

## 只打印不匹配某个正则的行
    perl -ne '!/regex/ && print'

## 打印匹配某个正则的前一行
    perl -ne '/regex/ && $last && print $last; $last = $_'

## 打印匹配某个正则的后一行
    perl -ne 'if ($p) { print; $p = 0 } $p++ if /regex/'

## 打印同时包含 AAA 和 BBB 的行
    perl -ne '/AAA/ && /BBB/ && print'

## 打印既不包含 AAA 也不包含 BBB 的行
    perl -ne '!/AAA/ && !/BBB/ && print'

## 打印顺序包含 AAA, BBB, CCC 的行
    perl -ne '/AAA.*BBB.*CCC/ && print'

## 打印长度不小于 80 个字符的行
    perl -ne 'print if length >= 80'

## 打印长度小于 80 个字符的行
    perl -ne 'print if length < 80'

## 只显示第 13 行
    perl -ne '$. == 13 && print && exit'

## 打印除了第 27 行外的所有行
    perl -ne '$. != 27 && print'
    perl -ne 'print if $. != 27'

## 只打印第 13,19,67 行
    perl -ne 'print if $. == 13 || $. == 19 || $. == 67'
    perl -ne 'print if int($.) ~~ (13, 19, 67)' 

## 打印匹配两个正则间的所有行(包括匹配行本身)
    perl -ne 'print if /regex1/../regex2/'

## 打印第 17 到 30 行间的所有行
    perl -ne 'print if $. >= 17 && $. <= 30'
    perl -ne 'print if int($.) ~~ (17..30)'
    perl -ne 'print if grep { $_ == $. } 17..30'

## 打印最长行
    perl -ne '$l = $_ if length($_) > length($l); END { print $l }'

## 打印最短行
    perl -ne '$s = $_ if $. == 1; $s = $_ if length($_) < length($s); END { print $s }'

## 打印包含数字的行
    perl -ne 'print if /\d/'

## 查找只包含数字的行
    perl -ne 'print if /^\d+$/'

## 打印只包含字母的行
    perl -ne 'print if /^[[:alpha:]]+$/

## 从文件首行开始,每两行打印一次
    perl -ne 'print if $. % 2'

## 从第二行开始,每两行打印一次
    perl -ne 'print if $. % 2 == 0'

## 打印重复出现的行
    perl -ne 'print if ++$a{$_} == 2'

## 打印所有唯一的行
    perl -ne 'print unless $a{$_}++'

## 打印每行的第一个字段(模拟 cut -f 1 -d ' ')
    perl -alne 'print $F[0]'


# 实用的正则
-------------------------

## 匹配像 IP 地址的
    /^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/
    /^(\d{1,3}\.){3}\d{1,3}$/

## 判断一个数字是否在 0 到 255 间
    /^([0-9]|[0-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])$/

## 匹配一个 IP 地址
    my $ip_part = qr|([0-9]|[0-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])|;
    if ($ip =~ /^($ip_part\.){3}$ip_part$/) {
     say "valid ip";
    }

## 检查一个字符串是否是电子邮箱地址
    /\S+@\S+\.\S+/

## 检测一个字符串是否是十进制数
    /^\d+$/
    /^[+-]?\d+$/
    /^[+-]?\d+\.?\d*$/

## 检测一个字符串是否是十六进制数
    /^0x[0-9a-f]+$/i

## 检测一个字符串是否是八进制数
    /^0[0-7]+$/

## 检测一个字符串是否是二进制数
    /^[01]+$/

## 检测一个单词是否在字符串中出现两次
    /(word).*\1/

## 对字符串中的所有数字都加一
    $str =~ s/(\d+)/$1+1/ge

## 从 HTTP 头里取出 HTTP User-Agent
    /^User-Agent: (.+)$/

## 匹配可打印的 ASCII 字符
    /[ -~]/

## 匹配不可打印的 ASCII 字符
    /[^ -~]/

## 匹配 HTML 标签间的文本
    m|<strong>([^<]*)</strong>|
    m|<strong>(.*?)</strong>|

## 替换所有 <b> 为 <strong>
    $html =~ s|<(/)?b>|<$1strong>|g

## 存储所有匹配的字符串到数组里
    my @matches = $text =~ /regex/g;


# PERL 诀窍
-----------

## 显示 Perl 模块的版本号
    perl -MModule -le 'print $Module::VERSION'
    perl -MLWP::UserAgent -le 'print $LWP::UserAgent::VERSION'


# PERL 单行解释电子书
--------------------------------

我(peter@catonmat.net)在这个文件的基础上,写了一本电子书,如果您希望
支持我的工作,同时也更多的了解单行代码,您可以从下面的链接里获得一份
该电子书的拷贝:

	http://www.catonmat.net/blog/perl-book/

这本电子书以我在博客中写的 7 篇系列文章为基础.
在这本书里,我回顾了所有的单行程序,添加了更多的解释,新增了单行代码
同时也添加了两章 - 介绍 Perl 单行程序和总结了常用的特殊变量.

您可以在这里阅读原始的系列文章:

    http://www.catonmat.net/blog/perl-one-liners-explained-part-one/
    http://www.catonmat.net/blog/perl-one-liners-explained-part-two/
    http://www.catonmat.net/blog/perl-one-liners-explained-part-three/
    http://www.catonmat.net/blog/perl-one-liners-explained-part-four/
    http://www.catonmat.net/blog/perl-one-liners-explained-part-five/
    http://www.catonmat.net/blog/perl-one-liners-explained-part-six/
    http://www.catonmat.net/blog/perl-one-liners-explained-part-seven/


# 以下作者对本文做出贡献
-----------------

Andy Lester       http://www.petdance.com
Shlomi Fish       http://www.shlomifish.org
Madars Virza      http://www.madars.org
caffecaldo        https://github.com/caffecaldo
Kirk Kimmel       https://github.com/kimmel
avar              https://github.com/avar
rent0n


# 发现了臭虫? 添加其它的单行程序?
------------------------------------

给我的电子邮箱(peter@catonmat.net)发送臭虫邮件或新的单行代码!

# 祝你愉快
--------

我希望您觉得这些单行有用, 祝你愉快!

# ---完结---

翻译: veinian@gmail.com
