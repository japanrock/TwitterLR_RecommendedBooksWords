#!/usr/bin/env ruby
# coding: utf-8

require 'rubygems'
require 'oauth'
require 'json'
require 'hpricot'
require 'open-uri'
require 'yaml'
require 'parsedate'
require 'kconv'
require File.dirname(__FILE__) + '/twitter_oauth'

# Usage:
#  1. このファイルと同じディレクトリに以下5つのファイルを設置します。
#   * twitter_oauth.rb
#    * http://github.com/japanrock/TwitterTools/blob/master/twitter_oauth.rb
#   * sercret_key.yml 
#    * http://github.com/japanrock/TwitterTools/blob/master/secret_keys.yml.example
#   * recbook.yml
#    * http://github.com/japanrock/TwitterLR_RecommendedBooksWords/blob/master/recbook.yml
#  2. このファイルを実行します。
#   ruby recbook_twitter.rb

class LrRecBook
  attr_reader :selected_recbook_word
  attr_reader :select

  def initialize
    # カレントディレクトリの recbook.yml をロードします
    @recbook_words = YAML.load_file(File.dirname(__FILE__) + '/recbook.yml')
  end

  def head
    ""
  end

  def random_select
    @selected_recbook_word = @recbook_words[select]
  end

  # ポストする範囲を指定する
  def select
    @select = rand(1)
  end
end

twitter_oauth = TwitterOauth.new
lr_recbook    = LrRecBook.new

content  = lr_recbook.random_select
head     = lr_recbook.head
url      = lr_recbook.selected_culture["url"]
contents = lr_recbook.selected_culture["contents"]

twitter_oauth.post(head + contents + " - " + url)
