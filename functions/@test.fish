function @test -a name stuff operator expected
    set -U _spout_test_number (math $_spout_test_number +1)

    if test $stuff $operator $expected
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
    breakpoint
end