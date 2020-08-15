function @test
    set name $argv[1]
    set testArgs $argv[2..-1]

    set -a operatorList -{b,c,d,e,f,g,G,k,L,O,p,r,s,S,t,u,w,x} # Files and directories
    set -a operatorList = != -{n,z} # Strings
    set -a operatorList -{eq,ne,gt,ge,lt,le} # Numbers

    for op in $operatorList
        set -l operatorIndex (contains --index -- $op $testArgs)

        if test -n "$operatorIndex"
            set operator $op

            if not set expected (_spout_operator_expectations)
                set expected $testArgs[(math $operatorIndex+1)]
            end

            if test "$operatorIndex" -gt 1
                set actual $testArgs[(math $operatorIndex-1)]
            end
        end
    end

    set _spout_test_number (math $_spout_test_number +1)

    if test $testArgs
        echo "ok $_spout_test_number $name"

        set _spout_test_number_passed (math $_spout_test_number_passed +1)
        return 0
    else
        echo "not ok $_spout_test_number $name"
        echo "  ---"
        echo "    operator: $operator"
        echo "    expected: $expected"
        echo "    actual:   $actual"
        echo "  ..."

        set _spout_test_number_failed (math $_spout_test_number_failed +1)
        return 1
    end
end

function _spout_operator_expectations --no-scope-shadowing
    switch $operator
        case '-n'
            echo "a non-zero length string"
            set actual $testArgs[(math $operatorIndex+1)]
        case '-z'
            echo "a zero length string"
            set actual $testArgs[(math $operatorIndex+1)]
        case '-b'
            echo "a block device"
        case '-c'
            echo "a character device"
        case '-d'
            echo "a directory"
        case '-e'
            echo "an existing file"
        case '-f'
            echo "a regular file"
        case '-g'
            echo "a file with the set-group-ID bit set"
        case '-G'
            echo "a file with same group ID as the current user"
        case '-k'
            echo "a file with the sticky bit set"
        case '-L'
            echo "a symbolic link"
        case '-O'
            echo "a file owned by the current user"
        case '-p'
            echo "a named pipe"
        case '-r'
            echo "a file marked as readable"
        case '-s'
            echo "a file of size greater than zero"
        case '-S'
            echo "a socket"
        case '-t'
            echo "a terminal tty file descriptor"
        case '-u'
            echo "a file with the set-user-ID bit set"
        case '-w'
            echo "a file marked as writable"
        case '-x'
            echo "a file marked as executable"
        case '*'
            return 1
    end
end