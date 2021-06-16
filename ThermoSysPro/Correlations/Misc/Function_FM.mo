within ThermoSysPro.Correlations.Misc;
function Function_FM
  "Calculation of the correction factor for material and gauge"
  input Modelica.SIunits.Thickness e_tubes "Weight average thickness of tubes";
  input Integer Tube_Material "Material of the tubes. 1:Cu Fe 194 - 2:Arsenical Cu - 3:Admiralty - 4:Al Brass - 5:Al Bronze - 6:Carbon Steel 
    - 7:Cu Ni 90-10 - 8:Cu Ni 70-30 - 9:SS (UNS S43035) - 10:Titanium Grades 1 & 2 - 11:SS (UNS S44660) 
    - 12:SS (UNS S44735) - 13:SS TP 304 - 14:SS TP 316/317 - 15:SS (UNS N08367)";

public
  output Real FM "Correction factor for material and gauge";

algorithm
  if Tube_Material==1 then
    FM :=2.315302E-03*(e_tubes*1000)^4 - 1.463925E-02*(e_tubes*1000)^3 + 3.110868E-02*(e_tubes*1000)
      ^2 - 4.539741E-02*(e_tubes*1000) + 1.058871E+00;
  else
      if Tube_Material == 2 then
        FM :=1.157434E-03*(e_tubes*1000)^4 - 7.121250E-03*(e_tubes*1000)^3 + 1.364947E-02*
        (e_tubes*1000)^2 - 3.449694E-02*(e_tubes*1000) + 1.052996E+00;
      else
        if Tube_Material == 3 then
          FM :=-5.199660E-05*(e_tubes*1000)^3 - 3.573278E-04*(e_tubes*1000)^2 - 4.132974E-02*
         (e_tubes*1000) + 1.050264E+00;
        else
          if Tube_Material == 4 then
            FM :=6.698826E-04*(e_tubes*1000)^3 - 3.663560E-03*(e_tubes*1000)^2 - 4.115372E-02
            *(e_tubes*1000) + 1.048801E+00;
          else
            if Tube_Material == 5 then
              FM :=-4.847211E-04*(e_tubes*1000)^3 + 2.243464E-03*(e_tubes*1000)^2 -
              5.989998E-02*(e_tubes*1000) + 1.050915E+00;
            else
              if Tube_Material == 6 then
                FM :=-6.633831E-04*(e_tubes*1000)^3 + 6.392384E-03*(e_tubes*1000)^2 -
                9.975868E-02*(e_tubes*1000) + 1.051240E+00;
              else
                if Tube_Material == 7 then
                  FM :=-2.216250E-04*(e_tubes*1000)^3 + 5.447765E-03*(e_tubes*1000)^2 -
                  1.041923E-01*(e_tubes*1000) + 1.051423E+00;
                else
                  if Tube_Material == 8 then
                    FM :=-9.966165E-04*(e_tubes*1000)^3 + 1.501534E-02*(e_tubes*1000)^2 -
                    1.568190E-01*(e_tubes*1000) + 1.050232E+00;
                  else
                    if Tube_Material == 9 then
                      FM :=-2.019135E-03*(e_tubes*1000)^3 + 2.416873E-02*(e_tubes*1000)^2 -
                      1.909330E-01*(e_tubes*1000) + 1.050183E+00;
                    else
                      if Tube_Material == 10 then
                        FM :=-2.205027E-03*(e_tubes*1000)^3 + 2.776231E-02*(e_tubes*1000)^2
                         - 2.079415E-01*(e_tubes*1000) + 1.049684E+00;
                      else
                        if Tube_Material == 11 then
                          FM :=-3.337646E-03*(e_tubes*1000)^3 + 3.826354E-02*(e_tubes*1000)^2
                           - 2.451577E-01*(e_tubes*1000) + 1.047242E+00;
                        else
                          if Tube_Material == 12 then
                            FM :=-3.111927E-03*(e_tubes*1000)^3 + 3.866531E-02*(e_tubes*1000)^2
                            - 2.511187E-01*(e_tubes*1000) + 1.045886E+00;
                          else
                            if Tube_Material == 13 then
                              FM :=-5.461198E-03*(e_tubes*1000)^3 + 5.599292E-02*
                              (e_tubes*1000)^2 - 2.964332E-01*(e_tubes*1000) + 1.046373E+00;
                            else
                              if Tube_Material == 14 then
                                FM :=-5.744495E-03*(e_tubes*1000)^3 + 5.902780E-02*
                                (e_tubes*1000)^2 - 3.063905E-01*(e_tubes*1000) + 1.044663E+00;
                              else
                                if Tube_Material == 15 then
                                  FM :=-8.268350E-03*(e_tubes*1000)^3 + 7.823031E-02*
                                  (e_tubes*1000)^2 - 3.567748E-01*(e_tubes*1000) +
                                  1.040474E+00;
                                else
                                 FM :=0;
                                end if;
                              end if;
                            end if;
                          end if;
                        end if;
                      end if;
                    end if;
                  end if;
                end if;
              end if;
            end if;
          end if;
        end if;
      end if;
    end if;

  annotation (Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2019</b> </p>
<p><b>ThermoSysPro Version 3.2</h4>
</html>"));
end Function_FM;
