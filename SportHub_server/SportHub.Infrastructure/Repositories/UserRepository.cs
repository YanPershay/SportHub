using Microsoft.EntityFrameworkCore;
using SportHub.Core.Entities;
using SportHub.Core.Repositories;
using SportHub.Infrastructure.Data;
using SportHub.Infrastructure.Repositories.Base;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SportHub.Infrastructure.Repositories
{
    public class UserRepository : Repository<User>, IUserRepository
    {
        public UserRepository(SportHubContext context) : base(context)
        {

        }

        public async Task<User> GetUserByGuidAsync(Guid id)
        {
            return await _context.Users.Include(nameof(UserInfo)).FirstOrDefaultAsync(u => u.GuidId.Equals(id));
        }

        public async Task<bool> IsUsernameBusy(string username)
        {
            return await _context.Users.AnyAsync(u => u.Username.Equals(username));
        }

        public async Task<IEnumerable<User>> SearchUserAsync(string searchString)
        {
            var split = searchString.Split();

            var resultUsers = new List<User>();

            foreach(var str in split)
            {
                var result = await _context.Users.Include(u => u.UserInfo)
                .Where(u => u.Username.Contains(str) || u.UserInfo.FirstName.Contains(str) || u.UserInfo.LastName.Contains(str)).ToListAsync();

                resultUsers.AddRange(result);
            }

            return resultUsers.Distinct();
        }
    }
}
