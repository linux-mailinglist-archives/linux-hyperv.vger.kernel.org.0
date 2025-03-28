Return-Path: <linux-hyperv+bounces-4723-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB730A74ED3
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Mar 2025 18:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00A7D16C684
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Mar 2025 17:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00221DDC0B;
	Fri, 28 Mar 2025 17:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MDN0aaDd"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AAD3C0C
	for <linux-hyperv@vger.kernel.org>; Fri, 28 Mar 2025 17:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743181410; cv=none; b=t/3pSbBHmbflCfkvx9eQgMNTxJbN85scpwwHQFevZ6Bf5HwFz6jMP9wD6BXj01576hzRMllnfO+xU0Jpc6FosPXWeAN44/Bfnf/6nA95LxvyknWsBwxTwtAzFOzDXJjAVQs+C+rG7PEMpMZg9uEcLl54HWoecBh493mMs9Oj5cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743181410; c=relaxed/simple;
	bh=5VL+nSlr4EcqTMw6hRb9pJpX+24HA7R7EtdOhFmG/0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTaqsdxEzsxNl+ADshi9oVdt7yyTUl3vfV07D/bIZl5AZ3qy/gc1LJv6SO5ggcsMUz5Q3YiET8n0zdxBZdGcew338KzObaX5advd4ujgPlS3FvGyzQePKzlW5bl5txb2AHQb6AZhpwV2gqsD6L5QnJLYfpnRDAt+ybGu4+efjS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MDN0aaDd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743181408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9uf0+0Mizn7Wtg468+LZG3Q/0Otqz8lfJO3EiDJY7w4=;
	b=MDN0aaDd5BB8sFE2d9mV4AeL2Dmu68I8kk3oXy1vbdsGrYiMto1+DUsracAjMmGyBAkCq0
	heulOM3GNJn07dXmvCmAzWpoDuhVLV28IrsEbWpZrdvpcvVZUGQp7VVppZhHYxrsTvDUys
	m74fGTea01WwGoYcSRsH0wbgDiCdDsc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-gYxuvrKcO5-zyabMgAZnPA-1; Fri, 28 Mar 2025 13:03:26 -0400
X-MC-Unique: gYxuvrKcO5-zyabMgAZnPA-1
X-Mimecast-MFC-AGG-ID: gYxuvrKcO5-zyabMgAZnPA_1743181406
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ab397fff5a3so249512766b.1
        for <linux-hyperv@vger.kernel.org>; Fri, 28 Mar 2025 10:03:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743181405; x=1743786205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9uf0+0Mizn7Wtg468+LZG3Q/0Otqz8lfJO3EiDJY7w4=;
        b=vncqX9Yx/bsuEo6Wp+Bq2IEnu5w0hsFX+SP0JxG+IEyy5h5hrDta92RdXFCui1e88J
         RygjOoIrLRNZyIpWOVZlHW+KJLsagij+y3yeAJAJPwYTZcTB/VEjEA2Xc9UesMbkvH7f
         XYiRiDU3hve+kApZO0UwBX0Vr7YJ6cq6P84Y7VY3QigyAsRT0JScy8QcueZ/mXUvEcKR
         sGqylx3eWQXuCkgdekkBjRqklB1P9mRRawfqBcdig9zHNC7mBMryLmHsCTwfb/aNe9Ll
         i0dO6IrNGypwo3Se8uvqq7n687lSKcEcbZ3wAp6QEYogib062+bzGLsSbwSlcHXKpyIS
         hGTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWX2MW+DZ1H5I+FD9bR4SYUBbYquqUhhr3M7NbQpyuEPQw1j72i+L7NQ3U5cmSDItT0MQ0M/MUBHjOdotY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqhjMOyfY6382rqUEqIlTwESt+BFCRtpg/myDkxpJ9XuIxjcXb
	bn1RLAiD8a9WprXOI72qWi5yDh+402bog83UuTDeKoAhpPu4yfOH/bmOqaj5l38R+RgM8BOVlCZ
	0NRwDVXfnT9WUPOMlegeN6VXeCAdY2K22EVCJEx48SeCVyibOBpqg2A6e1ZN3iQ==
