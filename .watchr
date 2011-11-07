watch( '^spec/.*_spec\.rb') { |m| system("spin push #{m[0]}") }

