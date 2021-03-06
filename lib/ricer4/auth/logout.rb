module Ricer4::Plugins::Auth
  class Logout < Ricer4::Plugin
  
    trigger_is :logout
    permission_is :authenticated
    
    has_usage
    def execute
      user.logout!
      rply :msg_logged_out
    end
  
  end
end
