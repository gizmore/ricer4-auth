module Ricer4::Extend::ForcesAuthentication
  
  FORCE_AUTH_OPTIONS ||= {
    always: true
  }
  
  def forces_authentication(options={})
    class_eval do |klass|

      ActiveRecord::Magic::Options.merge(options, FORCE_AUTH_OPTIONS)
      
      klass.register_exec_function(:exec_auth_check!) if options[:always]
      
      def passes_auth_check?
        !failed_auth_check?
      end
      
      def failed_auth_check?
        (user.registered?) && (!user.authenticated?)
      end
      
      def auth_check_text
        I18n.t('ricer4.extend.forces_authentication.err_authenticate')
      end

      def exec_auth_check!(line)
        if failed_auth_check?
          raise Ricer4::ExecutionException.new(auth_check_text)
        end
      end

    end
  end
end
Ricer4::Plugin.extend(Ricer4::Extend::ForcesAuthentication)
