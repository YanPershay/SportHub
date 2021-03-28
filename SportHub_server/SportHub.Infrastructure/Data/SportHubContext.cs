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
        public DbSet<Post> Posts { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<User>()
            .HasOne(a => a.UserInfo)
            .WithOne(a => a.User)
            .HasPrincipalKey<User>(x => x.GuidId)
            .HasForeignKey<UserInfo>(c => c.UserId).IsRequired();

            modelBuilder.Entity<User>()
            .HasMany(a => a.Posts)
            .WithOne(a => a.User)
            .HasPrincipalKey(x => x.GuidId)
            .HasForeignKey(c => c.UserId).IsRequired();
        }
    }
}
