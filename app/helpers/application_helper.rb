module ApplicationHelper
  def bootstrap_form_for(object, options = {}, &block)
    options[:builder] = BootstrapFormBuilder
    form_for(object, options, &block)
  end
  
  def euro(price)
  	raw ( "%.2f &euro;" % price )
  end

  def format_diff_as_table(diff)
  	columns = "".html_safe
  	diff.each do |key,value|
  		changes = value.map { |change| content_tag(:td, change) }.join
  		columns += "<tr><td>".html_safe
  		columns << key
  		columns << "</td>#{changes}</tr>".html_safe
  	end

  	"<table>
  		<thead>
  			<tr><th>Field</th><th>Before</th><th>After</th></tr>
  		</thead>
  		<tbody>
  			#{columns}
  		</tbody>
  	</table>".html_safe
  end

end
