class ApplicationController < ActionController::Base
  require 'net/http'
  require 'uri'
  require 'json'

  protect_from_forgery with: :exception
  before_action :global_variables

  private

  def send_request(action, hash, method)
    hash = isempty(hash)
    uri = uri_action(action)
    req = req(method, uri)

    http = Net::HTTP.new(uri.host, uri.port)
    req.body = hash.to_json
    http.use_ssl = true
    res = http.request(req).body
    res = JSON[res] if res.present?
    res
  end

  def send_authenticated_request(action, hash, method)
    hash = isempty(hash)
    uri = uri_action(action)
    req = req(method, uri)

    http = Net::HTTP.new(uri.host, uri.port)
    req.body = hash.to_json
    http.use_ssl = true
    res = http.request(req).body
    res = JSON[res] if res.present?
    res
  end

  def isempty(hash)
    hash.nil? ? {} : hash
  end

  def uri_action(action)
    URI.parse("https://dev2.bliimo.net/#{action}")
  end

  MD_GENERATOR = %w[Post Put Get Delete Patch].freeze

  def req(method, uri)
    path = uri.path
    request_uri = uri.request_uri

    case method
    when 'post' then Net::HTTP::Post.new(path, request_header)
    when 'put' then Net::HTTP::Put.new(path, request_header)
    when 'get' then Net::HTTP::Get.new(request_uri, request_header)
    when 'delete' then Net::HTTP::Delete.new(path, request_header)
    when 'patch' then Net::HTTP::Patch.new(path, request_header)
    end
  end

  def request_header
    if current_user
      { 'Content-Type' => 'application/json', 'Authorization' => "#{current_user.token_type} #{current_user.access_token}" }
    else
      { 'Content-Type' => 'application/json' }
    end
  end
end
