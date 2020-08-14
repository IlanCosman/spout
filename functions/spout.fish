function spout
    set -e _spout_test_number
    set -e _spout_test_number_passed
    set -e _spout_test_number_failed

    printf '%s\n' 'TAP version 13'

    for file in $argv
        fish $file
    end

    printf '%s\n'
    printf '%s\n' "1..$_spout_test_number"
    printf '%s\n' "# pass $_spout_test_number_passed"
    printf '%s\n' "# fail $_spout_test_number_failed"

    if test $_spout_test_number_failed -gt 0
        return 1
    end
end