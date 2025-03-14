class AuthorSerializer
  include Alba::Resource

  attributes :id, :first_name, :last_name, :middle_name
end
