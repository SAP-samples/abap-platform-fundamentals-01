report zdemo_itab_group_by_sample.
types:
  begin of enum confederation,
    afc,
    caf,
    concacaf,
    conmebol,
    ofc,
    uefa,
  end of enum confederation,
  begin of ty_wm_team,
    confederation type confederation,
    country       type string,
  end of ty_wm_team,
  tt_wm_team type standard table of ty_wm_team with empty key.
data:
  lt_wm_teams type tt_wm_team.

data(out) = cl_demo_output=>new( ).

lt_wm_teams = value #( ( confederation = conmebol country = `Argentina` )
                       ( confederation = afc      country = `Australia` )
                       ( confederation = uefa     country = `Belgium` )
                       ( confederation = conmebol country = `Brazil` )
                       ( confederation = caf      country = `Cameroon` )
                       ( confederation = concacaf country = `Canada` )
                       ( confederation = concacaf country = `Costa Rica` )
                       ( confederation = uefa     country = `Croatia` )
                       ( confederation = uefa     country = `Denmark` )
                       ( confederation = conmebol country = `Ecuador` )
                       ( confederation = uefa     country = `England` )
                       ( confederation = uefa     country = `France` )
                       ( confederation = uefa     country = `Germany` )
                       ( confederation = caf      country = `Ghana` )
                       ( confederation = afc      country = `Iran` )
                       ( confederation = afc      country = `Japan` )
                       ( confederation = concacaf country = `Mexico` )
                       ( confederation = caf      country = `Morocco` )
                       ( confederation = uefa     country = `Netherlands` )
                       ( confederation = uefa     country = `Poland` )
                       ( confederation = uefa     country = `Portugal` )
                       ( confederation = afc      country = `Qatar` )
                       ( confederation = afc      country = `Saudi Arabia` )
                       ( confederation = caf      country = `Senegal` )
                       ( confederation = uefa     country = `Serbia` )
                       ( confederation = uefa     country = `Spain` )
                       ( confederation = afc      country = `South Korea` )
                       ( confederation = uefa     country = `Switzerland` )
                       ( confederation = caf      country = `Tunisia` )
                       ( confederation = concacaf country = `United States` )
                       ( confederation = conmebol country = `Uruguay` )
                       ( confederation = uefa     country = `Wales` ) ).

loop at lt_wm_teams into data(lv_team) " Loop at group
     group by ( confederation = lv_team-confederation
                size = group size
                index = group index ) ascending
                assigning field-symbol(<group>).
  out->write( <group> ).
  loop at group <group> " Loop at group members
       assigning field-symbol(<member>).
    out->write( <member> ).
  endloop.
endloop.
out->display( ).
