Return-Path: <linux-hyperv+bounces-6987-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A3FBA454A
	for <lists+linux-hyperv@lfdr.de>; Fri, 26 Sep 2025 17:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74B3D177765
	for <lists+linux-hyperv@lfdr.de>; Fri, 26 Sep 2025 15:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873FD1FBE87;
	Fri, 26 Sep 2025 15:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VpiC8pYb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A86213957E
	for <linux-hyperv@vger.kernel.org>; Fri, 26 Sep 2025 15:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758898944; cv=none; b=i3CGqVhnqcHm2Gd1CqtR6Q/Zf0yB7HESKf5A+ECMpzNttkckjF61JpnIMjqnnk2ve8Y0iGReeAmG/VulumLMQ1t7bJtC0itY85Wvd5P1E5mqH27AB1hjAI/2vnvZvHtW76izmJL6LxbOQRaKoFfgqaJR87VtpZAWyEB3r8ecj0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758898944; c=relaxed/simple;
	bh=Cs/84XxAXxX6tTTqn+kLkflAcjIdDxlMGi6PGFWdU8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0CxfROBq68bs9n4gCvdjC+9mTjFkbCjwMCMQ4aWEStIeRJLZoOYFfmS+vzHIc01uKNqYwjdZf0c0MnR/ewmnWiNdkIhmsskyV8I+rOAny5bVF0NAj5O12iSdkjlO9JJV9/O0q34hlDmBI8tEaL+Z3eRH3Z0IQU2IiwdUDn8kK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VpiC8pYb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758898940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=noZOuOVCvuhaRciLh0umvqzDccdwZKtJ1ZnIqPU5vcI=;
	b=VpiC8pYbV8ftzCgCVUUFANMM/1vs77V0EDcP3ij7FAkZcTgECddcLo/6A7fsjXyxh2UvLu
	7ASdKUhVUWXPYjrnS+T2U46elwAkf3YjbKRhmvTXEGStZ+DerV0eV84d+wUpLqo/xMpQxC
	I43DhARBn5iLtPoh22wRaZgJlM+m2SQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-f72w8V30OiSZwEjb-fYxqA-1; Fri, 26 Sep 2025 11:02:17 -0400
X-MC-Unique: f72w8V30OiSZwEjb-fYxqA-1
X-Mimecast-MFC-AGG-ID: f72w8V30OiSZwEjb-fYxqA_1758898936
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3f93db57449so1117720f8f.2
        for <linux-hyperv@vger.kernel.org>; Fri, 26 Sep 2025 08:02:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758898936; x=1759503736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=noZOuOVCvuhaRciLh0umvqzDccdwZKtJ1ZnIqPU5vcI=;
        b=QDrK5EneQFzy6vmTQeBQtrYTHqxTWAkDayaOENu7jJCC1HuuxBSOGyQot2bmADD3NP
         27CrF7FsG++OOYpxd8/dC5SEWUFilXYi1uVw4EZBJylqAi38PeJ8HA1e0bklL4bseNRl
         bPSO82sCsUa+QhUE7TVAeojFQNG3MDRxzqGPkIGo994fYRNGRR/9m5xL+Y90BLuI+f3R
         OW5wAbqLm6d1UpM8i9H4LvKMtz4n9mE8YxJJyylQBqFm4phX3DdszwW+4s6Y7z4y/3FF
         1K7oudZiBLELZ56EzYkSpq/FLPofN9w3zdWbsV0RHuH9KCMCehJfSoIp6UnPhKZpPs8X
         1aGg==
X-Forwarded-Encrypted: i=1; AJvYcCVp+DkmmYXBkdj2oijsK9VykzrqoxCHlyJt5j7+//5GqShzIDpmv8BcDAHr1cCaYGrSN9mg0XEyrP1Np3s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf3KCsg8GoRPRrPDagDlSQI6XOw82MNZblArSQRGsipKDYtrcD
	qwX8pAIsS5lLSVK0GPSIF4s/AGOb8p+Vbv1NQdKwEGzFmRt8qTKYVsyF4497HW3v6kLhoVzf/PN
	ZFq5ONTzMpe8sX2v9CeEH3jhazwKtzUk3VjJqXwH76zHWzGGjjO4/uNUrafs6/5Opww==
