Return-Path: <linux-hyperv+bounces-7436-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D189AC3C6D7
	for <lists+linux-hyperv@lfdr.de>; Thu, 06 Nov 2025 17:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66D3A620775
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Nov 2025 16:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939F83570A0;
	Thu,  6 Nov 2025 16:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CQKAiqtd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="naptq2FY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01313563F4
	for <linux-hyperv@vger.kernel.org>; Thu,  6 Nov 2025 16:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762445937; cv=none; b=p63pvSBuJxyjzlHG5U0v2xXR3LFx7D68taQOSnGtQTfNwvsj44ZV28BL60Sq1a1vzpFXhmKZwocwHiZ09gKKJxM5GQ/ad2/E5DQUIsFq55xkcuSyTb083bVacJFFE1asdVW8zqby51Wtq2TtukZTmGm4PWoxQQZ0Ty2/bnih86Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762445937; c=relaxed/simple;
	bh=P6dqZEO6asp6iI5HNxSfu9qxJ1GAnGbKVOQiwtyp9f0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTdeEQgtXtmI4HuqUjEzacE5LRZWsr2qL7bHMDeAZUaFEPIeyc2w3i+UK0kG6DLqQAGppHpRMA1xpuz7utBhfQ23fnXWhMeBwkhG1uglpziQctE0Nifcx89g/RBxbFlB8sqqh1RKMPsqyo0rx5LNmxHcUYpBDAIHYxMJqa9koGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CQKAiqtd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=naptq2FY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762445935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HlaSIzfnjC1rglQ5EMwdrXBGdH8/0geumBayPNyr3uQ=;
	b=CQKAiqtdcCdCJaRnUC4cXUP3CiFotSvF8TkE1vIUlf8hyCQ7aZpL4e1srbGaKhwNJJrQtq
	+/OBaUZHx3bWMD9lgoS3B2DeOYZhjlC3vW2EhfhOm+Ffrim+suTfRfGRa1CpBzU+mg6d/G
	jiokImjolZiU3qAdileDSyLRnJpySP8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-kLEKxj8TMpmYSSTeQfflZA-1; Thu, 06 Nov 2025 11:18:43 -0500
X-MC-Unique: kLEKxj8TMpmYSSTeQfflZA-1
X-Mimecast-MFC-AGG-ID: kLEKxj8TMpmYSSTeQfflZA_1762445923
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47754e6bddbso9310295e9.3
        for <linux-hyperv@vger.kernel.org>; Thu, 06 Nov 2025 08:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762445922; x=1763050722; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HlaSIzfnjC1rglQ5EMwdrXBGdH8/0geumBayPNyr3uQ=;
        b=naptq2FY7vSy6FB81bWqWweXzkkfSANvNAOsfCt7jdTi8zUsspJAuzTbEFHsLhWyVV
         Iuh+DSI02FpkpGfOyGdH5Z1qJOP52LlN8PMHKGCVGNFj8tZ+CAOj8ZTg5DKHXKthWOEQ
         0ckrpwdpyVS9f/+4Anqcw+8Dx8D4+rgsbontvpkJjbN+2eljAeLg9kLr+GiOyXbRo0L5
         o0AiiCM41C+2hPMzKrhSg+9FgzH8tNnZyQ2s0hY6r8mLNUehUZQ+/WX6FkLbydRWDypx
         NTQqLvYAzNxfCuxcGznAqxNxtH97qXY/AZiCRlWTOpx/iA2P0sZGxHvQn8YJ8XcPMI3l
         T6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762445922; x=1763050722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlaSIzfnjC1rglQ5EMwdrXBGdH8/0geumBayPNyr3uQ=;
        b=fpymcYGK6VOawFmJ5P/MCRjRbhv6f+AwtFqUnDrDXibTN0FSot1bP5AqqR18ubBTe0
         X6uclvwHxUUOYj1s+o35zzj9wbf6Ol1n+1ZpSPu03gP7WsTpFdqcSllpPQHKa3Ebw3DV
         suz6AbRTxlTdwwmp7Hw7GXvFWBwxDwjXxdHoro9nlZViiHPQbwKUFXM+ccXYOe3kDnI0
         d7BEoDLJIfak5viuVa2yGuCPVbXXYMKD2eHjrQ1EuB547gHxxd3i2oou4oEPTql5JwVV
         2Z1QX17ZRQzOMfCmsxXxyzxMUU7Ntb0oLmH2sX9s8Mi9LFNeTuk90IJsDyS4xhxn5g/l
         bsCA==
