#!/usr/local/bin/plackup --no-default-middleware
# --no-default-middleware
use strict;
use lib '/home/cade/pro/reactor/lib';
use lib '/home/cade/pro/perl-mods/Data/Tools/lib';
use lib '/home/cade/pro/decor/web/lib', '/home/cade/pro/decor/shared/lib';
use Web::Reactor::Decor;
use Data::Dumper;
use Time::HR;

$| = 1;
$Data::Dumper::Sortkeys = 1;
  
print STDERR  "\n" x 10;

my $APP_NAME = 'app1';
my $cfg = {
          APP_NAME            => $APP_NAME,
          DECOR_CORE_ROOT     => '/home/cade/pro/decor/',
          DECOR_CORE_HOST     => 'localhost:42000',
          DECOR_CORE_APP      => $APP_NAME,
          DEBUG               => 10,
          LANG                => 'bg',
          USER_SESSION_EXPIRE => 100000000,
          SESS_VAR_DIR        => '/tmp/decor-varx',
          DISABLE_SECURE_COOKIES => 1,
          };

sub
{
    my $env = shift;
 
    my $res;
    eval
      {
      $res = Web::Reactor::Decor->new( $env, $cfg )->run();
      };
    if( $@ or ! $res )
      {
      print STDERR "REACTOR EXCEPTION: $@";
      $res = [ 200, [ 'content-type' => 'text/plain' ], [ 'system is currently unavailable' ] ];
      }
    
    return $res;  
};
