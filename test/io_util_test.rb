# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/io_util'

describe 'io util' do
  it 'can print prompt' do
    assert IoUtil.prompt
  end

  it 'can print welcome' do
    assert IoUtil.print_welcome
  end

  it 'can print help' do
    assert IoUtil.print_help
  end

  it 'can find quit command' do
    assert IoUtil.contains_quit_command('\q')
    assert IoUtil.contains_quit_command('/q')
    assert IoUtil.contains_quit_command('quit')
    assert IoUtil.contains_quit_command('/quit')
    assert IoUtil.contains_quit_command('\quit')
    assert IoUtil.contains_quit_command('exit')
    assert IoUtil.contains_quit_command('/exit')
    assert IoUtil.contains_quit_command('\exit')
  end

  it 'can get user prompt' do
    assert_equal 'command', IoUtil.get_user_prompt('/test command', 'test')
    assert_equal 'command', IoUtil.get_user_prompt('/test    command', 'test')
  end

  it 'can see if match command' do
    assert IoUtil.matches_command?('/test command', %w[test t])
    assert IoUtil.matches_command?('/t command', %w[test t])
    refute IoUtil.matches_command?('/notmatch command', %w[test t])
    refute IoUtil.matches_command?('/p command', %w[test t])
  end

  it 'can read input' do
    IoUtil.read_input
  end
end
