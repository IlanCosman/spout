function spout
    set -U _spout_operators
    set -a _spout_operators = != -{n,z} # Strings
    set -a _spout_operators -{eq,ne,gt,ge,lt,le} # Numbers
    set -a _spout_operators -{b,c,d,e,f,g,G,k,L,O,p,r,s,S,t,u,w,x} # Files and directories

    set -U _spout_operators_with_expectations -{n,z,b,c,d,e,f,g,G,k,L,O,p,r,s,S,t,u,w,x}
    set -U _spout_expectations \
        "a non-zero length string" \
        "a zero length string" \
        "a block device" \
        "a character device" \
        "a directory" \
        "an existing file" \
        "a regular file" \
        "a file with the set-group-ID bit set" \
        "a file with same group ID as the current user" \
        "a file with the sticky bit set" \
        "a symbolic link" \
        "a file owned by the current user" \
        "a named pipe" \
        "a file marked as readable" \
        "a file of size greater than zero" \
        "a socket" \
        "a terminal tty file descriptor" \
        "a file with the set-user-ID bit set" \
        "a file marked as writable" \
        "a file marked as executable"

    set -U _spout_test_number 0
    set -U _spout_test_number_passed 0
    set -U _spout_test_number_failed 0

    printf '%s\n' 'TAP version 13'

    for file in $argv
        fish $file
    end

    printf '%s\n' \
        "" \
        "1..$_spout_test_number" \
        "# pass $_spout_test_number_passed" \
        "# fail $_spout_test_number_failed"

    if test $_spout_test_number_failed -gt 0
        return 1
    end
end

function _spout_uninstall --on-event _spout_uninstall
    set -e _spout_operators
    set -e _spout_operators_with_expectations
    set -e _spout_expectations
    set -e _spout_test_number
    set -e _spout_test_number_passed
    set -e _spout_test_number_failed
end