sub head_touches_tail {
  my ($head, $tail) = @_;
  return abs($head->[0] - $tail->[0]) <= 1 && abs($head->[1] - $tail->[1]) <= 1;
}

sub move_tail {
  my ($head, $tail) = @_;
  
  if ($head == $tail || head_touches_tail($head, $tail)) {
    return $tail;
  }

  if ($head->[0] == $tail->[0]) {
    if ($head->[1] > $tail->[1]) {
      $tail->[1] += 1;
    } else {
      $tail->[1] -= 1;
    }
  }

  if ($head->[1] == $tail->[1]) {
    if ($head->[0] > $tail->[0]) {
      $tail->[0] += 1;
    } else {
      $tail->[0] -= 1;
    }
  }

  if ($head->[0] > $tail->[0] && $head->[1] > $tail->[1]) {
    $tail->[0] += 1;
    $tail->[1] += 1;
  }
  if ($head->[0] > $tail->[0] && $head->[1] < $tail->[1]) {
    $tail->[0] += 1;
    $tail->[1] -= 1;
  }
  if ($head->[0] < $tail->[0] && $head->[1] < $tail->[1]) {
    $tail->[0] -= 1;
    $tail->[1] -= 1;
  }
  if ($head->[0] < $tail->[0] && $head->[1] > $tail->[1]) {
    $tail->[0] -= 1;
    $tail->[1] += 1;

  return $tail;
  }
}

sub solution_pt_1 {
  open(my $file, "<", "input.txt") or die "Could not open input.txt: $!";

  my %result_set;
  my $tail = [0,0];
  my $head = [1,2];

  while (my $line = <$file>) {
    my ($direction, $steps) = split " ", $line;
    chomp($steps);
    for (my $i = 0; $i < $steps; $i++) {
      if ($direction eq "U") {
        $head->[1] += 1;
        $tail = move_tail($head, $tail);
      }
      if ($direction eq "R") {
        $head->[0] += 1;
        $tail = move_tail($head, $tail);
      }
      if ($direction eq "D") {
        $head->[1] -= 1;
        $tail = move_tail($head, $tail);
      }
      if ($direction eq "L") {
        $head->[0] -= 1;
        $tail = move_tail($head, $tail);
      }
      $result_set{join(",", @{$tail})} = 1;
    }
  }
  return scalar(keys %result_set);
}

if ($0 eq __FILE__) {
  print solution_pt_1();
}
 