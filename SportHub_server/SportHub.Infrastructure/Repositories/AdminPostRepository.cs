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

        public async Task<IEnumerable<AdminPost>> GetAdminPostsByCategoryIdAsync(int id)
        {
            return await _context.AdminPosts.Where(u => u.CategoryId.Equals(id)).ToListAsync();
        }
    }
}
