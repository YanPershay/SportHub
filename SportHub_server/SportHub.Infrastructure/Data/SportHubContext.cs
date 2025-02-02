﻿using Microsoft.EntityFrameworkCore;
using SportHub.Core.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
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
        public DbSet<TrainerPost> TrainerPosts { get; set; }
        public DbSet<Comment> Comments { get; set; }
        public DbSet<Like> Likes { get; set; }
        public DbSet<Subscribe> Subscribes { get; set; }
        public DbSet<SavedPost> SavedPosts { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {

            //foreach (var relationship in modelBuilder.Model.GetEntityTypes().SelectMany(e => e.GetForeignKeys()))
            //{
            //    relationship.DeleteBehavior = DeleteBehavior.Cascade;
            //}

            modelBuilder.Entity<User>()
                .HasKey(u => u.GuidId)
                .HasName("PrimaryKey_GuidId");

            modelBuilder.Entity<User>()
            .HasOne(a => a.UserInfo)
            .WithOne(a => a.User)
            .HasPrincipalKey<User>(x => x.GuidId)
            .HasForeignKey<UserInfo>(c => c.UserId).IsRequired();

            modelBuilder.Entity<Post>()
            .HasOne(a => a.User)
            .WithMany(a => a.Posts)
            .HasForeignKey(c => c.UserId);

            modelBuilder.Entity<User>()
            .HasMany(a => a.TrainerPosts)
            .WithOne(a => a.User)
            .HasPrincipalKey(x => x.GuidId)
            .HasForeignKey(c => c.UserId);

            modelBuilder.Entity<Comment>()
            .HasOne(a => a.User)
            .WithMany(a => a.Comments)
            .HasPrincipalKey(x => x.GuidId)
            .OnDelete(DeleteBehavior.Restrict)
            .HasForeignKey(c => c.UserId);

            modelBuilder.Entity<Comment>()
            .HasOne(a => a.Post)
            .WithMany(a => a.Comments)
            //.OnDelete(DeleteBehavior.Restrict)
            .HasForeignKey(c => c.PostId);//.IsRequired();

            modelBuilder.Entity<Like>()
            .HasOne(a => a.User)
            .WithMany(a => a.Likes)
            .OnDelete(DeleteBehavior.Restrict)
            .HasPrincipalKey(x => x.GuidId)
            .HasForeignKey(c => c.UserId);//.IsRequired();

            modelBuilder.Entity<Like>()
            .HasOne(a => a.Post)
            .WithMany(a => a.Likes)
            //.OnDelete(DeleteBehavior.Restrict)
            .HasForeignKey(c => c.PostId);//.IsRequired();

            modelBuilder.Entity<Like>()
            .HasIndex(p => new { p.UserId, p.PostId })
            .IsUnique(true);

            modelBuilder.Entity<Subscribe>()
            .HasOne(a => a.Subscriber)
            .WithMany(a => a.Subscribers)
            .HasPrincipalKey(x => x.GuidId)
            //.OnDelete(DeleteBehavior.Restrict)
            .HasForeignKey(c => c.SubscriberId);//.IsRequired();

            modelBuilder.Entity<Subscribe>()
            .HasOne(a => a.User)
            .WithMany(a => a.Subscribes)
            .HasPrincipalKey(x => x.GuidId)
            .OnDelete(DeleteBehavior.Restrict);
            //.HasForeignKey(c => c.UserId);//.IsRequired();

            modelBuilder.Entity<Subscribe>()
            .HasIndex(p => new { p.SubscriberId, p.UserId })
            .IsUnique(true);

            modelBuilder.Entity<User>()
            .HasMany(c => c.SavedPosts)
            .WithOne(p => p.User)
            .OnDelete(DeleteBehavior.Restrict)
            .HasForeignKey(p => p.UserId)
            .HasPrincipalKey(x => x.GuidId);
            //.IsRequired();

            modelBuilder.Entity<Post>()
            .HasMany(a => a.SavedPosts)
            .WithOne(a => a.Post)
            //.OnDelete(DeleteBehavior.Restrict)
            .HasForeignKey(c => c.PostId);
            //.IsRequired();

            modelBuilder.Entity<SavedPost>()
            .HasIndex(p => new { p.UserId, p.PostId })
            .IsUnique(true);
        }
    }
}
