Return-Path: <linux-hyperv+bounces-7320-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B005DC02F82
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Oct 2025 20:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1FEAC507A0D
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Oct 2025 18:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDE834EEE8;
	Thu, 23 Oct 2025 18:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAe+IZ07"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D6D34B407
	for <linux-hyperv@vger.kernel.org>; Thu, 23 Oct 2025 18:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761244098; cv=none; b=XXyZXYcNtyJj4rq72eJBpvo3ZVMmvDQMPyihIVE9SLlEQG1cYHYB+SKv4c6EsgySTUt3vCjozlYjJ/uPzR/WG/MTj3/XKIalTrK25Ejs3O2CBNhBMVe1lfIFX9HjOsLU/WZYM8t7IpNQGI82cKEPtJKzgHGM15K8j/I5KQOAwBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761244098; c=relaxed/simple;
	bh=kUefiKfkicMX8tmziLXEi//+t8csN8furvqT9U5IgCE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u2MXGu1LMvEi0YDUN2JdYJxtFe7gwNJHxPMEmk4ggDQJiqhRaSUfSpBPn7JOFX2dmNPuPULxaKnFtPwPBA8saddne/2f3RCXzNxrcpDvkZnB4di9arKzbjIM4X57fpoaUTkJH1qQSDDMZV0EA4stD4IYGpr0yhVujQCH/sQgv9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cAe+IZ07; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-290c2b6a6c2so12954985ad.1
        for <linux-hyperv@vger.kernel.org>; Thu, 23 Oct 2025 11:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761244090; x=1761848890; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ENceTHQQLbApf5YaDY/ZTac12ozK8h8RipNYM83YVxY=;
        b=cAe+IZ07igbq+BkPU5qd+wVGpHzBGx1pBdllSZR/VonoXlggQ3aJeJsqd+mEjZpvhI
         4m0eyW70hHmZ2aNrQaaTqk+UgOVDRc8K9cVvAevIR3tAKDXIx+H6qMCvIr0isQlDXREN
         wHGA4UC+WvDqiuC2+sdMGBBySqkANDJ2TuuyHupRn5XWQ3IC+/p5+eJqgRRW9It3bpWW
         CenuUolDtzE3y2wYcOggBUzYSKWZv2BKqNbzPQoV2Zswg464V8DPzGlKBmCKhsKp3Slj
         Oc2P/qvcV6vbmGGbFHSjf0Nh2sjCFjEEAhIvHXPQ/sJbl5JCf26oocvNPLqRn6rVXo4z
         LwEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761244090; x=1761848890;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ENceTHQQLbApf5YaDY/ZTac12ozK8h8RipNYM83YVxY=;
        b=LKlL4uZ16ZeOmXs++yyceFzkaxoNeHUwRxeUPg4PZ5kdmfiQFqoBUxyQdto7rybFKT
         oYQ3K7Cg+efR9bnEWmIh9OQWFRHQ01PX1rbs6ZhDI5AfMTyOVM5VlmJOjo+kxqhcxI1w
         BGTJHFIYvaaGfob9e/NXS6R5fHmMru+tjG6+Xezf2lkyfunbeZOhWsn0Qg9sA83vFpQj
         ++6vEKiBiEQd430VsiBhTzs9ypR3FCM4N3DPP4ll0YbV8RrJZVEAqe3DK2CpnxFs/kNu
         UCutqUg+OhUeQel0WwUV2Kg30IhhTobK0DbRrraIYBcwfi+J/SXdYb2TZwdaTC92j5Qf
         rXqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZnKOBdqLIXp31rkXpqs8bAOvOPESzRhMEDYVugRfzXHtVY3f44O5ayM4LCc1EY5EUJIa3ZIlmebFC9lI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsqe7PIskzRkt8iKu8rcG6fGT/fNooCzMrdJ0Vz49gKQqePg11
	BJDPCFcKaqSxg50P513DTw0d9KLWsWl/iWmY9+vYpVdNkUNV94ImE/UF
X-Gm-Gg: ASbGnctREE4XhrAFj49/cybokat/f/cszRZgaVI6EEiJgkiy40JM9P4+gtn0OvEdS1i
	/Th9hNmgON3oxV7wM+N5+UJDQkL+BgeB2m0sc4V4jycS7c6GHLYFeJ4IgYLG9FrNBdSS5mCod56
	54enfPH5G2WfObFTOqvbeZ90F9ngxE021Db/QRt5isNPATzgH46de0XmXJJB5FE5zipyP2Y+0jw
	V6GTArj/VuUIX6inqoCfD9nhRGFwZuYgdYxvd/5tAa4CNRXrPgc7Jf7hCzfJ+WOwBP+rilyCCvq
	fuGHgt9azBZVLKVtgXEZNfbU/3stUTqtX8dgoeC2lCP5yuk6QwyqpH4B/HlrGvYlCmDjKfbv7x0
	bb007PAc0fPl4wf/dm/VF8cf+g0WvCgVh6sB3nga+xuTwG+jfQvnH/ee6Qni3Ud2wqTnRurDj
