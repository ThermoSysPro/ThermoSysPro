within ThermoSysPro.Fluid.Interfaces.Connectors;
connector FluidOutlet "Fluid outlet connector"
  Units.SI.Pressure P(start=1.e5) "Fluid pressure in the control volume";
  Units.SI.MassFlowRate Q(start=500)
    "Mass flow rate of the fluid crossing the boundary of the control volume";
  Units.SI.SpecificEnthalpy h(start=1.e5)
    "Specific enthalpy of the fluid crossing the boundary of the control volume";
  Units.SI.SpecificEnthalpy h_vol_1(start=1.e5)
    "Fluid specific enthalpy in the control volume 1";
  Units.SI.SpecificEnthalpy h_vol_2(start=1.e5)
    "Fluid specific enthalpy in the control volume 2";
  output ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType ftype
    "Fluid type";
  ThermoSysPro.Units.SI.MassFraction Xco2(start=0.01)
    "CO2 mass fraction of the fluid crossing the boundary of the control volume";
  ThermoSysPro.Units.SI.MassFraction Xh2o(start=0.05)
    "H2O mass fraction of the fluid crossing the boundary of the control volume";
  ThermoSysPro.Units.SI.MassFraction Xo2(start=0.2)
    "O2 mass fraction of the fluid crossing the boundary of the control volume";
  ThermoSysPro.Units.SI.MassFraction Xso2(start=0)
    "SO2 mass fraction of the fluid crossing the boundary of the control volume";
  output Real diff_res_1(start=1e4)
    "Diffusion resistance from control volume 1";
  input Real diff_res_2(start=1e4)
    "Diffusion resistance from control volume 2";
  output Boolean diff_on_1
    "true: with diffusion - false: without diffusion from control volume 1";
  input Boolean diff_on_2
    "true: with diffusion - false: without diffusion from control volume 2";
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,108,92})}),
    Window(
      x=0.26,
      y=0.39,
      width=0.6,
      height=0.6),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
</html>",
 revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Daniel Bouskela </li>
</ul>
</html>"));
end FluidOutlet;
