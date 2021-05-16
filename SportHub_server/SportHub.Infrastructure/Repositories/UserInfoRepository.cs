using Microsoft.EntityFrameworkCore;
using SportHub.Core.Entities;
using SportHub.Core.Repositories;
using SportHub.Infrastructure.Data;
using SportHub.Infrastructure.Repositories.Base;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace SportHub.Infrastructure.Repositories
{
    public class UserInfoRepository : Repository<UserInfo>, IUserInfoRepository
    {
        public UserInfoRepository(SportHubContext context) : base(context)
        {

        }

        public async Task<UserInfo> GetUserInfoByGuidAsync(Guid id)
        {
            var userInfo = await _context.UsersInfo.FirstOrDefaultAsync(u => u.UserId.Equals(id));
            _context.Entry(userInfo).State = EntityState.Detached;
            return userInfo;
        }
    }
}
