# Hyperwallet::Ruby

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/hyperwallet/ruby`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hyperwallet-ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hyperwallet-ruby

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/hyperwallet-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Hyperwallet::Ruby project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/hyperwallet-ruby/blob/master/CODE_OF_CONDUCT.md).

### Payee

  # index
  payee_connector = Hyperwallet::Resources::Payee
  payees          = payee_connector.index


#### create

  payload2 = {:client_user_id            => 'test5userid5',
             :profile_type              => 'INDIVIDUAL' ,
             :first_name                => 'Han',
             :last_name                 => 'Solo' ,
             :date_of_birth             => '1980-11-12',
             :email                     => 'jgtr7@hey.com',
             :address_line1            => '675 Dolores St',
             :city                      => 'Berkeley' ,
             :state_province            => 'CA' ,
             :country                   => 'US',
             :postal_code               => '94704',
             :program_token             => 'prg-1bd466b5-2a58-4e3a-8942-6a93591a9a86' }

  new_payee2            = Hyperwallet::Resources::Payee.create(payload2)


#### show
  user_token = "usr-6ac6618e-44fe-4252-af8c-76cd4e68f601"
  payee = Hyperwallet::Resources::Payee.new
  payee.show(token: user_token)

#### Getting a new auth token
  user_token = "usr-6ac6618e-44fe-4252-af8c-76cd4e68f601"
  existing_payee = Hyperwallet::Resources::Payee.new(token: user_token)
  token = existing_payee.get_authentication_token

#### Getting the list of bank accounts for a user
  user_token     = "usr-6ac6618e-44fe-4252-af8c-76cd4e68f601"
  existing_payee = Hyperwallet::Resources::Payee.new(token: user_token)
  bank_accounts  = existing_payee.index_bank_accounts

### Transfer Methods
#### Getting transfer methods
##### On TransferMethod
  user_token       = "usr-6ac6618e-44fe-4252-af8c-76cd4e68f601"
  transfer_methods = Hyperwallet::Resources::TransferMethod.index(user_token: user_token)

##### On BankAccount
  user_token       = "usr-6ac6618e-44fe-4252-af8c-76cd4e68f601"
  bank_accounts    = Hyperwallet::Resources::BankAccount.index(user_token: user_token)

#### Show BankAccount method
  user_token     = "usr-6ac6618e-44fe-4252-af8c-76cd4e68f601" 
  transfer_token = "trm-e998ba11-ca03-4a27-8bd9-dc95120d8e57"
  bank_account = Hyperwallet::Resources::BankAccount.new
  bank_account.show(user_token: user_token, transfer_token: transfer_token)

#### Show TransferMethod method
  user_token     = "usr-6ac6618e-44fe-4252-af8c-76cd4e68f601" 
  transfer_token = "trm-e998ba11-ca03-4a27-8bd9-dc95120d8e57"
  transfer_method = Hyperwallet::Resources::TransferMethod.new
  transfer_method.show(user_token: user_token, transfer_token: transfer_token)

#### Creating a bank account
  user_token     = "usr-6ac6618e-44fe-4252-af8c-76cd4e68f601"

  payload3 = {
    token:                      user_token,
    profile_type:               "INDIVIDUAL",
    transfer_method_country:    "US",
    transfer_method_currency:   "USD",
    type:                       "BANK_ACCOUNT",
    branch_id:                  101089292,
    bank_account_id:            7861012347,
    bank_account_purpose:       "CHECKING",
    bank_account_relationship:  "SELF"
  }

  existing_payee = Hyperwallet::Resources::Payee.new(payload)
  new_account   = existing_payee.create_bank_account




### Payment
#### Create
  bank_account_token = "trm-b7b7e1f9-9a02-4cdf-a281-6beeb958c41a"
  bank_account_token = 'trm-e998ba11-ca03-4a27-8bd9-dc95120d8e57'

  payload = {
    amount: "20.00",
    currency: "USD",
    client_payment_id: "123456789",
    destination_token: bank_account_token,
    program_token: "prg-1bd466b5-2a58-4e3a-8942-6a93591a9a86",
    purpose:        "PP0001"
  }

  new_payment       = Hyperwallet::Resources::Payment.create(payload)


#### Get payment
  token = "pmt-cb7ba194-1e2c-4227-ae43-006fafba062d"
  payment = Hyperwallet::Resources::Payment.new
  retrieved_payment = payment.show(token: token)

#### List payments
payments = Hyperwallet::Resources::Payment.index


### Webhook Notification
  webhook_token = "wbh-e4b41307-536b-45d1-bf0d-55fe2d011aa8"
  webhook = Hyperwallet::Resources::WebhookNotification.new
  webhook.show(token: webhook_token)

### Receipts
  user_token     = "usr-6ac6618e-44fe-4252-af8c-76cd4e68f601"
  receipt        = Hyperwallet::Resources::Receipt.new
  receipt.show(token: user_token)
