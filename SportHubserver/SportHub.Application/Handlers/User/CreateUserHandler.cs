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
using BC = BCrypt.Net.BCrypt;

namespace SportHub.Application.Handlers
{
    public class CreateUserHandler : IRequestHandler<CreateUserCommand, UserResponse>
    {
        private readonly IUserRepository _userRepository;

        public CreateUserHandler(IUserRepository userRepository)
        {
            _userRepository = userRepository;
        }

        public async Task<UserResponse> Handle(CreateUserCommand request, CancellationToken cancellationToken)
        {
            var userEntity = UserMapper.Mapper.Map<User>(request);

            if(userEntity is null)
            {
                throw new ApplicationException("There is an issue with mapping");
            }

            userEntity.Password = BC.HashPassword(request.Password);

            var newUser = await _userRepository.AddAsync(userEntity);
            var userResponse = UserMapper.Mapper.Map<UserResponse>(newUser);
            return userResponse;
        }
    }
}
