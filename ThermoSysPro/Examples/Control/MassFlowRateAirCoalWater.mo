within ThermoSysPro.Examples.Control;
model MassFlowRateAirCoalWater "MassFlowRateAirCoalWater"
 // Modelica.SIunits.Power Welec
 //   "(Percent, max=100)Electrical power produced by the generator";
 Modelica.SIunits.Power Welec( start=804.461)
    "(MW)Electrical power produced by the generator";
 Modelica.SIunits.MassFlowRate Qair(start=710) "Air mass flow rate";
 Modelica.SIunits.MassFlowRate Qcoal(start=70) "Coal mass flow rate";
 Modelica.SIunits.MassFlowRate Qwater(start=600) "Water mass flow rate";

  InstrumentationAndControl.Connectors.InputReal Electrical_power_MW
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},   rotation=-90,
        origin={-10,96})));
  InstrumentationAndControl.Connectors.OutputReal Q_air
                              annotation (Placement(transformation(
        origin={110,-9},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  InstrumentationAndControl.Connectors.OutputReal Q_coal
                              annotation (Placement(transformation(
        origin={110,75},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  InstrumentationAndControl.Connectors.OutputReal Q_water
                              annotation (Placement(transformation(
        origin={110,-89},
        extent={{10,-10},{-10,10}},
        rotation=180)));
equation
  //if (cardinality(Electrical_power_Percent) == 0) then
  //  Electrical_power_Percent.signal = 100;
  //end if;

  if (cardinality(Electrical_power_MW) == 0) then
    Electrical_power_MW.signal = 804.461;
  end if;

  Welec = Electrical_power_MW.signal;
  //Qair = 45.38 + 0.8249*Welec;
  //Qcoal = - 2.4172 + 0.0849*Welec;

  Qair = 46.0 + 0.8229*Welec;
  Qcoal = - 2.3534 + 0.0847*Welec;

  //Qwater = 23.484 + 0.7166*Welec;
  Qwater = 23.524 + 0.7166*Welec;

  //Qwater = 23.523 + 0.7166*Welec;

  Q_air.signal = Qair;
  Q_coal.signal = Qcoal;
  Q_water.signal = Qwater;

  annotation (Diagram(graphics={
        Rectangle(
          extent={{-100,86},{100,-100}},
          lineColor={0,0,255},
          pattern=LinePattern.Dash,
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-32,92},{144,56}},
          lineColor={255,255,255},
          pattern=LinePattern.Dash,
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          textString="Qcoal"),
        Text(
          extent={{10,-72},{96,-102}},
          lineColor={255,255,255},
          pattern=LinePattern.Dash,
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          textString="Qwater"),
        Text(
          extent={{30,12},{100,-26}},
          lineColor={255,255,255},
          pattern=LinePattern.Dash,
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          textString="Qair")}), Icon(graphics={
        Rectangle(
          extent={{-100,86},{100,-100}},
          lineColor={0,0,255},
          pattern=LinePattern.Dash,
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-34,91},{142,55}},
          lineColor={255,255,255},
          pattern=LinePattern.Dash,
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          textString="Qcoal"),
        Text(
          extent={{22,12},{102,-28}},
          lineColor={255,255,255},
          pattern=LinePattern.Dash,
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          textString="Qair"),
        Text(
          extent={{-6,-70},{98,-104}},
          lineColor={255,255,255},
          pattern=LinePattern.Dash,
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          textString="Qwater")}));
end MassFlowRateAirCoalWater;
