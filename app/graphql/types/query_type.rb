Types::QueryType = GraphQL::ObjectType.define do
  name "Query"
  # Add root-level fields here.
  # They will be entry points for queries on your schema.

  field :allLinks, !types[Types::LinkType] do
    description 'Query for all the links'
    resolve ->(_obj, _args, _ctx) { Link.all }
  end

  field :allUsers, !types[Types::UserType] do
    description 'Lists a bunch of users'
    resolve ->(_obj, _args, _ctx) { User.all }
  end
end
