within ThermoSysPro.Correlations.Thermal;
function WBInternalOnePhaseFlowHeatTransferCoefficient
  "Internal one-phase water or steam flow heat transfer coefficient"

  input ThermoSysPro.Correlations.Misc.Pro_TwoPhaseWaterSteam hy
                                                            annotation (Placement(
        transformation(extent={{-26,-74},{-6,-54}}, rotation=0)));
  input Real geomt[6] "Geometrical data vector";
  input Real Gm "Water mass velocity at the inlet (kg/m2s)";

  output Modelica.SIunits.CoefficientOfHeatTransfer hi
    "Internal heat transfer coefficient";

protected
  Modelica.SIunits.DynamicViscosity mul "Dynamic viscosity of the liquid phase";
  Modelica.SIunits.SpecificHeatCapacity cpl
    "Specific heat capacity of the liquid phase";
  Modelica.SIunits.ThermalConductivity kl
    "Thermal conductivity of the liquid phase";
  Modelica.SIunits.Diameter dtin "Pipes internal diameter";
  Real Re "Reynolds number for the computation of hi";
  Real Pr "Prandtl Reynolds number for the computation of hi";

algorithm
  cpl := hy.cpl;
  mul := hy.mul;
  kl := hy.kl;
  dtin := geomt[2];

  /* Reynolds number */
  Re := Gm*dtin/mul;

  /* Prandtl number */
  Pr := mul*cpl/kl;

  /* Internal heat transfer coefficient */
  hi := (0.023*kl/dtin)*(Re^0.8)*(Pr^0.4);

  annotation (
    smoothOrder=2,
    Documentation(revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Baligh El Hefni </li>
</ul>
</html>",
   info="<html>
<p><b>Copyright &copy; EDF 2002 - 2010</b></p>
</HTML>
<html>
<p><b>ThermoSysPro Version 2.0</h4>
</HTML>
"));
end WBInternalOnePhaseFlowHeatTransferCoefficient;
