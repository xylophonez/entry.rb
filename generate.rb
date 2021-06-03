#! /usr/bin/ruby

require 'date'
require 'redcarpet'

class Site
  def initialize
    @sorted_entries = Dir[entries_path + '/*'].sort_by { |f| File.mtime(f) }.reverse
    @entries = []
  end
  def entries_path
    "#{Dir.home}/Documents/entries"
  end
  def entries
    @entries
  end
  def sorted_entries
    @sorted_entries
  end
  def title
    "My blog" # edit blog title here
  end
  def head
    "<head><title>#{title}</title><link rel=\"stylesheet\" type=\"text/css\" href=\"stylesheet.css\" media=\"screen\"</head><body>"
  end
  def top
    "<h1>#{title}</h1><hr>"
  end
end

class Entry
  def initialize(entry, site)
    @site = site
    @renderer = Redcarpet::Render::HTML.new(no_links: false, hard_wrap: true)
    @markdown = Redcarpet::Markdown.new(@renderer, extensions = {})
    @entry = entry
    @title = get_title
    @content = get_content
  end
  def title
    @title
  end
  def content
    @content
  end
 def get_title
    @entry.gsub(@site.entries_path,"").gsub(".md","").gsub("_", " ").gsub('/',"")
  end
  def get_content
    lines = File.read(@entry)
    @markdown.render(lines)
  end
end

class Generator
  def initialize
    @site = Site.new
    @index = File.new('entry/site/index.html', 'w')
    @index.puts(@site.head)
    @index.puts(@site.top)
    read_entry_list
    generate_entry_html
    @index.puts("</body>")
  end
  def generate_entry_html
    @site.entries.each do |entry|
      @index.puts("<h2 class=\"datestamp\">test - #{entry.title}</h2>")
      @index.puts("#{entry.content}")
    end
  end
  def read_entry_list
    @site.sorted_entries.each do |entry|
      @site.entries.push(Entry.new(entry, @site))
    end
  end
end
