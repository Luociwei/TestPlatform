//
//  AppDelegate.m
//  Python_objc
//
//  Created by RyanGao on 2020/6/11.
//  Copyright © 2020 RyanGao. All rights reserved.

//'/Library/Frameworks/Python.framework/Versions/3.8/lib/python3.8/site-packages']

#import "AppDelegate.h"


@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    char pyPath[] ="/usr/bin/python3";
     Py_SetProgramName(pyPath);
     if (Py_IsInitialized())
     return;
     
     Py_Initialize();
     NSLog(@"PyInit");
     const char *pypath = [[[NSBundle mainBundle] resourcePath] UTF8String];
     
     
     
     // import sys 导入头文件
     PyObject *sys = PyImport_Import(PyString_FromString("sys"));
     
     // sys.path.append(resourcePath)
     PyObject *sys_path_append = PyObject_GetAttrString(PyObject_GetAttrString(sys, "path"), "append");
     
     PyObject *resourcePath = PyTuple_New(1);
     PyTuple_SetItem(resourcePath, 0, PyString_FromString(pypath));
     PyObject_CallObject(sys_path_append, resourcePath);
     // import MyModule   # this is in my project folder
     // myModule = PyImport_Import(PyString_FromString("MyModule"));
     
     
     
     // ********keynote***********
     KeynoteModule = PyImport_Import(PyString_FromString("generate_keynote"));
     
     
    
    
}


- (void)applicationWillTerminate:(NSNotification *)aNotification
{
    
}

- (IBAction)btPythonTest:(id)sender
{
    /*PyObject *my_func = PyObject_GetAttrString(KeynoteModule, "my_func");
    if (my_func && PyCallable_Check(my_func)){
        PyObject *result = PyObject_CallObject(my_func, NULL);
        if(result != NULL){
            NSLog(@"Result 1 of call: %s", PyString_AsString(result));
        }
    }
    
    
    PyObject *arglist;
    arglist = Py_BuildValue("ii", 10,20);  //传递参数为什么是两个 ii，请参考    OC调用python.pdf 文档
    PyObject *my_func2 = PyObject_GetAttrString(KeynoteModule, "my_func2");
    if (my_func2 && PyCallable_Check(my_func2))
    {
        PyObject *result = PyObject_CallObject(my_func2, arglist);
        if(result != NULL){
            NSLog(@"Result 2 of call: %s", PyString_AsString(result));
        }
    }
    
    PyObject *arglistStr;
    arglistStr = Py_BuildValue("ssss", "suncode","shenzhen","zhongshan","zhuhai");
    PyObject *my_func3 = PyObject_GetAttrString(KeynoteModule, "my_func3");
    if (my_func3 && PyCallable_Check(my_func3))
    {
        PyObject *result = PyObject_CallObject(my_func3, arglistStr);
        if(result != NULL){
            NSLog(@"Result 3 of call: %s", PyString_AsString(result));
        }
    }
    */
}


- (IBAction)btKeynote:(id)sender
{
    NSLog(@"====keynote");
    NSString *path = [[NSBundle mainBundle] resourcePath];
    [self InvokingPythonScriptAtPath:path];
}

-(id) InvokingPythonScriptAtPath :(NSString*)pyScriptPath
{
    NSTask *shellTask = [[NSTask alloc]init];
    [shellTask setLaunchPath:@"/Library/Frameworks/Python.framework/Versions/3.8/bin/python3"];
    NSString *pyStr =[NSString stringWithFormat:@"%@/generate_keynote.py",[NSString stringWithFormat:@"%@",pyScriptPath]];

    [shellTask setArguments:[NSArray arrayWithObjects:pyStr, nil]];

    NSPipe *pipe = [[NSPipe alloc]init];
    [shellTask setStandardOutput:pipe];

    [shellTask launch];
    
    NSFileHandle *file = [pipe fileHandleForReading];
    NSData *data =[file readDataToEndOfFile];
    NSString *strReturnFromPython = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"The return content from python script is: %@",strReturnFromPython);
    return strReturnFromPython;

}

@end