X-Forwarded-Encrypted: i=1; AJvYcCUpe/VI7mDrBlcP1bOHbBpFM0G6PEnx7t3ssldFbT9iOlmUOata/VSI9QjfYSt6K3T6q1UlltExoh7lh8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWfRTkCvyPa5J3AEvQnhYqiZNreJu1wJvqpWrvo8aQh0LqUnKK
	bBjxZqNjo4TVoSwl57A2MLcIS/SnV4+diBfVnhkPbasEEQ9XoejAeDNs3eF8wwIx0LvJxyd3zAB
	PFnE+UPlSqoFspHYC1JnuGUZgoRSnR9nCUJhnjO6UXvsDUWFEReksQJ8RFf89CafQ7w==
X-Gm-Gg: ASbGncv24PC3Hl2Kp4fePs+3GPmHO0xQUwpmP7lf8OOmnMgwaMfu9987KAmEEzpXEbI
	oAV1szVFtQ7qPKSBi9FKxw4AuaKE/+oMnZoO9NkBFigpDySjj8NIjQtwlsWPscqMGXIPi2ZsghL
	xRC2P3NtogAahByoddYPVrPdy4elCeBEE6BGo8f69QaGe9mGYtTkKlXGvfv2J4gKzS0WpzbVrh3
	lfnGB77TB1eOcDDfuh9KRGqPADzkNvcxSgh/jigdB2dX/hnzIwAGZi3GfbYNjBlIUU0376Vk/F4
	PX/Tdz6i4QsDhPKV8ltiWwR6fU94bOmWX2CaDfppPaJLIgtx78loGdViuS7FW7zGdwIDs3pjvIc
	4GQ==
X-Received: by 2002:a05:600c:5251:b0:470:fe3c:a3b7 with SMTP id 5b1f17b1804b1-4775cdbd546mr60024895e9.5.1762445922528;
        Thu, 06 Nov 2025 08:18:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFP/WvasiwYTgtNLqdi1/A6yt0PQxbP4Abxbsn2GMIJwekrkfT7LDMidIZ3T6Hr6zobvw5ZaQ==
X-Received: by 2002:a05:600c:5251:b0:470:fe3c:a3b7 with SMTP id 5b1f17b1804b1-4775cdbd546mr60024435e9.5.1762445921975;
        Thu, 06 Nov 2025 08:18:41 -0800 (PST)
Received: from sgarzare-redhat ([78.209.9.120])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477626eb4fdsm55397145e9.17.2025.11.06.08.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 08:18:41 -0800 (PST)
Date: Thu, 6 Nov 2025 17:18:36 +0100
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
Subject: Re: [PATCH net-next v8 05/14] vsock/loopback: add netns support
Message-ID: <tuclqrdg5p2uzfvczhcdig7jlifvhqtlafe4xcqy4x4p3vrya6@jq5mujdluze5>
References: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
 <20251023-vsock-vmtest-v8-5-dea984d02bb0@meta.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251023-vsock-vmtest-v8-5-dea984d02bb0@meta.com>

On Thu, Oct 23, 2025 at 11:27:44AM -0700, Bobby Eshleman wrote:
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
>---

I'm a bit confused, should we move this after the next patch that add 
support of netns in the virtio common module?

Or this is a pre-requisite?

>Changes in v7:
>- drop for_each_net() init/exit, drop net_rwsem, the pernet registration
>  handles this automatically and race-free
>- flush workqueue before destruction, purge pkt list
>- remember net_mode instead of current net mode
>- keep space after INIT_WORK()
>- change vsock_loopback in netns_vsock to ->priv void ptr
>- rename `orig_net_mode` to `net_mode`
>- remove useless comment
>- protect `register_pernet_subsys()` with `net_rwsem`
>- do cleanup before releasing `net_rwsem` when failure happens
>- call `unregister_pernet_subsys()` in `vsock_loopback_exit()`
>- call `vsock_loopback_deinit_vsock()` in `vsock_loopback_exit()`
>
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
> include/net/netns/vsock.h      |  2 +
> net/vmw_vsock/vsock_loopback.c | 85 ++++++++++++++++++++++++++++++++++++------
> 2 files changed, 75 insertions(+), 12 deletions(-)
>
>diff --git a/include/net/netns/vsock.h b/include/net/netns/vsock.h
>index c9a438ad52f2..9d0d8e2fbc37 100644
>--- a/include/net/netns/vsock.h
>+++ b/include/net/netns/vsock.h
>@@ -16,5 +16,7 @@ struct netns_vsock {
> 	/* protected by lock */
> 	enum vsock_net_mode mode;
> 	bool mode_locked;
>+
>+	void *priv;
> };
> #endif /* __NET_NET_NAMESPACE_VSOCK_H */
>diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
>index a8f218f0c5a3..474083d4cfcb 100644
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
>+	if (virtio_vsock_skb_net_mode(skb) == VSOCK_NET_MODE_LOCAL)
>+		vsock = (struct vsock_loopback *)net->vsock.priv;

