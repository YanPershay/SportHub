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
        public DbSet<UserInfo> UsersInfo { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<User>()
            .HasOne(a => a.UserInfo)
            .WithOne(a => a.User)
            .HasPrincipalKey<User>(x => x.GuidId)
            .HasForeignKey<UserInfo>(c => c.UserId).IsRequired();
        }
    }
}
