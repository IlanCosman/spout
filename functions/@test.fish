function @test -a name stuff operator expected
    set -U _spout_test_number (math $_spout_test_number +1)

    if test $stuff $operator $expected
        echo "ok $_spout_test_number $name"

        set -U _spout_test_number_passed (math $_spout_test_number_passed +1)
    else
        echo "not ok $_spout_test_number $name"
        echo "  ---"
        echo "    operator: $operator"
        echo "    expected: $expected"
        echo "    actual:   $stuff"
        echo "  ..."

        set -U _spout_test_number_failed (math $_spout_test_number_failed +1)
        set -U _spout_test_failed
    end
    breakpoint
end