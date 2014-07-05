require 'spec_helper'

describe Project do
  it{should belong_to(:user)}
  it{should have_many(:members)}
  it{should have_many(:stories)}

  context 'project with valid' do
    let!(:project) { build(Project, title: 'nowy')}
    it 'title' do
      expect(project.title).to eq 'nowy'
      expect(project.valid?).to eq true
    end

  end

  context 'project when' do
    let!(:project) { build(Project, title: '')}
    let!(:project2) { build(Project, title: 'aa')}
    let!(:project3) { build(Project, title: '12345678910111213')}
    it 'title is blank' do
      expect(project.valid?).to eq false
    end
    it 'title is to short' do
      expect(project2.valid?).to eq false
    end
    it 'title is to long' do
      expect(project3.valid?).to eq false
    end

  end

end