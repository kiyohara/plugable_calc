require 'spec_helper'

describe PlugableCalc do
  it 'has a version number' do
    expect(PlugableCalc::VERSION).not_to be nil
  end

  it 'calc String' do
    expect(PlugableCalc.calc('abc def')).to eq 'abc def'
  end
end
