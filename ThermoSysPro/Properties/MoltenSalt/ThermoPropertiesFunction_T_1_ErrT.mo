within ThermoSysPro.Properties.MoltenSalt;
function ThermoPropertiesFunction_T_1_ErrT "ThermoPropertiesFunction"
  input Modelica.SIunits.Temperature T
    "dimensionless derivatives of the Gibbs function";
  output ThermoSysPro.Properties.MoltenSalt.ThermoProperties_T pro;
//protected
  //Real vt;
  //Real vp;

algorithm
  //if (T-273)>538 then
  if (T-273)>838 then
    assert(false, "Molten salt_T: Temperature is too high (" + String(T-273) + ")");
  elseif (T-273)<149 then
    assert(false, "Molten salt_T: Temperature is too low (" + String(T-273) + ")");
  else
    pro.d := 1938.0-(0.732*(T-273-200));
    pro.cp := 1561.7;
    pro.k := 0.421-6.53e-4*(T-273-260);
    pro.mu := Modelica.Math.exp(-4.343-2.0143*(Modelica.Math.log(T-273)-5.011));
    //pro.mu :=(2.5-((T-273)-300)/(450-300))*0.001;
    pro.ddpT := 1e-6;
    pro.ddTp := -0.732;
  end if;
  LogVariable(T);
  annotation (smoothOrder=2,Icon(graphics={
        Text(extent={{-136,102},{140,42}}, textString=
                                               "%name"),
        Ellipse(
          extent={{-100,40},{100,-100}},
          lineColor={255,127,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-84,-4},{84,-52}},
          lineColor={255,127,0},
          textString=
               "function")}),
                           Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2010</b></p>
</HTML>
<html>
<p><b>ThermoSysPro Version 2.0</b></p>
</HTML>
"));
end ThermoPropertiesFunction_T_1_ErrT;
