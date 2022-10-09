﻿using GrpcDemo.Service.Data;

namespace GrpcDemo.Service.Services {
    public class SubscriberService : ISubscriberService {
        private readonly ISubscriptionRepo _subsRepo;

        public SubscriberService(ISubscriptionRepo subs) {
            _subsRepo = subs;
        }

        public async Task<bool> UpdateSubscriberHost(string name, string host) {
            await _subsRepo.UpdateSubscriberHostAsync(name, host);
            return true;
        }

        public async Task<bool> UpdateSubscription(string name, string topic, bool isActive) {
            await _subsRepo.UpdateSubscriptionAsync(name, topic, isActive);
            return true;
        }
    }
}
