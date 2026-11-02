function clean --description "Clean Rust/npm build artifacts and .DS_Store files"
    argparse h/help n/dry-run -- $argv
    or return 1

    if set -q _flag_help
        echo "Usage: clean [-n|--dry-run] [DIR...]"
        echo "Finds Rust projects (Cargo.toml + target/) and runs cargo clean."
        echo "Finds npm projects (package.json + node_modules/) and deletes node_modules/."
        echo "Deletes .DS_Store files."
        echo "Default directory: \$HOME"
        return 0
    end

    set -l roots $argv
    test (count $roots) -eq 0; and set roots $HOME

    # target/ next to a Cargo.toml = Rust project (or workspace)
    # node_modules/ next to a package.json = npm project
    set -l kinds
    set -l dirs
    set -l ds_stores
    for root in $roots
        for found in (find $root \
                \( -name .git -o -name .Trash -o -path "$HOME/Library" \) -prune -o \
                -type d \( -name target -o -name node_modules \) -prune -print -o \
                -type f -name .DS_Store -print 2>/dev/null)
            set -l dir (dirname $found)
            switch (basename $found)
                case .DS_Store
                    set -a ds_stores $found
                    continue
                case target
                    test -f $dir/Cargo.toml; or continue
                    set -a kinds rust
                case node_modules
                    test -f $dir/package.json; or continue
                    set -a kinds npm
            end
            set -a dirs $dir
        end
    end

    if test (count $dirs) -eq 0 -a (count $ds_stores) -eq 0
        echo "Nothing to clean."
        return 0
    end

    set -l total_kb 0
    # Not `seq (count $dirs)`: on macOS `seq 0` counts down to 1 0
    set -l i 0
    for dir in $dirs
        set i (math $i + 1)
        set -l kind $kinds[$i]
        set -l artifact $dir/target
        test $kind = npm; and set artifact $dir/node_modules

        set -l before_kb (du -sk $artifact 2>/dev/null | cut -f1)
        test -n "$before_kb"; or set before_kb 0
        set -l size (__clean_human $before_kb)

        if set -q _flag_dry_run
            printf "%-6s %-10s %s\n" "[$kind]" $size $dir
            set total_kb (math $total_kb + $before_kb)
            continue
        end

        printf "🧹 %-6s %-10s %s\n" "[$kind]" $size $dir
        if test $kind = rust
            cargo clean --quiet --manifest-path $dir/Cargo.toml
        else
            rm -rf $artifact
        end
        or echo "   ⚠️  failed for $dir"

        set -l after_kb 0
        test -d $artifact; and set after_kb (du -sk $artifact 2>/dev/null | cut -f1)
        set total_kb (math $total_kb + $before_kb - $after_kb)
    end

    set -l ds_count (count $ds_stores)
    if test $ds_count -gt 0
        set -l ds_kb (du -sk $ds_stores 2>/dev/null | awk '{s += $1} END {print s + 0}')
        set -l size (__clean_human $ds_kb)
        if set -q _flag_dry_run
            printf "%-6s %-10s %s\n" "[ds]" $size "$ds_count .DS_Store file(s)"
            set total_kb (math $total_kb + $ds_kb)
        else
            printf "🧹 %-6s %-10s %s\n" "[ds]" $size "$ds_count .DS_Store file(s)"
            rm -f $ds_stores
            set -l left (count (for f in $ds_stores; test -e $f; and echo $f; end))
            test $left -gt 0; and echo "   ⚠️  $left .DS_Store file(s) could not be deleted"
            set total_kb (math $total_kb + $ds_kb)
        end
    end

    echo
    set -l total (__clean_human $total_kb)
    set -l summary (count $dirs)" project(s)"
    test $ds_count -gt 0; and set summary "$summary and $ds_count .DS_Store file(s)"
    if set -q _flag_dry_run
        echo "$summary to clean, $total would be freed (dry-run, nothing deleted)."
    else
        echo "$summary cleaned, $total freed."
    end
end

function __clean_human --argument-names kb
    if test $kb -ge 1048576
        printf "%.2f GB" (math $kb / 1048576)
    else if test $kb -ge 1024
        printf "%.1f MB" (math $kb / 1024)
    else
        printf "%d KB" $kb
    end
end
