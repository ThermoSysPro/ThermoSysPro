within ThermoSysPro.Properties.MoltenSalt;
record ThermoProperties_h
  //ThermoSysPro.Units.AbsoluteTemperature T(
    //min=ThermoSysPro.Properties.WaterSteam.InitLimits.TMIN,
    //max=ThermoSysPro.Properties.WaterSteam.InitLimits.TMAX,
    //nominal=ThermoSysPro.Properties.WaterSteam.InitLimits.TNOM) "Temperature";
  Modelica.SIunits.Density d(
    min=HitecLimits.DMIN,
    max=HitecLimits.DMAX,
    nominal=HitecLimits.DNOM) "Density";
  //Modelica.SIunits.SpecificEnergy u(
    //min=ThermoSysPro.Properties.WaterSteam.InitLimits.SEMIN,
    //max=ThermoSysPro.Properties.WaterSteam.InitLimits.SEMAX,
    //nominal=ThermoSysPro.Properties.WaterSteam.InitLimits.SENOM)
    //"Specific inner energy";
  //Modelica.SIunits.SpecificEntropy s(
    //min=ThermoSysPro.Properties.WaterSteam.InitLimits.SSMIN,
    //max=ThermoSysPro.Properties.WaterSteam.InitLimits.SSMAX,
    //nominal=ThermoSysPro.Properties.WaterSteam.InitLimits.SSNOM)
    //"Specific entropy";
  Modelica.SIunits.SpecificHeatCapacity cp(
    min=HitecLimits.CPMIN,
    max=HitecLimits.CPMAX,
    nominal=HitecLimits.CPNOM) "Specific heat capacity at constant presure";

  //Modelica.SIunits.DerDensityByEnthalpy ddhp
    //"Derivative of density wrt. specific enthalpy at constant pressure";
  //Modelica.SIunits.DerDensityByPressure ddph
   // "Derivative of density wrt. pressure at constant specific enthalpy";
  //Real duph(unit="m3/kg")
    //"Derivative of specific inner energy wrt. pressure at constant specific enthalpy";
  //Real duhp(unit = "1")
    //"Derivative of specific inner energy wrt. specific enthalpy at constant pressure";
  //ThermoSysPro.Units.MassFraction x "Vapor mass fraction";
  Modelica.SIunits.ThermalConductivity k(
    min=HitecLimits.LAMMIN,
    max=HitecLimits.LAMMAX,
    nominal=HitecLimits.LAMNOM);
  Modelica.SIunits.DynamicViscosity mu(
    min=HitecLimits.ETAMIN,
    max=HitecLimits.ETAMAX,
    nominal=HitecLimits.ETANOM);
  Modelica.SIunits.DerDensityByTemperature ddTp;
  Modelica.SIunits.DerDensityByPressure ddpT;
  annotation (Icon(graphics={
        Rectangle(
          extent={{-100,60},{100,-90}},
          lineColor={28,108,200},
          fillColor={255,255,127},
          fillPattern=FillPattern.Solid),
        Text(extent={{-127,125},{127,65}}, textString=
                                               "%name"),
        Line(points={{-100,-40},{100,-40}}, color={0,0,0}),
        Line(points={{-100,10},{100,10}}, color={0,0,0}),
        Line(points={{0,60},{0,-90}}, color={0,0,0})}));
end ThermoProperties_h;
