using DJSCaseMgmtModel.Entities;
using DJSCaseMgmtModel.ViewModels;
using DJSCaseMgtService.Models;
using DJSCaseMgtService.oAuth;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.Owin.Security;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Security.Principal;
using System.Threading.Tasks;
using System.Web;

namespace DJSCaseMgtService.oAuth
{


    //public static string FindFirstValue(this ClaimsIdentity identity, string claimType);
    //public static string GetUserId(this IIdentity identity);
    //public static string GetUserName(this IIdentity identity);
    


public class AuthRepository : IDisposable
    {
        private AuthContext _ctx;

        private UserManager<IdentityUser> _userManager;
    


    public AuthRepository()
        {
            _ctx = new AuthContext();
            _userManager = new UserManager<IdentityUser>(new UserStore<IdentityUser>(_ctx));
        }

        public async Task<IdentityResult> RegisterUser(UserModel LoginModel)
        {
           
                IdentityUser user = new IdentityUser
                {
                    UserName = LoginModel.UserName
                };


                var result = await _userManager.CreateAsync(user, LoginModel.Password.ToString());

            if (result.Succeeded)
            {
                var currentUser = _userManager.FindByName(user.UserName);

                var roleresult = _userManager.AddToRole(currentUser.Id, LoginModel.UserRole);


            }
            if (!result.Succeeded)
            {

                var tr = LoginModel.UserName;
            }

            return result;
            
           
           
        }

        //public async Task<IList<string>> UserRoles(string userId)
        //{
        //    IList<string> roles = await _userManager.GetRolesAsync(userId);
        //    Console.WriteLine(roles);
        //    return roles;




        //}



    public static class UserDetails
        {
            public static IdentityUser role = null;
        }
        public async Task<IdentityUser> FindUser(string userName, string password)
        {
            
            IdentityUser user = await _userManager.FindAsync(userName, password);

            UserDetails.role = user;

            return user;
        }

        //public IList<string> GetCurrentUser()
        //{

        //    var userRoleIds = (from r in currentUser.Roles select r.RoleId);

        //    serRoles = (from id in userRoleIds
        //                let r = roleManager.FindById(id)
        //                select r.Name).ToList();


        //    return result;

            
        //}

        public Client FindClient(string clientId)
        {
            var client = _ctx.Client.Find(clientId);

            return client;
        }

        public async Task<bool> AddRefreshToken(RefreshToken token)
        {
            
           var existingToken = _ctx.RefreshTokens.Where(r => r.Subject == token.Subject && r.ClientId == token.ClientId).SingleOrDefault();

           if (existingToken != null)
           {
             var result = await RemoveRefreshToken(existingToken);
           }
          
            _ctx.RefreshTokens.Add(token);

            return await _ctx.SaveChangesAsync() > 0;
        }

        public async Task<bool> RemoveRefreshToken(string refreshTokenId)
        {
           var refreshToken = await _ctx.RefreshTokens.FindAsync(refreshTokenId);

           if (refreshToken != null) {
               _ctx.RefreshTokens.Remove(refreshToken);
               return await _ctx.SaveChangesAsync() > 0;
           }

           return false;
        }

        public async Task<bool> RemoveRefreshToken(RefreshToken refreshToken)
        {
            _ctx.RefreshTokens.Remove(refreshToken);
             return await _ctx.SaveChangesAsync() > 0;
        }

        public async Task<RefreshToken> FindRefreshToken(string refreshTokenId)
        {
            var refreshToken = await _ctx.RefreshTokens.FindAsync(refreshTokenId);

            return refreshToken;
        }

        public List<RefreshToken> GetAllRefreshTokens()
        {
             return  _ctx.RefreshTokens.ToList();
        }

        public async Task<IdentityUser> FindAsync(UserLoginInfo loginInfo)
        {
            IdentityUser user = await _userManager.FindAsync(loginInfo);

            return user;
        }

        public async Task<IdentityResult> CreateAsync(IdentityUser user)
        {
            var result = await _userManager.CreateAsync(user);

            return result;
        }

        public async Task<IdentityResult> AddLoginAsync(string userId, UserLoginInfo login)
        {
            var result = await _userManager.AddLoginAsync(userId, login);

            return result;
        }

        public void Dispose()
        {
            _ctx.Dispose();
            _userManager.Dispose();

        }
    }
}