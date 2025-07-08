{delib, ...}:
delib.module {
  name = "constants";

  options.constants = with delib; {
    username = readOnly (strOption "compactcode");
    userfullname = readOnly (strOption "Shanon McQuay");
    useremail = readOnly (strOption "hi@shan.dog");
  };
}
