%% MicroAssmbly Robot
%% 清除工作区中的变量、关闭所有图形窗口以及清除命令行窗口
clc;
close all;
clear;
%% 创建类
% 需要提前打开vrep工程
myRobot = UR5;
myRobot.StartSimulation();
myRobot.PositionReset();
% pause(2);
% myRobot.SetJointAngle(myRobot.joint1,90);
myRobot.SetJointVelocity(myRobot.joint1,90);
% myRobot.sim.simxSetBoolParam(myRobot.clientID,paramIdentifier,paramValue, myRobot.sim.simx_opmode_oneshot_wait);
% [min, max] = myRobot.GetJointLimit(myRobot.Gripper_joint1);
pause;
%%
myRobot.StopSimulation();
myRobot.delete();