X-Gm-Gg: ASbGncvPHqKQ7OG5gt1SSx0E9N4VCqogYc6EqD6GzXCzQzleonlh9SZ5iWeNEHPJYiP
	buPqPAGVMKlqIP2xVOjgnSrNKIcVpkR3b4iHa9wpTctki7ZDd/E3StZpHiApG0x1+7sBJxuBYDK
	Uwkm1YAXuCCm9DlxXYdLL7rBI2/wPmy6nkretwdiXrxFhtCpkXH8iBeSXksSLARCEFGYGzrUfQW
	zZDe4NwSi2TGwav3C8T/A7TY9py381mvurjH60VzJpCTMTSe6EurMBh/JKWDNQMnOKwchqJp6hi
	VAZ1XkYIyOBlwMV8cnP+ULLuoKBqubUzKVmd8nD+TLBMdcsUYbV9q7lgGmSqjvBp
X-Received: by 2002:a17:906:c115:b0:ac6:e29b:8503 with SMTP id a640c23a62f3a-ac71eac290amr421854166b.1.1743181405008;
        Fri, 28 Mar 2025 10:03:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGd9u9IUSVtU5cjE8R52KpOjUFspVo6+RZH/1O5CExd6Dpx7I7lN+krtxHcvzE1FAVtm4Ndw==
X-Received: by 2002:a17:906:c115:b0:ac6:e29b:8503 with SMTP id a640c23a62f3a-ac71eac290amr421844466b.1.1743181404266;
        Fri, 28 Mar 2025 10:03:24 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-55.business.telecomitalia.it. [87.12.25.55])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71927b243sm191783266b.69.2025.03.28.10.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 10:03:23 -0700 (PDT)
Date: Fri, 28 Mar 2025 18:03:19 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>, 
	Daniel =?utf-8?B?QmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, "David S. Miller" <davem@davemloft.net>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v2 0/3] vsock: add namespace support to vhost-vsock
Message-ID: <r6a6ihjw3etlb5chqsb65u7uhcav6q6pjxu65iqpp76423w2wd@kmctvoaywmbu>
References: <20250312-vsock-netns-v2-0-84bffa1aa97a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250312-vsock-netns-v2-0-84bffa1aa97a@gmail.com>

CCing Daniel

On Wed, Mar 12, 2025 at 01:59:34PM -0700, Bobby Eshleman wrote:
>Picking up Stefano's v1 [1], this series adds netns support to
>vhost-vsock. Unlike v1, this series does not address guest-to-host (g2h)
>namespaces, defering that for future implementation and discussion.
>
>Any vsock created with /dev/vhost-vsock is a global vsock, accessible
>from any namespace. Any vsock created with /dev/vhost-vsock-netns is a
>"scoped" vsock, accessible only to sockets in its namespace. If a global
>vsock or scoped vsock share the same CID, the scoped vsock takes
>precedence.
>
>If a socket in a namespace connects with a global vsock, the CID becomes
>unavailable to any VMM in that namespace when creating new vsocks. If
>disconnected, the CID becomes available again.

I was talking about this feature with Daniel and he pointed out 
something interesting (Daniel please feel free to correct me):

     If we have a process in the host that does a listen(AF_VSOCK) in a 
     namespace, can this receive connections from guests connected to 
     /dev/vhost-vsock in any namespace?

     Should we provide something (e.g. sysctl/sysfs entry) to disable 
     this behaviour, preventing a process in a namespace from receiving 
     connections from the global vsock address space (i.e.  
     /dev/vhost-vsock VMs)?

I understand that by default maybe we should allow this behaviour in 
order to not break current applications, but in some cases the user may 
want to isolate sockets in a namespace also from being accessed by VMs 
running in the global vsock address space.

Indeed in this series we have talked mostly about the host -> guest path 
(as the direction of the connection), but little about the guest -> host 
path, maybe we should explain it better in the cover/commit 
descriptions/documentation.

Thanks,
Stefano

