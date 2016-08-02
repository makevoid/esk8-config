# Chapter Opal

#### chapters

### Opal

### Block Syntax
### ...

### Inesita



# ---------------

<!-- intro -->

Ruby can be used as JS

Ruby has a block Syntax


Ruby is very similar to Coffeescript as it's has ben inspired strongly by it.

### Opal

I program Ruby from 10 years, constantly, incessantely?

I always looked as code espressivity as one of the most important feature of a programming language

comunicability is key

that's why a cucumber/rspec runner-like program is preferred for developing on (the act of programming) and also the actual writing of smart contract templates


### Block Syntax

The ruby block syntax is usually expressed as:


    do
      # code
    end

but can be easily expressed very similarly to the JS one:

    -> {
      # code
    }

That's the Ruby basic form of block code, here's the complete one, where we define the full block

    -> {
      puts "hello block!"
    }

This is a block, an anonymous function, a ruby closure.

We can assign it as a variable

   fun = -> {
     puts "hello block!"
   }

and call it

   fun()
   #=> "hello block!"

So far nothing new

The beauty of ruby, a functional approach + a class system make it the definitive language, really. There's no point of using a so awefully defined language and stick to it no matter what.

Ruby is for the simple humans.

class Test
  def initialize

  end

  def something

  end
end


The ruby component (inesita/clearwater library) is defined as:


    class Component
      include Library::Component

      def render

      end
    end

This one has initialize too

    class Component
      include Library::Component

      def initialize

      end

      def render

      end
    end

This instead is an implementation of a library to make Component a Component, let's call this library `PBD`. Just the initials of this book, Practical Blockchain Development. PBD.

    module PBDComponent

    end

We'll not use the separator `::` (class/modules separator), so that the code above will become:


    class Component
      include PBDComponent

      def initialize

      end

      def render

      end
    end


Then our module will implement a method:


    module PBDComponent
      def lib_render_default

      end
    end



And we're at 1 level of module:


    module PBDComponent
      def setup

      end

      def render_default
        lib_render_default
      end
    end

And here it is the implementation, easy:

    class Component
      include PBDComponent

      def initialize
        setup
      end

      def render
        default_render
      end
    end

Looking at the second level of module mixing.

    include ReactiveLib

This is a module 2nd level


    module PBDComponent
      include ReactiveLib

      def setup
        puts "ready!"
      end

      def render_default
        lib_render_default
      end
    end

but first let's add one thing first, instance variables. `this` in ruby is called `self` and it often implicit its contents, for example in ruby there are no => arrows or -> like in Coffeescript to , only ->


include ReactiveLib


Ruby compiles in JS

# Enter Opal


The reactive lib and the component library we produced can be mounted on an HTML page

  module ReactiveLib
    def render_default
       <<-`
      <<-"<div>

      "
    end
  end

That's it:

  module PBDComponent
    include ReactiveLib

    def setup
      puts "ready!"
    end

    def render
      render_default
    end
  end


#### Opal:

##### Backticks:

Ruby by default executes bash

    puts `ls`


in Ruby

  will print a list of the files present in your home dir

in opal the backticks



Bash Heredoc in Ruby


JS Heredoc in Ruby-Opal


    HELLO = "hello world"

    puts <<-`HEREDOC`
    cat #{HELLO}
    HEREDOC



note that this time i expressed

in JS (ES6):

    const HELLO = "hello world"

in Coffeescript

    HELLO = "hello world" # note, this is not a constant because of JS

in Ruby (Opal)

    HELLO = "hello world"

is actually a constant, even if its default behaviour is to ...

    # ruby
    puts <<-`HEREDOC`
    cat #{__FILE__}
    HEREDOC


This will change in version 3, where all the variables will be constants (immutable) by default, TODO check ruby core status


    # opal
    puts <<-`HEREDOC`
    console.log #{HELLO}
    HEREDOC


Here's the JS version, before we saw a ruby one, in the Ruby one, the code will be printed in a bash shell and executed, shelling out is the best way to make working software quickly sometimes, it's hard to admit but the bash interface is very "functional".

Simplicity is king.
Pipes and Files==Streams are a great concepts.

Ptpe and


#### Streams

This is how stram work:

    cat a.txt > b.txt

or simply:

    cat a > b

They redirect the input


#### Pipes

Pipes


Ruby it's a great addition to the shell, let's use it.

    ruby -e '(1..100).to_a{ |n| `echo "#{n}" >> foo.txt` }'

We used ruby to generate an array of 100 entries, the first starting as the number 1 and the last the number 100.

We shell out  the current bash commands:

    echo "1" >> foo.txt
    echo "2" >> foo.txt
    echo "3 #...foo.txt
    # ...

`>>` is like `>` but it appends to the file instead of overwiting the file.

And here's the bash command using Pipes

   cat foo.txt | grep 1

Will leave us with with a `foo.txt` file containing:

   1
   10
   11
   12
   13
   14
   ...

Grep-ping (that's the linux term), which means getting or filtering the file opened by the `cat` command, printed to the stdout, the output of our shell program, that reaching the end of the line gets printed on the screen.

Streams and pipes used to put together many commands, if it has a bash interface, and it's easily installable, your program is probably going to stay :D . Having a CLI interface helps keeping your library easily runnable.




#### Inesita

Let's make an Inesita-based app:
