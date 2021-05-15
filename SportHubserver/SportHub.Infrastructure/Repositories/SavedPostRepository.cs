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
    public class SavedPostRepository : Repository<SavedPost>, ISavedPostRepository
    {
        public SavedPostRepository(SportHubContext context) : base(context)
        {

        }

        public async Task<IEnumerable<SavedPost>> GetSavedPostsByUserIdAsync(Guid userId)
        {
            return await _context.SavedPosts.Where(s => s.UserId.Equals(userId)).ToListAsync();
        }
    }
}
