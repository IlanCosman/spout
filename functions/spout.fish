function spout
    set -lx _spout_test_number 0
    set -lx _spout_test_number_passed 0
    set -lx _spout_test_number_failed 0

    echo 'TAP version 13'

    for file in $argv
        fish $file
    end

    echo
    echo "1..$_spout_test_number"
    echo "# pass $_spout_test_number_passed"
    echo "# fail $_spout_test_number_failed"

    if test $_spout_test_number_failed -gt 0
        return 1
    end
end