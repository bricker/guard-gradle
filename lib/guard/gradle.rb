require "guard/gradle/version"

require 'guard'
require 'guard/plugin'

module Guard
  class Gradle < Plugin
    def run_on_changes(paths)
      UI.info "Building project..."
      spawn("./gradlew build")
    end
  end
end
