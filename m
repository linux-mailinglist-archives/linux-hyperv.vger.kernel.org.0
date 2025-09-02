Return-Path: <linux-hyperv+bounces-6700-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F41CBB4092E
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Sep 2025 17:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E0624E6DA5
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Sep 2025 15:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C799324B15;
	Tue,  2 Sep 2025 15:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zkxupd1z"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A5E324B0F
	for <linux-hyperv@vger.kernel.org>; Tue,  2 Sep 2025 15:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756827585; cv=none; b=Pu5ZK48KdNGHFU+dnYIbANkD5RyCoiyCnifnNXbO++LynTgfZu+cE3cFTeCs6MEgpYo+KPViiWDfhkfnaklvMPaCdBgLpTIur/7XK5D088K96edFDMMCJiPSy62cGYyr6OeC2ha2YK+NsmFXz3MuI+fVYqh6tpSkLn7skldcRHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756827585; c=relaxed/simple;
	bh=ijK/+xIpeN17dxbQHbMOG2ke44a1MFr4g1HJn02UfSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ft9hSxstZKD+WUfQ13vJ8e/ZmpkbQxQa7fBCPnR4xkZhBoZvJtlHrG/0WUMCNGmEEgX0LT4GBPqQ5sBQi95Z257qbYSPMnmzwWTG/CsAa8I51ZeRHR4FxPCfL2itDkXzmQgvA2mONqyrLfRRQU+SqyIsyokARCbwb+Eqrr2rs/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zkxupd1z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756827582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SQaincXKmSrmm4miwZrh+ORA+WjmxLVBDz6USAiGAKA=;
	b=Zkxupd1z83G+Hc42wg3vld4L04IZET85OzZiSubPY2GvAQB85JLlsShDoNo3Yrt/mzC97v
	HpL+h/JffbJ4tt+mTtVAXrEo8woGWkemKFjWXz9H4NPrAPE/uo6ek+klbR7evwCCZGvqD2
	IwDGs9VYnkl+46hfS0Qv4+tqcGNzE6Y=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-oAsVPJc7MAO5kIoX4nZ2DQ-1; Tue, 02 Sep 2025 11:39:41 -0400
X-MC-Unique: oAsVPJc7MAO5kIoX4nZ2DQ-1
X-Mimecast-MFC-AGG-ID: oAsVPJc7MAO5kIoX4nZ2DQ_1756827580
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7fa717ff66bso1133746185a.3
        for <linux-hyperv@vger.kernel.org>; Tue, 02 Sep 2025 08:39:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756827580; x=1757432380;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQaincXKmSrmm4miwZrh+ORA+WjmxLVBDz6USAiGAKA=;
        b=fFhKACofB5e3WH6bkA8hPB7I5O0tEh31blk9ItCj/cfgPfBw+uIPqa+grCLXdDaiaG
         1wb/YUu8Z3llfHEdtBEk003mSpLxWeADd3HkRVlQoGlKyRBddB6SsOzQeJGDEMS5vWbI
         zoAV7WQKLPUb2UnoHC7u9qtXyriX7I97/eKhuz3cylvgOZY0aR3pl8FxdeIrP4GgYD1z
         Fq0ISSytJ7kaiP/cYZzwIKVzKSkJPvN6l0Y3WvRdbRwmeBg8Kq0Ye7CW7CB9PrxoA+UY
         x9pBJSlMjMQOV3sCLJtHIYnwAvIdZPiju0wYfrKSgu6uskf8WD7rI+fkFsgXZ/LuGfAb
         rG+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXd9M9V/NwcjIdxCD27RpPwpWMkvS6v5O4LTx8qti3PRvoCy5DQMqeEcE95tJJDxYyBkheaEL+cTxsKqR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI9XqVHikdWzMpDPRzbiNTFzUjvTYDYr+08LDJ9tckhfXn40Kv
	6tqJjuERkKnW9FXm+6zFZlHB68dWY7rj0IVDpXmZ54fDtk3k8YyiESzsBn3RWUbLJ7eJTaCgzt1
	+g1R8d1OB1xe1jrn8MWoxugH44vlNB9VH2dEbJJQLJQZVxpcJRw2weLrDNhWc2lFCTg==
X-Gm-Gg: ASbGnctFXC7xs5+HRa4e1nkrQHH4+uKkZ7Vz6b/otFVHjJ8D8Jwug2ohlAykBHZP9/O
	IeQMHieF6CV60VhOVjDaJehBJiv+4kT9OJjcU8WCuZQb7kpPE/2qsqqSuetPIUl8uS1CjRv6Rui
	QsBBbZXbucpHyFsKyqN9+GmsMN+DYWUcq0fr+0GxqiLfkVjplSdUoPHJdSeblksqADKJP4cu0uP
	i2k6vDPhQuiVGkFK5ULhJbDb0ThK3MrxskaWD/jOkEATADEszqWlSXxfgb5zj6Bl+FAfFg0Jsq/
	Jp+Sx8Q6NtWnqSCbBXpkwLWe2ClmShzns1D/okuKIRDD3QoJ0lN4XdfQQBOS31DrXnktVk3dHqF
	GYRivMQg4BmV4Eqli
