#encoding: UTF-8

# -----------------------------------------------------------------------------
# Motivation   : To extend the parameter expansion in bash shell.
# File name    : runCommandWithParameters.rb
# Author       : George Cong Liu
# Updated      : Mon Jun 04 13:00 CST 2018
# Usage        : $ ruby runCommandWithParameters.rb $COMMAND $PARAMETERS
# Example      : $ ruby ./runCommandWithParameters.rb "pod repo remove" \
#                ./PATH_TO_REPOS/{repo_a,repo_b,repo_c,repo_d,repo_e,repo_f}
# -----------------------------------------------------------------------------

# The main() 
def mainProcedure()
  puts "Starts working..."
  
  # NOTE
  # ARGV[0] is $COMMAND
  # ARGV[1] ... ARGV[ARGV.count - 1] are parameters of $COMMAND.
  # ARGV.count is the number of parameters of $COMMAND.
  command = ARGV[0].dup
  
  # Add a trailing space to $COMMAND.
  command.gsub!(/$/, " ") 
 
  ARGV.delete_at(0)

  ARGV.each do | param |
    system "#{command}#{param}"
  end
end

# Main procedure 
mainProcedure()
