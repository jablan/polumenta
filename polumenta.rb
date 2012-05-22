# encoding: utf-8
require 'sinatra'
require 'haml'

configure do
  set :s, {
    l: {
      a: %w{B V G D Đ Ž Z J K L Lj P S T Ć F H Č Dž Š Flj Klj Plj Gr Vr Vl Pl Fl Tr},
      b: %w{a e i o u},
      c: %w{b v g d đ ž z j k l lj p s t ć f h č dž š},
      d: %w{o},
      e: %w{b v g d đ ž z j k l lj p s t ć f h č dž š flj klj plj gr vr vl pl fl tr},
      t: ['Polumenta Generator'],
      p: ['Polumenta'],
    },
    c: {
      a: %w{Б В Г Д Ђ Ж З Ј К Л Љ П С Т Ћ Ф Х Ч Џ Ш Фљ Кљ Пљ Гр Вр Вл Пл Фл Тр},
      b: %w{а е и о у},
      c: %w{б в г д ђ ж з ј к л љ п с т ћ ф х ч џ ш},
      d: %w{о},
      e: %w{б в г д ђ ж з ј к л љ п с т ћ ф х ч џ ш фљ кљ пљ гр вр вл пл фл тр},
      t: ['Полумента Генератор'],
      p: ['Полумента'],
    }
  }
end

before do
  @s = Hash[settings.s.map{|a, m| [a, Hash[m.map{|b, l| [b, l.sample]}]]}]
end

[
  ['/',      :c, [:a, :b, :c, :d]],
  ['/olo',   :c, [:a, :b, :c, :d, :c, :b, :c, :d]],
  ['/ololo', :c, [:a, :b, :c, :d, :e, :b, :c, :d]],
  ['/l',      :l, [:a, :b, :c, :d]],
  ['/lolo',   :l, [:a, :b, :c, :d, :c, :b, :c, :d]],
  ['/lololo', :l, [:a, :b, :c, :d, :e, :b, :c, :d]],
].each do |route, alphabet, order|
  get route do
    @dado = order.map{|r| @s[alphabet][r]}.join
    @title = @s[alphabet][:t]
    p = @s[alphabet][:p]
    haml "#{@dado} #{p}"
  end
end

get // do
  redirect to('/')
end
