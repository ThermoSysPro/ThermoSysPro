within ThermoSysPro.Properties.WaterSteamSimple.Validation;
model generate_data_watersat
  import Modelica.SIunits.*;
  parameter Pressure p_min = 1e5;
  parameter Pressure p_max = 220e5;
  parameter Pressure delta_p(min = 1) = 20e5;

  ThermoSysPro.Properties.WaterSteamSimple.PropThermoSat pro1_polynomial;
  ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat pro1_IF97;
  ThermoSysPro.Properties.WaterSteamSimple.PropThermoSat pro2_polynomial;
  ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat pro2_IF97;

 // Integer i_p;
 // Integer i_h;
protected
  parameter Integer n_p =  integer((p_max - p_min)/delta_p);

  Integer i_mat;
  Real res1_polynomial[n_p,6];
  Real res1_IF97[n_p,6];
  Real res2_polynomial[n_p,6];
  Real res2_IF97[n_p,6];
public
   output AbsolutePressure p[n_p];

algorithm
  i_mat :=0;
  for i_p in 1:n_p loop
    p[i_p] := p_min + (i_p-1)*delta_p;

      //Properties
    (pro1_IF97,pro2_IF97) :=
      ThermoSysPro.Properties.WaterSteamSimple.SimpleWater.Water_sat_P(p[i_p]);

      (pro1_polynomial,pro2_polynomial) := ThermoSysPro.Properties.WaterSteam.IF97.Water_sat_P(
         p[i_p]);

      //Store results
      i_mat := i_mat + 1;

      //Liquid
      res1_polynomial[i_mat,1] := 1;
      res1_polynomial[i_mat,2] := p[i_p];
      res1_polynomial[i_mat,3] := pro1_polynomial.T;
      res1_polynomial[i_mat,4] := pro1_polynomial.rho;
      res1_polynomial[i_mat,5] := pro1_polynomial.h;
      res1_polynomial[i_mat,6] := pro1_polynomial.cp;

      res1_IF97[i_mat,1] := 1;
      res1_IF97[i_mat,2] := p[i_p];
      res1_IF97[i_mat,3] := pro1_IF97.T;
      res1_IF97[i_mat,4] := pro1_IF97.rho;
      res1_IF97[i_mat,5] := pro1_IF97.h;
      res1_IF97[i_mat,6] := pro1_IF97.cp;

      //Vapour
      res2_polynomial[i_mat,1] := 1;
      res2_polynomial[i_mat,2] := p[i_p];
      res2_polynomial[i_mat,3] := pro2_polynomial.T;
      res2_polynomial[i_mat,4] := pro2_polynomial.rho;
      res2_polynomial[i_mat,5] := pro2_polynomial.h;
      res2_polynomial[i_mat,6] := pro2_polynomial.cp;

      res2_IF97[i_mat,1] := 1;
      res2_IF97[i_mat,2] := p[i_p];
      res2_IF97[i_mat,3] := pro2_IF97.T;
      res2_IF97[i_mat,4] := pro2_IF97.rho;
      res2_IF97[i_mat,5] := pro2_IF97.h;
      res2_IF97[i_mat,6] := pro2_IF97.cp;
  end for;

 //Write results
 DymolaCommands.MatrixIO.writeMatrix("res_polynomial_sat1.mat","res1_polynomial",res1_polynomial);
 DymolaCommands.MatrixIO.writeMatrix("res_IF97_sat1.mat","res1_IF97",res1_IF97);
 DymolaCommands.MatrixIO.writeMatrix("res_polynomial_sat2.mat","res2_polynomial",res2_polynomial);
 DymolaCommands.MatrixIO.writeMatrix("res_IF97_sat2.mat","res2_IF97",res2_IF97);
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
end generate_data_watersat;
