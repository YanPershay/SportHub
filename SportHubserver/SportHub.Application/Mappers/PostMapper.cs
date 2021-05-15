using AutoMapper;
using SportHub.Application.Mappers.Profiles;
using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Application.Mappers
{
    public class PostMapper
    {

        private static readonly Lazy<IMapper> Lazy = new Lazy<IMapper>(() =>
        {
            var config = new MapperConfiguration(cfg =>
            {
                cfg.ShouldMapProperty = p => p.GetMethod.IsPublic || p.GetMethod.IsAssembly;
                cfg.AddProfile<PostMappingProfile>();
            });

            var mapper = config.CreateMapper();
            return mapper;
        });

        public static IMapper Mapper => Lazy.Value;
    }
}
