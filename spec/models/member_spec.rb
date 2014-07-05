require 'spec_helper'

describe Member do
  it {should belong_to :project}
end