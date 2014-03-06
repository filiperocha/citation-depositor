# -*- coding: utf-8 -*-
require 'sinatra/base'
require 'erb'
require 'time'

require_relative 'lib/citation-depositor/labs'
require_relative 'lib/citation-depositor/auth'
require_relative 'lib/citation-depositor/licence'
require_relative 'lib/citation-depositor/depositor'
require_relative 'lib/citation-depositor/widget'
require_relative 'lib/citation-depositor/help'

require_relative 'lib/citation-depositor/dummy_auth'
require_relative 'lib/citation-depositor/labs_auth'

class App < Sinatra::Base
  register CitationDepositor::LabsBase
  register CitationDepositor::SimpleSessionAuth
  register CitationDepositor::Licence
  register CitationDepositor::Depositor
  register CitationDepositor::Widget
  register CitationDepositor::Help

  set(:alive) { true }
  set(:stats) { {} }
  set(:authorize) { |user, pass| CitationDepositor::LabsAuth.can_auth?(user, pass) }

  # An alternative is CitationDepositor::DummyAuth.can_auth? which will
  # auth by attempting to make an empty deposit to the deposit system

  get '/' do
    if has_authed?
      redirect '/deposits'
    else
      erb :index
    end
  end
 
  get '/signin' do
    erb :signin
  end

  get '/auth/account' do
    erb :account
  end
  
end

