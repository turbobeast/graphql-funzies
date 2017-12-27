class Resolvers::SignInUser < GraphQL::Function
  argument :email, !Types::AuthProviderEmailInput

  type do
    name 'SignInPayload'

    field :token, types.String
    field :user, Types::UserType
  end

  def call(_obj, args, ctx)
    input = args[:email]

    return unless input

    user = User.find_by email: input[:email]
    return unless user
    return unless user.authenticate(input[:password])

    token = create_token(user)
    ctx[:session][:token] = token

    OpenStruct.new(
      user: user,
      token: token
    )
  end

  private

  def create_token(user)
    crypt = ActiveSupport::MessageEncryptor.new(Rails.application.secrets.secret_key_base.byteslice(0..31))
    crypt.encrypt_and_sign("user-id:#{user.id}")
  end
end
