Types::LinkType = GraphQL::ObjectType.define do
  name 'Link'

  field :id, !types.ID
  field :url, !types.String
  field :description, !types.String

  # add postedBy field to Link type
  # - "-> { }": helps against loading issues between types
  # - "property": remaps field to an attribute of Link model
  field :posted_by, -> { Types::UserType }, property: :user
end