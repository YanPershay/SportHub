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
    public class AdminPostRepository : Repository<AdminPost>, IAdminPostRepository
    {
        public AdminPostRepository(SportHubContext context) : base(context)
        {

        }

        public async Task<IEnumerable<AdminPost>> GetAdminPostsAsync()
        {
            return await _context.AdminPosts.Include(p => p.User).OrderByDescending(p => p.DateCreated).ToListAsync();
        }
    }
}