X-Received: by 2002:a05:620a:372a:b0:7e8:17a6:df7a with SMTP id af79cd13be357-7ff2aa20761mr1338558585a.52.1756827580101;
        Tue, 02 Sep 2025 08:39:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6/y08WKJpx5mnjw2i65ALVd9fFwq5cYei6ST/nQhexfxqSk9Y8GAx8rFFbyj8AxVhJpr5Gw==
X-Received: by 2002:a05:620a:372a:b0:7e8:17a6:df7a with SMTP id af79cd13be357-7ff2aa20761mr1338552085a.52.1756827579403;
        Tue, 02 Sep 2025 08:39:39 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-185-93.business.telecomitalia.it. [87.12.185.93])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-80918cbf80csm31703885a.43.2025.09.02.08.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 08:39:38 -0700 (PDT)
Date: Tue, 2 Sep 2025 17:39:33 +0200
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
Subject: Re: [PATCH net-next v5 4/9] vsock/loopback: add netns support
Message-ID: <mhjgn7fdztfqi6ku3gesgd42jj5atn4sqnvpyncw2jds23dpc3@iiupljayjxs4>
References: <20250827-vsock-vmtest-v5-0-0ba580bede5b@meta.com>
 <20250827-vsock-vmtest-v5-4-0ba580bede5b@meta.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250827-vsock-vmtest-v5-4-0ba580bede5b@meta.com>

On Wed, Aug 27, 2025 at 05:31:32PM -0700, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add NS support to vsock loopback. Sockets in a global mode netns
>communicate with each other, regardless of namespace. Sockets in a local
>mode netns may only communicate with other sockets within the same
>namespace.
>
>Add callbacks for transport to hook into the initialization and exit of
>net namespaces.
>
>The transport's init hook will be called once per netns init. Likewise
>for exit.
>
>When a set of init/exit callbacks is registered, the init callback is
>called on each already existing namespace.
>
>Only one callback registration is supported for now. Currently
>vsock_loopback is the only user.

Why?

In general, commit descriptions (and code comments) should focus on the 
reason (why?) to simplify also the review.

