module SSHKit

  class Configuration

    attr_accessor :umask, :output_verbosity
    attr_writer :output, :backend, :default_env

    def output
      @output ||= use_format(:pretty)
    end

    def deprecation_logger
      self.deprecation_output = $stderr if @deprecation_logger.nil?
      @deprecation_logger
    end

    def deprecation_output=(out)
      @deprecation_logger = DeprecationLogger.new(out)
    end

    def default_env
      @default_env ||= {}
    end

    def backend
      @backend ||= SSHKit::Backend::Netssh
    end

    def output_verbosity
      @output_verbosity ||= logger(:info)
    end

    def output_verbosity=(verbosity)
      @output_verbosity = logger(verbosity)
    end

    # TODO: deprecate in favor of `use_format`
    def format=(format)
      use_format(format)
    end

    # Tell SSHKit to use the specified `formatter` for stdout. The formatter
    # can be the name of a built-in SSHKit formatter, like `:pretty`, a
    # formatter class, like `SSHKit::Formatter::Pretty`, or a custom formatter
    # class you've written yourself.
    #
    # Additional arguments will be passed to the formatter's constructor.
    #
    # Example:
    #
    #   config.use_format(:pretty)
    #
    # Is equivalent to:
    #
    #   config.output = SSHKit::Formatter::Pretty.new($stdout)
    #
    def use_format(formatter, *args)
      klass = formatter.is_a?(Class) ? formatter : formatter_class(formatter)
      self.output = klass.new($stdout, *args)
    end

    def command_map
      @command_map ||= SSHKit::CommandMap.new
    end

    def command_map=(value)
      @command_map = SSHKit::CommandMap.new(value)
    end

    private

    def logger(verbosity)
      verbosity.is_a?(Integer) ? verbosity : Logger.const_get(verbosity.upcase)
    end

    def formatter_class(symbol)
      name = symbol.to_s.downcase
      found = SSHKit::Formatter.constants.find do |const|
        const.to_s.downcase == name
      end
      fail NameError, 'Unrecognized SSHKit::Formatter "#{symbol}"' if found.nil?
      SSHKit::Formatter.const_get(found)
    end

  end

end
