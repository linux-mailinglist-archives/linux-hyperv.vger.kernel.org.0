Return-Path: <linux-hyperv+bounces-6505-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A08B6B1D400
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Aug 2025 10:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA594167260
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Aug 2025 08:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EB5242D8C;
	Thu,  7 Aug 2025 08:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OFEya+Oz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922E2250C06
	for <linux-hyperv@vger.kernel.org>; Thu,  7 Aug 2025 08:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754554019; cv=none; b=ii2/xuX0+s3kfe5SsdAA1iBBHRPvoketg/3HgDXrwJVHOanSAtK6QFlExmf2bA9vHJKvNXwWSFl2Fevhm3gig9eVAEfPmAsEkB/mOkmODjWa5uNvAvvZYtSX0pXI2UnLWts5sOSGZhRFjh3WVsrCNu+w3/dbV2MKDpQ+0Tl2t20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754554019; c=relaxed/simple;
	bh=u2Il4zcXlbBWcOa6mv3Dqk2LkCaGUlZ1IGfaEMSMzMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUolAJVZPX972n7D1yKbtrRTzMW+do9iuecdfVce5HuwDhvMpVo757SpKYs5M1z/B0Pv8N9iFICi0+O6CpMRt3GkQSKtzoQHzPxpcdPQmqSrdN6+ksp2fveYDzydo+MAy5OdvcUrENQK0O3aNXf4eAFCgxdNIqsrdmo1uHG3vQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OFEya+Oz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754554016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7F/nfJfc6zfGggUKAtMQtDXDSwk2D4R5Dz6fv6UQzEk=;
	b=OFEya+OzfRF7ifIb1yJuVzNn0ErzCKrGVrB/boMdx+q46meCuhyEI6yRB00XMghQtGITsy
	EHZQi5ZFnks6rNhZVsGjWrf1cdDubmtOAZjVadbLfl5eEbh9rHx//yi6I4tw/oN+yHY04e
	suKFbGHjR8bHQduAFhIrC/W/SR6LYAo=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-Sl8-t1FKNrGA9G_HU5M0Bg-1; Thu, 07 Aug 2025 04:06:55 -0400
X-MC-Unique: Sl8-t1FKNrGA9G_HU5M0Bg-1
X-Mimecast-MFC-AGG-ID: Sl8-t1FKNrGA9G_HU5M0Bg_1754554015
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-70e73d3c474so11143247b3.3
        for <linux-hyperv@vger.kernel.org>; Thu, 07 Aug 2025 01:06:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754554010; x=1755158810;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7F/nfJfc6zfGggUKAtMQtDXDSwk2D4R5Dz6fv6UQzEk=;
        b=awqPKQRY2OsJHbQKJ3QI1T9PJ7QNA5/7cHnS+e5W+iplWE13neCua6esIjV8HIxx+4
         /G3pyxYLJiPFy5MazsP1C0pwoFh2sPlvqv29zg1Cb+yvJQVa83AXXP4QxYpNbdZWEHk+
         2bp01Lr1N4jWe9UDXr3ip6DH5zBtI+fHaRBxmKppid//zmf1pz0iJMCfIrnAGd/wbruS
         NcoYy1MGnyBRGd0r1S7tOh40HwmOI2zC98Nskc64va87CW4BpFtcEKiahi6mThP1+EJ9
         vxb2YLNabqvoRy1Bt9eabzrv74CGf0dbwBC+mucAgoG8ROyMD1VWecfgEQj6ae/LnITq
         Pbaw==
X-Forwarded-Encrypted: i=1; AJvYcCXC1UbxcG5jrudZ58uwjEZ8qtjNYCZDXbpMeu8tZOqcrAxnFrl9j6seBkXuJ4mrGNfBM6L+YyPXNYExiGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpkiGKKwQeQ2s0ePpHCGMHDiU38iuhXdQJpb4vskytxGkL6mDp
	KgpV/p1+PXUCcFLTs9nk5j1Z3A1HDuYzvIUgDRotsw1eWNc+zmdMAbcNb2iBc6H2wi4LZ45M0fd
	HjGPG/nUmEC4KJHKNlsIqbrIiC6tSTNILwFT0J6UV+H/EojKeKlMW6tVm93Jejl/p3Q==
