function @test
    set -U _spout_test_number (math $_spout_test_number +1)

    # Beginning operators
    argparse --ignore-unknown b c d e f g G k L O p r s S t u w x -- $argv # Operators for files and directories
    argparse --ignore-unknown n z -- $argv # Operators for text strings

    for operator in eq ne gt ge lt le
        if contains -- "-$operator" $argv
            set -e _flag_(string sub --length 1 $operator)
        end
    end

    set -l beginningOperators (set -l -n | string replace --filter "_flag_" "-")

    set -l name $argv[1]
    set -l stuff $argv[2]
    set -l operator $argv[3]
    set -l expected $argv[4]

    set testArgs $stuff $operator $expected

    # Check for beginning operator
    if test -n "$beginningOperators"
        set operator $beginningOperators

        if test -n "$expected"
            set stuff $expected
        end
        set testArgs $operator $stuff
    end

    if test $testArgs
        printf '%s\n' "ok $_spout_test_number $name"

        set -U _spout_test_number_passed (math $_spout_test_number_passed +1)
    else
        printf '%s\n' "not ok $_spout_test_number $name"
        printf '%s\n' "  ---"
        printf '%s\n' "    operator: $operator"
        printf '%s\n' "    expected: $expected"
        printf '%s\n' "    actual:   $stuff"
        printf '%s\n' "  ..."

        set -U _spout_test_number_failed (math $_spout_test_number_failed +1)
    end
end

function _spout_errors --no-scope-shadowing
    switch $operator
        case "-n"
            set message "a non-zero length string"
    end
end