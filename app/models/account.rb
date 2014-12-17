class Account < ActiveRecord::Base
	validates_presence_of :subdomain
    validates_format_of :subdomain, :with => /[A-Za-z0-9-]+/ , :message => 'The subdomain can only contain alphanumeric characters and dashes.', :allow_blank => true
    validates_uniqueness_of :subdomain, :case_sensitive => false
	validates_exclusion_of :subdomain, :in => %w( support blog billing help api ), :message => "The subdomain <strong>{{value}}</strong> is reserved and unavailable."
    before_validation :downcase_subdomain
	
	has_many :stores
	has_many :users
	accepts_nested_attributes_for :stores, allow_destroy: true
    protected
      def downcase_subdomain
        self.subdomain.downcase! if attribute_present?("subdomain")
      end
	
end