X-Gm-Gg: ASbGncujd23+QiRX6PVbb8VDYuKg9mnH47SgwH9mo/JzqYjU9tqqx3SAXc+YGaPRtiM
	HndxSlxY6vL+8AukqPh/GeS2tEAWgEQz5xE+zc3ZeCrF0k0mY/3scpGDH5BM439NoW/RnRvlOPW
	YJLLyOcVQcVORQxOvFGnDQ5yGtB5ojTX9eS4OeA/EFL2bauHIhnzluFgeTptwqIIZSpq83gFWAt
	yIkWb0hjDGmcbXAEiqlVYVPYdlFXcGJkmMtKf1xwWOHHynkwbBf1b3WuNPPzXOBvbGxjAG5xldk
	WTIHCFFG9sUbNTWGVn2QE3Y50e2Dv/PvkLDbjpI5FaeH5MuTWoxbIUSQS9L+yXgAxGRzVkyRQIR
	qfP3diRxDn54MyZQ=
X-Received: by 2002:a05:690c:6203:b0:71a:a9c:30dd with SMTP id 00721157ae682-71bcc6d6851mr85320877b3.2.1754554009637;
        Thu, 07 Aug 2025 01:06:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkk4jVdfxkNS66lXJnELQ1c8i2y7wkD6dlYIhb6ZnK84/IDwj2JHOFZ/v+UaqBfCV8rwA6qA==
X-Received: by 2002:a05:690c:6203:b0:71a:a9c:30dd with SMTP id 00721157ae682-71bcc6d6851mr85319947b3.2.1754554008050;
        Thu, 07 Aug 2025 01:06:48 -0700 (PDT)
Received: from sgarzare-redhat (host-79-45-205-118.retail.telecomitalia.it. [79.45.205.118])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71b5a3a9110sm44916537b3.4.2025.08.07.01.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 01:06:47 -0700 (PDT)
Date: Thu, 7 Aug 2025 10:06:35 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH RFC net-next v4 00/12] vsock: add namespace support to
 vhost-vsock
Message-ID: <27a6zuc6wwuixgozhkxxd2bmpiegiat4bkwghvjz6y3wugtjqm@az7j7et7hzpq>
References: <20250805-vsock-vmtest-v4-0-059ec51ab111@meta.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250805-vsock-vmtest-v4-0-059ec51ab111@meta.com>

Hi Bobby,

On Tue, Aug 05, 2025 at 02:49:08PM -0700, Bobby Eshleman wrote:
>This series adds namespace support to vhost-vsock. It does not add
>namespaces to any of the guest transports (virtio-vsock, hyperv, or
>vmci).
>
>The current revision only supports two modes: local or global. Local
>mode is complete isolation of namespaces, while global mode is complete
>sharing between namespaces of CIDs (the original behavior).
>
>Future may include supporting a mixed mode, which I expect to be more
>complicated because socket lookups will have to include new logic and
>API changes to behave differently based on if the lookup is part of a
>mixed mode CID allocation, a global CID allocation, a mixed-to-global
>connection (allowed), or a global-to-mixed connection (not allowed).
>
>Modes are per-netns and write-once. This allows a system to configure
>namespaces independently (some may share CIDs, others are completely
>isolated). This also supports future mixed use cases, where there may 
>be
>namespaces in global mode spinning up VMs while there are
>mixed mode namespaces that provide services to the VMs, but are not
>allowed to allocate from the global CID pool.
>
>Thanks again for everyone's help and reviews!

Thanks for your work!

As I mentioned to you, I'll be off for the next 2 weeks, so I'll take a 
look when I'm back, but feel free to send new versions if you receive 
enough comments on this.

Thanks,
Stefano

