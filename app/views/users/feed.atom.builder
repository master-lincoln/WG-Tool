atom_feed :language => 'de-DE' do |feed|
  feed.title @title
  feed.updated @updated

  @invoices.each do |item|
    next if item.updated_at.blank?

    feed.entry( item ) do |entry|
      entry.url invoices_url(item, :host => 'wg-tool.herokuapp.com')
      entry.title item.creator.name
      entry.content simple_format(item.comment), :type => 'html'

      # the strftime is needed to work with Google Reader.
      entry.updated(item.updated_at.strftime("%Y-%m-%dT%H:%M:%SZ")) 

      entry.author do |author|
        author.name item.creator.name
      end
    end
  end
end
