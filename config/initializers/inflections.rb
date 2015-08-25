ActiveSupport::Inflector.inflections do |inflect|
  inflect.singular /^(campus)(es)?$/i, '\1'
  inflect.plural   /^(campus)$/i, '\1es'
end
