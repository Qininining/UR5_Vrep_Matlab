classdef UR5
    % 添加属性
    properties
        sim
        clientID

        joint1
        joint2
        joint3
        joint4
        joint5
        joint6


    end
    % 添加方法
    methods
        %% 构造函数
        function obj = UR5()
            % 连接Vrep
            obj.sim=remApi('remoteApi');
            obj.sim.simxFinish(-1);
            obj.clientID=obj.sim.simxStart('127.0.0.1',19997,true,true,5000,5);
            if (obj.clientID>-1)
                disp('Connected to remote API server');
            else
                disp('Failed connecting to remote API server');
                return;
            end
            obj.sim.simxAddStatusbarMessage(obj.clientID,'Hello CoppeliaSim!',obj.sim.simx_opmode_oneshot);

            % 获取MicroAssmbly Stage句柄
            UR5_joint_Handle = zeros(6,1);
            [~,UR5_joint_Handle(1,1)] = obj.sim.simxGetObjectHandle(obj.clientID,'/UR5/joint',obj.sim.simx_opmode_blocking);%simx_opmode_blocking:可以理解为这个操作执行一次，但是没有执行完就要等，所以速度慢，但是会保证通信完成
            [~,UR5_joint_Handle(2,1)] = obj.sim.simxGetObjectHandle(obj.clientID,'/UR5/link/joint',obj.sim.simx_opmode_blocking);
            [~,UR5_joint_Handle(3,1)] = obj.sim.simxGetObjectHandle(obj.clientID,'/UR5/link/joint/link/joint',obj.sim.simx_opmode_blocking);
            [~,UR5_joint_Handle(4,1)] = obj.sim.simxGetObjectHandle(obj.clientID,'/UR5/link/joint/link/joint/link/joint',obj.sim.simx_opmode_blocking);
            [~,UR5_joint_Handle(5,1)] = obj.sim.simxGetObjectHandle(obj.clientID,'/UR5/link/joint/link/joint/link/joint/link/joint',obj.sim.simx_opmode_blocking);
            [~,UR5_joint_Handle(6,1)] = obj.sim.simxGetObjectHandle(obj.clientID,'/UR5/link/joint/link/joint/link/joint/link/joint/link/joint',obj.sim.simx_opmode_blocking);

            % 重新赋值
            % Stage
            obj.joint1 = UR5_joint_Handle(1,1);
            obj.joint2 = UR5_joint_Handle(2,1);
            obj.joint3 = UR5_joint_Handle(3,1);
            obj.joint4 = UR5_joint_Handle(4,1);
            obj.joint5 = UR5_joint_Handle(5,1);
            obj.joint6 = UR5_joint_Handle(6,1);



        end

        %% 开始模拟
        function StartSimulation(obj)
            obj.sim.simxStartSimulation(obj.clientID,obj.sim.simx_opmode_blocking);
            obj.sim.simxAddStatusbarMessage(obj.clientID,'Start Simulation',obj.sim.simx_opmode_oneshot);
        end

        %% 停止模拟
        function StopSimulation(obj)
            obj.sim.simxAddStatusbarMessage(obj.clientID,'Stop Simulation',obj.sim.simx_opmode_oneshot);
            obj.sim.simxStopSimulation(obj.clientID,obj.sim.simx_opmode_blocking);
        end

        %% 设置关节位置
        function SetJointPosition(obj, joint, targetPosition)
            obj.sim.simxSetJointTargetPosition(obj.clientID, joint, targetPosition, obj.sim.simx_opmode_oneshot_wait);
        end


        %% 设置关节角度
        function SetJointAngle(obj, joint, targetAngle)
            obj.sim.simxSetJointTargetPosition(obj.clientID, joint, targetAngle / 180 * pi, obj.sim.simx_opmode_oneshot_wait);
        end


        %% 设置关节角度
        function SetJointVelocity(obj, joint, targetVelocity)
            obj.sim.simxSetJointTargetVelocity(obj.clientID, joint, targetVelocity / 180 * pi, obj.sim.simx_opmode_oneshot_wait);
        end

        %% 关节位置归零
        function PositionReset(obj)
            obj.sim.simxSetJointTargetPosition(obj.clientID, obj.joint1, 0, obj.sim.simx_opmode_oneshot_wait);
            obj.sim.simxSetJointTargetPosition(obj.clientID, obj.joint2, 0, obj.sim.simx_opmode_oneshot_wait);
            obj.sim.simxSetJointTargetPosition(obj.clientID, obj.joint3, 0, obj.sim.simx_opmode_oneshot_wait);
            obj.sim.simxSetJointTargetPosition(obj.clientID, obj.joint4, 0, obj.sim.simx_opmode_oneshot_wait);
            obj.sim.simxSetJointTargetPosition(obj.clientID, obj.joint5, 0, obj.sim.simx_opmode_oneshot_wait);
            obj.sim.simxSetJointTargetPosition(obj.clientID, obj.joint6, 0, obj.sim.simx_opmode_oneshot_wait);
        end

        %% 析构函数
        function delete(obj)
            obj.sim.simxFinish(obj.clientID);
            obj.sim.delete(); % call the destructor!
        end

    end
end











