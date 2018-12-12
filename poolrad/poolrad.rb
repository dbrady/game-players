#!/usr/bin/env ruby
# poolrad.rb - lib for common Pool of Radiance stuff
# run as a script to check that the game_cfg.yml is et up right
require 'yaml'
require 'fileutils'

class Poolrad
  def initialize
  end

  def here
    File.dirname(__FILE__)
  end
  def tool_path; here; end

  def config
    YAML::load_file(File.join(here, "game_cfg.yml"))
  end

  def game_path
    config["game_data_path"]
  end

  # Given a save id, like "B1" or "C6", return the filename
  # of that save
  def save_filename(id, ext="SAV")
    "CHRDAT#{id}.#{ext}"
  end

  def save_filepath(id, ext="SAV")
    File.join game_path, save_filename(id, ext)
  end

  def backup_save_filename(id, ext="SAV")
    src = File.join(game_path, save_filename(id, ext))
    dst = File.join(game_path, save_filename(id, ext + ".BAK"))
    File.cp src, dst
  end

  def backup_save_filepath(id, ext="SAV")
    File.join game_path, backup_save_filename(id, ext)
  end


  def assert_game_configuration!
    if !File.directory?(game_path)
      barf_to_death! <<OHNOES
Could not find Pool of Radiance.
1. Is your game_cfg.yml configured?
2. Is Pool of Radiance actually installed where game_cfg.yml's "game_data_path"
   says it is?
OHNOES
    end
  end

  def assert_save_game_exists!(id, ext="SAV")
    filepath = save_filepath(id, ext)
    if !File.exists?(filepath)
      barf_to_death! <<LOLBARF
Could not find Pool of Radiance savegame data file at '#{filepath}',
check your install directory or game_cfg.yml"
LOLBARF
    end
  end

  def barf_to_death!(msg, code=1)
    puts msg
    exit code
  end
end

if __FILE__==$0
  poolrad = Poolrad.new
  puts "Pool of Radiance is configured at #{poolrad.game_path}"
  puts "Checking for Pool of Radiance folder..."
  poolrad.assert_game_configuration!
  puts "Everything checks out!"
end
