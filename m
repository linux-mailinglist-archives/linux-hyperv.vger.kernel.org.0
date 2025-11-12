Return-Path: <linux-hyperv+bounces-7509-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E0610C50CA5
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Nov 2025 07:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 66D1634C697
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Nov 2025 06:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B14D2F290E;
	Wed, 12 Nov 2025 06:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjHZrcDl"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DF42E8DFA
	for <linux-hyperv@vger.kernel.org>; Wed, 12 Nov 2025 06:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762930545; cv=none; b=f+70CJ7yDH9oH4meuxZt9HE+H9L/wf3PWHKdKAiDgFfXnsyLutXONzAW1wCz4xe7E+BCWM5q8JwHBhKm7J7zkMvxNdzBM0La0eGuzIBVbtrpwt9fuTj3/yrxoH4u4gjhFbqtpIFexfXoVILb3gtUG5ie3lXVsqcZ1EKeDm1s3Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762930545; c=relaxed/simple;
	bh=01uUMlfiWTKv03h82J1+m084yYvxNbGX6LOW1sTU7AA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LLeSfgGLwfSLc+ylcYT1UyHxc8S0UfSz7osqYGlSRQOuTs7eEEw5A1U+o5Zy421R98EA0DEH2ePOKYGr+Colplqe0fjalZUVdY0/BAd44FYq7jNuigOSPbAxYJlZ4ju+SPWblyNLy8e66BcHYupriRgRukXOgWsyLwVl917yF6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jjHZrcDl; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7aa2170adf9so451649b3a.0
        for <linux-hyperv@vger.kernel.org>; Tue, 11 Nov 2025 22:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762930540; x=1763535340; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PmM345PPlBdkJ7nEXyq1t64bQ5asJdDBfV1okwjOHnA=;
        b=jjHZrcDldEWkHLwOL8JeO1G2IG6ADbFIXe23zt7MNhTCJPuETFk4+9ZSnAF+/eaLxU
         +nIlRUgIqQtMFutAyB32tdi6ABASI1xIoKtXscqvc7uu2Rct5tmWVrJ0+5m3wOZ4Yfl7
         98S454HV2ZYpBSR833M4XIG2zlIyI4mnCEnv3XHDmY/mUs/S4y9ZYZeeiRmKJgRobNI2
         JJF1y+QTPy0nnenAE5VgvZGj6hry6WZchuq5W1+9oVsWlGm3K1fXNJQxBqooZSr9rBY9
         S3goCENHzAU0FOPHFgDaDVU3+GSsyhhzBc3D5qWHWvQ0pgPzB1EznNFCSm+NAj14LycJ
         +1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762930540; x=1763535340;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PmM345PPlBdkJ7nEXyq1t64bQ5asJdDBfV1okwjOHnA=;
        b=rPRiK1OKTyCth9UJL+I50ZuYQmjEmRdmX7cuvpGd66UZGMvhgItE9KTrLus1erf/TL
         ZxuBN9jfQtn8/mqFDe1pnhL0uVe16mYm9FeWnThH6yCpIBmxZH9z+AIaljOmHZCkNJxj
         BIBfcOlo30x+SabCj+vvKqPgZKEmUcJvAr6gBIjZCqtU7rsPR8znX/dJbbWmKYEvR5lj
         8S1Y64d6OYQs2XMXUQ5bBZGPQkElejswgvaOtDiL2GkZdnUdr/blgSlstVdKHy45R+yt
         FE1MHpqIZWHm1lyiORmlghSOQj0tjU+8LBn3nvRXJslT8ufJh1UsLEuFYzESYzcx/Uzp
         MtFA==
X-Forwarded-Encrypted: i=1; AJvYcCXB3Iu87e+oZupUn/RwaPGCu+Gu61chFAhEHf6OwPGTRWZO9C4jUEOOH0hnOiszTcIdJTiXaFDnuQJw1jg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD7dx4xImb4MY4b3umZCCwW1P/GYLv+syrxgZN4qzQKfNZqEth
	KUfvdE5vJKMsPRB7A+dZO4jV99Egx48gde5DfBxX3Lns8+IVgg1+ibB/
X-Gm-Gg: ASbGncvcmXuL73Wu3r5YTaR7BQlShNeO+fwSZJRZxtsofTirh3HayJkD7s9lAZgPP8p
	FtxoEQPoWNKoIE3rcRrJPMgpfF3xHiB3vy5TK3tA0ZHMUOLexOHZLeLZ23BSULuyP4WQO0JsG/g
	UKO3pjWoKVOPPJP+K2/XapSLJ7ZcT22V3pwHo8q9UEqYJRC1LaJqFienpf2aUpoJFo36jaFOeX2
	8PQCRcihNv/UIXG7tfPz2LHGVCCd0YX5871gXnEh5bE5s8RMZrdqzv1kFo33k/JytOwiyF3iSTd
	RK+1H3+ypQtVdjtG6r9klCPVsiD4IkJxc7cmaaFsDMmdToUUbT6AAJ3DTCuXzhPfP8FpaPsoYcX
	WEjZ3A+pJpceD10rp+WeNl1ohnY1YaioCxNiTH2ETqUUIGzVx+ZAByZOAqo+c6L2Pxpob7Q==
