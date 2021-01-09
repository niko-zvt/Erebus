// ====================================================================================
// Wirth's Chainlet
// A terribly stupid implementation of a singly linked list using prehistoric Pascal.
// ====================================================================================
program WirthsChainlet;

// TYPES DECLARATION SECTION
type                      
    nodePtr = ^node;      // The pointer on combined structured data type "Node"
    node = record         // Node type
        data: integer;    // Data field
        next: nodePtr;    // Link to the next node
    end;                  // End node type declaration

// VARIABLE DECLARATION SECTION
var                       
    listPtr: nodePtr;     // Pointer to the list
    tempPtr: nodePtr;     // Temp pointer
    tempVal: integer;     // Temp variable
    testPtr: nodePtr;     // Link to test linked list

// MAIN SECTION
begin                     
  new(listPtr);           // Create a new dynamic variable and set a pointer to it
  listPtr^.data := 0;     // Data field initialization
  listPtr^.next := nil;   // Link field initialization
  
  // Directive to disable auto-checking of the result of accessing I/O
  // You must explicitly check for I/O errors with the IOResult function
  {$I-}

  // Call to start data entry
  write('Enter integers. To complete, submit "EOF" (Ctrl+D or Ctrl+Z).');

  // Infinite loop until an EOF situation is submitted for input
  while not eof do
  begin
    readln(tempVal);                // Input the next value
    if IOResult <> 0 then           // If an input error occurred
    begin
        writeln('Invalid input!');  // Reporting an error
        halt(1)                     // Exit with an error code
    end;
    
    new(tempPtr);                   // Else create a new dynamic variable
    tempPtr^.data := tempVal;       // Fill in the data field
    tempPtr^.next := listPtr;       // Bind new node to a linked list
    listPtr := tempPtr;             // Move the pointer to new start position
  end;

  // Output result list
  writeln('');
  writeln('Your list:');

  testPtr := listPtr;               // Test pointer
  while (testPtr^.next) <> nil do   // While next pointer don't equal null
  begin
    writeln(testPtr^.data);         // Output data field
    testPtr := testPtr^.next;       // Change the pointer to the next one
  end;

  // CONCLUSION
  // Of course, we could clear the dynamically allocated memory with the "dispose" function, but do we need it?
  // The program is already closing, and the OS usually fixes our flaws and returns the allocated memory.
  // But it's a bad form if to count on that.
  // And we will certainly use this to shoot ourselves in the foot!
end.