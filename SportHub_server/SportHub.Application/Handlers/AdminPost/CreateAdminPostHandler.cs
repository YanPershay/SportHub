using MediatR;
using SportHub.Application.Commands;
using SportHub.Application.Mappers;
using SportHub.Application.Responses;
using SportHub.Core.Entities;
using SportHub.Core.Repositories;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace SportHub.Application.Handlers
{
    public class CreateAdminPostHandler : IRequestHandler<CreateAdminPostCommand, AdminPostResponse>
    {
        private readonly IAdminPostRepository _adminPostRepository;

        public CreateAdminPostHandler(IAdminPostRepository adminPostRepository)
        {
            _adminPostRepository = adminPostRepository;
        }

        public async Task<AdminPostResponse> Handle(CreateAdminPostCommand request, CancellationToken cancellationToken)
        {
            var adminPostEntity = AdminPostMapper.Mapper.Map<AdminPost>(request);

            if(adminPostEntity is null)
            {
                throw new ApplicationException("There is an issue with mapping");
            }

            var newAdminPost = await _adminPostRepository.AddAsync(adminPostEntity);
            var adminPostResponse = AdminPostMapper.Mapper.Map<AdminPostResponse>(newAdminPost);
            return adminPostResponse;
        }
    }
}
