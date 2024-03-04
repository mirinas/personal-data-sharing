package main.exceptions;

import org.hyperledger.fabric.shim.ChaincodeException;

public class ChaincodeError extends ChaincodeException {

  public ChaincodeError(String message) {
    super(message);
  }

  @Override
  public synchronized Throwable fillInStackTrace() {
    return this;
  }
}
