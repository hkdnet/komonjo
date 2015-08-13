# allow accsess with symbol key
module HashExtensions
  refine Hash do
    def symbolize_keys
      map { |k, v| [k.to_sym, v] }
    end
  end
end
