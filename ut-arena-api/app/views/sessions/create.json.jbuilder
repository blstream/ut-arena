json.user do
  json.id @user.id
  json.login @user.login
  json.token @user.authentication_token
end