X-Google-Smtp-Source: AGHT+IGL+PtKUr5eZ+mANzrBQrF6tJP4JHS8yZ0mhNm5Rv4OrWq7HGiA79wb53NBZDSFfGYBMJn/Vw==
X-Received: by 2002:a17:903:2443:b0:290:bd15:24ad with SMTP id d9443c01a7336-290cb65b68fmr269267885ad.45.1761244089851;
        Thu, 23 Oct 2025 11:28:09 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:8::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fb01915f6sm3089451a91.16.2025.10.23.11.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 11:28:09 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 23 Oct 2025 11:27:45 -0700
Subject: [PATCH net-next v8 06/14] vsock/virtio: add netns to virtio
 transport common
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-vsock-vmtest-v8-6-dea984d02bb0@meta.com>
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

Enable network namespace support in the virtio-vsock common transport
layer by declaring namespace pointers in the transmit and receive
paths.

The changes include:
1. Add a 'net' field to virtio_vsock_pkt_info to carry the namespace
   pointer for outgoing packets.
2. Store the namespace and namespace mode in the skb control buffer when
   allocating packets (except for VIRTIO_VSOCK_OP_RST packets which do
   not have an associated socket).
3. Retrieve namespace information from skbs on the receive path for
   lookups using vsock_find_connected_socket_net() and
   vsock_find_bound_socket_net().

This allows users of virtio transport common code
(vhost-vsock/virtio-vsock) to later enable namespace support.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v7:
- add comment explaining the !vsk case in virtio_transport_alloc_skb()
---
 include/linux/virtio_vsock.h            |  1 +
 net/vmw_vsock/virtio_transport_common.c | 21 +++++++++++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 29290395054c..f90646f82993 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -217,6 +217,7 @@ struct virtio_vsock_pkt_info {
 	u32 remote_cid, remote_port;
 	struct vsock_sock *vsk;
 	struct msghdr *msg;
+	struct net *net;
 	u32 pkt_len;
 	u16 type;
 	u16 op;
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index dcc8a1d5851e..b8e52c71920a 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -316,6 +316,15 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
 					 info->flags,
 					 zcopy);
 
+	/*
+	 * If there is no corresponding socket, then we don't have a
+	 * corresponding namespace. This only happens For VIRTIO_VSOCK_OP_RST.
+	 */
+	if (vsk) {
+		virtio_vsock_skb_set_net(skb, info->net);
+		virtio_vsock_skb_set_net_mode(skb, vsk->net_mode);
+	}
+
 	return skb;
 out:
 	kfree_skb(skb);
@@ -527,6 +536,7 @@ static int virtio_transport_send_credit_update(struct vsock_sock *vsk)
 	struct virtio_vsock_pkt_info info = {
 		.op = VIRTIO_VSOCK_OP_CREDIT_UPDATE,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1067,6 +1077,7 @@ int virtio_transport_connect(struct vsock_sock *vsk)
 	struct virtio_vsock_pkt_info info = {
 		.op = VIRTIO_VSOCK_OP_REQUEST,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1082,6 +1093,7 @@ int virtio_transport_shutdown(struct vsock_sock *vsk, int mode)
 			 (mode & SEND_SHUTDOWN ?
 			  VIRTIO_VSOCK_SHUTDOWN_SEND : 0),
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1108,6 +1120,7 @@ virtio_transport_stream_enqueue(struct vsock_sock *vsk,
 		.msg = msg,
 		.pkt_len = len,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1145,6 +1158,7 @@ static int virtio_transport_reset(struct vsock_sock *vsk,
 		.op = VIRTIO_VSOCK_OP_RST,
 		.reply = !!skb,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	/* Send RST only if the original pkt is not a RST pkt */
@@ -1465,6 +1479,7 @@ virtio_transport_send_response(struct vsock_sock *vsk,
 		.remote_port = le32_to_cpu(hdr->src_port),
 		.reply = true,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1578,7 +1593,9 @@ static bool virtio_transport_valid_type(u16 type)
 void virtio_transport_recv_pkt(struct virtio_transport *t,
 			       struct sk_buff *skb)
 {
+	enum vsock_net_mode net_mode = virtio_vsock_skb_net_mode(skb);
 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
+	struct net *net = virtio_vsock_skb_net(skb);
 	struct sockaddr_vm src, dst;
 	struct vsock_sock *vsk;
 	struct sock *sk;
@@ -1606,9 +1623,9 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 	/* The socket must be in connected or bound table
 	 * otherwise send reset back
 	 */
-	sk = vsock_find_connected_socket(&src, &dst);
+	sk = vsock_find_connected_socket_net(&src, &dst, net, net_mode);
 	if (!sk) {
-		sk = vsock_find_bound_socket(&dst);
+		sk = vsock_find_bound_socket_net(&dst, net, net_mode);
 		if (!sk) {
 			(void)virtio_transport_reset_no_sock(t, skb);
 			goto free_pkt;

-- 
2.47.3


