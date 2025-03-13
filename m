Return-Path: <linux-hyperv+bounces-4482-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1A0A5FA13
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Mar 2025 16:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAB8B188920D
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Mar 2025 15:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9347267F5B;
	Thu, 13 Mar 2025 15:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GATIJYVn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093DD266B5B
	for <linux-hyperv@vger.kernel.org>; Thu, 13 Mar 2025 15:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741880247; cv=none; b=iJtXX2zY1LgsCnXhT/o70QTLsNYALGK77CvBXtUeq2SqR/oRuGsIIosjlcK61EhT0AxJbs5/Ym1jfJ5t1BWsEeDRePTZpsQpNoBsVsXIt13sanPVEUBg7h33PY85Zeu5MzWZlsmsZGZDBVmaPCAooRu4e8uMeDKbn0JGadPNNJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741880247; c=relaxed/simple;
	bh=Y77Em3/niRgA67iEpRFgCcPBmNOvas3WDyQvzjEYZrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O16giL/kKpdCOgfnFLuRr1fwtty7L3hYJO8FpVk5FlcQ54zL0HIgNeSvlcIY2t48pC5CgwYS/q84RDakbU38Up/WZrVuJSwNe7NyZXKdyZLA2KJ8kCWMIZZEkdyemlINRMPR4qSudcRMnQwrq9EPoPZ5F7paeQLXR42QL+WRT5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GATIJYVn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741880245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TozB4Fx8fnL74+/ZdpiLO6KqtqXqLhZ7FUHL1U433aE=;
	b=GATIJYVnyMEX3ZdQOo+fUnJ2UT/8JCvdSoGO5U/PLzdN4v7aNTHVy3SiyWd57VJM16upKg
	ApQ6m3ZLbrkX8NCIx5++WGDLXDh6OQzOzeSVxq701FZ5wpcVzBEeDqwbnvQDkm7Kg8a+aq
	fc9+zPmu3dWCudA9OW+h2NsyXjsmDzg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-HKC90GirNjeiGYYipWOBgw-1; Thu, 13 Mar 2025 11:37:23 -0400
X-MC-Unique: HKC90GirNjeiGYYipWOBgw-1
X-Mimecast-MFC-AGG-ID: HKC90GirNjeiGYYipWOBgw_1741880242
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3933ab5b1d5so659731f8f.2
        for <linux-hyperv@vger.kernel.org>; Thu, 13 Mar 2025 08:37:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741880242; x=1742485042;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TozB4Fx8fnL74+/ZdpiLO6KqtqXqLhZ7FUHL1U433aE=;
        b=JQPChnhq1a0CqLM3aR2DEPuAm0HnW+NiV5207lUWSmbzW+u0knQunxS2VikX/vsL87
         3rLhyRD2rMdsnE6kxS5ADP3iuG/R2qrjSw14EoMv75LrnZnL5QSWNyI/1/cpepvraJti
         yckwKWxB8Vshr2G6Y/uNJE55lvKfwXjKyVTcGSeO+HKXuskXDuK+yq0inggIc29NEE3o
         yXCxN83QjQcjs9kInobsynWNLaDPIQzs983jx/CaTnTh8JWMVuOpxN3bdljaqiCnSfBn
         7M4JdgTuxcT0yL5Taj0VNZIn3QDhpTNc7kwuTmxeb2SlTQg2i06o0snSu6VxabOJ2dw7
         r78Q==
X-Forwarded-Encrypted: i=1; AJvYcCVgjMUVPlDU8Lmg5Fm1Kmrm7v6b2Nw0SY0y58K26Rw2KsKbHxJfCCG5IqlTvr8LlbWs76sT1e1gOuyMxHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmDnilQU6xerhIP80A1XFKT2kMUJ/G8MAKgW/bQ+7gmUzGaykM
	D8pBsSqxNLpliZ/CMos6zhmnfT4UWUcf3QplNc6DeK2rJXzZz4gegokvfcO+4Psh8zsU9Asmn26
	TJBaKuHaIo7c/e5kDZYrQ+JMmeUsAOakrZeYvk/lG9zppPtVRINwMLN/88nZeCg==
X-Gm-Gg: ASbGncuvX7vRVMfIiP3GrNgGdPKq7VZnl/yrRKFo/b93DKjSv+svMxj49JRm0mPcAmo
	h9ApA9gW8/jPc2KLninHbM4JePfipXSswYcaPKeTfdsHDXyfZivtior4uUTbhqdQlBmeeJxOf9v
	r++s+Ez25sog2dPpKfmF4suKDPYGkzUjkpKjIyysjr/mheD4wip2KbDObZ9Hbr64N7R3LHXoxMU
	mURBi64V7sM/wp9esNnfp64Ze1O3hLD7vdeR5N7NQHn9h1aBS+7+cpGQLQN0kSCriFkv+zrVFLv
	IPw4nC4Q/OmUdsaNdMtkypkl/dN+jHtK75A+/KbBNAiRttYOFVJ3JyQPpyBS3GfG
