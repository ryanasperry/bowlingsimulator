classdef World < handle
    properties
        pins Disc
        ball Disc
        plotProgress;
        timestep = .005;
        momentum  = 0;
        iterations = 0;
        displacement = zeros(1,10);
    end
    methods
        function obj = World(ballPosition, ballVelocity, ballMass, plot)
            x = 0.153162;
            y = 0.263525;
            locations = [0, 0;
                x, y;
                -x, y;
                2*x, 2*y;
                0, 2*y;
                -2*x, 2*y;
                3*x, 3*y;
                x, 3*y;
                -x, 3*y;
                -3*x, 3*y];
            
            for i = 1:10
                obj.pins(i) = Disc(1.5, .121/2, locations(i,:), [0, 0]);
            end
            obj.ball = Disc(ballMass, .2159/2, ballPosition, ballVelocity);
            obj.plotProgress = plot;
        end
        function visualize(obj)
            for i = 1:length(obj.pins)
                [x, y] = plot_circle(obj.pins(i).position, obj.pins(i).radius);
                plot(x,y,'r');
                hold on
            end
            [x, y] = plot_circle(obj.ball.position, obj.ball.radius);
            plot(x,y,'b');
            plot([.762,.762],[-.5,1],'k')
            plot([-.762,-.762],[-.5,1],'k')
            plot([-.52705,-.52705],[-.5,1],'k')
            plot([.52705,.52705],[-.5,1],'k')
            axis equal
            hold off
        end
        function update(obj)
            for i = 1:length(obj.pins)
                obj.pins(i).velocity = update_velocity(obj.pins(i), obj.timestep);
                newpos= update_position(obj.pins(i), obj.timestep);
                obj.displacement(i) = obj.displacement(i) + abs(norm(newpos - obj.pins(i).position));
                obj.pins(i).position = newpos;
            end
            obj.ball.velocity = update_velocity(obj.ball, obj.timestep);
            obj.ball.position = update_position(obj.ball, obj.timestep);
            for i = 1:length(obj.pins)
                if abs(obj.pins(i).position(1))> .52705
                    sgn = sign(obj.pins(i).position(1));
                    obj.pins(i).position = [sgn*.7015,obj.pins(i).position(2)];
                    obj.pins(i).velocity = [0, sqrt(obj.pins(i).velocity(2)^2+obj.pins(i).velocity(1)^2)];
                end
            end
            if abs(obj.ball.position(1)) > .52705 || obj.ball.position(2) > .95
                sgn = sign(obj.ball.position(1));
                obj.ball.position = [sgn*.65405,0];
                obj.ball.velocity = [0, 0];
            end
            for i = 1:length(obj.pins)
                for j = i+1:length(obj.pins)
                    if check_collisions(obj.pins(i), obj.pins(j))
                        m1 = obj.pins(j).mass;
                        m2 = obj.pins(i).mass;
                        c1 = obj.pins(j).cRes;
                        c2 = obj.pins(i).cRes;
                        v1 = obj.pins(j).velocity;
                        v2 = obj.pins(i).velocity;
                        x1 = obj.pins(j).position;
                        x2 = obj.pins(i).position;
                        obj.pins(j).velocity = c1*(v1-(2*m2/(m1+m2))*dot(v1-v2,x1-x2)/norm(x1-x2)^2*(x1-x2));
                        obj.pins(i).velocity = c2*(v2-(2*m1/(m1+m2))*dot(v2-v1,x2-x1)/norm(x2-x1)^2*(x2-x1));
                    end
                end
            end
            for i = 1:length(obj.pins)
                if check_collisions(obj.ball, obj.pins(i))
                    m1 = obj.ball.mass;
                    m2 = obj.pins(i).mass;
                    c1 = obj.ball.cRes;
                    c2 = obj.pins(i).cRes;
                    v1 = obj.ball.velocity;
                    v2 = obj.pins(i).velocity;
                    x1 = obj.ball.position;
                    x2 = obj.pins(i).position;
                    obj.ball.velocity = c1*(v1-(2*m2/(m1+m2))*dot(v1-v2,x1-x2)/norm(x1-x2)^2*(x1-x2));
                    obj.pins(i).velocity = c2*(v2-(2*m1/(m1+m2))*dot(v2-v1,x2-x1)/norm(x2-x1)^2*(x2-x1));
                end
            end
            for i = 1:length(obj.pins)
                %m(i) = log(norm(obj.pins(i).velocity));
                m(i) = obj.pins(i).mass*norm(obj.pins(i).velocity)^2;
            end
            obj.momentum(length(obj.momentum) + 1) = sum(m);
            if obj.plotProgress
                if rem(obj.iterations,5) == 0
                    obj.visualize();
                    drawnow;
                end
                %pause(.5);
            end
        end
    end
end