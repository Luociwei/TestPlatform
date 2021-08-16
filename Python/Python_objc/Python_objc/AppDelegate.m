//
//  AppDelegate.m
//  Python_objc
//
//  Created by RyanGao on 2020/6/11.
//  Copyright © 2020 RyanGao. All rights reserved.
//

#import "AppDelegate.h"


@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSString *logPath = @"";
    char *s = logPath.UTF8String;
    NSString *settingListPath= [[NSBundle mainBundle] pathForResource:@"SettingList.plist" ofType:nil];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:settingListPath];
    NSString *python_path = @"";
    BOOL isPython3 = [dic[@"isPython3"] boolValue];
    if (isPython3) {
        python_path =dic[@"which python3"];
    }else{
        python_path =dic[@"which python2"];
    }
    char *pyPath =(char *)python_path.UTF8String;
    Py_SetProgramName(pyPath);
    
//       char pyPath[] ="/usr/bin/python3";
//       Py_SetProgramName(pyPath);
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
       myModule = PyImport_Import(PyString_FromString("MyModule"));
    
}


- (void)applicationWillTerminate:(NSNotification *)aNotification
{
    
}

- (IBAction)btPythonTest:(id)sender
{
    PyObject *my_func = PyObject_GetAttrString(myModule, "my_func");
    if (my_func && PyCallable_Check(my_func)){
        PyObject *result = PyObject_CallObject(my_func, NULL);
        if(result != NULL){
            NSLog(@"Result 1 of call: %s", PyString_AsString(result));
        }
    }
    
    
    PyObject *arglist;
    arglist = Py_BuildValue("ii", 10,20);  //传递参数为什么是两个 ii，请参考    OC调用python.pdf 文档
    PyObject *my_func2 = PyObject_GetAttrString(myModule, "my_func2");
    if (my_func2 && PyCallable_Check(my_func2))
    {
        PyObject *result = PyObject_CallObject(my_func2, arglist);
        if(result != NULL){
            NSLog(@"Result 2 of call: %s", PyString_AsString(result));
        }
    }
    
    
    
    PyObject *arglistStr;
    arglistStr = Py_BuildValue("ssss", "suncode","shenzhen","zhongshan","zhuhai");
    PyObject *my_func3 = PyObject_GetAttrString(myModule, "my_func3");
    if (my_func3 && PyCallable_Check(my_func3))
    {
        PyObject *result = PyObject_CallObject(my_func3, arglistStr);
        if(result != NULL){
            NSLog(@"Result 3 of call: %s", PyString_AsString(result));
        }
    }
    
}


@end
