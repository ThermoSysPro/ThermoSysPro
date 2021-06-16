within ThermoSysPro.Correlations.Thermal;
function Function_U1 "Calculation of the uncorrected heat transfer coefficient"
  input Modelica.SIunits.Diameter D_tubes "Weight average thickness of tubes";
  input Modelica.SIunits.Velocity Vf "Velocity of cold water";

protected
  Real U11;
  Real U12;
  Real U13;
  Real U14;
  Real U15;
  Real U16;

public
  output Real U1 "Uncorrected heat transfer coefficient";

algorithm
  U11 :=1.348357E+01*Vf^3 - 2.483302E+02*Vf^2 + 1.791513E+03*Vf + 1.184589E+03;
  U12 :=1.339090E+01*Vf^3 - 2.476065E+02*Vf^2 + 1.774936E+03*Vf + 1.157884E+03;
  U13 :=1.193064E+01*Vf^3 - 2.382921E+02*Vf^2 + 1.738812E+03*Vf + 1.146127E+03;
  U14 :=1.119801E+01*Vf^3 - 2.319792E+02*Vf^2 + 1.707795E+03*Vf + 1.130690E+03;
  U15 :=1.249170E+01*Vf^3 - 2.405850E+02*Vf^2 + 1.707789E+03*Vf + 1.096353E+03;
  U16 :=1.139964E+01*Vf^3 - 2.309074E+02*Vf^2 + 1.669797E+03*Vf + 1.084915E+03;

   if (D_tubes >= 0.01588) and (D_tubes <= 0.01905) then
    U1 :=1.348357E+01*Vf^3 - 2.483302E+02*Vf^2 + 1.791513E+03*Vf + 1.184589E+03;
   else
    if (D_tubes > 0.01905) and (D_tubes < 0.0223) then
      U1 := U11 - (U11 - U12)/(0.0223 - 0.01905)*(D_tubes - 0.01905);
    else
      if (D_tubes >= 0.0223) and (D_tubes <= 0.0254) then
        U1 :=1.339090E+01*Vf^3 - 2.476065E+02*Vf^2 + 1.774936E+03*Vf +
          1.157884E+03;
      else
        if (D_tubes > 0.0254) and (D_tubes <0.02858) then
          U1 :=U12 - (U12 - U13)/(0.02858 - 0.0254)*(D_tubes - 0.0254);
        else
          if (D_tubes >= 0.02858) and (D_tubes <= 0.03175) then
            U1 :=1.193064E+01*Vf^3 - 2.382921E+02*Vf^2 + 1.738812E+03*Vf +
              1.146127E+03;
          else
            if (D_tubes > 0.03175) and (D_tubes <0.03493) then
              U1 :=U13 - (U13 - U14)/(0.03493 - 0.03175)*(D_tubes - 0.03175);
            else
              if (D_tubes >= 0.03493) and (D_tubes <= 0.0381) then
                U1 :=1.119801E+01*Vf^3 - 2.319792E+02*Vf^2 + 1.707795E+03*Vf +
                  1.130690E+03;
              else
                if (D_tubes > 0.0381) and (D_tubes <0.04128) then
                  U1 :=U14 - (U14 - U15)/(0.04128 - 0.0381)*(D_tubes - 0.0381);
                else
                  if (D_tubes >= 0.04128) and (D_tubes <= 0.04445) then
                    U1 :=1.249170E+01*Vf^3 - 2.405850E+02*Vf^2 + 1.707789E+03*
                      Vf + 1.096353E+03;
                  else
                    if (D_tubes > 0.04445) and (D_tubes <0.04763) then
                      U1 :=U15 - (U15 - U16)/(0.04763 - 0.04445)*(D_tubes -
                        0.04445);
                    else
                      if (D_tubes >= 0.04763) and (D_tubes <= 0.0508) then
                         U1 :=1.139964E+01*Vf^3 - 2.309074E+02*Vf^2 +
                          1.669797E+03*Vf + 1.084915E+03;
                      else
                              U1 :=0;
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
end Function_U1;