>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@gmail.com>
>To: Stefano Garzarella <sgarzare@redhat.com>
>To: Shuah Khan <shuah@kernel.org>
>To: David S. Miller <davem@davemloft.net>
>To: Eric Dumazet <edumazet@google.com>
>To: Jakub Kicinski <kuba@kernel.org>
>To: Paolo Abeni <pabeni@redhat.com>
>To: Simon Horman <horms@kernel.org>
>To: Stefan Hajnoczi <stefanha@redhat.com>
>To: Michael S. Tsirkin <mst@redhat.com>
>To: Jason Wang <jasowang@redhat.com>
>To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>To: Eugenio Pérez <eperezma@redhat.com>
>To: K. Y. Srinivasan <kys@microsoft.com>
>To: Haiyang Zhang <haiyangz@microsoft.com>
>To: Wei Liu <wei.liu@kernel.org>
>To: Dexuan Cui <decui@microsoft.com>
>To: Bryan Tan <bryan-bt.tan@broadcom.com>
>To: Vishnu Dasa <vishnu.dasa@broadcom.com>
>To: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
>Cc: virtualization@lists.linux.dev
>Cc: netdev@vger.kernel.org
>Cc: linux-kselftest@vger.kernel.org
>Cc: linux-kernel@vger.kernel.org
>Cc: kvm@vger.kernel.org
>Cc: linux-hyperv@vger.kernel.org
>Cc: berrange@redhat.com
>
>Changes in v4:
>- removed RFC tag
>- implemented loopback support
>- renamed new tests to better reflect behavior
>- completed suite of tests with permutations of ns modes and vsock_test
>  as guest/host
>- simplified socat bridging with unix socket instead of tcp + veth
>- only use vsock_test for success case, socat for failure case (context
>  in commit message)
>- lots of cleanup
>
>Changes in v3:
>- add notion of "modes"
>- add procfs /proc/net/vsock_ns_mode
>- local and global modes only
>- no /dev/vhost-vsock-netns
>- vmtest.sh already merged, so new patch just adds new tests for NS
>- Link to v2:
>  https://lore.kernel.org/kvm/20250312-vsock-netns-v2-0-84bffa1aa97a@gmail.com
>
>Changes in v2:
>- only support vhost-vsock namespaces
>- all g2h namespaces retain old behavior, only common API changes
>  impacted by vhost-vsock changes
>- add /dev/vhost-vsock-netns for "opt-in"
>- leave /dev/vhost-vsock to old behavior
>- removed netns module param
>- Link to v1:
>  https://lore.kernel.org/r/20200116172428.311437-1-sgarzare@redhat.com
>
>Changes in v1:
>- added 'netns' module param to vsock.ko to enable the
>  network namespace support (disabled by default)
>- added 'vsock_net_eq()' to check the "net" assigned to a socket
>  only when 'netns' support is enabled
>- Link to RFC: https://patchwork.ozlabs.org/cover/1202235/
>
>---
>Bobby Eshleman (12):
>      vsock: a per-net vsock NS mode state
>      vsock: add net to vsock skb cb
>      vsock: add netns to af_vsock core
>      vsock/virtio: add netns to virtio transport common
>      vhost/vsock: add netns support
>      vsock/virtio: use the global netns
>      hv_sock: add netns hooks
>      vsock/vmci: add netns hooks
>      vsock/loopback: add netns support
>      selftests/vsock: improve logging in vmtest.sh
>      selftests/vsock: invoke vsock_test through helpers
>      selftests/vsock: add namespace tests
>
> MAINTAINERS                             |    1 +
> drivers/vhost/vsock.c                   |   48 +-
> include/linux/virtio_vsock.h            |   12 +
> include/net/af_vsock.h                  |   59 +-
> include/net/net_namespace.h             |    4 +
> include/net/netns/vsock.h               |   21 +
> net/vmw_vsock/af_vsock.c                |  204 +++++-
> net/vmw_vsock/hyperv_transport.c        |    2 +-
> net/vmw_vsock/virtio_transport.c        |    5 +-
> net/vmw_vsock/virtio_transport_common.c |   14 +-
> net/vmw_vsock/vmci_transport.c          |    4 +-
> net/vmw_vsock/vsock_loopback.c          |   59 +-
> tools/testing/selftests/vsock/vmtest.sh | 1088 ++++++++++++++++++++++++++-----
> 13 files changed, 1330 insertions(+), 191 deletions(-)
>---
>base-commit: dd500e4aecf25e48e874ca7628697969df679493
>change-id: 20250325-vsock-vmtest-b3a21d2102c2
>
>Best regards,
>-- 
>Bobby Eshleman <bobbyeshleman@meta.com>
>


