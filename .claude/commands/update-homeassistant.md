Fetch the latest linuxserver/homeassistant docker image version directly from https://github.com/linuxserver/docker-homeassistant/releases and update the image version in modules/services/homeassistant.nix to the latest stable release.

After updating, provide:
1. The version change (old → new)
2. Link to the LinuxServer docker-homeassistant releases: https://github.com/linuxserver/docker-homeassistant/releases
3. Link to the official Home Assistant releases page: https://github.com/home-assistant/core/releases
4. Summary of major changes and breaking changes from the changelog
5. Any important migration notes or compatibility concerns

Use WebFetch to get release information directly from the LinuxServer releases page to determine the latest version tag, then check the upstream Home Assistant releases for changelog details.
