#!/bin/env ruby
# encoding: utf-8

class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    root_path
  end

  def after_sign_in_path_for(resource)
    root_path
  end

  def after_sign_out_path_for(resource)
    root_pathß
  end

end