/*
** Lua binding: tClassLua
** Generated automatically by tolua++-1.0.92 on Thu Mar  4 00:50:47 2021.
*/

#ifndef __cplusplus
#include "stdlib.h"
#endif
#include "string.h"

#include "tolua++.h"

/* Exported function */
TOLUA_API int  tolua_tClassLua_open (lua_State* tolua_S);

#include "tClass.h"

/* function to release collected object via destructor */
#ifdef __cplusplus

static int tolua_collect_Aclass (lua_State* tolua_S)
{
 Aclass* self = (Aclass*) tolua_tousertype(tolua_S,1,0);
	Mtolua_delete(self);
	return 0;
}
#endif


/* function to register type */
static void tolua_reg_types (lua_State* tolua_S)
{
 tolua_usertype(tolua_S,"Aclass");
}

/* get function: a of class  Aclass */
#ifndef TOLUA_DISABLE_tolua_get_Aclass_a
static int tolua_get_Aclass_a(lua_State* tolua_S)
{
  Aclass* self = (Aclass*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in accessing variable 'a'",NULL);
#endif
  tolua_pushnumber(tolua_S,(lua_Number)self->a);
 return 1;
}
#endif //#ifndef TOLUA_DISABLE

/* set function: a of class  Aclass */
#ifndef TOLUA_DISABLE_tolua_set_Aclass_a
static int tolua_set_Aclass_a(lua_State* tolua_S)
{
  Aclass* self = (Aclass*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  tolua_Error tolua_err;
  if (!self) tolua_error(tolua_S,"invalid 'self' in accessing variable 'a'",NULL);
  if (!tolua_isnumber(tolua_S,2,0,&tolua_err))
   tolua_error(tolua_S,"#vinvalid type in variable assignment.",&tolua_err);
#endif
  self->a = ((int)  tolua_tonumber(tolua_S,2,0))
;
 return 0;
}
#endif //#ifndef TOLUA_DISABLE

/* method: new of class  Aclass */
#ifndef TOLUA_DISABLE_tolua_tClassLua_Aclass_new00
static int tolua_tClassLua_Aclass_new00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"Aclass",0,&tolua_err) ||
     !tolua_isnumber(tolua_S,2,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,3,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  int nTemp = ((int)  tolua_tonumber(tolua_S,2,0));
  {
   Aclass* tolua_ret = (Aclass*)  Mtolua_new((Aclass)(nTemp));
    tolua_pushusertype(tolua_S,(void*)tolua_ret,"Aclass");
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'new'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: new_local of class  Aclass */
#ifndef TOLUA_DISABLE_tolua_tClassLua_Aclass_new00_local
static int tolua_tClassLua_Aclass_new00_local(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"Aclass",0,&tolua_err) ||
     !tolua_isnumber(tolua_S,2,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,3,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  int nTemp = ((int)  tolua_tonumber(tolua_S,2,0));
  {
   Aclass* tolua_ret = (Aclass*)  Mtolua_new((Aclass)(nTemp));
    tolua_pushusertype(tolua_S,(void*)tolua_ret,"Aclass");
    tolua_register_gc(tolua_S,lua_gettop(tolua_S));
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'new'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: Get of class  Aclass */
#ifndef TOLUA_DISABLE_tolua_tClassLua_Aclass_Get00
static int tolua_tClassLua_Aclass_Get00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"Aclass",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  Aclass* self = (Aclass*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'Get'", NULL);
#endif
  {
   int tolua_ret = (int)  self->Get();
   tolua_pushnumber(tolua_S,(lua_Number)tolua_ret);
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'Get'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: Get1 of class  Aclass */
#ifndef TOLUA_DISABLE_tolua_tClassLua_Aclass_Get100
static int tolua_tClassLua_Aclass_Get100(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"Aclass",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  Aclass* self = (Aclass*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'Get1'", NULL);
#endif
  {
   int tolua_ret = (int)  self->Get1();
   tolua_pushnumber(tolua_S,(lua_Number)tolua_ret);
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'Get1'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* Open function */
TOLUA_API int tolua_tClassLua_open (lua_State* tolua_S)
{
 tolua_open(tolua_S);
 tolua_reg_types(tolua_S);
 tolua_module(tolua_S,NULL,0);
 tolua_beginmodule(tolua_S,NULL);
  #ifdef __cplusplus
  tolua_cclass(tolua_S,"Aclass","Aclass","",tolua_collect_Aclass);
  #else
  tolua_cclass(tolua_S,"Aclass","Aclass","",NULL);
  #endif
  tolua_beginmodule(tolua_S,"Aclass");
   tolua_variable(tolua_S,"a",tolua_get_Aclass_a,tolua_set_Aclass_a);
   tolua_function(tolua_S,"new",tolua_tClassLua_Aclass_new00);
   tolua_function(tolua_S,"new_local",tolua_tClassLua_Aclass_new00_local);
   tolua_function(tolua_S,".call",tolua_tClassLua_Aclass_new00_local);
   tolua_function(tolua_S,"Get",tolua_tClassLua_Aclass_Get00);
   tolua_function(tolua_S,"Get1",tolua_tClassLua_Aclass_Get100);
  tolua_endmodule(tolua_S);
 tolua_endmodule(tolua_S);
 return 1;
}


#if defined(LUA_VERSION_NUM) && LUA_VERSION_NUM >= 501
 TOLUA_API int luaopen_tClassLua (lua_State* tolua_S) {
 return tolua_tClassLua_open(tolua_S);
};
#endif

