Fetch the latest linuxserver/sonarr docker image version directly from https://github.com/linuxserver/docker-sonarr/releases and update the image version in modules/services/media.nix to the latest stable release.

After updating, provide:
1. The version change (old → new)
2. Link to the LinuxServer docker-sonarr releases: https://github.com/linuxserver/docker-sonarr/releases
3. Link to the official Sonarr releases page: https://github.com/Sonarr/Sonarr/releases
4. Summary of major changes and breaking changes from the changelog
5. Any important migration notes or compatibility concerns

Use WebFetch to get release information directly from the LinuxServer releases page to determine the latest version tag, then check the upstream Sonarr releases for changelog details.
