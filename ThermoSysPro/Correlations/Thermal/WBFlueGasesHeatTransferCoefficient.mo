within ThermoSysPro.Correlations.Thermal;
function WBFlueGasesHeatTransferCoefficient
  "Flue gases heat transfer coefficient"
  input Real propf[4] "Flue gases properties vector";
  input Units.SI.MassFlowRate Qef "Flue gases mass flow rate at the inlet";
  input Units.SI.AbsolutePressure Pmf "Flue gases average pressure";
  input Units.SI.Temperature Tmf "Flue gases average temperature";
  input Real XefCO2 "CO2 mass fraction at the inlet";
  input Real XefH2O "H2O mass fraction at the inlet";
  input Units.SI.PathLength dz "Step in the z direction";
  input Units.SI.Length long "Wall zone length";
  input Units.SI.Length prof "Wall zone width";
  input Units.SI.Temperature Tpext "External wall temperature";
  input Real fvd=0 "Particles volume fraction";
  input Real emimur=0.1 "Wall emissivity";

  output Units.SI.CoefficientOfHeatTransfer hf
    "Global heat transfer coefficient";

protected
  Units.SI.ThermalConductivity condf "Flue gases thermal conductivity";
  Units.SI.SpecificHeatCapacity cpf "Flue gases specific heat capacity";
  Units.SI.DynamicViscosity muf "Flue gases dynamic viscosity";
  Real Ref "Flue gases Reynolds number";
  Real Prf "Flue gases Prandtl number";
  Units.SI.CoefficientOfHeatTransfer hc
    "Flue gases convective heat transfer coefficient";
  Units.SI.Volume volumg "Gas volume";
  Units.SI.Area senveng "Gas total envelope surface";
  Units.SI.Radius rop "Average optical radius between pipes";
  Real EG " ";
  Real ES " ";
  Real emigaz "Gas emissivity";
  Real emigaz0 "Gas emissivity";
  Units.SI.CoefficientOfHeatTransfer hr "Radiation heat transfer coefficient";

algorithm
  condf := propf[1];
  cpf := propf[2];
  muf := propf[3];

  /* Reynolds number */
  Ref := Qef*dz/(muf*prof*long);

  /* Prandtl number */
  Prf:=muf*cpf/condf;

  /* Convective heat transfer coefficient */
  if (Ref <= 3e5) then
    /* Laminar regime */
    hc := 0.66*(Ref^0.5)*(Prf^0.333)*condf/dz;
  else
    /* Turbulent regime */
    hc := 0.036*(Ref^0.8)*(Prf^0.333)*condf/dz;
  end if;

  /* Flue gases radiation */
  volumg := dz*long*prof;
  senveng := 2*dz*long + 2*dz*prof + 2*long*prof;
  rop := 3.6*volumg/senveng;

  (EG, ES, emigaz0) := ThermoSysPro.Properties.FlueGases.FlueGases_Absorb(XefCO2*Pmf, XefH2O*Pmf, fvd,rop, Tmf);

  if (emigaz0 < 0.0001) then
    emigaz := 0.0001;
  elseif (emigaz0 > 1) then
    emigaz := 0.99;
  else
    emigaz := emigaz0;
  end if;

  /* Radiation heat transfer coefficient */
  hr := 5.68e-8/(1/emigaz + (1 - emimur)/emimur)*(Tmf^2 + Tpext^2)*(Tmf + Tpext);

  /* Flue gases heat transfer coefficient */
  hf := hc + hr;

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
end WBFlueGasesHeatTransferCoefficient;
