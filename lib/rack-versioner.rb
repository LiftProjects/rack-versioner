require "rack-versioner/version"

module Rack
  class Versioner
    def initialize(app, options = {})
      @app = app
      @options = options
    end

    def call(env)  
      env['api.version'] = extract_version(env)
      @app.call env
    end

    private
    # 1
    # 1.2
    # 1.2.3
    VERSION_STRING       = '(\d+(?:\.\d+)*)'

    # v1.2.3
    PATH_INFO_PATTERN    = /\bv(.*)/

    # application/vnd.foo.bar-v1+xml
    # application/vnd.foo.bar-v1.2.3+json
    # ...
    HTTP_ACCEPT_PATTERN  = /.*\-v#{VERSION_STRING}/

    # ?version=1.2.3
    QUERY_STRING_PATTERN = /\bversion=#{VERSION_STRING}(&|$)/

    def extract_version(env)
      strategy = @options[:using].to_sym || :path

      case strategy
      when :path
        extract_version_from_path(env)
      when :header
        extract_version_from_header(env)
      when :query
        extract_version_from_query(env)
      end
    end
    
    def extract_version_from_path(env)
      pieces = env['PATH_INFO'].split('/')
      version = ''
      path = '/'
      
      unless pieces.empty?
        version = pieces[1][PATH_INFO_PATTERN, 1]
        path = pieces[2..-1].join('/')
      end

      env['PATH_INFO'] = "/#{path}"
      return version
    end

    def extract_version_from_header(env)
      version = env['HTTP_ACCEPT'].to_s[HTTP_ACCEPT_PATTERN, 1]
    end

    def extract_version_from_query(env)
      version = env['QUERY_STRING'].to_s[QUERY_STRING_PATTERN, 1]
    end

  end
end
