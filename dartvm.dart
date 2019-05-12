  // Dart Native (VM JIT and AOT)
  // Dart Native enables running Dart code compiled to native ARM or X64 machine code

  /*-----------------------------------------------------------------------------------
   Side note (ARM): 
  -----------------------------------------------------------------------------------*/
  const String whatIsArmQuestion = 'What is ARM';
  const String whatIsArmAnswer =
   """ARM is a family of reduced instruction set computing architecture for processors.
   Between ARMv3 to ARMv7 architecture
   supported only 32-bit address space, from ARMv8-A architecture ARM added support
   for a 64-bit address space.""";
  const String armMainDifferenceQuestion = 
  'What is the main difference of ARM from other CPU architectures';
  const String armMainDifferenceAnswer =
  """Main difference from other CPU architectures is that it requires fewer transistors
   that those with a complex instruction set computing architecture which improves
   cost, power consumption and heat dissipation.""";

  /*-----------------------------------------------------------------------------------
   Dart VM:
  -----------------------------------------------------------------------------------*/
  const String dartVM =
   """Dart VM is a collection of components for executing Dart code natively. It contains
   a Just-in-Time (JIT) and Ahead-of-Time (AOT) compilation pipelines. Thanks to this
   Dart VM offers multiple ways to interpret the code. Dart VM can execute the code from
   the source or Kernal binary using JIT, snapshots, AOT snapshots, or AppJIT snapshot.
   The biggest difference between these options is basically when and how Dart VM 
   converts dart source code to executable code.""";
   
  /*-----------------------------------------------------------------------------------
   How Dart VM works:
  -----------------------------------------------------------------------------------*/
  const String howDartVMworks =
   """Any Dart code in the Dart VM runs within isolation. Isolates can communicate by 
   passing messages through ports. The OS thread can only enter a single isolate at a 
   time. if it wants to enter another isolate it must leave the current. Additionally, 
   there is only one mutator thread for an isolate at a time. Beyond the mutator thread
   an isolate can also be associated with multiple helper threads, including a background
   JIT compiler thread, GC sweeper threads and even concurrent GC market threads.""";  