X-Received: by 2002:a5d:6da3:0:b0:391:2bcc:11f2 with SMTP id ffacd0b85a97d-396c1753759mr12322f8f.1.1741880242309;
        Thu, 13 Mar 2025 08:37:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF02exxmoWcKdhQRrcSKqOBNvSNn3RWXG71ebE8fKId+jw35Z2l6uHrxPDWlYovTWlQpC4iSg==
X-Received: by 2002:a5d:6da3:0:b0:391:2bcc:11f2 with SMTP id ffacd0b85a97d-396c1753759mr12284f8f.1.1741880241718;
        Thu, 13 Mar 2025 08:37:21 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a731265sm57233895e9.4.2025.03.13.08.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 08:37:21 -0700 (PDT)
Date: Thu, 13 Mar 2025 16:37:16 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
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
Message-ID: <zz5fnulfljo6hyxaveseq3dxfgljfs33m7ncsw6uod6wouaqhl@jzdmg6s7g5dw>
References: <20250312-vsock-netns-v2-0-84bffa1aa97a@gmail.com>
 <Z9JC0VoMwAHKjqEX@devvm6277.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z9JC0VoMwAHKjqEX@devvm6277.cco0.facebook.com>

Hi Bobby,
first of all, thank you for starting this work again!

On Wed, Mar 12, 2025 at 07:28:33PM -0700, Bobby Eshleman wrote:
>Hey all,
>
>Apologies for forgetting the 'net-next' prefix on this one. Should I
>resend or no?

I'd say let's do a firts review cycle on this, then you can re-post.
Please check also maintainer cced, it looks like someone is missing:
https://patchwork.kernel.org/project/netdevbpf/patch/20250312-vsock-netns-v2-1-84bffa1aa97a@gmail.com/

>
>Best,
>Bobby
>
>On Wed, Mar 12, 2025 at 01:59:34PM -0700, Bobby Eshleman wrote:
>> Picking up Stefano's v1 [1], this series adds netns support to
>> vhost-vsock. Unlike v1, this series does not address guest-to-host (g2h)
>> namespaces, defering that for future implementation and discussion.
>>
>> Any vsock created with /dev/vhost-vsock is a global vsock, accessible
>> from any namespace. Any vsock created with /dev/vhost-vsock-netns is a
>> "scoped" vsock, accessible only to sockets in its namespace. If a global
>> vsock or scoped vsock share the same CID, the scoped vsock takes
>> precedence.

This inside the netns, right?
I mean if we are in a netns, and there is a VM A attached to 
/dev/vhost-vsock-netns witch CID=42 and a VM B attached to 
/dev/vhost-vsock also with CID=42, this means that VM A will not be 
accessible in the netns, but it can be accessible outside of the netns,
right?

>>
>> If a socket in a namespace connects with a global vsock, the CID becomes
>> unavailable to any VMM in that namespace when creating new vsocks. If
>> disconnected, the CID becomes available again.

IIUC if an application in the host running in a netns, is connected to a 
guest attached to /dev/vhost-vsock (e.g. CID=42), a new guest can't be 
ask for the same CID (42) on /dev/vhost-vsock-netns in the same netns 
till that connection is active. Is that right?

>>
>> Testing
>>
>> QEMU with /dev/vhost-vsock-netns support:
>> 	https://github.com/beshleman/qemu/tree/vsock-netns

You can also use unmodified QEMU using `vhostfd` parameter of 
`vhost-vsock-pci` device:

# FD will contain the file descriptor to /dev/vhost-vsock-netns
exec {FD}<>/dev/vhost-vsock-netns

# pass FD to the device, this is used for example by libvirt
qemu-system-x86_64 -smp 2 -M q35,accel=kvm,memory-backend=mem \
   -drive file=fedora.qcow2,format=qcow2,if=virtio \
   -object memory-backend-memfd,id=mem,size=512M \
   -device vhost-vsock-pci,vhostfd=${FD},guest-cid=42 -nographic

That said, I agree we can extend QEMU with `netns` param too.

BTW, I'm traveling, I'll be back next Tuesday and I hope to take a 
deeper look to the patches.

Thanks,
Stefano

