#!/bin/env ruby
# encoding: utf-8

namespace :denuncias do

  desc 'Cria denúncias diversas no sistema'
  task :trocar_imagens => :environment do
    i = 1;
    Denuncia.all.each do |d|
      d.foto = File.new("foto_denuncia_production_#{i}.jpg", "r")
      d.save
      i = i + 1;
    end
  end

end