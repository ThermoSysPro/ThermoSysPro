within ThermoSysPro.Properties.WaterSteamSimple.Validation;
model generate_data_supercritique_ph
  import Modelica.SIunits.*;
  parameter Pressure p_min = 200e5;
  parameter Pressure p_max = 400e5;
  parameter Pressure delta_p(min = 1) = 10e5;
  parameter SpecificEnthalpy h_min = 1e5;
  parameter SpecificEnthalpy h_max = 4e6;
  parameter SpecificEnthalpy  delta_h(min = 1) = 0.1e5;

  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph pro_polynomial;
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph pro_IF97;

protected
  parameter Integer n_p =  integer((p_max - p_min)/delta_p);
  parameter Integer n_h = integer((h_max - h_min)/delta_h);

  Integer i_mat;
  Real res_polynomial[n_p*n_h,12];
  Real res_IF97[n_p*n_h,12];

public
   output AbsolutePressure p[n_p];
   output SpecificEnthalpy h[n_h];

algorithm
  i_mat :=0;
  for i_p in 1:n_p loop
    p[i_p] := p_min + (i_p-1)*delta_p;
    for i_h in 1:n_h loop
      h[i_h] := h_min + (i_h-1)*delta_h;

      //Properties
      pro_IF97 := ThermoSysPro.Properties.Fluid.Ph(
         p[i_p],
         h[i_h],
         0,1);

       pro_polynomial := ThermoSysPro.Properties.Fluid.Ph(
         p[i_p],
         h[i_h],
         0,3);

      //Store results
      i_mat := i_mat + 1;
      res_polynomial[i_mat,1] := p[i_p];
      res_polynomial[i_mat,2] := h[i_h];
      res_polynomial[i_mat,3] := pro_polynomial.x;
      res_polynomial[i_mat,4] := pro_polynomial.T;
      res_polynomial[i_mat,5] := pro_polynomial.d;
      res_polynomial[i_mat,6] := pro_polynomial.u;
      res_polynomial[i_mat,7] := pro_polynomial.s;
      res_polynomial[i_mat,8] := pro_polynomial.cp;
      res_polynomial[i_mat,9] := pro_polynomial.ddhp;
      res_polynomial[i_mat,10] := pro_polynomial.ddph;
      res_polynomial[i_mat,11] := pro_polynomial.duph;
      res_polynomial[i_mat,12] := pro_polynomial.duhp;

      res_IF97[i_mat,1] := p[i_p];
      res_IF97[i_mat,2] := h[i_h];
      res_IF97[i_mat,3] := pro_IF97.x;
      res_IF97[i_mat,4] := pro_IF97.T;
      res_IF97[i_mat,5] := pro_IF97.d;
      res_IF97[i_mat,6] := pro_IF97.u;
      res_IF97[i_mat,7] := pro_IF97.s;
      res_IF97[i_mat,8] := pro_IF97.cp;
      res_IF97[i_mat,9] := pro_IF97.ddhp;
      res_IF97[i_mat,10] := pro_IF97.ddph;
      res_IF97[i_mat,11] := pro_IF97.duph;
      res_IF97[i_mat,12] := pro_IF97.duhp;
    end for;

  end for;

 //Write results
 DymolaCommands.MatrixIO.writeMatrix("res_polynomial_supercritique_ph.mat","res_polynomial",res_polynomial);
 DymolaCommands.MatrixIO.writeMatrix("res_IF97_supercritique_ph.mat","res_IF97",res_IF97);

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
end generate_data_supercritique_ph;
