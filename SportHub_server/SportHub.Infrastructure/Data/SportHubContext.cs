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
        public DbSet<Subscribe> Subscribes { get; set; }
        public DbSet<SavedPost> SavedPosts { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<User>()
                .HasKey(u => u.GuidId)
                .HasName("PrimaryKey_GuidId");

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

          //  modelBuilder.Entity<Post>()
          //  .HasMany(c => c.Likes)
          //  .WithOne(p => p.Post)
          //  .HasForeignKey(p => p.PostId)
          //  .OnDelete(DeleteBehavior.Restrict)
          //  .IsRequired();

          //  modelBuilder.Entity<Like>()
          //.HasOne(p => p.User)
          //.WithMany(c => c.Likes)
          //.HasForeignKey(p => p.UserId);

            //TODO: Настроить уникальность лайков путем миграции БД

            //modelBuilder.Entity<Like>()
            //.HasOne(a => a.User)
            //.WithMany(a => a.Likes)
            //.HasPrincipalKey(x => x.GuidId)
            //.HasForeignKey(c => c.UserId).IsRequired();

            //modelBuilder.Entity<Like>()
            //.HasOne(a => a.Post)
            //.WithMany(a => a.Likes)
            //.OnDelete(DeleteBehavior.Restrict)
            //.HasForeignKey(c => c.PostId).IsRequired();

            //modelBuilder.Entity<Like>()
            //.HasIndex(p => new { p.UserId, p.PostId })
            //.IsUnique(true);

            modelBuilder.Entity<User>()
            .HasMany(a => a.Likes)
            .WithOne(a => a.User)
            .HasPrincipalKey(x => x.GuidId)
            .HasForeignKey(c => c.UserId)
            .IsRequired();

            modelBuilder.Entity<Subscribe>()
            .HasOne(a => a.Subscriber)
            .WithMany(a => a.Subscribers)
            .HasPrincipalKey(x => x.GuidId)
            .HasForeignKey(c => c.SubscriberId).IsRequired();

            modelBuilder.Entity<Subscribe>()
            .HasOne(a => a.User)
            .WithMany(a => a.Subscribes)
            .HasPrincipalKey(x => x.GuidId)
            .OnDelete(DeleteBehavior.Restrict)
            .HasForeignKey(c => c.UserId).IsRequired();

            modelBuilder.Entity<Subscribe>()
            .HasIndex(p => new { p.SubscriberId, p.UserId })
            .IsUnique(true);

            modelBuilder.Entity<User>()
            .HasMany(c => c.SavedPosts)
            .WithOne(p => p.User)
            .HasForeignKey(p => p.UserId)
            .HasPrincipalKey(x => x.GuidId)
            .OnDelete(DeleteBehavior.Restrict)
            .IsRequired();

            modelBuilder.Entity<Post>()
            .HasMany(a => a.SavedPosts)
            .WithOne(a => a.Post)
            .HasForeignKey(c => c.PostId)
            .OnDelete(DeleteBehavior.Restrict)
            .IsRequired();

            modelBuilder.Entity<SavedPost>()
            .HasIndex(p => new { p.UserId, p.PostId })
            .IsUnique(true);
        }
    }
}
