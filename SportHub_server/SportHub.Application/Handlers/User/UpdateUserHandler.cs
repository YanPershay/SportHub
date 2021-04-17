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
    public class UpdateUserHandler : IRequestHandler<UpdateUserCommand, UserResponse>
    {
        private readonly IUserRepository _userRepository;

        public UpdateUserHandler(IUserRepository userRepository)
        {
            _userRepository = userRepository;
        }

        public async Task<UserResponse> Handle(UpdateUserCommand request, CancellationToken cancellationToken)
        {
            var userEntity = UserMapper.Mapper.Map<User>(request);

            if (userEntity is null)
            {
                throw new ApplicationException("There is an issue with mapping");
            }

            var user = await _userRepository.GetUserByGuidAsync(userEntity.GuidId);
            user.Username = userEntity.Username;
            user.Email = userEntity.Email;
            if(userEntity.Password != null)
            {
                user.Password = userEntity.Password;
            }

            await _userRepository.UpdateAsync(user);
            var userResponse = UserMapper.Mapper.Map<UserResponse>(userEntity);
            return userResponse;
        }
    }
}
