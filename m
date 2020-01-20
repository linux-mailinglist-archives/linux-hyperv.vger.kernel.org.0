Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E69A21429FC
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Jan 2020 13:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgATMDc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 20 Jan 2020 07:03:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40397 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726798AbgATMDc (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 20 Jan 2020 07:03:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579521811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i0FYwpPvJVwXX6WibGdKe3t8GmO0Q/BB/ry3XOYj5v4=;
        b=IUsagC+QT7o8Lg7F1pqLCJbSApDaimaTwWR2DDCb+EFmTbNbyTERf0ROeQzX6iE2e3fthU
        8F+yuUTDv9de3lrQaArYnjglILK+XcLEWnwlYCnFXQssRlJpkb5HigEHVl5nJCAVc7o+4f
        e3mDKsdzEwwtdJ/I6u5d9fFXZCzJ1GM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-ZytiQGW0MzuUfZ2Ky81NPA-1; Mon, 20 Jan 2020 07:03:28 -0500
X-MC-Unique: ZytiQGW0MzuUfZ2Ky81NPA-1
Received: by mail-qt1-f199.google.com with SMTP id d18so21101613qtp.16
        for <linux-hyperv@vger.kernel.org>; Mon, 20 Jan 2020 04:03:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i0FYwpPvJVwXX6WibGdKe3t8GmO0Q/BB/ry3XOYj5v4=;
        b=jVZ7aT6wwmZTsZ+8WrNAqi8DkNw5oWlYXuj4Nep7RtOxVW9Z5DANknLYAsBYIuq8Wt
         Orf27641GEUxYb062WVwYr2Rr4qHOi2geNcK3xDKVQKSq9cVp7AclvYWw/BLYiyeAClb
         QKpE1tqPEHyDYxzrrgRbC2fOtGnaxcsSztTwJ9BJQoaVDMvRGmCWu2VDv5DlTb64RAtB
         tsyg0IMzgq/lDH8oUEK0/MxpLwmH96kWg0wzjIzs/qOjG6eA1Il3KvgTHnoWMdqTrt60
         JOTSUdK+FJ+xnfBSmiQjAfQyhj9dUnfsBQwH6MLfkP1CoJRC+x/DCfAtHhd6eh9PhCc4
         Askw==
X-Gm-Message-State: APjAAAX5S5wGea/IOxLG713mpCxVeQIr++oNjp+VkKCdQhK0l5d+NjfQ
        uXzTLMWxbwQlScjNZSJNqaGKtFCV58ZLb9pJL0GpqZVZXRh7uQKpTW+QEVhHxeXa3UG/oQkLgK/
        0bs1Gk98ZsHBFioWBFrtgVp1H
X-Received: by 2002:ac8:2c7d:: with SMTP id e58mr20372310qta.196.1579521807750;
        Mon, 20 Jan 2020 04:03:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqwBOvpzVbluzRk2PBevjR+yTn5PHKpCN1mkjbfx/S5QQmnZyFB/1WiP+Ct1GD9bo9yvXG9y7A==
X-Received: by 2002:ac8:2c7d:: with SMTP id e58mr20372288qta.196.1579521807486;
        Mon, 20 Jan 2020 04:03:27 -0800 (PST)
Received: from redhat.com (bzq-79-179-85-180.red.bezeqint.net. [79.179.85.180])
        by smtp.gmail.com with ESMTPSA id h8sm17044762qtm.51.2020.01.20.04.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 04:03:26 -0800 (PST)
Date:   Mon, 20 Jan 2020 07:03:20 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jhansen@vmware.com,
        jasowang@redhat.com, kvm@vger.kernel.org, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-hyperv@vger.kernel.org, decui@microsoft.com
Subject: Re: [PATCH net-next 1/3] vsock: add network namespace support
Message-ID: <20200120060601-mutt-send-email-mst@kernel.org>
References: <20200116172428.311437-1-sgarzare@redhat.com>
 <20200116172428.311437-2-sgarzare@redhat.com>
 <20200120.100610.546818167633238909.davem@davemloft.net>
 <20200120101735.uyh4o64gb4njakw5@steredhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120101735.uyh4o64gb4njakw5@steredhat>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Jan 20, 2020 at 11:17:35AM +0100, Stefano Garzarella wrote:
> On Mon, Jan 20, 2020 at 10:06:10AM +0100, David Miller wrote:
> > From: Stefano Garzarella <sgarzare@redhat.com>
> > Date: Thu, 16 Jan 2020 18:24:26 +0100
> > 
> > > This patch adds 'netns' module param to enable this new feature
> > > (disabled by default), because it changes vsock's behavior with
> > > network namespaces and could break existing applications.
> > 
> > Sorry, no.
> > 
> > I wonder if you can even design a legitimate, reasonable, use case
> > where these netns changes could break things.
> 
> I forgot to mention the use case.
> I tried the RFC with Kata containers and we found that Kata shim-v1
> doesn't work (Kata shim-v2 works as is) because there are the following
> processes involved:
> - kata-runtime (runs in the init_netns) opens /dev/vhost-vsock and
>   passes it to qemu
> - kata-shim (runs in a container) wants to talk with the guest but the
>   vsock device is assigned to the init_netns and kata-shim runs in a
>   different netns, so the communication is not allowed
> But, as you said, this could be a wrong design, indeed they already
> found a fix, but I was not sure if others could have the same issue.
> 
> In this case, do you think it is acceptable to make this change in
> the vsock's behavior with netns and ask the user to change the design?

David's question is what would be a usecase that's broken
(as opposed to fixed) by enabling this by default.

If it does exist, you need a way for userspace to opt-in,
module parameter isn't that.

> 
> > 
> > I am totally against adding a module parameter for this, it's
> > incredibly confusing for users and will create a test scenerio
> > that is strongly less likely to be covered.
> > 
> 
> Got it, I'll remove the module parameter!
> 
> Thanks,
> Stefano

