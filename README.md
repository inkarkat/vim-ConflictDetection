CONFLICT DETECTION
===============================================================================
_by Ingo Karkat_

DESCRIPTION
------------------------------------------------------------------------------

This plugin detects and highlights conflict markers such as &lt;&lt;&lt;&lt;&lt;&lt;&lt;, =======,
and &gt;&gt;&gt;&gt;&gt;&gt;&gt;, which are inserted by source code management systems on merges to
indicate that the automatic resolution failed; this plugin helps you with
becoming aware of and finding them.

### SEE ALSO

- To quickly locate and resolve the conflicts, you can use the motions and
  text objects provided by the companion ConflictMotions.vim plugin
  ([vimscript #3991](http://www.vim.org/scripts/script.php?script_id=3991)).

### RELATED WORKS

- conflict-marker.vim (https://github.com/rhysd/conflict-marker.vim) can
  highlight the markers themselves; it also offers jumps and ways to resolve
  them.

USAGE
------------------------------------------------------------------------------

    The plugin automatically adds syntax definitions for the conflict markers and
    the conflicted lines which are enclosed in the markers. Lines originating from
    "our" version are highlighted in a different way than lines from "their"
    version, so it's easier for you to visually differentiate the alternatives and
    make the right editing choices to resolve the conflict. The "base" version of
    the diff3-style syntax is supported, too.

    :ConflictSyntax [{syntax}]
                            Remove / change the syntax (to {syntax}) while keeping
                            the conflict syntax definitions (:setl syntax=...
                            would remove them as well). Useful when the filetype's
                            own syntax interferes with the overlaid conflict
                            syntax definitions.

    The plugin warns you when a buffer that contains conflict markers is edited or
    saved. Cp. g:ConflictDetection_WarnEvents

    The detections stores its status in the buffer variable b:conflicted. You can
    evaluate this boolean variable in a custom statusline to indicate whether
    the buffer contains conflicts.

INSTALLATION
------------------------------------------------------------------------------

The code is hosted in a Git repo at
    https://github.com/inkarkat/vim-ConflictDetection
You can use your favorite plugin manager, or "git clone" into a directory used
for Vim packages. Releases are on the "stable" branch, the latest unstable
development snapshot on "master".

This script is also packaged as a vimball. If you have the "gunzip"
decompressor in your PATH, simply edit the \*.vmb.gz package in Vim; otherwise,
decompress the archive first, e.g. using WinZip. Inside Vim, install by
sourcing the vimball or via the :UseVimball command.

    vim ConflictDetection*.vmb.gz
    :so %

To uninstall, use the :RmVimball command.

### DEPENDENCIES

- Requires Vim 7.0 or higher.
- Requires the ingo-library.vim plugin ([vimscript #4433](http://www.vim.org/scripts/script.php?script_id=4433)), version 1.003 or
  higher.

CONFIGURATION
------------------------------------------------------------------------------

For a permanent configuration, put the following commands into your vimrc:

By default, the DiffAdd (our version), DiffText (their version), and
DiffChange (base version) highlight groups are used for highlighting
conflicted lines. The lines containing the highlight markers are colored with
a foreground color derived from the correspoding groups.
You may define your own colors via the :highlight command:

    highlight def link conflictOurs                     guibg=Green
    highlight def link conflictBase                     guibg=Brown
    highlight def link conflictTheirs                   guibg=Red
    highlight def link conflictSeparatorMarkerSymbol    guifg=Black
    highlight def conflictOursMarker                    guifg=Green
    highlight def conflictBaseMarker                    guifg=Brown
    highlight def conflictTheirsMarker                  guifg=Red

The buffer is searched for conflict markers when a file is edited and when the
buffer is saved, and the status is updated accordingly. The autocmd-events
are stored in a variable. If you don't need the auto-detection, empty the
event list:

    let g:ConflictDetection_AutoDetectEvents = ''

A warning message is issued when the buffer is read or written and conflict
markers have been detected. You can empty / edit the autocmd-events list if
you don't want a warning at all / on buffer writes only:

    let g:ConflictDetection_WarnEvents = 'BufWritePost'

CONTRIBUTING
------------------------------------------------------------------------------

Report any bugs, send patches, or suggest features via the issue tracker at
https://github.com/inkarkat/vim-ConflictDetection/issues or email (address
below).

HISTORY
------------------------------------------------------------------------------

##### 1.12    27-Mar-2013
- To avoid false positives (e.g. in nested email replies), ensure that both
  "our" and "theirs" markers do exist.
- Add dependency to ingo-library ([vimscript #4433](http://www.vim.org/scripts/script.php?script_id=4433)).

##### 1.11    04-Dec-2012
- FIX: Prevent error on Vim 7.0 - 7.2.

##### 1.10    04-Dec-2012
- ENH: Add :ConflictSyntax command to work around interference of the conflict
highlightings with the original filetype's syntax.

##### 1.02    16-Nov-2012
- FIX: Avoid E417 / E421 in conflict marker highlight group definitions when no
original color is defined (i.e. when the colorscheme does not define a cterm /
gui background color for DiffAdd/Change/Text). Thanks to Dave Goodell for
sending a patch.

##### 1.01    17-Oct-2012
- Avoid long search delays on very large files.

##### 1.00    13-Jul-2012
- First published version.

##### 0.01    14-Mar-2012
- Started development.

------------------------------------------------------------------------------
Copyright: (C) 2012-2020 Ingo Karkat -
The [VIM LICENSE](http://vimdoc.sourceforge.net/htmldoc/uganda.html#license) applies to this plugin.

Maintainer:     Ingo Karkat &lt;ingo@karkat.de&gt;
