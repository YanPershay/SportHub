using SportHub.Core.Entities;
using SportHub.Core.Repositories.Base;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SportHub.Core.Repositories
{
    public interface IUserRepository : IRepository<User>
    {
        Task<User> GetUserByGuidAsync(Guid id);
        Task<IEnumerable<User>> SearchUserAsync(string searchString);
    }
}
