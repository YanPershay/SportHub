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
        public DbSet<PostCategory> PostCategories { get; set; }
        public DbSet<AdminPost> AdminPosts { get; set; }
        public DbSet<Comment> Comments { get; set; }
        public DbSet<Like> Likes { get; set; }

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

            modelBuilder.Entity<PostCategory>()
            .HasMany(c => c.AdminPosts)
            .WithOne(p => p.PostCategory)
            .HasForeignKey(p => p.CategoryId)
            .IsRequired();

            modelBuilder.Entity<User>()
            .HasMany(a => a.AdminPosts)
            .WithOne(a => a.User)
            .HasPrincipalKey(x => x.GuidId)
            .HasForeignKey(c => c.UserId).IsRequired();

            modelBuilder.Entity<Post>()
            .HasMany(c => c.Comments)
            .WithOne(p => p.Post)
            .HasForeignKey(p => p.PostId)
            .OnDelete(DeleteBehavior.Restrict)
            .IsRequired();

            modelBuilder.Entity<User>()
            .HasMany(a => a.Comments)
            .WithOne(a => a.User)
            .HasPrincipalKey(x => x.GuidId)
            .HasForeignKey(c => c.UserId)
            .IsRequired();

            modelBuilder.Entity<Post>()
            .HasMany(c => c.Likes)
            .WithOne(p => p.Post)
            .HasForeignKey(p => p.PostId)
            .OnDelete(DeleteBehavior.Restrict)
            .IsRequired();

            modelBuilder.Entity<User>()
            .HasMany(a => a.Likes)
            .WithOne(a => a.User)
            .HasPrincipalKey(x => x.GuidId)
            .HasForeignKey(c => c.UserId)
            .IsRequired();
        }
    }
}
