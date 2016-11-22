# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

movies = [
    {:title => 'The Terminator', :director => 'James Cameron', :rating => 'R', :release_date => '26-Oct-1984'},
    {:title => 'Titanic', :director => 'James Cameron', :rating => 'PG-13', :release_date => '19-Dec-1997'},
    {:title => 'Avatar', :director => 'James Cameron', :rating => 'PG-13', :release_date => '18-Dec-2009'},
    {:title => 'Aliens', :director => 'James Cameron', :rating => 'R', :release_date => '18-Jul-1986'},
    {:title => 'When Harry Met Sally', :director => 'Rob Reiner', :rating => 'R', :release_date => '21-Jul-1989'},
    {:title => 'The Help', :director => 'Tate Taylor', :rating => 'PG-13', :release_date => '10-Aug-2011'},
    {:title => 'Chocolat', :director => 'Lasse Hallström', :rating => 'PG-13', :release_date => '5-Jan-2001'},
    {:title => 'Amelie', :director => 'Jean-Pierre Jeunet', :rating => 'R', :release_date => '25-Apr-2001'},
    {:title => '2001: A Space Odyssey', :director => 'Stanley Kubrick', :rating => 'G', :release_date => '6-Apr-1968'},
    {:title => 'The Shining', :director => 'Stanley Kubrick', :rating => 'R', :release_date => '13-Jun-1980'},
    {:title => 'A Clockwork Orange', :director => 'Stanley Kubrick', :rating => 'R', :release_date => '2-Feb-1972'},
    {:title => 'Dr. Strangelove', :director => 'Stanley Kubrick', :rating => 'PG', :release_date => '29-Feb-1964'},
    {:title => 'The Incredibles', :director => 'Brad Bird', :rating => 'PG', :release_date => '5-Nov-2004'},
    {:title => 'Raiders of the Lost Ark', :director => 'Steven Spielberg', :rating => 'PG', :release_date => '12-Jun-1981'},
    {:title => 'Saving Private Ryan', :director => 'Steven Spielberg', :rating => 'R', :release_date => '24-Jul-1998'},
    {:title => "Schindler's List", :director => 'Steven Spielberg', :rating => 'R', :release_date => '4-Feb-1994'},
    # director set empty
    {:title => 'Aladdin', :director => '', :rating => 'G', :release_date => '25-Nov-1992'},
    # director unset
    {:title => 'Chicken Run', :rating => 'G', :release_date => '21-Jun-2000'},
]

movies.each do |movie|
  Movie.create!(movie)
end