>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>
>---
>Changes in v5:
>- add callbacks code to avoid reverse dependency
>- add logic for handling vsock_loopback setup for already existing
>  namespaces
>---
> include/net/af_vsock.h         |  34 +++++++++++++
> include/net/netns/vsock.h      |   5 ++
> net/vmw_vsock/af_vsock.c       | 110 +++++++++++++++++++++++++++++++++++++++++
> net/vmw_vsock/vsock_loopback.c |  72 ++++++++++++++++++++++++---
> 4 files changed, 213 insertions(+), 8 deletions(-)
>
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index 83f873174ba3..9333a98b9a1e 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -305,4 +305,38 @@ static inline bool vsock_net_check_mode(struct net *n1, struct net *n2)
> 	       (vsock_net_mode(n1) == VSOCK_NET_MODE_GLOBAL &&
> 		vsock_net_mode(n2) == VSOCK_NET_MODE_GLOBAL);
> }
>+
>+struct vsock_net_callbacks {
>+	int (*init)(struct net *net);
>+	void (*exit)(struct net *net);
>+	struct module *owner;
>+};
>+
>+#if IS_ENABLED(CONFIG_VSOCKETS_LOOPBACK)
>+
>+#define vsock_register_net_callbacks(__init, __exit) \
>+	__vsock_register_net_callbacks((__init), (__exit), THIS_MODULE)
>+
>+int __vsock_register_net_callbacks(int (*init)(struct net *net),
>+				   void (*exit)(struct net *net),
>+				   struct module *owner);
>+void vsock_unregister_net_callbacks(void);
>+
>+#else
>+
>+#define vsock_register_net_callbacks(__init, __exit) do { } while (0)
>+
>+static inline int __vsock_register_net_callbacks(int (*init)(struct net *net),
>+						 void (*exit)(struct net *net),
>+						 struct module *owner)
>+{
>+	return 0;
>+}
>+
>+static inline void vsock_unregister_net_callbacks(void) {}
>+static inline int vsock_net_call_init(struct net *net) { return 0; }
>+static inline void vsock_net_call_exit(struct net *net) {}
>+
>+#endif /* CONFIG_VSOCKETS_LOOPBACK */
>+
> #endif /* __AF_VSOCK_H__ */
>diff --git a/include/net/netns/vsock.h b/include/net/netns/vsock.h
>index d4593c0b8dc4..08d9a933c540 100644
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
>@@ -16,5 +18,8 @@ struct netns_vsock {
> 	/* protected by lock */
> 	enum vsock_net_mode mode;
> 	bool written;
>+#if IS_ENABLED(CONFIG_VSOCKETS_LOOPBACK)
>+	struct vsock_loopback *loopback;

If this is not protected by `lock`, please leave an empty line, but 
maybe we should consider using locking (see comment later).

>+#endif
> };
> #endif /* __NET_NET_NAMESPACE_VSOCK_H */
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 68a8875c8106..5a73d9e1a96f 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -134,6 +134,9 @@
> #include <uapi/linux/vm_sockets.h>
> #include <uapi/asm-generic/ioctls.h>
>
>+static struct vsock_net_callbacks vsock_net_callbacks;
>+static DEFINE_MUTEX(vsock_net_callbacks_lock);
>+
> static int __vsock_bind(struct sock *sk, struct sockaddr_vm *addr);
> static void vsock_sk_destruct(struct sock *sk);
> static int vsock_queue_rcv_skb(struct sock *sk, struct sk_buff *skb);
>@@ -2781,6 +2784,49 @@ static void vsock_net_init(struct net *net)
> 	net->vsock.mode = VSOCK_NET_MODE_GLOBAL;
> }
>
>+#if IS_ENABLED(CONFIG_VSOCKETS_LOOPBACK)
>+static int vsock_net_call_init(struct net *net)
>+{
>+	struct vsock_net_callbacks *cbs;
>+	int ret;
>+
>+	mutex_lock(&vsock_net_callbacks_lock);
>+	cbs = &vsock_net_callbacks;
>+
>+	ret = 0;
>+	if (!cbs->owner)
>+		goto out;
>+
>+	if (try_module_get(cbs->owner)) {
>+		ret = cbs->init(net);
>+		module_put(cbs->owner);
>+	}
>+
>+out:
>+	mutex_unlock(&vsock_net_callbacks_lock);
>+	return ret;
>+}
>+
>+static void vsock_net_call_exit(struct net *net)
>+{
>+	struct vsock_net_callbacks *cbs;
>+
>+	mutex_lock(&vsock_net_callbacks_lock);
>+	cbs = &vsock_net_callbacks;
>+
>+	if (!cbs->owner)
>+		goto out;
>+
>+	if (try_module_get(cbs->owner)) {
>+		cbs->exit(net);
>+		module_put(cbs->owner);
>+	}
>+
>+out:
>+	mutex_unlock(&vsock_net_callbacks_lock);
>+}
>+#endif /* CONFIG_VSOCKETS_LOOPBACK */
>+
> static __net_init int vsock_sysctl_init_net(struct net *net)
> {
> 	vsock_net_init(net);
>@@ -2788,12 +2834,20 @@ static __net_init int vsock_sysctl_init_net(struct net *net)
> 	if (vsock_sysctl_register(net))
> 		return -ENOMEM;
>
>+	if (vsock_net_call_init(net) < 0)
>+		goto err_sysctl;
>+
> 	return 0;
>+
>+err_sysctl:
>+	vsock_sysctl_unregister(net);
>+	return -ENOMEM;
> }
>
> static __net_exit void vsock_sysctl_exit_net(struct net *net)
> {
> 	vsock_sysctl_unregister(net);
>+	vsock_net_call_exit(net);
> }
>
> static struct pernet_operations vsock_sysctl_ops __net_initdata = {
>@@ -2938,6 +2992,62 @@ void vsock_core_unregister(const struct 
>vsock_transport *t)
> }
> EXPORT_SYMBOL_GPL(vsock_core_unregister);
>
>+#if IS_ENABLED(CONFIG_VSOCKETS_LOOPBACK)
>+int __vsock_register_net_callbacks(int (*init)(struct net *net),
>+				   void (*exit)(struct net *net),
>+				   struct module *owner)
>+{
>+	struct vsock_net_callbacks *cbs;
>+	struct net *net;
>+	int ret = 0;
>+
>+	mutex_lock(&vsock_net_callbacks_lock);
>+
>+	cbs = &vsock_net_callbacks;
>+	cbs->init = init;
>+	cbs->exit = exit;
>+	cbs->owner = owner;
>+
>+	/* call callbacks on any net previously created */
>+	down_read(&net_rwsem);
>+
>+	if (try_module_get(cbs->owner)) {
>+		for_each_net(net) {
>+			ret = cbs->init(net);
>+			if (ret < 0)
>+				break;
>+		}
>+
>+		if (ret < 0)
>+			for_each_net(net)
>+				cbs->exit(net);
>+
>+		module_put(cbs->owner);
>+	}
>+
>+	up_read(&net_rwsem);
>+	mutex_unlock(&vsock_net_callbacks_lock);
>+
>+	return ret;
>+}
>+EXPORT_SYMBOL_GPL(__vsock_register_net_callbacks);
>+
>+void vsock_unregister_net_callbacks(void)
>+{
>+	struct vsock_net_callbacks *cbs;
>+
>+	mutex_lock(&vsock_net_callbacks_lock);
>+
>+	cbs = &vsock_net_callbacks;
>+	cbs->init = NULL;
>+	cbs->exit = NULL;
>+	cbs->owner = NULL;
>+
>+	mutex_unlock(&vsock_net_callbacks_lock);
>+}
>+EXPORT_SYMBOL_GPL(vsock_unregister_net_callbacks);

