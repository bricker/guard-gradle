require 'bundler/setup'
require 'test/unit'
require 'mocha/test_unit'

require File.expand_path(File.dirname(__FILE__) + '/../lib/guard/gradle')

class GuardGradleTest < Test::Unit::TestCase

	def test_single_should_be_executed
		plugin = Guard::Gradle.new
		expected = 'User'
		plugin.expects(:fire_command).with("./gradlew test -Dtest.single=#{expected} --daemon")
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

	def test_for_multi_projects
		plugin = Guard::Gradle.new({multi_project: true})
		expected = 'Foo/User'
		plugin.expects(:fire_command).with('./gradlew test -p Foo -Dtest.single=User --daemon')
		Dir.expects(:glob).returns([true])
		plugin.run_on_changes [expected]
	end

  def test_for_configurable_command
		plugin = Guard::Gradle.new({command: 'gradle'})
		expected = 'User'
		plugin.expects(:fire_command).with("gradle test -Dtest.single=#{expected} --daemon")
		Dir.expects(:glob).returns([true])
		plugin.run_on_changes [expected]
  end

  def test_for_configurable_task
		plugin = Guard::Gradle.new({task: 'mySpecialTask'})
		expected = 'User'
		plugin.expects(:fire_command).with("./gradlew mySpecialTask -Dtest.single=#{expected} --daemon")
		Dir.expects(:glob).returns([true])
		plugin.run_on_changes [expected]
  end

  def test_for_configurable_flags
		plugin = Guard::Gradle.new({flags: '-q -s'})
		expected = 'User'
		plugin.expects(:fire_command).with("./gradlew test -q -s -Dtest.single=#{expected} --daemon")
		Dir.expects(:glob).returns([true])
		plugin.run_on_changes [expected]
  end
end