Is there some kind of refcount on the net?
What I mean is, are we sure this pointer is still valid? Could the net 
disappear in the meantime?

The rest LGTM!

Thanks,
Stefano

>+	else
>+		vsock = &the_vsock_loopback;
>
> 	virtio_vsock_skb_queue_tail(&vsock->pkt_queue, skb);
> 	queue_work(vsock->workqueue, &vsock->pkt_work);
>@@ -134,11 +142,8 @@ static void vsock_loopback_work(struct work_struct *work)
> 	}
> }
>
>-static int __init vsock_loopback_init(void)
>+static int vsock_loopback_init_vsock(struct vsock_loopback *vsock)
> {
>-	struct vsock_loopback *vsock = &the_vsock_loopback;
>-	int ret;
>-
> 	vsock->workqueue = alloc_workqueue("vsock-loopback", WQ_PERCPU, 0);
> 	if (!vsock->workqueue)
> 		return -ENOMEM;
>@@ -146,15 +151,73 @@ static int __init vsock_loopback_init(void)
> 	skb_queue_head_init(&vsock->pkt_queue);
> 	INIT_WORK(&vsock->pkt_work, vsock_loopback_work);
>
>+	return 0;
>+}
>+
>+static void vsock_loopback_deinit_vsock(struct vsock_loopback *vsock)
>+{
>+	if (vsock->workqueue) {
>+		flush_work(&vsock->pkt_work);
>+		virtio_vsock_skb_queue_purge(&vsock->pkt_queue);
>+		destroy_workqueue(vsock->workqueue);
>+		vsock->workqueue = NULL;
>+	}
>+}
>+
>+static int vsock_loopback_init_net(struct net *net)
>+{
>+	int ret;
>+
>+	net->vsock.priv = kzalloc(sizeof(struct vsock_loopback), GFP_KERNEL);
>+	if (!net->vsock.priv)
>+		return -ENOMEM;
>+
>+	ret = vsock_loopback_init_vsock((struct vsock_loopback *)net->vsock.priv);
>+	if (ret < 0) {
>+		kfree(net->vsock.priv);
>+		net->vsock.priv = NULL;
>+		return ret;
>+	}
>+
>+	return 0;
>+}
>+
>+static void vsock_loopback_exit_net(struct net *net)
>+{
>+	vsock_loopback_deinit_vsock(net->vsock.priv);
>+	kfree(net->vsock.priv);
>+	net->vsock.priv = NULL;
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
> 	ret = vsock_core_register(&loopback_transport.transport,
> 				  VSOCK_TRANSPORT_F_LOCAL);
> 	if (ret)
>-		goto out_wq;
>+		goto out_unregister_pernet_subsys;
>
> 	return 0;
>
>-out_wq:
>-	destroy_workqueue(vsock->workqueue);
>+out_unregister_pernet_subsys:
>+	unregister_pernet_subsys(&vsock_loopback_net_ops);
>+out_deinit_vsock:
>+	vsock_loopback_deinit_vsock(vsock);
> 	return ret;
> }
>
>@@ -164,11 +227,9 @@ static void __exit vsock_loopback_exit(void)
>
> 	vsock_core_unregister(&loopback_transport.transport);
>
>-	flush_work(&vsock->pkt_work);
>-
>-	virtio_vsock_skb_queue_purge(&vsock->pkt_queue);
>+	unregister_pernet_subsys(&vsock_loopback_net_ops);
>
>-	destroy_workqueue(vsock->workqueue);
>+	vsock_loopback_deinit_vsock(vsock);
> }
>
> module_init(vsock_loopback_init);
>
>-- 
>2.47.3
>


