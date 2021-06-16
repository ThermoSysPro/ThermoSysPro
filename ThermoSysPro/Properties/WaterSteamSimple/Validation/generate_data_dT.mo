within ThermoSysPro.Properties.WaterSteamSimple.Validation;
model generate_data_dT
  import Modelica.SIunits.*;
  parameter Density d_min = 15;
  parameter Density d_max = 1000;
  parameter Density delta_d(min = 1) = 25;
  parameter Temperature T_min = 290;
  parameter Temperature T_max = 1000;
  parameter Temperature  delta_T(min = 1) = 50;

  Modelica.SIunits.DynamicViscosity mu_polynomial "Dynamic viscosity";
  Modelica.SIunits.ThermalConductivity  lambda_polynomial
    "Thermal conductivity";
  Modelica.SIunits.DynamicViscosity mu_IF97 "Dynamic viscosity";
  Modelica.SIunits.ThermalConductivity  lambda_IF97 "Thermal conductivity";

protected
  parameter Integer n_d =  integer((d_max - d_min)/delta_d);
  parameter Integer n_T = integer((T_max - T_min)/delta_T);

  Integer i_mat;
public
  Real res_polynomial[n_d*n_T,4];
  Real res_IF97[n_d*n_T,4];

public
   output AbsolutePressure d[n_d];
   output SpecificEnthalpy T[n_T];

algorithm
  i_mat :=0;
  for i_d in 1:n_d loop
    d[i_d] := d_min + (i_d-1)*delta_d;
    for i_T in 1:n_T loop
      T[i_T] := T_min + (i_T-1)*delta_T;

      //Properties
      mu_polynomial :=
        ThermoSysPro.Properties.WaterSteamSimple.SimpleWater.DynamicViscosity_rhoT(
        d[i_d], T[i_T]);

      lambda_polynomial :=
        ThermoSysPro.Properties.WaterSteamSimple.SimpleWater.ThermalConductivity_rhoT(
        d[i_d], T[i_T]);

      mu_IF97 := ThermoSysPro.Properties.WaterSteam.IF97.DynamicViscosity_rhoT(
         d[i_d],
         T[i_T]);

      lambda_IF97 := ThermoSysPro.Properties.WaterSteam.IF97.ThermalConductivity_rhoT(
          d[i_d],
         T[i_T],0,0);

      //Store results
      i_mat := i_mat + 1;
      res_polynomial[i_mat,1] := d[i_d];
      res_polynomial[i_mat,2] := T[i_T];
      res_polynomial[i_mat,3] := mu_polynomial;
      res_polynomial[i_mat,4] := lambda_polynomial;

      res_IF97[i_mat,1] := d[i_d];
      res_IF97[i_mat,2] := T[i_T];
      res_IF97[i_mat,3] := mu_IF97;
      res_IF97[i_mat,4] := lambda_IF97;

    end for;

  end for;

 //Write results
 DymolaCommands.MatrixIO.writeMatrix("res_polynomial_lbdmu_dT.mat","res_polynomial",res_polynomial);
 DymolaCommands.MatrixIO.writeMatrix("res_IF97_lbdmu_dT.mat","res_IF97",res_IF97);

  annotation (Icon(graphics={
        Rectangle(
          lineColor={200,200,200},
          fillColor={248,248,248},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-100.0,-100.0},{100.0,100.0}},
          radius=25.0),
        Rectangle(
          lineColor={128,128,128},
          extent={{-100.0,-100.0},{100.0,100.0}},
          radius=25.0),
        Polygon(
          origin={8.0,14.0},
          lineColor={78,138,73},
          fillColor={78,138,73},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{-58.0,46.0},{42.0,-14.0},{-58.0,-74.0},{-58.0,46.0}})}));
end generate_data_dT;
