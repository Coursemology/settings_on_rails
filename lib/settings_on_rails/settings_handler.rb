module SettingsOnRails
  class SettingsHandler
    def initialize(keys, target_object, column)
      @keys = _prefix(keys.dup)
      @target_object = target_object
      @column = column
    end

    REGEX_SETTER = /\A([a-z]\w+)=\Z/i
    REGEX_GETTER = /\A([a-z]\w+)\Z/i

    def respond_to?(method_name, include_priv=false)
      super || method_name.to_s =~ REGEX_SETTER
    end

    def method_missing(method_name, *args, &block)
      if method_name.to_s =~ REGEX_SETTER && args.size == 1
        _set_value($1, args.first)
      elsif method_name.to_s =~ REGEX_GETTER && args.size == 0
        _get_value($1)
      else
        super
      end
    end

    private
    def _get_value(name)
      node = _get_key_node

      if node
        node[name]
      else
        nil
      end
    end

    def _set_value(name, v)
      return if _get_value(name) == v

      @target_object.send("#{@column}_will_change!")
      _build_key_tree
      node = _get_key_node
      if v.nil?
        node.delete(name)
      else
        node[name] = v
      end
    end

    def _key_node_exist?
      value = _target_column

      for key in @keys
          value = value[key]
          return false unless value
      end

      true
    end

    def _get_key_node
      ret = _key_node_exist?
      return nil unless ret

      @keys.inject(_target_column) { |h, key| h[key] }
    end

    def _build_key_tree
      value = _target_column

      for key in @keys
        value[key] = {} unless value[key]
        value = value[key]
      end
    end

    def _target_column
      @target_object.read_attribute(@column.to_sym)
    end

    def _target_class
      @target_object.class
    end

    # prefix keys with __, to differentiate `settings(:key_a, :key_b)` and settings(:key_a).key_b
    # thus __ becomes an reserved field
    def _prefix(keys)
      for i in 0..(keys.length - 1)
        keys[i] = ('__' + keys[i].to_s).to_sym
      end
      keys
    end
  end
end
