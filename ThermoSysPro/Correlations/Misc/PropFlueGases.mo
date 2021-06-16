within ThermoSysPro.Correlations.Misc;
function PropFlueGases "Computation of the flue gases properties"
  input Modelica.SIunits.AbsolutePressure Pmf "Flue gases average pressure";
  input Modelica.SIunits.Temperature Tmf "Flue gases average temperature";
  input Real XefCO2 "CO2 mass fraction";
  input Real XefH2O "H2O mass fraction";
  input Real XefO2 "O2 mass fraction";
  input Real XefN2 "N2 mass fraction";
  input Real XefSO2 "SO2 mass fraction";

  output Real propf[4] "Flue gases physical properties vector";

protected
  Modelica.SIunits.ThermalConductivity condf "Flue gases thermal conductivity";
  Modelica.SIunits.SpecificHeatCapacity cpf "Flue gases specific heat capacity";
  Modelica.SIunits.DynamicViscosity muf "Flue gases dynamic viscosity";
  Modelica.SIunits.Density rhof "Flue gases density";

algorithm
  condf := ThermoSysPro.Properties.FlueGases.FlueGases_k(Pmf, Tmf, XefCO2, XefH2O, XefO2, XefSO2);
  cpf := ThermoSysPro.Properties.FlueGases.FlueGases_cp(Pmf, Tmf, XefCO2, XefH2O, XefO2, XefSO2);
  muf := ThermoSysPro.Properties.FlueGases.FlueGases_mu(Pmf, Tmf, XefCO2, XefH2O, XefO2, XefSO2);
  rhof := ThermoSysPro.Properties.FlueGases.FlueGases_rho(Pmf, Tmf, XefCO2, XefH2O, XefO2, XefSO2);

  propf[1] := condf;
  propf[2] := cpf;
  propf[3] := muf;
  propf[4] := rhof;

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
end PropFlueGases;
