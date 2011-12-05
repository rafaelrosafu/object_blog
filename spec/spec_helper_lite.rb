# -*- encoding : utf-8 -*-
require 'minitest/autorun'
require 'rr'
require 'ostruct'

class MiniTest::Unit::TestCase
  include RR::Adapters::MiniTest
end

def stub_constant(full_name, type)
  full_name.to_s.split(/::/).inject(Object) do |context, name|
    begin
      context.const_get(name)
    rescue NameError
      context.const_set(name, type.new)
    end
  end
end

def stub_class(full_name)
  stub_constant(full_name, Class)
end

def stub_module(full_name)
  stub_constant(full_name, Module)
end
