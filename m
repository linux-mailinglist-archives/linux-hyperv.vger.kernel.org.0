Return-Path: <linux-hyperv+bounces-6894-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C0FB7E6B8
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Sep 2025 14:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECA483273AC
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Sep 2025 23:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7792A2F3C34;
	Tue, 16 Sep 2025 23:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGHr+K6C"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E442F5493
	for <linux-hyperv@vger.kernel.org>; Tue, 16 Sep 2025 23:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758066244; cv=none; b=JnL3YSMlQVk4vw7EgqwuqYRynEKT28k0mdmyy3Ud7YCImrFm0fdWNZvhkM1yK64G2TM7oMrEMMqhL7dVzvkKN7u3A0sBhYQ+0NeUtiTyIL9xC2dWeSHQ4hp8TeSL7gjXMnbs6Y54iC/86fJ6GheB74tNByknJITacl95DxNnP6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758066244; c=relaxed/simple;
	bh=XsnkMyQoiDjSyscFIjDdskWFvtSk6gaKUIKj/7lSCm4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eyD+iRcCGck4HK+5TMeAYw077OKuFom+BalxCAO/ElBM9gqFOdCTvq31Soo8RYkrwwqZCZrYxssfGx/6dx6AAfHJ8SyWj9f5CFIFR+nxBEZVNxtxhRX9Q8LAZ8PIhJuvxRg+MZWLZoG7xP9sPaFbHLTQpMn8OvF6XoOmtro9lQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGHr+K6C; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-25669596955so62396465ad.0
        for <linux-hyperv@vger.kernel.org>; Tue, 16 Sep 2025 16:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758066241; x=1758671041; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GbdwKehIoIHRtRqLAxQ+WKxaFmFQHmQ2pBun1Ap9hJU=;
        b=YGHr+K6CngRyT4HyIMqT9bKIf+qM7VFqGbFy0rdQ7YpECOCz7YcGtpc4+eReHNPf/N
         ebIx/XgP47NnwP3UakNk9KYGaFqE6VyaTDF0dkUrDic6SSoBn+UsOLn0swQ5AxUAXNVf
         Zi9oY8ysf4HeKzfmVOnfoalLY00LdoT6Ql4O2t8nhbsO1OJc24eg0N7KQWo3gr3/UIQd
         qIR4owAJVF0+MHROycaIwxqOeD1ueB/E1ToxWDzVLt6FMs7abNstkkW6M5fAyJvilQiF
         WeEDxRVu+81gLuQEwDJymIaxhyTYO8zZuD1mfkUOgnozcFOqL5PffLla3n4MWCHbzb+1
         RGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758066241; x=1758671041;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GbdwKehIoIHRtRqLAxQ+WKxaFmFQHmQ2pBun1Ap9hJU=;
        b=sQ22u//fGmsgIaawSs/8SoctDrDdbL0tT4yjZFC7Li1okOqK/B2fwroskcseOSfv5Q
         rBMgMkm5fWRRo/bQ0gsDtx6RI8neHfnQudhr8ECSwU+9WReJXxrYmnFqgNCNc+yPvDw6
         VvukTt2OrKOgjW6M+z4GJrW+uIB3B+M4331msn4NEMBpBsNh/79n8X9GMzXGaihYLhoG
         4Nia/7p64/lXCO/o8c7Z+bgBH0V8WloNKuf5hvKXXsl6hwAudfi9UJxSiHmEAf9yrsz8
         7RQhbnNAj8F9+w4YGlTv8wRqrgnb3RcWQYHL8qXixxbv18GQFOQdRHHDsOqn1Uom4KBa
         4aXA==
X-Forwarded-Encrypted: i=1; AJvYcCUew8gy41kqhjkK5v7/0T1M/WbiG3rF8DuT+aQFrhyEzF3gdShqGLALtD/AfhTERGe73KfJUlgU5tBwzzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YynA5dqGgf8DlKrwwzVvLbYby999ZkcG8PfXx34FP0CzunvDjoW
	9jTBNfd/L2ODuXtjlbLT7lCNu5wmkCNd5e9/IIjVQwMsLkGjeiGr0VgF
X-Gm-Gg: ASbGnctqECtSVumA/MVUxMooLSsxWdneKeUNNK3EHGUzcAHW0E47vvvJzznlwV5wwMb
	vYfxefpxHERr8oKM3wsgPGrTzIv0ehu5DT0dj7fCiZucEasf0eA6UI1tcPDrzg/iGBIjsNayFIZ
	0v/S+pF+01C3ZaY1mXgls9q4iPhzEA2XyEgflFHlX44F0HT2PjfmV9QDPwVxZ/OrKFriV5Lq8T9
	BXcCJH6VMg6yqdqv42ItkIDW0OFUO8juSu1VX4KfNrIfBc8eJacw+FezaCNoPBg2l+Crl/yAxNW
	dovKsK07Vn6m98zUzr4xykq36makJD7hYDFYgf7AMz99bFeZjAxFdN4YFkPC6vqetUrhqC9xS7d
	68XY8sJWFsUq3Lm+PK2PztHREFZ9U0hM=
