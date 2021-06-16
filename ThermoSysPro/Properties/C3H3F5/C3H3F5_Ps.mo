within ThermoSysPro.Properties.C3H3F5;
function C3H3F5_Ps "11133-C3H3F5 physical properties as a function of P and s"
  input Modelica.SIunits.AbsolutePressure P "Pressure";
  input Modelica.SIunits.SpecificEntropy s "Specific entropy";

protected
  Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
  Modelica.SIunits.AbsolutePressure Psc "Critical pressure";
  Modelica.SIunits.AbsolutePressure Pcalc
    "Variable for the computation of the pressure";
  Modelica.SIunits.SpecificEntropy scalc
    "Variable for the computation of the specific entropy";
  Modelica.SIunits.SpecificEnthalpy hsatL "Boiling specific enthalpy";
  Modelica.SIunits.SpecificEnthalpy hsatV "Condensation specific enthalpy";
  Modelica.SIunits.SpecificEntropy ssatL "Boiling specific entropy";
  Modelica.SIunits.SpecificEntropy ssatV "Condensation specific entropy";
  Real x "Vapor mass fraction";
  Real A;
  Real B;
  Real C;

public
  output ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ps props
    annotation (Placement(transformation(extent={{-100,80},{-80,100}}, rotation=
           0)));

protected
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph pro
                     annotation (Placement(transformation(extent={{-60,80},{-40,
            100}}, rotation=0)));
algorithm

  /* Critical pressure */
  Psc := 3640000;

  /* Tests : the function is only valid for P > 0, P < Pcritique, h > 0.6 kJ/kg and h < 2.52 kJ/kg */
  if (P > Psc) then
    Pcalc := Psc/100000;
  elseif (P <= 0) then
    Pcalc := 1/100000;
  else
    Pcalc := P/100000;
  end if;

  if (s > 2520) then
    scalc := 2.52;
  elseif (s < 600) then
    scalc := 0.6;
  else
    scalc := s/1000;
  end if;

  /* Properties on the saturation line */
  hsatV := -0.00000274*Pcalc^6 + 0.00032217*Pcalc^5 - 0.01489673*Pcalc^4 + 0.34258030*Pcalc^3
            - 4.15381744*Pcalc^2 + 27.64876596*Pcalc + 385.22149853;
  hsatL := -0.0000039275*Pcalc^6 + 0.0004780040*Pcalc^5 - 0.0227439765*Pcalc^4 + 0.5370471515*Pcalc^3
            - 6.6496487588*Pcalc^2 + 46.8685173786*Pcalc + 166.7823742593;
  ssatV := 0.0000000017*Pcalc^6 - 0.0000002159*Pcalc^5 + 0.0000102230*Pcalc^4 - 0.0002295813*Pcalc^3
            + 0.0023692545*Pcalc^2 - 0.0062966866*Pcalc + 1.7667560947;
  ssatL := -0.0000000164*Pcalc^6 + 0.0000019814*Pcalc^5 - 0.0000934768*Pcalc^4 + 0.0021827510*Pcalc^3
            - 0.0265228817*Pcalc^2 + 0.1740890297*Pcalc + 0.8685336198;

  /* Determination of the property zone (liquid, two-phase or steam) and compuation of the properties */
  if ((scalc >= ssatL) and (scalc <= ssatV)) then
      /* Two-phase zone */
      x := (scalc - ssatL) / (ssatV - ssatL);
      h := 1000*(hsatL*(1-x) + hsatV * x);

  elseif (scalc < ssatL) then
      /* Liquid zone */
      x := 0;
      h := 1000*(112.482*scalc^2 + 50.525*scalc + 39.292);
      if (h > hsatL) then
          h := 1000*hsatL;
      end if;
  else
      /* Steam zone */
      x := 1;
      A :=  -0.0396219*Pcalc^2 + 0.2873498*Pcalc + 185.5998054;
      B := -0.1114991*Pcalc^2 + 12.8417980*Pcalc - 415.1029137;
      C :=   0.1219352*Pcalc^2 - 13.8031170*Pcalc + 540.5578010;
      h := 1000*(A*scalc^2 + B*scalc + C);
      if (h < hsatV) then
          h := 1000*hsatV;
      end if;
  end if;

  pro := C3H3F5_Ph(P,h);

  props.T := pro.T;
  props.d := pro.d;
  props.u := pro.u;
  props.h := h;
  props.cp := pro.cp;
  props.x := x;

  annotation (
    smoothOrder = 2,
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2010</b></p>
</HTML>
<html>
<p><b>ThermoSysPro Version 2.0</b></p>
</HTML>
"));
end C3H3F5_Ps;