X-Gm-Gg: ASbGncss+N5Qp82orZ/BxaSfW9YK+YDTpvk+rHVPG3ARWpo0pBjtPCvOVuVkCilT+6J
	mmfW1H4PQtvL0P9x+HxFY72NO5N4eoNdMEQUbOHdWihUHWeLXKJUUKhK7bJr+moG40W4zmAfei/
	rAdqYVbSXGv+eLD1S20b6erhaozcne2886FdWKDrcCd3jVBr1S1TuL6VK1odE2LljGO6Nd2S50A
	AF1mNG/JDX13sVRI8XI3/uP6t46ttygkE/XVjYqhs2hbPguB6PZovI/VT0BRPUGKuUPr6IsiLbV
	YN0940vA74JNV0CAAs2CmYxrEokuY7T2WaOKDKSW
X-Received: by 2002:a05:6000:2907:b0:401:41a9:524f with SMTP id ffacd0b85a97d-40e4adce99dmr6567965f8f.29.1758898935198;
        Fri, 26 Sep 2025 08:02:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFp9n5wQpwde1tH3nQF00RbxIpJ1olb46GcoU3IRR/xtuLALGNwhpPij5ohfy6r8k5VTCZivQ==
X-Received: by 2002:a05:6000:2907:b0:401:41a9:524f with SMTP id ffacd0b85a97d-40e4adce99dmr6567911f8f.29.1758898934453;
        Fri, 26 Sep 2025 08:02:14 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.94.69])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc7d3780asm7290179f8f.52.2025.09.26.08.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 08:02:12 -0700 (PDT)
Date: Fri, 26 Sep 2025 17:01:56 +0200
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
Subject: Re: [PATCH net-next v6 4/9] vsock/loopback: add netns support
Message-ID: <evrzjpefb2e7m5idtr4sk3s4zdsnp6iecycpq4qglxode3kbor@vszhzmngupy2>
References: <20250916-vsock-vmtest-v6-0-064d2eb0c89d@meta.com>
 <20250916-vsock-vmtest-v6-4-064d2eb0c89d@meta.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250916-vsock-vmtest-v6-4-064d2eb0c89d@meta.com>

On Tue, Sep 16, 2025 at 04:43:48PM -0700, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add NS support to vsock loopback. Sockets in a global mode netns
>communicate with each other, regardless of namespace. Sockets in a local
>mode netns may only communicate with other sockets within the same
>namespace.
>
>Use pernet_ops to install a vsock_loopback for every namespace that is
>created (to be used if local mode is enabled).
>
>Retroactively call init/exit on every namespace when the vsock_loopback
>module is loaded in order to initialize the per-ns device.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>
>---
>Changes in v6:
>- init pernet ops for vsock_loopback module
>- vsock_loopback: add space in struct to clarify lock protection
>- do proper cleanup/unregister on vsock_loopback_exit()
>- vsock_loopback: use virtio_vsock_skb_net()
>
>Changes in v5:
>- add callbacks code to avoid reverse dependency
>- add logic for handling vsock_loopback setup for already existing
>  namespaces
>---
> include/net/af_vsock.h         |  1 +
> include/net/netns/vsock.h      |  6 +++
> net/vmw_vsock/vsock_loopback.c | 98 ++++++++++++++++++++++++++++++++++++++----
> 3 files changed, 97 insertions(+), 8 deletions(-)

