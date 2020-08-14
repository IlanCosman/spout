function @test
    set -U _spout_test_number (math $_spout_test_number+1)

    # Beginning operators
    argparse --ignore-unknown b c d e f g G k L O p r s S t u w x -- $argv # Operators for files and directories
    argparse --ignore-unknown n z -- $argv # Operators for text strings

    # -eq will cause argparse to create _flag_e, which we must erase
    for operator in eq ne gt ge lt le
        if contains -- "-$operator" $argv
            set -e _flag_(string sub --length 1 $operator)
        end
    end

    set -l beginningOperators (set -l -n | string replace --filter '_flag_' '-')

    set -l name $argv[1]
    set -l stuff $argv[2]
    set -l operator $argv[3]
    set -l expected $argv[4]

    set testArgs $stuff $operator $expected

    # Check for beginning operators
    if test -n "$beginningOperators"
        set operator $beginningOperators

        if test -n "$expected"
            set stuff $expected
        end
        set testArgs $operator $stuff

        set expected (_spout_beginning_operators_expectations)
    end

    if test $testArgs
        printf '%s\n' "ok $_spout_test_number $name"

        set -U _spout_test_number_passed (math $_spout_test_number_passed+1)
    else
        printf '%s\n' "not ok $_spout_test_number $name"
        printf '%s\n' "  ---"
        printf '%s\n' "    operator: $operator"
        printf '%s\n' "    expected: $expected"
        printf '%s\n' "    actual:   $stuff"
        printf '%s\n' "  ..."

        set -U _spout_test_number_failed (math $_spout_test_number_failed+1)
    end
end

function _spout_beginning_operators_expectations --no-scope-shadowing
    switch $operator
        case '-n'
            printf '%s\n' "a non-zero length string"
        case '-z'
            printf '%s\n' "a zero length string"
        case '-b'
            printf '%s\n' "a block device"
        case '-c'
            printf '%s\n' "a character device"
        case '-d'
            printf '%s\n' "a directory"
        case '-e'
            printf '%s\n' "an existing file"
        case '-f'
            printf '%s\n' "a regular file"
        case '-g'
            printf '%s\n' "a file with the set-group-ID bit set"
        case '-G'
            printf '%s\n' "a file with same group ID as the current user"
        case '-k'
            printf '%s\n' "a file with the sticky bit set"
        case '-L'
            printf '%s\n' "a symbolic link"
        case '-O'
            printf '%s\n' "a file owned by the current user"
        case '-p'
            printf '%s\n' "a named pipe"
        case '-r'
            printf '%s\n' "a file marked as readable"
        case '-s'
            printf '%s\n' "a file of size greater than zero"
        case '-S'
            printf '%s\n' "a socket"
        case '-t'
            printf '%s\n' "a terminal tty file descriptor"
        case '-u'
            printf '%s\n' "a file with the set-user-ID bit set"
        case '-w'
            printf '%s\n' "a file marked as writable"
        case '-x'
            printf '%s\n' "a file marked as executable"
        case '*'
            printf '%s\n' "a valid operator"
    end
end