package decor::actions::fileecho;
use strict;

use JSON;
use Data::Dumper;


sub main
{
  my $reo = shift;

  # list all parameters
  my $ui = $reo->get_user_input();

  my $text;
  
  my %hr = %$ui;
  $hr{ 'FDATA' } = $reo->get_postdata_body();
  
  my $core = new Decor::Shared::Net::Client;
  $core->connect( "localhost:42112", "app1", { 'MANUAL' => 1 } );

  my $res = $core->tx_msg( \%hr );

  my $fdata = $res->{ 'FDATA' } x 2;
  my $ftype = $res->{ 'FTYPE'  };
  my $fname = $res->{ 'FNAME' };
  
  print STDERR Dumper( 'RES ' x 12, $res, $fdata, $ftype, FILE_NAME => $fname );

  return $reo->render_data( $fdata, $ftype, FILE_NAME => $fname );
}

1;
