Spree::User.class_eval do
  scope :dibs_referrers, lambda { includes(:spree_roles).where("#{::Spree::Role.table_name}.name" => "dibs_referral") }
  has_many :dibs_referrals, -> { uniq }, class_name: '::Spree::Order', foreign_key: 'dibs_referral_id'
end
