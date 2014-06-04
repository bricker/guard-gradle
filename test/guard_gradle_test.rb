require 'bundler/setup'
require 'test/unit'
require 'mocha/test_unit'

require File.expand_path(File.dirname(__FILE__) + '/../lib/guard/gradle')

class GuardGradleTest  < Test::Unit::TestCase

	def test_single_should_be_executed
		plugin = Guard::Gradle.new
		expected = 'User'
		plugin.expects(:fire_command).with("./gradlew test -Dtest.single=#{expected}")
		Dir.expects(:glob).returns([true])
		plugin.run_on_changes [expected]
	end

	def test_all_when_file_not_found
		plugin = Guard::Gradle.new
		expected = 'User'
		plugin.expects(:fire_command).with('./gradlew test')
		Dir.expects(:glob).returns([])
		plugin.run_on_changes [expected]
	end
end