 \
	class Object; \
	  CROSS_COMPILING = RUBY_PLATFORM; \
	  remove_const :RUBY_PLATFORM; \
	  remove_const :RUBY_VERSION; \
	  RUBY_PLATFORM = "arm-linux"; \
	  RUBY_VERSION = "1.9.1"; \
	end; \
	if RUBY_PLATFORM =~ /mswin|bccwin|mingw/; \
	  class File; \
	    remove_const :ALT_SEPARATOR; \
	    ALT_SEPARATOR = "\\"; \
	  end; \
	end; \
	
