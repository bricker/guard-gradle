require 'guard/gradle/version'
require 'guard'
require 'guard/plugin'

module Guard
	class Gradle < Plugin
		
		DEF_CMD = './gradlew test'

		def run_on_changes(paths)
			if(paths.size == 1) && (Dir.glob("src/test/**/#{paths[0]}*").size > 0)
				fire_command("#{DEF_CMD} -Dtest.single=#{paths[0]}")
      		else
      			run_all
      		end
		end

		def run_all
			fire_command DEF_CMD
		end

		def fire_command(command)
			result = system command
    		summary = result ? 'Success' : 'Failure'
    		image = result ? :success : :failed
    		notify(summary, image)
		end

		 def notify(summary, image)
    		::Guard::Notifier.notify(summary, title: 'Nebula Test Results', image: image)
    	end

	    def start
	    	fire_command DEF_CMD
	    end

	    def run_all
	    	fire_command DEF_CMD
	    end
	end
end