Just tried to boot a Fedora 42 VM with these patches applied on top of
master, commit 4ff71af020ae ("Merge tag 'net-6.17-rc8' of 
git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")

And during the boot I have this:

[    5.117627] systemd[1]: Detected virtualization kvm.
[    5.117650] systemd[1]: Detected architecture x86-64.
[    5.141282] systemd[1]: bpf-restrict-fs: BPF LSM hook not enabled in the kernel, BPF LSM not supported.
[    5.317525] NET: Registered PF_VSOCK protocol family
[    5.320496] Guest personality initialized and is inactive
[    5.320960] VMCI host device registered (name=vmci, major=10, minor=259)
[    5.320965] Initialized host personality
[    5.465051] ------------[ cut here ]------------
[    5.465068] WARNING: CPU: 1 PID: 297 at net/vmw_vsock/vsock_loopback.c:164 vsock_loopback_init_net+0x4a/0x60 [vsock_loopback]
[    5.465081] Modules linked in: vsock_loopback(+) vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vmw_vmci vsock virtio_rng rng_core
[    5.465115] CPU: 1 UID: 0 PID: 297 Comm: modprobe Not tainted 6.17.0-rc7-ste-00128-gcb48f49ce0ac #40 PREEMPT(none)
[    5.465123] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.17.0-5.fc42 04/01/2014
[    5.465127] RIP: 0010:vsock_loopback_init_net+0x4a/0x60 [vsock_loopback]
[    5.465134] Code: 48 8b 3d b9 43 22 c2 e8 e4 e9 53 c1 48 89 83 e8 0e 
00 00 48 85 c0 74 1b 48 89 c7 e8 f0 fe ff ff 48 8b 5d f8 c9 c3 cc cc cc 
cc <0f> 0b 31 c0 c3 cc cc cc cc b8 f4 ff ff ff eb e6 66 0f 1f 44 00 00
[    5.465140] RSP: 0018:ffffc900002afb48 EFLAGS: 00010286
[    5.465147] RAX: ffffffff836c8798 RBX: 0000000000000000 RCX: ffffffffc0015056
[    5.465151] RDX: 0000000000000000 RSI: 0000000000000100 RDI: ffffffff836c8700
[    5.465155] RBP: ffffc900002afb60 R08: ffff88800c0bd378 R09: 00000000f4197968
[    5.465159] R10: 0000000000000200 R11: 0000000003ad91eb R12: ffffffff836c8700
[    5.465163] R13: ffffffffc023f240 R14: ffffffffc0015010 R15: 0000000000000000
[    5.465172] FS:  00007f2f6c3e1b80(0000) GS:ffff8880fb4d2000(0000) 
knlGS:0000000000000000
[    5.465192] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.465196] CR2: 00007f27ae2e7000 CR3: 000000000b436001 CR4: 0000000000770ef0
[    5.465200] PKRU: 55555554
[    5.465203] Call Trace:
[    5.465206]  <TASK>
[    5.465210]  ? vsock_loopback_init+0x6c/0xff0 [vsock_loopback]
[    5.465217]  do_one_initcall+0x73/0x2d0
[    5.465233]  do_init_module+0x65/0x210
[    5.465243]  load_module+0x1a6e/0x1cf0
[    5.465256]  init_module_from_file+0x92/0xd0
[    5.465260]  ? init_module_from_file+0x92/0xd0
[    5.465269]  idempotent_init_module+0x12d/0x340
[    5.465278]  __x64_sys_finit_module+0x60/0xb0
[    5.465284]  x64_sys_call+0x18a0/0x1d80
[    5.465291]  do_syscall_64+0x73/0x320
[    5.465302]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    5.465307] RIP: 0033:0x7f2f6c4d60cd
[    5.465312] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 03 4d 0f 00 f7 d8 64 89 01 48
[    5.465317] RSP: 002b:00007ffe7166e7a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[    5.465323] RAX: ffffffffffffffda RBX: 000055d75bab9e40 RCX: 00007f2f6c4d60cd
[    5.465326] RDX: 0000000000000000 RSI: 000055d75bab15ee RDI: 0000000000000005
[    5.465330] RBP: 00007ffe7166e860 R08: 0000000000000000 R09: 000055d75baba520
[    5.465333] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000040000
[    5.465336] R13: 000055d75baba940 R14: 000055d75bab15ee R15: 0000000000000000
[    5.465391]  </TASK>
[    5.465395] irq event stamp: 15179
[    5.465399] hardirqs last  enabled at (15185): [<ffffffff81350e9e>] __up_console_sem+0x5e/0x80
[    5.465407] hardirqs last disabled at (15190): [<ffffffff81350e83>] __up_console_sem+0x43/0x80
[    5.465411] softirqs last  enabled at (15172): [<ffffffff812d2e21>] 
irq_exit_rcu+0x61/0xb0
[    5.465419] softirqs last disabled at (15165): [<ffffffff812d2e21>] irq_exit_rcu+0x61/0xb0
[    5.465425] ---[ end trace 0000000000000000 ]---

