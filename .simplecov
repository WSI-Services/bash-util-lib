# https://github.com/infertux/bashcov/blob/master/USAGE.md
# https://github.com/simplecov-ruby/simplecov#test-suite-names

SimpleCov.command_name "Bash Utility Library"

# https://github.com/infertux/bashcov/blob/master/spec/test_app/.simplecov
# https://github.com/simplecov-ruby/simplecov#groups

SimpleCov.add_group "Library Scripts", /^\/src\/bash-util-lib.*\.sh$/
SimpleCov.add_group "Unit Tests", /^\/tests\/bash-util-lib.*\.test\.sh$/

# https://github.com/simplecov-ruby/simplecov#defining-custom-filters

SimpleCov.add_filter %r{^/tests/shunit2\.}
