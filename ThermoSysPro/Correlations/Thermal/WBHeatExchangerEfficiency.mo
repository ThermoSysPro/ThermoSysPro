within ThermoSysPro.Correlations.Thermal;
function WBHeatExchangerEfficiency "Heat exchanger efficiency"
  input Modelica.SIunits.MassFlowRate QevC "Steam mass flow rate at the inlet";
  input Modelica.SIunits.MassFlowRate QeeF "Water mass flow rate at the inlet";
  input Modelica.SIunits.SpecificHeatCapacity Cc
    "Hot fluid specific heat capacity";
  input Modelica.SIunits.SpecificHeatCapacity Cf
    "Cold fluid specific heat capacity";
  input Modelica.SIunits.CoefficientOfHeatTransfer KEG0
    "Global heat transfer coefficient";
  input Modelica.SIunits.Area S0 "External exchange surface";
  input Real Phase " = 0 ou 1 one-phase flow - otherwise two-phase flow";

  output Real EC0 "Heat exchanger efficiency";

protected
  Real NUT "Number of transfer units";
  Real CpMIN "Minimum heat capacity for the two fluids";
  Real CpMAX "Maximum heat capacity for the two fluids";
  Integer TYP2 "0 = co-current, 1 = counter-current";
  Modelica.SIunits.CoefficientOfHeatTransfer KEG
    "Global heat exchange coefficient";
  Modelica.SIunits.Area S "External exchange surface";
  Real EC "Exchnager efficiency";

algorithm
  TYP2 := 1;

  /* Verification of the inputs */
  KEG := if (KEG0 > 0) then KEG0 else 10;
  S := if (S0 > 0) then S0 else 1;

  //  NTU method
  //  ----------

  /* Minimum and maximum heat capacities */
  if (QevC*Cc < QeeF*Cf) then
    CpMIN := noEvent(abs(QevC*Cc));
    CpMAX := noEvent(abs(QeeF*Cf));
  else
    CpMIN := noEvent(abs(QeeF*Cf));
    CpMAX := noEvent(abs(QevC*Cc));
  end if;

  /* Heat exchanger efficiency */
  if ((Phase > 0) and (Phase < 1)) then
    /* Two-phase flow */
    NUT := KEG*S/noEvent(abs(QeeF*Cf));
    EC := 1 - Modelica.Math.exp(-NUT);
  else
    NUT := KEG*S/CpMIN;
    /* One-phase flow */
    /* Crossed currents */
    if (abs(QevC*Cc) < abs(QeeF*Cf)) then
      /* CpMIN is associated to the flue gases (fluide brasse) */
      EC := 1. - Modelica.Math.exp(-(abs(QeeF*Cf)/abs(QevC*Cc))*(1. - Modelica.Math.exp(-NUT*abs(QevC*Cc)/abs(QeeF*Cf))));
    else
      /* CpMIN is associated to water (fluide non brasse) */
      EC := abs(QevC*Cc)/abs(QeeF*Cf)*(1. - Modelica.Math.exp(-abs(QeeF*Cf)/abs(QevC*Cc)*(1 - Modelica.Math.exp(-NUT))));
    end if;
  end if;

  EC0 := if (EC > 0.) then EC else 1.e-2;

  annotation (
    smoothOrder=2,
    Icon(graphics),        Documentation(revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Baligh El Hefni </li>
</ul>
</html>",
   info="<html>
<p><b>Copyright &copy; EDF 2002 - 2014</b> </p>
<p><b>ThermoSysPro Version 3.1</h4>
</html>"));
end WBHeatExchangerEfficiency;
