# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_railsapp_session',
  :secret      => '6d70a9e57e167a4699d60a921751576300e78c50f23bbc3276f511090577c2757cf9bf2d93218b2163c84e9275f7d8be7577f8e58290c5904d4ad74118c4542b'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
