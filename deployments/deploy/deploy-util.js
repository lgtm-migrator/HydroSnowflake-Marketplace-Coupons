
const Logger = require('../logging/logger');

class DeployUtil {

  constructor(logSetting = Logger.state.NORMAL) {
    this.log = new Logger(logSetting);
  }

  //Function which takes solc compiled output, a contract name to extract, and returns a convenience object
  //  this returned object contains name, abi, bytecode, and the raw solc output
  extractContract(output, name){

    //Find all raw contract output
    let raw;
    let isFound = false;
    //Let's just hang onto the reference of the filename as well...
    let sol;
    for(let solFile in output.contracts) {
      this.log.print(Logger.state.SUPER, "Looking over " + solFile + "...");
      for(let c in output.contracts[solFile]) {
        console.log("    " + c);
        if(c === name) { 
          raw = output.contracts[solFile][c];
          sol = solFile;
          isFound = true;
          this.log.print(Logger.state.SUPER, "Found contract!!!");
        }
      }
    }
    //If we failed to find any contract, throw:
    if(!isFound) throw "Contract \"" + name + "\" not found within compiled output.";
    
    const contract = {
      "name": name,
      get abi() { return this.raw.abi; },
      get bytecode() { return this.raw.evm.bytecode.object; },
      get metadata() { return JSON.parse(this.raw.metadata); }, //the metadata object is just a string, so let's parse for convenience...
      get compilerVersion() { return this.metadata.compiler.version; },
      get optimizer() { return this.metadata.settings.optimizer; },
      "raw": raw,
      "solFile": sol
    }

    return contract;
  }



}



module.exports = DeployUtil;
