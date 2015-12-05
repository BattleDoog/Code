package com.qualcomm.ftcrobotcontroller.opmodes;

import com.qualcomm.robotcore.hardware.DcMotor;
import com.qualcomm.robotcore.hardware.HardwareMap;

/**
 * Created by BHS on 12/4/2015.
 */
public class PID {
    public DcMotor leftMotor;
    public DcMotor rightMotor;

    private final String LEFT_MOTOR_NAME = "backLeft";
    private final String RIGHT_MOTOR_NAME = "backRight";

    private DcMotor slaveMotor;
    private DcMotor masterMotor;

    private int slaveStartPos = 0;
    private int masterStartPos = 0;

    public boolean isRightSlaved = true;

    public final double sensitivity = 0.1;

    private boolean isTurning = false;

    public PID(HardwareMap hardwareMap, boolean  rightSlaved){
        leftMotor = hardwareMap.dcMotor.get(LEFT_MOTOR_NAME);
        rightMotor = hardwareMap.dcMotor.get(RIGHT_MOTOR_NAME);


        if (isRightSlaved){
            slaveMotor = rightMotor;
            masterMotor = leftMotor;
        } else {
            slaveMotor = leftMotor;
            masterMotor = rightMotor;
        }
    }

    public void update() {
        int slaveEncVal = slaveEncoder();
        int masterEncVal = masterEncoder();

        if (isTurning){
            masterEncVal *= -1;
        }
        double masterSlaveRatio = masterEncVal / slaveEncVal;
        double slaveChange = (1 - masterSlaveRatio) * sensitivity;
    }

    public int slaveEncoder(){
        return slaveMotor.getCurrentPosition() - slaveStartPos;
    }

    public int masterEncoder() {
        return masterMotor.getCurrentPosition() - masterStartPos;
    }

    public void setStraight(){
        isTurning = false;

        reset();
    }

    public void setTurning(){
        isTurning = true;

        reset();
    }

    public void reset(){
        slaveStartPos = slaveMotor.getCurrentPosition();
        masterStartPos = masterMotor.getCurrentPosition();
    }

    public void setSpeeds(double leftSpeed, double rightSpeed){
        leftMotor.setPower(leftSpeed);
        rightMotor.setPower(rightSpeed);
    }
}
