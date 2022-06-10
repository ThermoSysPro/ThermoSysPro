within ThermoSysPro.Fluid.Interfaces.Connectors;
connector FuelInlet "Fuel inlet connector"
  input Units.SI.MassFlowRate Q "Fuel mass flow rate";
  Units.SI.AbsolutePressure P "Fuel pressure";
  Units.SI.Temperature T "Fuel temperature";
  Units.SI.SpecificEnergy LHV "Lower heating value";
  Units.SI.SpecificHeatCapacity cp "Fuel specific heat capacity at 273.15 K";
  Real hum "Fuel humidity (%)";
  ThermoSysPro.Units.SI.MassFraction Xc "C mass fraction";
  ThermoSysPro.Units.SI.MassFraction Xh "H mass fraction";
  ThermoSysPro.Units.SI.MassFraction Xo "O mass fraction";
  ThermoSysPro.Units.SI.MassFraction Xn "N mass fraction";
  ThermoSysPro.Units.SI.MassFraction Xs "S mass fraction";
  ThermoSysPro.Units.SI.MassFraction Xashes "Ashes mass fraction";
  ThermoSysPro.Units.SI.MassFraction VolM "Percentage of volatile matter";
  Units.SI.Density rho "Fuel density";
  annotation (Icon(graphics={Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={0,0,0}), Ellipse(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={0,128,255})}),    Documentation(revisions="",
        info="<html>
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
</html>"));
end FuelInlet;
