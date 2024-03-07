//===- Flattening.cpp - Flattening Obfuscation pass------------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file implements the flattening pass
//
//===----------------------------------------------------------------------===//

#include "llvm/Transforms/Obfuscation/Flattening.h"
#include "llvm/Transforms/Scalar.h"
#include "llvm/CryptoUtils.h"

#define DEBUG_TYPE "flattening"

using namespace llvm;

// Stats
STATISTIC(Flattened, "Functions flattened");

namespace {
struct Flattening : public FunctionPass {
  static char ID;  // Pass identification, replacement for typeid
  bool flag;

  Flattening() : FunctionPass(ID) {}
  Flattening(bool flag) : FunctionPass(ID) { this->flag = flag; }

  bool runOnFunction(Function &F);
  bool flatten(Function *f);
};
}

char Flattening::ID = 0;
static RegisterPass<Flattening> X("flattening", "Call graph flattening");
Pass *llvm::createFlattening(bool flag) { return new Flattening(flag); }

bool Flattening::runOnFunction(Function &F) {
  Function *tmp = &F;
  // Do we obfuscate
  if (toObfuscate(flag, tmp, "fla")) {
    if (flatten(tmp)) {
      ++Flattened;
    }
  }

  return false;
}

bool Flattening::flatten(Function *f) {
  vector<BasicBlock *> origBB;
  BasicBlock *loopEntry;
  BasicBlock *loopEnd;
  LoadInst *load;
  SwitchInst *switchI;
  AllocaInst *switchVar;

  // SCRAMBLER
  //从加密随机数池中获取16字节作为密钥
  char scrambling_key[16];
  llvm::cryptoutils->get_bytes(scrambling_key, 16);
  // END OF SCRAMBLER

  // Lower switch
  //将Switch语句转化为if-else语句
  FunctionPass *lower = createLowerSwitchPass();
  lower->runOnFunction(*f);

  // Save all original BB
  //保存原来的基本块
  for (Function::iterator i = f->begin(); i != f->end(); ++i) {
    BasicBlock *tmp = &*i;
    origBB.push_back(tmp);

    BasicBlock *bb = &*i;
    //检查当前基本块的终止指令是否是Invoke指令
    if (isa<InvokeInst>(bb->getTerminator())) {
      return false;
    }
  }

  // Nothing to flatten
  //如果基本块数量<=1没必要控制流扁平化
  if (origBB.size() <= 1) {
    return false;
  }

  // Remove first BB
  //移除首块
  origBB.erase(origBB.begin());

  // Get a pointer on the first BB
  Function::iterator tmp = f->begin();  //++tmp;
  BasicBlock *insert = &*tmp;
  // insert指向第一个基本块即入口基本块
  // 
  // If main begin with an if
  //检查函数中第一个基本块的终止指令是否为条件分支指令（BranchInst），

  BranchInst *br = NULL;
  if (isa<BranchInst>(insert->getTerminator())) {
    br = cast<BranchInst>(insert->getTerminator());
  }
  // 如果是，则将第一个基本块拆分成两个基本块，并将新生成的基本块插入到函数的原始基本块列表中。
  //如果br指针不为NULL且条件分支指令是有条件的，或者终止指令的后继基本块数量大于1，则执行以下操作
  if ((br != NULL && br->isConditional()) ||
      insert->getTerminator()->getNumSuccessors() > 1) {
    BasicBlock::iterator i = insert->end();
	--i;
    //获取当前基本块的最后一个指令的迭代器，并向前移动一位。
    if (insert->size() > 1) {
      --i;
    }
    //如果当前基本块中的指令数量大于1，则再向前移动一位。这是因为在LLVM中，基本块的最后一条指令通常是终止指令（如分支或返回指令）。
    BasicBlock *tmpBB = insert->splitBasicBlock(i, "first");
    origBB.insert(origBB.begin(), tmpBB);
    //将当前基本块从迭代器i处分割成两个基本块，新生成的基本块名为"first"，并将指向新生成的基本块的指针保存到tmpBB中。
  }

  // Remove jump
  //删除insert块的跳转指令，insert为入口块
  insert->getTerminator()->eraseFromParent();

  // Create switch variable and set as it
  //在当前基本块中创建一个新的整数类型的局部变量，然后将一个经过加密或混淆的整数值存储到这个变量中，这个整数值将作为一个switch语句的控制变量。
  switchVar =
      new AllocaInst(Type::getInt32Ty(f->getContext()), 0, "switchVar", insert);
  //将这个switch语句的控制变量插入到insert块中
  new StoreInst(
      ConstantInt::get(Type::getInt32Ty(f->getContext()),
                       llvm::cryptoutils->scramble32(0, scrambling_key)),
      switchVar, insert);

  // Create main loop
  //loopEntry为主循环的入口点，被插入到insert前
  loopEntry = BasicBlock::Create(f->getContext(), "loopEntry", f, insert);
  //loopEnd为主循环基本块结束后的结束点，被插入到insert前
  loopEnd = BasicBlock::Create(f->getContext(), "loopEnd", f, insert);
  //将switchVar的值插入到loopEntry中
  load = new LoadInst(switchVar, "switchVar", loopEntry);

  // Move first BB on top
  //将insert基本块移动到loopEntry之前
  insert->moveBefore(loopEntry);
  //添加无条件分支连接insert到loopEntry
  BranchInst::Create(loopEntry, insert);

  // loopEnd jump to loopEntry
  //添加无条件分支连接loopEnd到loopEntry
  BranchInst::Create(loopEntry, loopEnd);

  //创建一个switch默认情况连接swDefault到loopEnd
  BasicBlock *swDefault =
      BasicBlock::Create(f->getContext(), "switchDefault", f, loopEnd);
  BranchInst::Create(loopEnd, swDefault);

  // Create switch instruction itself and set condition
  //创建一个switch语句，并设置它的条件和默认目标。
  switchI = SwitchInst::Create(&*f->begin(), swDefault, 0, loopEntry);
  //该switch语句由load的值来选择分支目标
  switchI->setCondition(load);

  // Remove branch jump from 1st BB and make a jump to the while
  //这行代码首先移除了函数的入口基本块的跳转指令，这是因为之前已经将控制流转移到了主循环的入口基本块，所以入口基本块不再需要跳转指令。
  f->begin()->getTerminator()->eraseFromParent();
  //创建了一个无条件分支连接&*f->begin()到loopEntry
  BranchInst::Create(loopEntry, &*f->begin());

  // Put all BB in the switch
  for (vector<BasicBlock *>::iterator b = origBB.begin(); b != origBB.end();
       ++b) {
    BasicBlock *i = *b;
    ConstantInt *numCase = NULL;

    // Move the BB inside the switch (only visual, no code logic)
    //将当前基本块移动到主循环结束的基本块 loopEnd 之前
    i->moveBefore(loopEnd);

    // Add case to switch
    //创建了一个整数常量作为当前基本块的case值，这个常量与scrambling_key有关
    numCase = cast<ConstantInt>(ConstantInt::get(
        switchI->getCondition()->getType(),
        llvm::cryptoutils->scramble32(switchI->getNumCases(), scrambling_key)));
    //这行代码将当前基本块作为一个case添加到了之前创建的switch语句中
    switchI->addCase(numCase, i);
  }

  // Recalculate switchVar
  for (vector<BasicBlock *>::iterator b = origBB.begin(); b != origBB.end();
       ++b) {
    BasicBlock *i = *b;
    ConstantInt *numCase = NULL;

    // Ret BB
    //检查当前基本块是否是一个返回基本块，即它没有后继基本块。如果是，就跳过这个基本块，因为返回基本块不会影响控制流的结构。
    if (i->getTerminator()->getNumSuccessors() == 0) {
      continue;
    }

    // If it's a non-conditional jump
    //这行代码检查当前基本块是否是一个非条件跳转的基本块，即它只有一个后继基本块。
    if (i->getTerminator()->getNumSuccessors() == 1) {
      // Get successor and delete terminator
      //取当前基本块的唯一后继基本块。
      BasicBlock *succ = i->getTerminator()->getSuccessor(0);
      //删除当前基本块的跳转指令
      i->getTerminator()->eraseFromParent();

      // Get next case
      //查找 switch 语句中与后继基本块 succ 对应的 case 值。
      numCase = switchI->findCaseDest(succ);

      // If next case == default case (switchDefault)
      //如果找不到对应的 case 值，即 numCase == NULL，则说明后继基本块是 switchDefault，这时就需要生成一个新的 case 值。
      if (numCase == NULL) {
        numCase = cast<ConstantInt>(
            ConstantInt::get(switchI->getCondition()->getType(),
                             llvm::cryptoutils->scramble32(
                                 switchI->getNumCases() - 1, scrambling_key)));
      }

      // Update switchVar and jump to the end of loop
      //将新的 case 值存储到 switch 语句的控制变量中，插入到当前基本块末尾。
      new StoreInst(numCase, load->getPointerOperand(), i);
      //创建一个无条件跳转指令从当前基本块跳转到 loopEnd。
      BranchInst::Create(loopEnd, i);
      continue;
    }

    // If it's a conditional jump
    //如果当前基本块的终止指令是一个条件分支指令（有两个后继基本块）
    if (i->getTerminator()->getNumSuccessors() == 2) {
      // Get next cases
      //获取条件跳转的两个后继基本块的对应 case 值。
      ConstantInt *numCaseTrue =
          switchI->findCaseDest(i->getTerminator()->getSuccessor(0));
      ConstantInt *numCaseFalse =
          switchI->findCaseDest(i->getTerminator()->getSuccessor(1));

      // Check if next case == default case (switchDefault)
      //检查每个后继基本块的 case 值是否为switchDefault。如果是，则生成一个新的 case 值。
      if (numCaseTrue == NULL) {
        numCaseTrue = cast<ConstantInt>(
            ConstantInt::get(switchI->getCondition()->getType(),
                             llvm::cryptoutils->scramble32(
                                 switchI->getNumCases() - 1, scrambling_key)));
      }
      // 检查每个后继基本块的 case 值是否为switchDefault。如果是，则生成一个新的 case 值。
      if (numCaseFalse == NULL) {
        numCaseFalse = cast<ConstantInt>(
            ConstantInt::get(switchI->getCondition()->getType(),
                             llvm::cryptoutils->scramble32(
                                 switchI->getNumCases() - 1, scrambling_key)));
      }

      // Create a SelectInst
      //使用 SelectInst 创建一个选择指令，根据条件跳转的条件选择下一个要执行的 case 值,插入到当前基本块。
      BranchInst *br = cast<BranchInst>(i->getTerminator());
      SelectInst *sel =
          SelectInst::Create(br->getCondition(), numCaseTrue, numCaseFalse, "",
                             i->getTerminator());

      // Erase terminator
      //删除当前基本块的jmp指令。
      i->getTerminator()->eraseFromParent();

      // Update switchVar and jump to the end of loop
      //将选择指令的结果存储到 switch 语句的控制变量中插入当前基本块
      new StoreInst(sel, load->getPointerOperand(), i);
      //创建一个无条件跳转指令从当前基本块跳转到 loopEnd。
      BranchInst::Create(loopEnd, i);
      continue;
    }
  }

  fixStack(f);

  return true;
}