X-Google-Smtp-Source: AGHT+IF/pyzswxNFNkRKTib2UDHppVdNz86fZjJPyjOG7e1TjRL6qmhbxP/zP+ozSDEbzUE6jX7HZg==
X-Received: by 2002:a17:902:ecce:b0:24c:7bc6:7ac7 with SMTP id d9443c01a7336-2681217e503mr1123395ad.18.1758066240548;
        Tue, 16 Sep 2025 16:44:00 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:72::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2679423db74sm59204955ad.77.2025.09.16.16.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 16:43:59 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 16 Sep 2025 16:43:50 -0700
Subject: [PATCH net-next v6 6/9] vhost/vsock: add netns support
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-vsock-vmtest-v6-6-064d2eb0c89d@meta.com>
References: <20250916-vsock-vmtest-v6-0-064d2eb0c89d@meta.com>
In-Reply-To: <20250916-vsock-vmtest-v6-0-064d2eb0c89d@meta.com>
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
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add the ability to isolate vsock flows using namespaces.

The VM, via the vhost_vsock struct, inherits its namespace from the
process that opens the vhost-vsock device. vhost_vsock lookup functions
are modified to take into account the mode (e.g., if CIDs are matching
but modes don't align, then return NULL).

vhost_vsock now acquires a reference to the namespace.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

---
Changes in v5:
- respect pid namespaces when assigning namespace to vhost_vsock
---
 drivers/vhost/vsock.c | 74 +++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 66 insertions(+), 8 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 34adf0cf9124..1aabe9f85503 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -46,6 +46,11 @@ static DEFINE_READ_MOSTLY_HASHTABLE(vhost_vsock_hash, 8);
 struct vhost_vsock {
 	struct vhost_dev dev;
 	struct vhost_virtqueue vqs[2];
+	struct net *net;
+	netns_tracker ns_tracker;
+
+	/* The ns mode at the time vhost_vsock was created */
+	enum vsock_net_mode orig_net_mode;
 
 	/* Link to global vhost_vsock_hash, writes use vhost_vsock_mutex */
 	struct hlist_node hash;
@@ -64,10 +69,40 @@ static u32 vhost_transport_get_local_cid(void)
 	return VHOST_VSOCK_DEFAULT_HOST_CID;
 }
 
+/* Return true if the namespace net can access the vhost_vsock vsock.
+ * Otherwise, return false.
+ *
+ * If the netns is the same, it doesn't matter if it is local or global. The
+ * vsock sockets within a namespace can always communicate.
+ *
+ * If the netns is different, then we need to check if the current namespace
+ * mode is global and if the namespace mode at the time of the vhost_vsock
+ * being created is global. If so, then we allow it. By checking the namespace
+ * mode at the time of the vhost_vsock's creation we allow the flow to continue
+ * working even if the namespace mode changes to "local" in the middle of a
+ * socket's lifetime. If we used the current namespace mode instead, then any
+ * socket that was alive prior to the mode change would suddenly fail.
+ */
+static bool vhost_vsock_net_check_mode(struct net *net,
+				       struct vhost_vsock *vsock,
+				       bool check_global)
+{
+	if (net_eq(net, vsock->net))
+		return true;
+
+	return check_global &&
+	       (vsock_net_mode(net) == VSOCK_NET_MODE_GLOBAL &&
+	        vsock->orig_net_mode == VSOCK_NET_MODE_GLOBAL);
+}
+
 /* Callers that dereference the return value must hold vhost_vsock_mutex or the
  * RCU read lock.
+ *
+ * If check_global is true, evaluate the vhost_vsock namespace and namespace
+ * net argument as matching if they are both in global mode.
  */
-static struct vhost_vsock *vhost_vsock_get(u32 guest_cid)
+static struct vhost_vsock *vhost_vsock_get(u32 guest_cid, struct net *net,
+					   bool check_global)
 {
 	struct vhost_vsock *vsock;
 
@@ -78,9 +113,9 @@ static struct vhost_vsock *vhost_vsock_get(u32 guest_cid)
 		if (other_cid == 0)
 			continue;
 
-		if (other_cid == guest_cid)
+		if (other_cid == guest_cid &&
+		    vhost_vsock_net_check_mode(net, vsock, check_global))
 			return vsock;
-
 	}
 
 	return NULL;
@@ -272,13 +307,14 @@ static int
 vhost_transport_send_pkt(struct sk_buff *skb)
 {
 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
+	struct net *net = virtio_vsock_skb_net(skb);
 	struct vhost_vsock *vsock;
 	int len = skb->len;
 
 	rcu_read_lock();
 
 	/* Find the vhost_vsock according to guest context id  */
-	vsock = vhost_vsock_get(le64_to_cpu(hdr->dst_cid));
+	vsock = vhost_vsock_get(le64_to_cpu(hdr->dst_cid), net, true);
 	if (!vsock) {
 		rcu_read_unlock();
 		kfree_skb(skb);
@@ -305,7 +341,7 @@ vhost_transport_cancel_pkt(struct vsock_sock *vsk)
 	rcu_read_lock();
 
 	/* Find the vhost_vsock according to guest context id  */
-	vsock = vhost_vsock_get(vsk->remote_addr.svm_cid);
+	vsock = vhost_vsock_get(vsk->remote_addr.svm_cid, sock_net(sk_vsock(vsk)), true);
 	if (!vsock)
 		goto out;
 
@@ -462,11 +498,12 @@ static struct virtio_transport vhost_transport = {
 
 static bool vhost_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid)
 {
+	struct net *net = sock_net(sk_vsock(vsk));
 	struct vhost_vsock *vsock;
 	bool seqpacket_allow = false;
 
 	rcu_read_lock();
-	vsock = vhost_vsock_get(remote_cid);
+	vsock = vhost_vsock_get(remote_cid, net, true);
 
 	if (vsock)
 		seqpacket_allow = vsock->seqpacket_allow;
@@ -526,6 +563,8 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
 			continue;
 		}
 
+		virtio_vsock_skb_set_net(skb, vsock->net);
+		virtio_vsock_skb_set_orig_net_mode(skb, vsock->orig_net_mode);
 		total_len += sizeof(*hdr) + skb->len;
 
 		/* Deliver to monitoring devices all received packets */
@@ -652,10 +691,14 @@ static void vhost_vsock_free(struct vhost_vsock *vsock)
 
 static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 {
+
 	struct vhost_virtqueue **vqs;
 	struct vhost_vsock *vsock;
+	struct net *net;
 	int ret;
 
+	net = current->nsproxy->net_ns;
+
 	/* This struct is large and allocation could fail, fall back to vmalloc
 	 * if there is no other way.
 	 */
@@ -669,6 +712,12 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 		goto out;
 	}
 
+	vsock->net = get_net_track(net, &vsock->ns_tracker, GFP_KERNEL);
+
+	/* Cache the mode of the namespace so that if that netns mode changes,
+	 * the vhost_vsock will continue to function as expected. */
+	vsock->orig_net_mode = vsock_net_mode(net);
+
 	vsock->guest_cid = 0; /* no CID assigned yet */
 	vsock->seqpacket_allow = false;
 
@@ -707,8 +756,16 @@ static void vhost_vsock_reset_orphans(struct sock *sk)
 	 * executing.
 	 */
 
+	/* DELETE ME:
+	 *
+	 * for each connected socket:
+	 *	vhost_vsock = vsock_sk(sk)
+	 *
+	 *	find the peer
+	 */
+
 	/* If the peer is still valid, no need to reset connection */
-	if (vhost_vsock_get(vsk->remote_addr.svm_cid))
+	if (vhost_vsock_get(vsk->remote_addr.svm_cid, sock_net(sk), false))
 		return;
 
 	/* If the close timeout is pending, let it expire.  This avoids races
@@ -753,6 +810,7 @@ static int vhost_vsock_dev_release(struct inode *inode, struct file *file)
 	virtio_vsock_skb_queue_purge(&vsock->send_pkt_queue);
 
 	vhost_dev_cleanup(&vsock->dev);
+	put_net_track(vsock->net, &vsock->ns_tracker);
 	kfree(vsock->dev.vqs);
 	vhost_vsock_free(vsock);
 	return 0;
@@ -779,7 +837,7 @@ static int vhost_vsock_set_cid(struct vhost_vsock *vsock, u64 guest_cid)
 
 	/* Refuse if CID is already in use */
 	mutex_lock(&vhost_vsock_mutex);
-	other = vhost_vsock_get(guest_cid);
+	other = vhost_vsock_get(guest_cid, vsock->net, true);
 	if (other && other != vsock) {
 		mutex_unlock(&vhost_vsock_mutex);
 		return -EADDRINUSE;

-- 
2.47.3


