class ApplicationController < ActionController::Base
  REALM = "RockPalace"
  USERS = { "admin" => "secret",
            "brad" => "pointer",
            "dap" => Digest::MD5.hexdigest(["dap",REALM,"secret"].join(":"))}

  def authenticate
    Rails.env.test? || authenticate_or_request_with_http_digest(REALM) { |username| USERS[username] }
  end
end
