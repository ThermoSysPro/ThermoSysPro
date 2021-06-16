within ThermoSysPro.Properties.FlueGases;
function XSat
//---------------------------------------------------------------------------
// Fonction  de l'humidité absolue a saturation xs(T)
// Tair en °K, attention formule avec T en °C
//---------------------------------------------------------------------------
  input Modelica.SIunits.Temperature Tair "Air temperature";
  input Modelica.SIunits.AbsolutePressure Patm "Atmospheric pressure";

public
  output Real xs "Humidity at the saturation point";

protected
  Real Ps;
  Real Ps0;
  Real TT;
  ThermoSysPro.Units.Temperature_degC T "Air temperature in Celsius";
algorithm
  T := Tair - 273.16;

  if (T < -20) then
    xs :=0;
  end if;

  if ((T >= -20) and (T <= 0)) then
    Ps := Modelica.Math.exp(6.4147+(22.376*T)/(271.68+T));
    xs := 0.622*Ps / (Patm-Ps);
  end if;

  if ((T > 0) and (T <= 40)) then
   Ps := Modelica.Math.exp(6.4147+(17.438*T)/(239.78+T));
   xs := 0.622*Ps / (Patm-Ps);
  end if;

  if ((40 < T) and (T < 90)) then
   TT := T/273.16;
   Ps0 := 0.78614
            + 10.7954*TT/(1+TT)
            - 5.028*Modelica.Math.log10(1+TT)
            + 1.50475e-5*(1.-1./(10^(8.2969*TT))
            +  0.00042873*(10^(4.76955*TT/(1.+TT)))-1.);
   Ps :=(10^Ps0)*100.;
   xs := 0.622*Ps / (Patm-Ps);
  end if;

  if (T >= 90) then
   xs := 0.5 + 0.001*T;
  end if;

  annotation (
    smoothOrder=2,
    Icon(graphics={
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
<p>Problem: discontinuous function. Should be replaced by a continuous one. </p>
<p><b>Copyright &copy; EDF 2002 - 2010</b></p>
</HTML>
<html>
<p><b>ThermoSysPro Version 2.0</b></p>
</HTML>
"));
end XSat;
