class Office
  attr_reader :config, :code

  def initialize(code, config)
    @code = code
    @config = config
  end

  def has_config?(key)
    @config.has_key?(key)
  end

end
