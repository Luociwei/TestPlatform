/*
** Lua binding: RPCLua
** Generated automatically by tolua++-1.0.92 on Fri Sep  3 00:01:50 2021.
*/

#ifndef __cplusplus
#include "stdlib.h"
#endif
#include "string.h"

#include "tolua++.h"

/* Exported function */
TOLUA_API int  tolua_RPCLua_open (lua_State* tolua_S);

#include "RPC.h"

/* function to release collected object via destructor */
#ifdef __cplusplus

static int tolua_collect_RPC (lua_State* tolua_S)
{
 RPC* self = (RPC*) tolua_tousertype(tolua_S,1,0);
	Mtolua_delete(self);
	return 0;
}
#endif


/* function to register type */
static void tolua_reg_types (lua_State* tolua_S)
{
 tolua_usertype(tolua_S,"RPC");
}

/* method: new of class  RPC */
#ifndef TOLUA_DISABLE_tolua_RPCLua_RPC_new00
static int tolua_RPCLua_RPC_new00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"RPC",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  {
   RPC* tolua_ret = (RPC*)  Mtolua_new((RPC)());
    tolua_pushusertype(tolua_S,(void*)tolua_ret,"RPC");
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

/* method: new_local of class  RPC */
#ifndef TOLUA_DISABLE_tolua_RPCLua_RPC_new00_local
static int tolua_RPCLua_RPC_new00_local(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"RPC",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  {
   RPC* tolua_ret = (RPC*)  Mtolua_new((RPC)());
    tolua_pushusertype(tolua_S,(void*)tolua_ret,"RPC");
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

/* method: Connect of class  RPC */
#ifndef TOLUA_DISABLE_tolua_RPCLua_RPC_Connect00
static int tolua_RPCLua_RPC_Connect00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"RPC",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  RPC* self = (RPC*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'Connect'", NULL);
#endif
  {
   int tolua_ret = (int)  self->Connect();
   tolua_pushnumber(tolua_S,(lua_Number)tolua_ret);
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'Connect'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: FixtureWrite of class  RPC */
#ifndef TOLUA_DISABLE_tolua_RPCLua_RPC_FixtureWrite00
static int tolua_RPCLua_RPC_FixtureWrite00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"RPC",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  RPC* self = (RPC*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'FixtureWrite'", NULL);
#endif
  {
   int tolua_ret = (int)  self->FixtureWrite();
   tolua_pushnumber(tolua_S,(lua_Number)tolua_ret);
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'FixtureWrite'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: FixtureRead of class  RPC */
#ifndef TOLUA_DISABLE_tolua_RPCLua_RPC_FixtureRead00
static int tolua_RPCLua_RPC_FixtureRead00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"RPC",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  RPC* self = (RPC*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'FixtureRead'", NULL);
#endif
  {
   const char* tolua_ret = (const char*)  self->FixtureRead();
   tolua_pushstring(tolua_S,(const char*)tolua_ret);
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'FixtureRead'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: DutWrite of class  RPC */
#ifndef TOLUA_DISABLE_tolua_RPCLua_RPC_DutWrite00
static int tolua_RPCLua_RPC_DutWrite00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"RPC",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  RPC* self = (RPC*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'DutWrite'", NULL);
#endif
  {
   int tolua_ret = (int)  self->DutWrite();
   tolua_pushnumber(tolua_S,(lua_Number)tolua_ret);
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'DutWrite'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: DutRead of class  RPC */
#ifndef TOLUA_DISABLE_tolua_RPCLua_RPC_DutRead00
static int tolua_RPCLua_RPC_DutRead00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"RPC",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  RPC* self = (RPC*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'DutRead'", NULL);
#endif
  {
   const char* tolua_ret = (const char*)  self->DutRead();
   tolua_pushstring(tolua_S,(const char*)tolua_ret);
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'DutRead'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* get function: a of class  RPC */
#ifndef TOLUA_DISABLE_tolua_get_RPC_a
static int tolua_get_RPC_a(lua_State* tolua_S)
{
  RPC* self = (RPC*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in accessing variable 'a'",NULL);
#endif
  tolua_pushnumber(tolua_S,(lua_Number)self->a);
 return 1;
}
#endif //#ifndef TOLUA_DISABLE

/* set function: a of class  RPC */
#ifndef TOLUA_DISABLE_tolua_set_RPC_a
static int tolua_set_RPC_a(lua_State* tolua_S)
{
  RPC* self = (RPC*)  tolua_tousertype(tolua_S,1,0);
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

/* method: Get of class  RPC */
#ifndef TOLUA_DISABLE_tolua_RPCLua_RPC_Get00
static int tolua_RPCLua_RPC_Get00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"RPC",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  RPC* self = (RPC*)  tolua_tousertype(tolua_S,1,0);
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

/* method: Get1 of class  RPC */
#ifndef TOLUA_DISABLE_tolua_RPCLua_RPC_Get100
static int tolua_RPCLua_RPC_Get100(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"RPC",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  RPC* self = (RPC*)  tolua_tousertype(tolua_S,1,0);
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
TOLUA_API int tolua_RPCLua_open (lua_State* tolua_S)
{
 tolua_open(tolua_S);
 tolua_reg_types(tolua_S);
 tolua_module(tolua_S,NULL,0);
 tolua_beginmodule(tolua_S,NULL);
  #ifdef __cplusplus
  tolua_cclass(tolua_S,"RPC","RPC","",tolua_collect_RPC);
  #else
  tolua_cclass(tolua_S,"RPC","RPC","",NULL);
  #endif
  tolua_beginmodule(tolua_S,"RPC");
   tolua_function(tolua_S,"new",tolua_RPCLua_RPC_new00);
   tolua_function(tolua_S,"new_local",tolua_RPCLua_RPC_new00_local);
   tolua_function(tolua_S,".call",tolua_RPCLua_RPC_new00_local);
   tolua_function(tolua_S,"Connect",tolua_RPCLua_RPC_Connect00);
   tolua_function(tolua_S,"FixtureWrite",tolua_RPCLua_RPC_FixtureWrite00);
   tolua_function(tolua_S,"FixtureRead",tolua_RPCLua_RPC_FixtureRead00);
   tolua_function(tolua_S,"DutWrite",tolua_RPCLua_RPC_DutWrite00);
   tolua_function(tolua_S,"DutRead",tolua_RPCLua_RPC_DutRead00);
   tolua_variable(tolua_S,"a",tolua_get_RPC_a,tolua_set_RPC_a);
   tolua_function(tolua_S,"Get",tolua_RPCLua_RPC_Get00);
   tolua_function(tolua_S,"Get1",tolua_RPCLua_RPC_Get100);
  tolua_endmodule(tolua_S);
 tolua_endmodule(tolua_S);
 return 1;
}


#if defined(LUA_VERSION_NUM) && LUA_VERSION_NUM >= 501
 TOLUA_API int luaopen_RPCLua (lua_State* tolua_S) {
 return tolua_RPCLua_open(tolua_S);
};
#endif