>
>Testing
>
>QEMU with /dev/vhost-vsock-netns support:
>	https://github.com/beshleman/qemu/tree/vsock-netns
>
>Test: Scoped vsocks isolated by namespace
>
>  host# ip netns add ns1
>  host# ip netns add ns2
>  host# ip netns exec ns1 \
>				  qemu-system-x86_64 \
>					  -m 8G -smp 4 -cpu host -enable-kvm \
>					  -serial mon:stdio \
>					  -drive if=virtio,file=${IMAGE1} \
>					  -device vhost-vsock-pci,netns=on,guest-cid=15
>  host# ip netns exec ns2 \
>				  qemu-system-x86_64 \
>					  -m 8G -smp 4 -cpu host -enable-kvm \
>					  -serial mon:stdio \
>					  -drive if=virtio,file=${IMAGE2} \
>					  -device vhost-vsock-pci,netns=on,guest-cid=15
>
>  host# socat - VSOCK-CONNECT:15:1234
>  2025/03/10 17:09:40 socat[255741] E connect(5, AF=40 cid:15 port:1234, 16): No such device
>
>  host# echo foobar1 | sudo ip netns exec ns1 socat - VSOCK-CONNECT:15:1234
>  host# echo foobar2 | sudo ip netns exec ns2 socat - VSOCK-CONNECT:15:1234
>
>  vm1# socat - VSOCK-LISTEN:1234
>  foobar1
>  vm2# socat - VSOCK-LISTEN:1234
>  foobar2
>
>Test: Global vsocks accessible to any namespace
>
>  host# qemu-system-x86_64 \
>	  -m 8G -smp 4 -cpu host -enable-kvm \
>	  -serial mon:stdio \
>	  -drive if=virtio,file=${IMAGE2} \
>	  -device vhost-vsock-pci,guest-cid=15,netns=off
>
>  host# echo foobar | sudo ip netns exec ns1 socat - VSOCK-CONNECT:15:1234
>
>  vm# socat - VSOCK-LISTEN:1234
>  foobar
>
>Test: Connecting to global vsock makes CID unavailble to namespace
>
>  host# qemu-system-x86_64 \
>	  -m 8G -smp 4 -cpu host -enable-kvm \
>	  -serial mon:stdio \
>	  -drive if=virtio,file=${IMAGE2} \
>	  -device vhost-vsock-pci,guest-cid=15,netns=off
>
>  vm# socat - VSOCK-LISTEN:1234
>
>  host# sudo ip netns exec ns1 socat - VSOCK-CONNECT:15:1234
>  host# ip netns exec ns1 \
>				  qemu-system-x86_64 \
>					  -m 8G -smp 4 -cpu host -enable-kvm \
>					  -serial mon:stdio \
>					  -drive if=virtio,file=${IMAGE1} \
>					  -device vhost-vsock-pci,netns=on,guest-cid=15
>
>  qemu-system-x86_64: -device vhost-vsock-pci,netns=on,guest-cid=15: vhost-vsock: unable to set guest cid: Address already in use
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@gmail.com>
>---
>Changes in v2:
>- only support vhost-vsock namespaces
>- all g2h namespaces retain old behavior, only common API changes
>  impacted by vhost-vsock changes
>- add /dev/vhost-vsock-netns for "opt-in"
>- leave /dev/vhost-vsock to old behavior
>- removed netns module param
>- Link to v1: https://lore.kernel.org/r/20200116172428.311437-1-sgarzare@redhat.com
>
>Changes in v1:
>- added 'netns' module param to vsock.ko to enable the
>  network namespace support (disabled by default)
>- added 'vsock_net_eq()' to check the "net" assigned to a socket
>  only when 'netns' support is enabled
>- Link to RFC: https://patchwork.ozlabs.org/cover/1202235/
>
>---
>Stefano Garzarella (3):
>      vsock: add network namespace support
>      vsock/virtio_transport_common: handle netns of received packets
>      vhost/vsock: use netns of process that opens the vhost-vsock-netns device
>
> drivers/vhost/vsock.c                   | 96 +++++++++++++++++++++++++++------
> include/linux/miscdevice.h              |  1 +
> include/linux/virtio_vsock.h            |  2 +
> include/net/af_vsock.h                  | 10 ++--
> net/vmw_vsock/af_vsock.c                | 85 +++++++++++++++++++++++------
> net/vmw_vsock/hyperv_transport.c        |  2 +-
> net/vmw_vsock/virtio_transport.c        |  5 +-
> net/vmw_vsock/virtio_transport_common.c | 14 ++++-
> net/vmw_vsock/vmci_transport.c          |  4 +-
> net/vmw_vsock/vsock_loopback.c          |  4 +-
> 10 files changed, 180 insertions(+), 43 deletions(-)
>---
>base-commit: 0ea09cbf8350b70ad44d67a1dcb379008a356034
>change-id: 20250312-vsock-netns-45da9424f726
>
>Best regards,
>-- 
>Bobby Eshleman <bobbyeshleman@gmail.com>
>


