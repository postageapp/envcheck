class Envcheck
  # == Constants ============================================================
  
  COMMANDS = {
    :ruby => {
      :version => /^ruby (\S+)/
    },
    :rubygems => {
      :bin => 'gem',
      :version => /(\S+)/
    },
    :bundler => {
      :bin => 'bundle',
      :version => /^Bundler version (.*)/
    },
    :passenger => {
      :version => /^Phusion Passenger version (\S+)/
    },
    :ImageMagick => {
      :bin => 'convert',
      :version => /^Version: ImageMagick (\S+)/
    },
    :mysql => {
      :version => /Ver\s+\S+\s+Distrib\s+(\S+),/
    }
  }.freeze

  # == Class Methods ========================================================

  def self.report
    self.new.report
  end

  # == Instance Methods =====================================================
  
  def initialize(options = nil)
    @options = options
  end
  
  def path
    @path ||= ENV['PATH'].split(/\:/).select do |path|
      path and path.match(/\S/)
    end
  end
  
  def find_in_path(file)
    return unless (file)

    file = file.to_s
    
    self.path.each do |path|
      test_path = File.expand_path(file, path)
      if (File.exist?(test_path))
        return test_path
      end
    end
    
    nil
  end
  
  def report
    summary = ''
    
    COMMANDS.each do |command, config|
      summary << "#{command}\n"
      
      if (bin_found = self.find_in_path(config[:bin] || command))
        summary << "  #{bin_found}\n"
        
        version_string = `#{bin_found} #{config[:version_flag] || '--version'}`
        
        if (match = (config[:version] and version_string.match(config[:version])))
          summary << "  Version #{match[1]}\n"
        else
          summary << version_string.split(/\n/).collect { |s| "  #{s}\n" }.join('')
        end
      else
        summary << "  NOT FOUND\n"
      end
    end
    
    summary
  end
end