>>
>> Test: Scoped vsocks isolated by namespace
>>
>>   host# ip netns add ns1
>>   host# ip netns add ns2
>>   host# ip netns exec ns1 \
>> 				  qemu-system-x86_64 \
>> 					  -m 8G -smp 4 -cpu host -enable-kvm \
>> 					  -serial mon:stdio \
>> 					  -drive if=virtio,file=${IMAGE1} \
>> 					  -device 
>> 					  vhost-vsock-pci,netns=on,guest-cid=15
>>   host# ip netns exec ns2 \
>> 				  qemu-system-x86_64 \
>> 					  -m 8G -smp 4 -cpu host -enable-kvm \
>> 					  -serial mon:stdio \
>> 					  -drive if=virtio,file=${IMAGE2} \
>> 					  -device vhost-vsock-pci,netns=on,guest-cid=15
>>
>>   host# socat - VSOCK-CONNECT:15:1234
>>   2025/03/10 17:09:40 socat[255741] E connect(5, AF=40 cid:15 port:1234, 16): No such device
>>
>>   host# echo foobar1 | sudo ip netns exec ns1 socat - VSOCK-CONNECT:15:1234
>>   host# echo foobar2 | sudo ip netns exec ns2 socat - VSOCK-CONNECT:15:1234
>>
>>   vm1# socat - VSOCK-LISTEN:1234
>>   foobar1
>>   vm2# socat - VSOCK-LISTEN:1234
>>   foobar2
>>
>> Test: Global vsocks accessible to any namespace
>>
>>   host# qemu-system-x86_64 \
>> 	  -m 8G -smp 4 -cpu host -enable-kvm \
>> 	  -serial mon:stdio \)
>> 	  -drive if=virtio,file=${IMAGE2} \
>> 	  -device vhost-vsock-pci,guest-cid=15,netns=off
>>
>>   host# echo foobar | sudo ip netns exec ns1 socat - VSOCK-CONNECT:15:1234
>>
>>   vm# socat - VSOCK-LISTEN:1234
>>   foobar
>>
>> Test: Connecting to global vsock makes CID unavailble to namespace
>>
>>   host# qemu-system-x86_64 \
>> 	  -m 8G -smp 4 -cpu host -enable-kvm \
>> 	  -serial mon:stdio \
>> 	  -drive if=virtio,file=${IMAGE2} \
>> 	  -device vhost-vsock-pci,guest-cid=15,netns=off
>>
>>   vm# socat - VSOCK-LISTEN:1234
>>
>>   host# sudo ip netns exec ns1 socat - VSOCK-CONNECT:15:1234
>>   host# ip netns exec ns1 \
>> 				  qemu-system-x86_64 \
>> 					  -m 8G -smp 4 -cpu host -enable-kvm \
>> 					  -serial mon:stdio \
>> 					  -drive if=virtio,file=${IMAGE1} \
>> 					  -device vhost-vsock-pci,netns=on,guest-cid=15
>>
>>   qemu-system-x86_64: -device vhost-vsock-pci,netns=on,guest-cid=15: vhost-vsock: unable to set guest cid: Address already in use
>>
>> Signed-off-by: Bobby Eshleman <bobbyeshleman@gmail.com>
>> ---
>> Changes in v2:
>> - only support vhost-vsock namespaces
>> - all g2h namespaces retain old behavior, only common API changes
>>   impacted by vhost-vsock changes
>> - add /dev/vhost-vsock-netns for "opt-in"
>> - leave /dev/vhost-vsock to old behavior
>> - removed netns module param
>> - Link to v1: https://lore.kernel.org/r/20200116172428.311437-1-sgarzare@redhat.com
>>
>> Changes in v1:
>> - added 'netns' module param to vsock.ko to enable the
>>   network namespace support (disabled by default)
>> - added 'vsock_net_eq()' to check the "net" assigned to a socket
>>   only when 'netns' support is enabled
>> - Link to RFC: https://patchwork.ozlabs.org/cover/1202235/
>>
>> ---
>> Stefano Garzarella (3):
>>       vsock: add network namespace support
>>       vsock/virtio_transport_common: handle netns of received packets
>>       vhost/vsock: use netns of process that opens the vhost-vsock-netns device
>>
>>  drivers/vhost/vsock.c                   | 96 +++++++++++++++++++++++++++------
>>  include/linux/miscdevice.h              |  1 +
>>  include/linux/virtio_vsock.h            |  2 +
>>  include/net/af_vsock.h                  | 10 ++--
>>  net/vmw_vsock/af_vsock.c                | 85 +++++++++++++++++++++++------
>>  net/vmw_vsock/hyperv_transport.c        |  2 +-
>>  net/vmw_vsock/virtio_transport.c        |  5 +-
>>  net/vmw_vsock/virtio_transport_common.c | 14 ++++-
>>  net/vmw_vsock/vmci_transport.c          |  4 +-
>>  net/vmw_vsock/vsock_loopback.c          |  4 +-
>>  10 files changed, 180 insertions(+), 43 deletions(-)
>> ---
>> base-commit: 0ea09cbf8350b70ad44d67a1dcb379008a356034
>> change-id: 20250312-vsock-netns-45da9424f726
>>
>> Best regards,
>> --
>> Bobby Eshleman <bobbyeshleman@gmail.com>
>>
>


