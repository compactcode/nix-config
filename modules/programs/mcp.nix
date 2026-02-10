{delib, ...}:
delib.module {
  # shared mcp server definitions
  name = "programs.mcp";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    programs.mcp = {
      enable = true;
      servers = {
        atlassian = {
          url = "https://mcp.atlassian.com/v1/sse";
        };
      };
    };
  };
}
