require 'guard/gradle/version'
require 'guard'
require 'guard/plugin'

module Guard
  class Gradle < Plugin
		
    DEF_CMD = './gradlew test'

    @multi_projs = false

    def initialize(options = {})
      if options.has_key? :multi_project
        @multi_projs = options[:multi_project]
      end
      super
    end

    def run_on_changes(paths)
      if paths.size == 1 && @multi_projs
        project = paths[0].split('/')[0]
        file = paths[0].split('/')[1]    
        if Dir.glob("#{project}/src/test/**/#{file}*").size > 0
          fire_command("#{DEF_CMD} -p #{project} -Dtest.single=#{file} --daemon")
        else
          run_all
        end
      elsif(paths.size == 1) && (Dir.glob("src/test/**/#{paths[0]}*").size > 0)
        fire_command("#{DEF_CMD} -Dtest.single=#{paths[0]} --daemon")
      else
        run_all
      end
    end

    def run_all
      fire_command DEF_CMD
    end

    def fire_command(command)
      UI.info "running #{command}"
      result = system command
      summary = result ? 'Success' : 'Failure'
      image = result ? :success : :failed
      notify(summary, image)
    end

    def notify(summary, image)
      ::Guard::Notifier.notify(summary, title: 'Gradle Test Results', image: image)
    end

    def start
      fire_command DEF_CMD
    end

    def run_all
      fire_command DEF_CMD
    end
  end
end
