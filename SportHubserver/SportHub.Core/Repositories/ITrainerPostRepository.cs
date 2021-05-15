using SportHub.Core.Entities;
using SportHub.Core.Repositories.Base;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace SportHub.Core.Repositories
{
    public interface ITrainerPostRepository : IRepository<TrainerPost>
    {
        Task<IEnumerable<TrainerPost>> GetTrainerPostsAsync();
    }
}
