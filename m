Return-Path: <linux-hyperv+bounces-7318-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C34FC02F2C
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Oct 2025 20:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD65619A7C38
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Oct 2025 18:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2419234DB42;
	Thu, 23 Oct 2025 18:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYmKKNkB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19B134C994
	for <linux-hyperv@vger.kernel.org>; Thu, 23 Oct 2025 18:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761244095; cv=none; b=th8uLzj6NrkXY2M83stGxJcOJoS5lBo5y8MOA2oBBkE/rLNBXVhUboiCTV8L3QAbCPpQ+KdRTTz4dvfkb0zHjfDvBeybobJBCguBBUPg/8zjSIIjVv2S0ja3IP4GlN12CiRV2ypkBdkKvkg4L45NzG9QYL03AWONTrgLbv/QNyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761244095; c=relaxed/simple;
	bh=2vOt3aqHsLlIKGuCeQI+QOWfaN9kYAWHryQIZjKv6ek=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KhV6/PPd6mTIp4zfAKN9XGAKXD7cMwJOYbGE1Ki2CXo2xJ9Dk6fwbmz6r/lYBKqGyS5K4LDvAvLipWYYB7X7UNUsnVodwkGZ35Zlz9IOf59iOAR5BNKZb8ZTr9ZCXrSR1Wi/Yn6vRBkyJeenjuwbNMDVOg8d6ioi/VqxdvaOG0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYmKKNkB; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2947d345949so7394625ad.3
        for <linux-hyperv@vger.kernel.org>; Thu, 23 Oct 2025 11:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761244089; x=1761848889; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rOnGwOJEogF4rPu54JUeb1SIxyq0svOAnIcOq7OsOBA=;
        b=YYmKKNkBccxWrc8puz4bMInZ7NThXENnsok/JGjbVLPP0r8M06izo0ibpDAD4naTvF
         pmFwEsKRC6s4US6nNejOG08ZhA4/bv3jNDHiH7PAhB6e3eLK8R+dFW6BQpikST4RfM3K
         CrCS5RBe+z/NmiVaN1TSyCBeYGTUxPEOXN9ZvziMTAXJcZQUhx+QZr1cSZvW33DqpNfj
         3DpOiBsvjfHIHgVl5HoL6a3zG7RwaI3dsyL/t18L9TIkEreUYAr4X7S96QJPvU/DtOY/
         E5kqt9vLREJeUl2RdDkdIrHp9xbt8pDg9gJZqtvIWHbcE7HNcTncm0bDkyxbp2wxacNP
         RIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761244089; x=1761848889;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rOnGwOJEogF4rPu54JUeb1SIxyq0svOAnIcOq7OsOBA=;
        b=hihk8NbchpXKE+W6ar6dWqSpuHK4k16/9ygBHR7kTcn1eF+e857CtX0s2dDVDwUTqz
         +CcYX5mFf0I/ZMg0+lydek7lSBmB6wjWbeWHwgkdtXalUNFGpXAXcRKjc7VwGn7QUmun
         +DXyqSqUSa9AobRLZIyDk9MkSdYwMmCZSHDKqztxaL+oiIzMvw2ErQksMbrq7fJblkzh
         Zx65BscHVeLm84kCsFwAtUg83sU2qxbw31oBJYfXKmZiREPNhKhUSl8/cCaapd3Najib
         TB+L50I1OybYrpkhxNAkRw/uPhsJBT/Ieho2xm0Yi2F4kJbcn02u1v6I1oH5S2pPK+4d
         Xgxg==
X-Forwarded-Encrypted: i=1; AJvYcCXS62Wo+qUVyZUtwEbqFkGFDd9MP5BM4UdbkdGC8J3wA/Sd+E//64NJ5Y9ZLz+BN5kBqbdMF7ZXK+z04o8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP3+8MLij5x7rP8fDm0qnbwy7Csi0fGgDaKssI1aBdOFmLJVYI
	7intE6pDlFCUZKcP+1ohRzFTVpLvYRvVQAF0GMgYk/YqgFYXQW7NDpMj
