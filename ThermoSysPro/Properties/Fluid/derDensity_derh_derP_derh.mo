within ThermoSysPro.Properties.Fluid;
function derDensity_derh_derP_derh
  "der(Density derivative w.r.t enthalpy) computation for all fluids (inputs: P, h, der(P), der(h), fluid)"

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

  output Real der_ddhp "Time derivative of Density derivative by enthalpy";

protected
  Modelica.SIunits.Duration dt=1;
  Modelica.SIunits.AbsolutePressure delta_P = 0.01*P;
  Modelica.SIunits.SpecificEnthalpy delta_h = 0.01*h;

///annotation(derivative(order=2)=derderDensity_derh_derderP_derderh);

algorithm
  // Water/Steam
  if fluid==1 then
    //

  // C3H3F5
  elseif fluid==2 then
    //

  // FlueGas
  elseif fluid==3 then
    assert(Xco2+Xh2o+Xo2+Xso2>0, "Wrong mass fraction definition");  /// Commentaire ajouté (si fluid==2, vérifie que les fractions massiques sont bien fournies en Input)
    //

  // MoltenSalt
  elseif fluid==4 then
    //

  // Oil
  elseif fluid==5 then
    der_ddhp := (ThermoSysPro.Properties.Fluid.Density_derh_Ph(P=P+delta_P,h=h+delta_h,fluid=fluid,mode=mode,Xco2=Xco2,Xh2o=Xh2o,Xo2=Xo2,Xso2=Xso2)
      - ThermoSysPro.Properties.Fluid.Density_derh_Ph(P=P-delta_P,h=h-delta_h,fluid=fluid,mode=mode,Xco2=Xco2,Xh2o=Xh2o,Xo2=Xo2,Xso2=Xso2))
      / dt;

  // Dry Air Ideal Gas
  elseif fluid==6 then
    //

  // Water/Steam Simple
  elseif  fluid==7 then
   //

  else
    assert(false, "incorrect fluid number");  ///
  end if;

end derDensity_derh_derP_derh;
