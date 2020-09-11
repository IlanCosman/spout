function @test -a name
    set testArgs $argv[2..-1]

    for op in $_spout_operators
        if set -l operatorIndex (contains --index -- $op $testArgs)
            set operator $op

            if set -l index (contains --index -- $op $_spout_operators_with_expectations)
                set expected $_spout_expectations[$index]
            else
                set expected $testArgs[(math $operatorIndex+1)]
            end

            if test "$operatorIndex" -gt 1
                set actual $testArgs[(math $operatorIndex-1)]
            end

            break
        end
    end

    set _spout_test_number (math $_spout_test_number +1)

    if test $testArgs
        echo "ok $_spout_test_number $name"

        set _spout_test_number_passed (math $_spout_test_number_passed +1)
        return 0
    else
        echo "not ok $_spout_test_number $name
  ---
    operator: $operator
    expected: $expected
    actual:   $actual
  ..."

        set _spout_test_number_failed (math $_spout_test_number_failed +1)
        return 1
    end
end