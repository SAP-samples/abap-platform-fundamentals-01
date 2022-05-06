"! <p class="shorttext synchronized" lang="en">Demonstrates set operation EXCEPT</p>
"!
"! Here we demonstrate the EXCEPT operation, which subtracts one query result set from
"! the other.
"!
"! Please execute the class in the eclipse editor aka. ADT with shortcut F9.
"! The result will be displayed in the console
class ybw_except definition
  public
  final
  create public .

  public section.
    interfaces if_oo_adt_classrun.
  protected section.
  private section.
endclass.



class ybw_except implementation.
  method if_oo_adt_classrun~main.
    " The first select queries all parties and persons from the vote table.
    " The second select will select all parties from the party view.
    " Now the EXCEPT operation subtracts all parties from the first query
    " effectively preserving the persons who has been voted for.
    select from ybw_vote
           fields party as keine_partei
           where vote = '1' and
                 votes > 0
    except
    select from ybw_votes_party
           fields party as keine_partei
    into table @data(persons_with_votes).
    out->write( 'persons_with_votes:' ).
    out->write( persons_with_votes ).

    " set operators are evaluated from left to right
    " there first the votes of the parties get subtracted
    " and afterwards votes of persons get subtracted from resulting
    " set of the former operation. Only the persisted totals
    " remain.
    " HINT: You can use brackets to change the precedence.
    select from ybw_vote
           fields party as rest
           where vote = '1' and
                 votes > 0
    except
    select from ybw_votes_party
           fields party as rest
    except
    select from ybw_votes_person
           fields party as rest
    into table @data(only_totals_remaining).
    out->write( '---------------------------------------------------------' ).
    out->write( 'only_totals_remaining:' ).
    out->write( only_totals_remaining ).
  endmethod.

endclass.