X-Gm-Gg: ASbGncvy5RNZ2vroLWFQ7eIJG/K/Imdlxg2yGr/10HQfPcLCYPTA5kQxDBeY2ndbVFE
	GlUoN+bi6RAtGpElbptSOFRe5obrox+MZ9Uiv8oIq+y/MV1zfRtcTCElb3TpL+RWIwvNKVVdpjN
	RPE0s+ptpJ5Q1N3VMtejiKfrMl1ak5IQKoWuCv2iEW+2I3bwTb8/SsctfKBgquZpBmE4NCkPnms
	a3C5qjkJIzmvAuCYftCek22ccBI0AB96hXHvRILKVII+17hJnPBpT2JUAeYj+znEMfc0iaZYh5r
	hKNXknYNnlatyhs0QrBkTIyefJ2uaR1FK3i08KopNgYrq+iVpUQ+5oCGRR5vIUb/wR0E+ABAsj/
	67UXlohtpwLlLP3KGNOU1RluMQofzmIiisCER/qWUWPQWT80hE3GpFe1rdpu5gptYylVD5HPKHk
	W9BOSkmnox
X-Google-Smtp-Source: AGHT+IFYpBBCCR720vuYSBRzPxT9Qu4/uM6zyCgPCDeVP26zw3QtdfGDA/4zRrKoUcEuv8sd3K898A==
X-Received: by 2002:a17:902:dad0:b0:24c:d0b3:3b20 with SMTP id d9443c01a7336-290ca12180emr327840225ad.37.1761244088774;
        Thu, 23 Oct 2025 11:28:08 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:74::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946ddec426sm30419245ad.34.2025.10.23.11.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 11:28:08 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 23 Oct 2025 11:27:44 -0700
Subject: [PATCH net-next v8 05/14] vsock/loopback: add netns support
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-vsock-vmtest-v8-5-dea984d02bb0@meta.com>
References: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
In-Reply-To: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add NS support to vsock loopback. Sockets in a global mode netns
communicate with each other, regardless of namespace. Sockets in a local
mode netns may only communicate with other sockets within the same
namespace.

Use pernet_ops to install a vsock_loopback for every namespace that is
created (to be used if local mode is enabled).

Retroactively call init/exit on every namespace when the vsock_loopback
module is loaded in order to initialize the per-ns device.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v7:
- drop for_each_net() init/exit, drop net_rwsem, the pernet registration
  handles this automatically and race-free
- flush workqueue before destruction, purge pkt list
- remember net_mode instead of current net mode
- keep space after INIT_WORK()
- change vsock_loopback in netns_vsock to ->priv void ptr
- rename `orig_net_mode` to `net_mode`
- remove useless comment
- protect `register_pernet_subsys()` with `net_rwsem`
- do cleanup before releasing `net_rwsem` when failure happens
- call `unregister_pernet_subsys()` in `vsock_loopback_exit()`
- call `vsock_loopback_deinit_vsock()` in `vsock_loopback_exit()`

Changes in v6:
- init pernet ops for vsock_loopback module
- vsock_loopback: add space in struct to clarify lock protection
- do proper cleanup/unregister on vsock_loopback_exit()
- vsock_loopback: use virtio_vsock_skb_net()

Changes in v5:
- add callbacks code to avoid reverse dependency
- add logic for handling vsock_loopback setup for already existing
  namespaces
---
 include/net/netns/vsock.h      |  2 +
 net/vmw_vsock/vsock_loopback.c | 85 ++++++++++++++++++++++++++++++++++++------
 2 files changed, 75 insertions(+), 12 deletions(-)

diff --git a/include/net/netns/vsock.h b/include/net/netns/vsock.h
index c9a438ad52f2..9d0d8e2fbc37 100644
--- a/include/net/netns/vsock.h
+++ b/include/net/netns/vsock.h
@@ -16,5 +16,7 @@ struct netns_vsock {
 	/* protected by lock */
 	enum vsock_net_mode mode;
 	bool mode_locked;
+
+	void *priv;
 };
 #endif /* __NET_NET_NAMESPACE_VSOCK_H */
diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
index a8f218f0c5a3..474083d4cfcb 100644
--- a/net/vmw_vsock/vsock_loopback.c
+++ b/net/vmw_vsock/vsock_loopback.c
@@ -28,8 +28,16 @@ static u32 vsock_loopback_get_local_cid(void)
 
 static int vsock_loopback_send_pkt(struct sk_buff *skb)
 {
-	struct vsock_loopback *vsock = &the_vsock_loopback;
+	struct vsock_loopback *vsock;
 	int len = skb->len;
+	struct net *net;
+
+	net = virtio_vsock_skb_net(skb);
+
+	if (virtio_vsock_skb_net_mode(skb) == VSOCK_NET_MODE_LOCAL)
+		vsock = (struct vsock_loopback *)net->vsock.priv;
+	else
+		vsock = &the_vsock_loopback;
 
 	virtio_vsock_skb_queue_tail(&vsock->pkt_queue, skb);
 	queue_work(vsock->workqueue, &vsock->pkt_work);
@@ -134,11 +142,8 @@ static void vsock_loopback_work(struct work_struct *work)
 	}
 }
 
-static int __init vsock_loopback_init(void)
+static int vsock_loopback_init_vsock(struct vsock_loopback *vsock)
 {
-	struct vsock_loopback *vsock = &the_vsock_loopback;
-	int ret;
-
 	vsock->workqueue = alloc_workqueue("vsock-loopback", WQ_PERCPU, 0);
 	if (!vsock->workqueue)
 		return -ENOMEM;
@@ -146,15 +151,73 @@ static int __init vsock_loopback_init(void)
 	skb_queue_head_init(&vsock->pkt_queue);
 	INIT_WORK(&vsock->pkt_work, vsock_loopback_work);
 
+	return 0;
+}
+
+static void vsock_loopback_deinit_vsock(struct vsock_loopback *vsock)
+{
+	if (vsock->workqueue) {
+		flush_work(&vsock->pkt_work);
+		virtio_vsock_skb_queue_purge(&vsock->pkt_queue);
+		destroy_workqueue(vsock->workqueue);
+		vsock->workqueue = NULL;
+	}
+}
+
+static int vsock_loopback_init_net(struct net *net)
+{
+	int ret;
+
+	net->vsock.priv = kzalloc(sizeof(struct vsock_loopback), GFP_KERNEL);
+	if (!net->vsock.priv)
+		return -ENOMEM;
+
+	ret = vsock_loopback_init_vsock((struct vsock_loopback *)net->vsock.priv);
+	if (ret < 0) {
+		kfree(net->vsock.priv);
+		net->vsock.priv = NULL;
+		return ret;
+	}
+
+	return 0;
+}
+
+static void vsock_loopback_exit_net(struct net *net)
+{
+	vsock_loopback_deinit_vsock(net->vsock.priv);
+	kfree(net->vsock.priv);
+	net->vsock.priv = NULL;
+}
+
+static struct pernet_operations vsock_loopback_net_ops = {
+	.init = vsock_loopback_init_net,
+	.exit = vsock_loopback_exit_net,
+};
+
+static int __init vsock_loopback_init(void)
+{
+	struct vsock_loopback *vsock = &the_vsock_loopback;
+	int ret;
+
+	ret = vsock_loopback_init_vsock(vsock);
+	if (ret < 0)
+		return ret;
+
+	ret = register_pernet_subsys(&vsock_loopback_net_ops);
+	if (ret < 0)
+		goto out_deinit_vsock;
+
 	ret = vsock_core_register(&loopback_transport.transport,
 				  VSOCK_TRANSPORT_F_LOCAL);
 	if (ret)
-		goto out_wq;
+		goto out_unregister_pernet_subsys;
 
 	return 0;
 
-out_wq:
-	destroy_workqueue(vsock->workqueue);
+out_unregister_pernet_subsys:
+	unregister_pernet_subsys(&vsock_loopback_net_ops);
+out_deinit_vsock:
+	vsock_loopback_deinit_vsock(vsock);
 	return ret;
 }
 
@@ -164,11 +227,9 @@ static void __exit vsock_loopback_exit(void)
 
 	vsock_core_unregister(&loopback_transport.transport);
 
-	flush_work(&vsock->pkt_work);
-
-	virtio_vsock_skb_queue_purge(&vsock->pkt_queue);
+	unregister_pernet_subsys(&vsock_loopback_net_ops);
 
-	destroy_workqueue(vsock->workqueue);
+	vsock_loopback_deinit_vsock(vsock);
 }
 
 module_init(vsock_loopback_init);

-- 
2.47.3


