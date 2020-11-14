function spout
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

    return $_spout_test_number_failed
end
