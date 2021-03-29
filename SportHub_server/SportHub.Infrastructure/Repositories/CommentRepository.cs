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
    public class CommentRepository : Repository<Comment>, ICommentRepository
    {
        public CommentRepository(SportHubContext context) : base(context)
        {

        }

        public async Task<IEnumerable<Comment>> GetCommentsByPostIdAsync(int id)
        {
            return await _context.Comments.Where(c => c.PostId == id).ToListAsync();
        }
    }
}
