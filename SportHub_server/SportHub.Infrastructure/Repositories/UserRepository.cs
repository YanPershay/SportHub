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
            return await _context.Users.FirstOrDefaultAsync(u => u.GuidId.Equals(id));
        } 
    }
}
