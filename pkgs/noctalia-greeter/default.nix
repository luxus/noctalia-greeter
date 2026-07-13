# Upstream noctalia-greeter with luxus patches (see patches/ and README).
{ noctaliaGreeter }:

noctaliaGreeter.overrideAttrs (old: {
  patches = (old.patches or [ ]) ++ [
    ./patches/noctalia-greeter-idle-blank.patch
    ./patches/noctalia-greeter-output-transform.patch
  ];
})
