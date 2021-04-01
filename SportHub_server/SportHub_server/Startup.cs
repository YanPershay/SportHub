using MediatR;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.OpenApi.Models;
using SportHub.Application.Handlers;
using SportHub.Core.Repositories;
using SportHub.Core.Repositories.Base;
using SportHub.Infrastructure.Data;
using SportHub.Infrastructure.Repositories;
using SportHub.Infrastructure.Repositories.Base;
using System.Linq;
using System.Reflection;

namespace SportHub_server
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddControllers();
            services.AddApiVersioning();
            services.AddDbContext<SportHubContext>(
                s => s.UseSqlServer(Configuration.GetConnectionString("SportHubConnection")), ServiceLifetime.Transient);
            services.AddSwaggerGen(c =>
            {
                c.SwaggerDoc("v1", new OpenApiInfo
                {
                    Title = "SportHub Review API",
                    Version = "v1"
                });
                //c.ResolveConflictingActions(apiDescriptions => apiDescriptions.First());
            });
            services.AddAutoMapper(typeof(Startup));

            services.AddMediatR(typeof(CreateUserHandler).GetTypeInfo().Assembly);
            services.AddMediatR(typeof(CreateUserInfoHandler).GetTypeInfo().Assembly);
            services.AddMediatR(typeof(CreatePostHandler).GetTypeInfo().Assembly);
            services.AddMediatR(typeof(CreateAdminPostHandler).GetTypeInfo().Assembly);
            services.AddMediatR(typeof(CreateCommentHandler).GetTypeInfo().Assembly);
            services.AddMediatR(typeof(AddLikeHandler).GetTypeInfo().Assembly);
            services.AddMediatR(typeof(SubscribeToUserHandler).GetTypeInfo().Assembly);
            services.AddMediatR(typeof(SavePostHandler).GetTypeInfo().Assembly);

            services.AddScoped(typeof(IRepository<>), typeof(Repository<>));

            services.AddTransient<IUserRepository, UserRepository>();
            services.AddTransient<IUserInfoRepository, UserInfoRepository>();
            services.AddTransient<IPostRepository, PostRepository>();
            services.AddTransient<IAdminPostRepository, AdminPostRepository>();
            services.AddTransient<ICommentRepository, CommentRepository>();
            services.AddTransient<ILikeRepository, LikeRepository>();
            services.AddTransient<ISubscribeRepository, SubscribeRepository>();
            services.AddTransient<ISavedPostRepository, SavedPostRepository>();
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            app.UseHttpsRedirection();

            app.UseRouting();

            app.UseAuthorization();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();
            });

            app.UseSwagger();
            app.UseSwaggerUI(
                c =>
                {
                    c.SwaggerEndpoint("/swagger/v1/swagger.json", "SportHub Review API V1");
                });
        }
    }
}
