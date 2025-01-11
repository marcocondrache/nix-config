{
  baseHome ? "/Users",
  ...
}:
{
  users.users.marcocondrache = {
    name = "marcocondrache";
    home = "${baseHome}/marcocondrache";
  };
}
