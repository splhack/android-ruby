require 'dl'
require 'dl/callback'
require 'dl/stack'
require 'dl/value'
require 'thread'

module DL
  class Function
    include DL
    include ValueUtil

    def initialize(cfunc, argtypes, &proc)
      @cfunc = cfunc
      @stack = Stack.new(argtypes.collect{|ty| ty.abs})
      if( @cfunc.ctype < 0 )
        @cfunc.ctype = @cfunc.ctype.abs
        @unsigned = true
      end
      if( proc )
        bind(&proc)
      end
    end

    def to_i()
      @cfunc.to_i
    end

    def check_safe_obj(val)
      if $SAFE > 0 and val.tainted?
        raise SecurityError, 'Insecure operation'
      end
    end

    def call(*args, &block)
      funcs = []
      args.each{|e| check_safe_obj(e) }
      check_safe_obj(block)
      args = wrap_args(args, @stack.types, funcs, &block)
      r = @cfunc.call(@stack.pack(args))
      funcs.each{|f| f.unbind_at_call()}
      return wrap_result(r)
    end

    def wrap_result(r)
      case @cfunc.ctype
      when TYPE_VOIDP
        r = CPtr.new(r)
      else
        if( @unsigned )
          r = unsigned_value(r, @cfunc.ctype)
        end
      end
      r
    end

    def bind(&block)
      if( !block )
        raise(RuntimeError, "block must be given.")
      end
      if( @cfunc.ptr == 0 )
        cb = Proc.new{|*args|
          ary = @stack.unpack(args)
          @stack.types.each_with_index{|ty, idx|
            case ty
            when TYPE_VOIDP
              ary[idx] = CPtr.new(ary[idx])
            end
          }
          r = block.call(*ary)
          wrap_arg(r, @cfunc.ctype, [])
        }
        case @cfunc.calltype
        when :cdecl
          @cfunc.ptr = set_cdecl_callback(@cfunc.ctype, @stack.size, &cb)
        when :stdcall
          @cfunc.ptr = set_stdcall_callback(@cfunc.ctype, @stack.size, &cb)
        else
          raise(RuntimeError, "unsupported calltype: #{@cfunc.calltype}")
        end
        if( @cfunc.ptr == 0 )
          raise(RuntimeException, "can't bind C function.")
        end
      end
    end

    def unbind()
      if( @cfunc.ptr != 0 )
        case @cfunc.calltype
        when :cdecl
          remove_cdecl_callback(@cfunc.ptr, @cfunc.ctype)
        when :stdcall
          remove_stdcall_callback(@cfunc.ptr, @cfunc.ctype)
        else
          raise(RuntimeError, "unsupported calltype: #{@cfunc.calltype}")
        end
        @cfunc.ptr = 0
      end
    end

    def bind_at_call(&block)
      bind(&block)
    end

    def unbind_at_call()
    end
  end

  class TempFunction < Function
    def bind_at_call(&block)
      bind(&block)
    end

    def unbind_at_call()
      unbind()
    end
  end

  class CarriedFunction < Function
    def initialize(cfunc, argtypes, n)
      super(cfunc, argtypes)
      @carrier = []
      @index = n
      @mutex = Mutex.new
    end

    def create_carrier(data)
      ary = []
      userdata = [ary, data]
      @mutex.lock()
      @carrier.push(userdata)
      return dlwrap(userdata)
    end

    def bind_at_call(&block)
      userdata = @carrier[-1]
      userdata[0].push(block)
      bind{|*args|
        ptr = args[@index]
        if( !ptr )
          raise(RuntimeError, "The index of userdata should be lower than #{args.size}.")
        end
        userdata = dlunwrap(Integer(ptr))
        args[@index] = userdata[1]
        userdata[0][0].call(*args)
      }
      @mutex.unlock()
    end
  end
end
