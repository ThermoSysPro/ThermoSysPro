within ThermoSysPro.Properties.Fluid;
function derSpecificInternalEnergy_derP_derh
  "der(Specific Internal Energy) computation for all fluids (inputs: P, h, der(P), der(h), fluid)"

  input Modelica.SIunits.AbsolutePressure P "Pressure (Pa)";
  input Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
  input Integer fluid
    "<html>Fluid number: <br>1 - Water/Steam <br>2 - C3H3F5 <br>3 - FlueGases <br>4 - MoltenSalt <br>5 - Oil <br>6 - DryAirIdealGas <br>7 - WaterSteamSimple </html>";
  input Integer mode "IF97 region - 0:automatic computation";
  input Real Xco2 "CO2 mass fraction";
  input Real Xh2o "H2O mass fraction";
  input Real Xo2 "O2 mass fraction";
  input Real Xso2 "SO2 mass fraction";
  input Real der_P "Pressure time derivative (J/(kg*s))";
  input Real der_h "Specific Enthalpy time derivative (J/(kg*s))";
  input Real der_Xco2=0 "CO2 mass fraction";
  input Real der_Xh2o=0 "H2O mass fraction";
  input Real der_Xo2=0 "O2 mass fraction";
  input Real der_Xso2=0 "SO2 mass fraction";

  output Real der_u "Specific Internal Energy time derivative (J/kg/s)";

protected
  Modelica.SIunits.Duration dt=1;
  Modelica.SIunits.AbsolutePressure delta_P = 0.01*P;
  Modelica.SIunits.SpecificEnthalpy delta_h = 0.01*h;

algorithm
  // Water/Steam, C3H3F5, FlueGas, MoltenSalt, Oil, DryAirIdealGas

    der_u :=(ThermoSysPro.Properties.Fluid.SpecificInternalEnergy_Ph_DO_NOT_USE(
    P=P + delta_P,
    h=h + delta_h,
    fluid=fluid,
    mode=mode,
    Xco2=Xco2,
    Xh2o=Xh2o,
    Xo2=Xo2,
    Xso2=Xso2) -
    ThermoSysPro.Properties.Fluid.SpecificInternalEnergy_Ph_DO_NOT_USE(
    P=P - delta_P,
    h=h - delta_h,
    fluid=fluid,
    mode=mode,
    Xco2=Xco2,
    Xh2o=Xh2o,
    Xo2=Xo2,
    Xso2=Xso2))/dt;

  assert(fluid==1 or fluid==2 or fluid==3 or fluid==4 or fluid==5 or fluid==6, "incorrect fluid number");  ///

end derSpecificInternalEnergy_derP_derh;
