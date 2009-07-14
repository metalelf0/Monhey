# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_finanzeRails_session',
  :secret      => 'e2c2186d933a644b2ae1f559b7e1792ae99e07d296f809a149a2db524f6c7b02581220acaf11aaeb84271c5a4ff7731aff47f23a70f5b10bd4bcfb808e9721e2'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
