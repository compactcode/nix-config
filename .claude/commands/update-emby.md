Fetch the latest linuxserver/emby docker image version directly from https://github.com/linuxserver/docker-emby/releases and update the image version in modules/services/emby.nix to the latest stable release.

After updating, provide:
1. The version change (old → new)
2. Link to the LinuxServer docker-emby releases: https://github.com/linuxserver/docker-emby/releases
3. Link to the official Emby releases page: https://github.com/MediaBrowser/Emby.Releases
4. Summary of major changes and breaking changes from the changelog
5. Any important migration notes or compatibility concerns

Use WebFetch to get release information directly from the LinuxServer releases page to determine the latest version tag, then check the upstream Emby releases for changelog details.