And could be related to a potential issue I see in vsock_loopback_init() 
(see comment later).

>
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index 628e35ae9d00..5180b7dbb6d6 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -320,4 +320,5 @@ static inline bool vsock_net_check_mode(struct vsock_sock *vsk, struct net *net,
>
> 	return orig_net_mode == VSOCK_NET_MODE_GLOBAL && vsk->orig_net_mode == VSOCK_NET_MODE_GLOBAL;
> }
>+
> #endif /* __AF_VSOCK_H__ */
>diff --git a/include/net/netns/vsock.h b/include/net/netns/vsock.h
>index d4593c0b8dc4..a32d546793a2 100644
>--- a/include/net/netns/vsock.h
>+++ b/include/net/netns/vsock.h
>@@ -9,6 +9,8 @@ enum vsock_net_mode {
> 	VSOCK_NET_MODE_LOCAL,
> };
>
>+struct vsock_loopback;
>+
> struct netns_vsock {
> 	struct ctl_table_header *vsock_hdr;
> 	spinlock_t lock;
>@@ -16,5 +18,9 @@ struct netns_vsock {
> 	/* protected by lock */
> 	enum vsock_net_mode mode;
> 	bool written;
>+
>+#if IS_ENABLED(CONFIG_VSOCKETS_LOOPBACK)
>+	struct vsock_loopback *loopback;
>+#endif

Honestly, I don't really like having something specific to a transport 
here. Could we have something more generic to allow a generic transport 
to register private data?

(It's not a strong opinion; we can resolve it in the future when we will 
have support for more transports if it's complicated)

> };
> #endif /* __NET_NET_NAMESPACE_VSOCK_H */
>diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
>index 1b2fab73e0d0..134e0619de07 100644
>--- a/net/vmw_vsock/vsock_loopback.c
>+++ b/net/vmw_vsock/vsock_loopback.c
>@@ -28,8 +28,16 @@ static u32 vsock_loopback_get_local_cid(void)
>
> static int vsock_loopback_send_pkt(struct sk_buff *skb)
> {
>-	struct vsock_loopback *vsock = &the_vsock_loopback;
>+	struct vsock_loopback *vsock;
> 	int len = skb->len;
>+	struct net *net;
>+
>+	net = virtio_vsock_skb_net(skb);
>+
>+	if (net && net->vsock.mode == VSOCK_NET_MODE_LOCAL)

Can `net` be NULL ?
If not, I'd print a warning or return an error.

>+		vsock = net->vsock.loopback;
>+	else
>+		vsock = &the_vsock_loopback;
>
> 	virtio_vsock_skb_queue_tail(&vsock->pkt_queue, skb);
> 	queue_work(vsock->workqueue, &vsock->pkt_work);
>@@ -134,27 +142,99 @@ static void vsock_loopback_work(struct work_struct *work)
> 	}
> }
>
>-static int __init vsock_loopback_init(void)
>+static int vsock_loopback_init_vsock(struct vsock_loopback *vsock)
> {
>-	struct vsock_loopback *vsock = &the_vsock_loopback;
>-	int ret;
>-
> 	vsock->workqueue = alloc_workqueue("vsock-loopback", 0, 0);
> 	if (!vsock->workqueue)
> 		return -ENOMEM;
>
> 	skb_queue_head_init(&vsock->pkt_queue);
> 	INIT_WORK(&vsock->pkt_work, vsock_loopback_work);

nit: leave a blank line here.

>+	return 0;
>+}
>+
>+static void vsock_loopback_deinit_vsock(struct vsock_loopback *vsock)
>+{
>+	if (vsock->workqueue)
>+		destroy_workqueue(vsock->workqueue);
>+}
>+
>+static int vsock_loopback_init_net(struct net *net)
>+{
>+	if (WARN_ON_ONCE(net->vsock.loopback))
>+		return 0;
>+
>+	net->vsock.loopback = kmalloc(sizeof(*net->vsock.loopback), GFP_KERNEL);
>+	if (!net->vsock.loopback)
>+		return -ENOMEM;
>+
>+	return vsock_loopback_init_vsock(net->vsock.loopback);
>+}
>+
>+static void vsock_loopback_exit_net(struct net *net)
>+{
>+	if (net->vsock.loopback) {
>+		vsock_loopback_deinit_vsock(net->vsock.loopback);
>+		kfree(net->vsock.loopback);
>+		net->vsock.loopback = NULL;
>+	}
>+}
>+
>+static void vsock_loopback_deinit_all(void)
>+{
>+	struct net *net;
>+
>+	down_read(&net_rwsem);
>+	for_each_net(net)
>+		vsock_loopback_exit_net(net);
>+	up_read(&net_rwsem);
>+}
>+
>+static struct pernet_operations vsock_loopback_net_ops = {
>+	.init = vsock_loopback_init_net,
>+	.exit = vsock_loopback_exit_net,
>+};
>+
>+static int __init vsock_loopback_init(void)
>+{
>+	struct vsock_loopback *vsock = &the_vsock_loopback;
>+	struct net *net;
>+	int ret;
>+
>+	ret = vsock_loopback_init_vsock(vsock);
>+	if (ret < 0)
>+		return ret;
>+
>+	ret = register_pernet_subsys(&vsock_loopback_net_ops);
>+	if (ret < 0)
>+		goto out_deinit_vsock;
>+
>+	/* call callbacks on any net previously created */
>+	down_read(&net_rwsem);

This could be related to the trace I posted on top.

Should we move the register_pernet_subsys() in the section protected by 
`net_rwsem`?

Because if a net is created just after this code returns from 
`register_pernet_subsys()`, we are going to call 
vsock_loopback_init_net() again here in this loop, no?


>+	for_each_net(net) {
>+		ret = vsock_loopback_init_net(net);
>+		if (ret < 0)
>+			break;
>+	}
>+	up_read(&net_rwsem);
>+
>+	/* undo any initializations that succeeded */

useless comment.

>+	if (ret < 0)
>+		goto out_deinit_pernet_vsock;

I'd move in the for block calling `up_read` before the goto, but not a 
strong opinion.

>
> 	ret = vsock_core_register(&loopback_transport.transport,
> 				  VSOCK_TRANSPORT_F_LOCAL);
> 	if (ret)
>-		goto out_wq;
>+		goto out_deinit_pernet_vsock;
>+
>
> 	return 0;
>
>-out_wq:
>-	destroy_workqueue(vsock->workqueue);
>+out_deinit_pernet_vsock:
>+	vsock_loopback_deinit_all();
>+	unregister_pernet_subsys(&vsock_loopback_net_ops);

What happen if a net is created after vsock_loopback_deinit_all()?
Should we do the opposite?
Or the unregister_pernet_subsys() should be called in the `net_rwsem` 
section?

>+out_deinit_vsock:
>+	vsock_loopback_deinit_vsock(vsock);
> 	return ret;
> }
>
>@@ -164,6 +244,8 @@ static void __exit vsock_loopback_exit(void)
>
> 	vsock_core_unregister(&loopback_transport.transport);
>
>+	vsock_loopback_deinit_all();
>+

Should we call also `unregister_pernet_subsys()` ?
Or in some way is automatically called since we are exiting?

Thanks,
Stefano

> 	flush_work(&vsock->pkt_work);
>
> 	virtio_vsock_skb_queue_purge(&vsock->pkt_queue);
>
	destroy_workqueue(vsock->workqueue);

What about replacing this with `vsock_loopback_deinit_vsock()` ?

Just to follow what we do in `vsock_loopback_init`.

Thanks,
Stefano


