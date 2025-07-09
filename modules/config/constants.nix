{delib, ...}:
delib.module {
  name = "constants";

  options.constants = with delib; {
    username = readOnly (strOption "compactcode");
    userfullname = readOnly (strOption "Shanon McQuay");
    useremail = readOnly (strOption "hi@shan.dog");
    usersshkey = readOnly (strOption "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDPCP4SqkSwxkX9dkk36idNz7wCtXfa84hwkkflJVuDF");
  };
}
