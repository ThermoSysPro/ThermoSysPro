within ThermoSysPro.Functions;
function TableSplineInterpolation "Table spline interpolation"
  input Real TabP[:] "1st reference table";
  input Real TabX[:] "2nd reference table";
  input Real TabY[:, :] "Results table";
  input Real P "1st reference value";
  input Real X "2nd reference value";
  input Real t = 0.5 "Stiffness parameter";
  output Real Y "Interpolated result";

protected
  Integer dimP=size(TabP, 1) "TabP dimension";
  Integer dimX=size(TabX, 1) "TabX dimension";
  Integer dimY1=size(TabY, 1) "TabY 1st dimension";
  Integer dimY2=size(TabY, 2) "TabY 2nd dimension";
  Integer IndP=0 "Reference index";
  Boolean IndPcal "Computed index";

  Real Y1;
  Real Y0;
  Real Y2;

algorithm
  if ((dimX <> dimY2) or (dimP <> dimY1)) then
    assert(false, "TableLinearInterpolation: the dimensions of the tables are different");
  end if;

  IndPcal :=false;

 for i in 2:dimP loop
    if ((P <= TabP[i]) and (not IndPcal)) then
      IndP := i;
      IndPcal := true;
    end if;
  end for;

   // If P is not contained in the table:
  if (not IndPcal) then
    IndP := dimP;
    if integer(P)<=2 then
      IndP :=2;
    end if;
  end if;

  // Find corresponding table for IndP (p1, p2)
  Y1 := ThermoSysPro.Functions.SplineInterpolation(
    TabX=TabX,
    TabY=TabY[IndP - 1, :],
    X=X, t= t);
  Y2 := ThermoSysPro.Functions.SplineInterpolation(
    TabX=TabX,
    TabY=TabY[IndP, :],
    X=X, t = t);

 // If possible to use three points (p0,p1,p2):
 if ((IndP > 2) and IndPcal) then
    Y0 := ThermoSysPro.Functions.SplineInterpolation(
      TabX=TabX,
      TabY=TabY[IndP - 2, :],
      X=X, t= t);
    Y := ThermoSysPro.Functions.SplineInterpolation(
      TabX=TabP[IndP - 2:IndP],
      TabY={Y0,Y1,Y2},
      X=P, t= t);
 else
    Y := ThermoSysPro.Functions.SplineInterpolation(
      TabX=TabP[IndP - 1:IndP],
      TabY={Y1,Y2},
      X=P, t= t);
 end if;

  annotation (
    smoothOrder=2,
    Icon(graphics),        Documentation(info="<html>
<p><b>ThermoSysPro Version 3.1</b> </p>
<p>Computes 2-dimensional spline interpolation based on function SplineInterpolation. The resulting 2-dimensional spline will be continuous and have continuous first derivatives. </p>
<p><h4><font color=\"#008000\">Implementation</font></h4></p>
<p>It uses a cardinal spline interpolation algorithm. Cardinal splines are a sub-set of cubic Hermite splines where each piece is a third-degree polynomial specified in Hermite form: i.e specified by its values and the first derivatives at the end points of the reference interval.</p>
<p>The derivatives are calculated based on the non-uniform cardinal grid approach, see function SplineInterpolation for futher details.</p>
<p><h4><font color=\"#008000\">Inputs</font></h4></p>
<p><ul>
<li>TabP: vecor containing p-table values</li>
<li>TabX: Vector containing x-table values</li>
<li>TabY: Vector containing y-table values</li>
<li>P: The p-value that the spline should be evaluated at</li>
<li>X: The x-value that the spline should be evaluated at</li>
<li>t: Cardinal spline shape parameter. t = 0.5 is default and is generally a good choice. A value close to 1 will yield a stiff spline, t=0<a name=\"_x0000_i1025\">&nbsp;</a>corresponds to a Catmull-Rom spline and <a name=\"_x0000_i1025\">&nbsp;</a>t &LT; 0 corresponds to a more &ldquo;loose&rdquo; spline. From testing, t=0.5 <a name=\"_x0000_i1025\">&nbsp;</a>seems to be a good choice in general and is therefore chosen as a default value. A value of t = 1 corresponds to that the derivative in all data points is zero, which may result in strange curves . See Examples &GT; TestSplineInterpolation for a demonstration.</li>
</ul></p>
<p><h4><font color=\"#008000\">Output</font></h4></p>
<p><ul>
<li>Y: Interpolated value evaluated at P,X</li>
</ul></p>
<p><h4><font color=\"#008000\">Extrapolation</font></h4></p>
<p>Linear extrapolation is employed if the reference value is not contained in the reference value table.</p>
<p><br/><b><font style=\"color: #008000; \">Example</font></b></p>
<p><ul>
<li>TabX = {1,2,3,4};</li>
<li>TabP = {1,2,3,4};</li>
<li>TabY = &nbsp;[2,2,2,2;2,2,1,2;2,2,2,2;1,2,1,2]; </li>
</ul></p>
<p>TabY respresents the value table, and TabX and TabP represent the reference tables.</p>
<p>The example was called for X = linspace(0,0.1,5) and P = linspace(0.1,0.1,4)</p>
<p>The black dots represent the data points, and the red lines represent the interpolation result.</p>
<p><br/><img src=\"modelica://ThermoSysPro/Resources/Images/splinetable.png\"/></p>
<p><h4><font color=\"#008000\">References</font></h4></p>
<p><a href=\"http://people.cs.clemson.edu/~dhouse/courses/405/notes/splines.pdf\">http://people.cs.clemson.edu/~dhouse/courses/405/notes/splines.pdf</a></p>
</html>", revisions="<html>
</html>"));
end TableSplineInterpolation;
