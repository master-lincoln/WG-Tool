def get_content(item)
  euro(item.price) +'<br>'+ simple_format(item.comment)
end

atom_feed :language => 'de-DE' do |feed|
  feed.title @title
  feed.updated @updated

  @invoices.each do |item|
    next if item.updated_at.blank?

    feed.entry( item ) do |entry|
      entry.title item.creator.name
      entry.content get_content(item), :type => 'html'
      entry.author do |author|
        author.name item.creator.name
      end
    end
  end
end
