function copyleft() {
    about(Who,What,When,Why);
    print "";
    print "This program is free software; you can redistribute it and/or";
    print "modify it under the terms of the GNU Lesser General Public";
    print "License as published by the Free Software Foundation; version 2.1.";
    print "";
    print "This program is distributed in the hope that it will be useful"
    print "but WITHOUT ANY WARRANTY; without even the implied warranty of";
    print "MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU";
    print "Lesser General Public License for more details.";
    print "";
    print "You should have received a copy of the GNU Lesser General Public";
    print "License along with this program; if not write to the Free Software";
    print "Foundation Inc. 51 Franklin St Fifth Floor Boston MA  02110-1301  USA";
}
function about(who,what,when,why) {
    print what " : " why;
    print "Copyright " when " " who ;
}
#requirez(prints.awk)

