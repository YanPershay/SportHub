using Microsoft.EntityFrameworkCore;
using SportHub.Core.Entities;
using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Infrastructure.Data
{
    public class SportHubContext : DbContext
    {
        public SportHubContext(DbContextOptions<SportHubContext> options) : base(options)
        {

        }

        public DbSet<User> Users { get; set; }
    }
}
