require 'rest_client'
require 'xmlsimple'

spreadsheet_root = "https://spreadsheets.google.com/feeds/cells/#{ENV['main_spreadsheet_key']}"

SCHEDULER.every '15m', :first_in => 0 do |job|
  todo = XmlSimple.xml_in(RestClient.get("#{spreadsheet_root}/od6/public/values/R1C6"))['content']['content']
  done = XmlSimple.xml_in(RestClient.get("#{spreadsheet_root}/od6/public/values/R1C8"))['content']['content']
  send_event('orgs_todo', { todo: todo })
  send_event('orgs_done', { done: done })
end