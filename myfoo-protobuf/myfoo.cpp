//
// protoc -I=./ --cpp_out=./myfoo.h myfoo.proto

#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <iostream>
#include <libxml/xmlreader.h>
#include <google/protobuf/message.h>
#include <myfoo.h>

namespace google::protobuf
{
std::string data;  // Will store a serialized version of the message.

void add(){
  // Create a message and serialize it.
  Foo foo;
  foo.set_text("Hello World!");
  foo.add_numbers(1);
  foo.add_numbers(5);
  foo.add_numbers(42);

  foo.SerializeToString(&data);
}

void serialize(){
  // Parse the serialized message and check that it contains the
  // correct data.
  Foo foo;
  foo.ParseFromString(data);

  assert(foo.text() == "Hello World!");
  assert(foo.numbers_size() == 3);
  assert(foo.numbers(0) == 1);
  assert(foo.numbers(1) == 5);
  assert(foo.numbers(2) == 42);
}

void  main(){
  // Same as the last block, but do it dynamically via the Message
  // reflection interface.
  Message* foo = new Foo;
  const Descriptor* descriptor = foo->GetDescriptor();

  // Get the descriptors for the fields we're interested in and verify
  // their types.
  const FieldDescriptor* text_field = descriptor->FindFieldByName("text");
  assert(text_field != nullptr);
  assert(text_field->type() == FieldDescriptor::TYPE_STRING);
  assert(text_field->label() == FieldDescriptor::LABEL_OPTIONAL);
  const FieldDescriptor* numbers_field = descriptor->
                                         FindFieldByName("numbers");
  assert(numbers_field != nullptr);
  assert(numbers_field->type() == FieldDescriptor::TYPE_INT32);
  assert(numbers_field->label() == FieldDescriptor::LABEL_REPEATED);

  // Parse the message.
  foo->ParseFromString(data);

  // Use the reflection interface to examine the contents.
  const Reflection* reflection = foo->GetReflection();
  assert(reflection->GetString(*foo, text_field) == "Hello World!");
  assert(reflection->FieldSize(*foo, numbers_field) == 3);
  assert(reflection->GetRepeatedInt32(*foo, numbers_field, 0) == 1);
  assert(reflection->GetRepeatedInt32(*foo, numbers_field, 1) == 5);
  assert(reflection->GetRepeatedInt32(*foo, numbers_field, 2) == 42);

  delete foo;
}
}