#require 'spec_helper'
#
#describe ApplicationHelper do
#  it 'returns correct sort' do
#    helper.stub(:sortable).and_return(true)
#    expect(helper).to receive(:link_to).once.with('username', {sort: 'username', direction: 'asc'}).and_return(:content)
#    expect(helper.sortable('username', 'username')).to eq(:content)
#  end
#  #title ||= column.titleize
#  #direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
#  #link_to title, {:sort => column, :direction => direction}
#end
