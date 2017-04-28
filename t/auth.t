use Test::More;
use t::Base;
use utf8;
use Utils::Auth;

use_ok('Utils::Auth');
require_ok('Utils::Auth');

my $test_mojo;
BEGIN { $test_mojo     = t::Base::get_test_mojo_session(); }    

# Salted password
ok(!defined(Utils::Auth::salted_password()), "Non defined result with no parameters!");
my $salt = Utils::Auth::salted_password('secret');
ok(defined($salt) && $salt, "Salt defined!");
ok(Utils::Auth::salted_password('secret', $salt), "Password correct!");
ok(!Utils::Auth::salted_password('secret1', $salt), "Password incorrect!"); 

### -=FINISH=-
done_testing();
