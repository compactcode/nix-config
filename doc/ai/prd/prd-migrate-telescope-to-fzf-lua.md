# PRD: Migrate from Telescope to fzf-lua in nixvim

## Introduction/Overview

This feature involves migrating the existing Telescope-based finder system in the nixvim configuration to use fzf-lua instead. The primary motivation is to achieve performance improvements while maintaining all current functionality. The migration should be transparent to the user, preserving all existing keybindings and workflows.

## Goals

1. Replace all Telescope functionality with equivalent fzf-lua implementations
2. Achieve measurable performance improvements in file finding and searching operations
3. Maintain 100% compatibility with existing keybindings and user workflows
4. Preserve all current extensions functionality (frecency, ui-select, yank_history integration)
5. Ensure seamless integration with existing LSP configuration

## User Stories

1. **As a developer**, I want to find files using `<leader>ff`, `<leader><space>`, and `<leader>t` with the same behavior but faster performance, so that my workflow remains unchanged while being more responsive.

2. **As a developer**, I want to search project content using `<leader>fs` and `<leader>fw` with improved speed, so that I can find code references more efficiently.

3. **As a developer**, I want to access LSP definitions and references via `<leader>cd` and `<leader>cu` with the same interface, so that my code navigation remains consistent.

4. **As a developer**, I want to access my yank history through `<leader>p` and recent files through `<leader>fo` with the same functionality, so that my productivity features are preserved.

5. **As a developer**, I want frecency-based file finding to continue working, so that my most-used files remain easily accessible.

## Functional Requirements

1. **File Finding Operations:**
   - FR1: The system must provide file finding via `<leader>ff` with frecency-based ranking
   - FR2: The system must provide basic file finding via `<leader><space>` and `<leader>t`
   - FR3: File finding must include hidden files by default (matching current `fd --hidden` behavior)
   - FR4: File finding must respect the current working directory scope

2. **Search Operations:**
   - FR5: The system must provide live grep search via `<leader>fs`
   - FR6: The system must provide current word search via `<leader>fw`
   - FR7: Search operations must include hidden files and respect current `rg` arguments
   - FR8: Search results must maintain the same format and navigation as current implementation

3. **LSP Integration:**
   - FR9: The system must provide LSP definitions lookup via `<leader>cd`
   - FR10: The system must provide LSP references lookup via `<leader>cu`
   - FR11: LSP integration must maintain the same picker interface and navigation

4. **History and Utility Features:**
   - FR12: The system must provide old files access via `<leader>fo` (cwd-scoped)
   - FR13: The system must provide marks access via `<leader>fm`
   - FR14: The system must provide search resume functionality via `<leader>fr`
   - FR15: The system must integrate with yank history for `<leader>p`

5. **UI and Navigation:**
   - FR16: The system must use the same navigation keybindings (`<C-n>`, `<C-e>` for movement)
   - FR17: The system must maintain color_devicons = false (no colored icons)
   - FR18: The system must preserve file size limits for previews (0.2MB limit)
   - FR19: The system must use ascending sorting strategy

6. **Built-in Picker Replacement:**
   - FR20: The system must replace Telescope's ui-select functionality for built-in vim pickers
   - FR21: All vim native selection interfaces must use fzf-lua instead of default pickers

## Non-Goals (Out of Scope)

1. Changing any existing keybindings or user interface patterns
2. Adding new functionality beyond current Telescope capabilities
3. Modifying the overall nixvim configuration structure
4. Changing the lazy loading strategy for the finder plugin
5. Altering integration with other nixvim plugins beyond what's necessary for the migration

## Technical Considerations

1. **Dependencies:** Must ensure fzf-lua is properly configured in the nixvim plugins section
2. **Extensions Mapping:** Need to identify fzf-lua equivalents for:
   - telescope-frecency → fzf-lua frecency support
   - telescope-ui-select → fzf-lua ui-select
   - telescope-fzf-native → native fzf-lua performance (built-in)
3. **Configuration Migration:** Current telescope settings (hidden files, preview limits, sorting) must be translated to fzf-lua equivalents
4. **LSP Integration:** Ensure fzf-lua properly integrates with existing LSP configuration in nixvim
5. **Performance:** fzf-lua should provide native performance improvements without requiring additional native extensions

## Success Metrics

1. **Functional Success:** All 21 functional requirements pass manual testing
2. **Performance Success:** Measurable improvement in file finding and search response times (subjective assessment acceptable)
3. **Compatibility Success:** Zero breaking changes to existing keybindings and workflows
4. **Integration Success:** All existing integrations (LSP, yank history, etc.) continue to work seamlessly

## Open Questions

1. Does fzf-lua have a direct equivalent to telescope-frecency, or will we need to implement frecency logic differently?
2. Are there any nixvim-specific configuration patterns for fzf-lua that differ from standard Neovim setups?
3. Should we maintain the current lazy loading strategy, or does fzf-lua have different performance characteristics that make lazy loading unnecessary?
4. Are there any edge cases in the current telescope configuration that might not translate directly to fzf-lua?
