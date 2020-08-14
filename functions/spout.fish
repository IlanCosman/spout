function spout
    set _spout_test_number 0
    set _spout_test_number_passed 0
    set _spout_test_number_failed 0

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