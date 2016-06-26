module Ricer4::Plugins::Auth
  class Login < Ricer4::Plugin

    trigger_is :login  
    permission_is :registered
    scope_is :user

    always_enabled
    bruteforce_protected
    
    has_usage '<password>'
    def execute(password)
      return erply :err_already_authenticated if user.authenticated?
      return erplyp :err_wrong_password unless user.authenticate!(password)
      rply :msg_authenticated
    end
  
  end
end