X-Google-Smtp-Source: AGHT+IGNhCkA23bPLUhPo1K8TP1fGLK1N8Jxj/eTUi5N0DaekLLmU2p8n1DIbr0n0Dbs2LkhzQbdKg==
X-Received: by 2002:a05:6a00:2d13:b0:7aa:8397:7754 with SMTP id d2e1a72fcca58-7b7a25aa4aamr2255142b3a.2.1762930540424;
        Tue, 11 Nov 2025 22:55:40 -0800 (PST)
Received: from localhost ([2a03:2880:2ff::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc17a956sm17716113b3a.44.2025.11.11.22.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 22:55:40 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 11 Nov 2025 22:54:48 -0800
Subject: [PATCH net-next v9 06/14] vsock/loopback: add netns support
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-vsock-vmtest-v9-6-852787a37bed@meta.com>
References: <20251111-vsock-vmtest-v9-0-852787a37bed@meta.com>
In-Reply-To: <20251111-vsock-vmtest-v9-0-852787a37bed@meta.com>
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
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 Sargun Dhillon <sargun@sargun.me>, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add NS support to vsock loopback. Sockets in a global mode netns
communicate with each other, regardless of namespace. Sockets in a local
mode netns may only communicate with other sockets within the same
namespace.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v9:
- remove per-netns vsock_loopback and workqueues, just re-using
  the net and net_mode in skb->cb achieved the same result in a simpler
  way. Also removed need for pernet_subsys.
- properly track net references

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
 net/vmw_vsock/vsock_loopback.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
index d3ac056663ea..e62f6c516992 100644
--- a/net/vmw_vsock/vsock_loopback.c
+++ b/net/vmw_vsock/vsock_loopback.c
@@ -32,6 +32,9 @@ static int vsock_loopback_send_pkt(struct sk_buff *skb, struct net *net,
 	struct vsock_loopback *vsock = &the_vsock_loopback;
 	int len = skb->len;
 
+	virtio_vsock_skb_set_net(skb, net);
+	virtio_vsock_skb_set_net_mode(skb, net_mode);
+
 	virtio_vsock_skb_queue_tail(&vsock->pkt_queue, skb);
 	queue_work(vsock->workqueue, &vsock->pkt_work);
 
@@ -116,8 +119,10 @@ static void vsock_loopback_work(struct work_struct *work)
 {
 	struct vsock_loopback *vsock =
 		container_of(work, struct vsock_loopback, pkt_work);
+	enum vsock_net_mode net_mode;
 	struct sk_buff_head pkts;
 	struct sk_buff *skb;
+	struct net *net;
 
 	skb_queue_head_init(&pkts);
 
@@ -131,7 +136,41 @@ static void vsock_loopback_work(struct work_struct *work)
 		 */
 		virtio_transport_consume_skb_sent(skb, false);
 		virtio_transport_deliver_tap_pkt(skb);
-		virtio_transport_recv_pkt(&loopback_transport, skb, NULL, 0);
+
+		/* In the case of virtio_transport_reset_no_sock(), the skb
+		 * does not hold a reference on the socket, and so does not
+		 * transitively hold a reference on the net.
+		 *
+		 * There is an ABA race condition in this sequence:
+		 * 1. the sender sends a packet
+		 * 2. worker calls virtio_transport_recv_pkt(), using the
+		 *    sender's net
+		 * 3. virtio_transport_recv_pkt() uses t->send_pkt() passing the
+		 *    sender's net
+		 * 4. virtio_transport_recv_pkt() free's the skb, dropping the
+		 *    reference to the socket
+		 * 5. the socket closes, frees its reference to the net
+		 * 6. Finally, the worker for the second t->send_pkt() call
+		 *    processes the skb, and uses the now stale net pointer for
+		 *    socket lookups.
+		 *
+		 * To prevent this, we acquire a net reference in vsock_loopback_send_pkt()
+		 * and hold it until virtio_transport_recv_pkt() completes.
+		 *
+		 * Additionally, we must grab a reference on the skb before
+		 * calling virtio_transport_recv_pkt() to prevent it from
+		 * freeing the skb before we have a chance to release the net.
+		 */
+		net_mode = virtio_vsock_skb_net_mode(skb);
+		net = virtio_vsock_skb_net(skb);
+
+		skb_get(skb);
+
+		virtio_transport_recv_pkt(&loopback_transport, skb, net,
+					  net_mode);
+
+		virtio_vsock_skb_clear_net(skb);
+		kfree_skb(skb);
 	}
 }
 

-- 
2.47.3


