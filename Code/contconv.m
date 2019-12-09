function [y, t] = contconv(x1, x2, t1, t2, dt)
    t1_end = ((length(x1) - 1) * dt) + t1;
    t2_end = ((length(x2) - 1) * dt) + t2;
    t = (t1+t2):dt:(t1_end+t2_end);
    y = conv(x1, x2) * dt;
end