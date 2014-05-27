require 'guard/gradle/version'
require 'guard'
require 'guard/plugin'

module Guard
	class Gradle < Plugin
		def run_on_changes(paths)
			if(paths.size == 1) && (Dir.glob("src/test/**/#{paths[0]}*").size > 0)
				fire_command("./gradlew test -Dtest.single=#{paths[0]}")
      		else
      			run_all
      		end
		end

		def run_all
			fire_command('./gradlew test')
		end

		def fire_command(command)
			spawn(command)
		end
	end
end