IIUC this function is called only in the error path of 
`vsock_loopback_init()`, but shuold we call it also in the 
vsock_loopback_exit() ?

>+#endif /* CONFIG_VSOCKETS_LOOPBACK */
>+
> module_init(vsock_init);
> module_exit(vsock_exit);
>
>diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
>index 1b2fab73e0d0..f16d21711cb0 100644
>--- a/net/vmw_vsock/vsock_loopback.c
>+++ b/net/vmw_vsock/vsock_loopback.c
>@@ -28,8 +28,19 @@ static u32 vsock_loopback_get_local_cid(void)
>
> static int vsock_loopback_send_pkt(struct sk_buff *skb)
> {
>-	struct vsock_loopback *vsock = &the_vsock_loopback;
>+	struct vsock_loopback *vsock;
> 	int len = skb->len;
>+	struct net *net;
>+
>+	if (skb->sk)
>+		net = sock_net(skb->sk);
>+	else
>+		net = NULL;

Why we can't use `virtio_vsock_skb_net` here?

>+
>+	if (net && net->vsock.mode == VSOCK_NET_MODE_LOCAL)
>+		vsock = net->vsock.loopback;
>+	else
>+		vsock = &the_vsock_loopback;
>
> 	virtio_vsock_skb_queue_tail(&vsock->pkt_queue, skb);
> 	queue_work(vsock->workqueue, &vsock->pkt_work);
>@@ -134,27 +145,72 @@ static void vsock_loopback_work(struct work_struct *work)
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
>+	return 0;
>+}
>+
>+static void vsock_loopback_deinit_vsock(struct vsock_loopback *vsock)
>+{
>+	if (vsock->workqueue)
>+		destroy_workqueue(vsock->workqueue);
>+}
>+
>+/* called with vsock_net_callbacks lock held */
>+static int vsock_loopback_init_net(struct net *net)
>+{
>+	if (WARN_ON_ONCE(net->vsock.loopback))
>+		return 0;
>+

Do we need some kind of locking here? I mean when reading/setting 
`net->vsock.loopback`?

>+	net->vsock.loopback = kmalloc(sizeof(*net->vsock.loopback), 
>GFP_KERNEL);
>+	if (!net->vsock.loopback)
>+		return -ENOMEM;
>+
>+	return vsock_loopback_init_vsock(net->vsock.loopback);
>+}
>+
>+/* called with vsock_net_callbacks lock held */
>+static void vsock_loopback_exit_net(struct net *net)
>+{
>+	if (net->vsock.loopback) {
>+		vsock_loopback_deinit_vsock(net->vsock.loopback);
>+		kfree(net->vsock.loopback);

Should we set `net->vsock.loopback` to NULL here?

>+	}
>+}
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
>+	ret = vsock_register_net_callbacks(vsock_loopback_init_net,
>+					   vsock_loopback_exit_net);

IIUC we need this only here because for now the only other transport 
supported is vhost-vsock, and IIUC `struct vhost_vsock *` there is 
handled with a map instead of a static variable, and `net` assigned when 
/dev/vhost-vsock is opened, right?

If in the future we will need to support G2H transports, like 
virtio-transport, we need to do something similar, right?

BTW I think we really need to exaplin this better in the commit 
description. It tooks me a while to get all of this (if it's correct)

Thanks,
Stefano

>+	if (ret < 0)
>+		goto out_deinit_vsock;
>
> 	ret = vsock_core_register(&loopback_transport.transport,
> 				  VSOCK_TRANSPORT_F_LOCAL);
> 	if (ret)
>-		goto out_wq;
>+		goto out_unregister_net;
>+
>
> 	return 0;
>
>-out_wq:
>-	destroy_workqueue(vsock->workqueue);
>+out_unregister_net:
>+	vsock_unregister_net_callbacks();
>+
>+out_deinit_vsock:
>+	vsock_loopback_deinit_vsock(vsock);
> 	return ret;
> }
>
>
>-- 
>2.47.3
>


