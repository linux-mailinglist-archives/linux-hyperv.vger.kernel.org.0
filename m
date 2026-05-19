Return-Path: <linux-hyperv+bounces-11028-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIhvI6mWDGp1jAUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11028-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 18:58:17 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EFE582BC2
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 18:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 600593058642
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 16:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2173F3546CA;
	Tue, 19 May 2026 16:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/ZdmZSn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B961B40911F
	for <linux-hyperv@vger.kernel.org>; Tue, 19 May 2026 16:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779209853; cv=none; b=n8wQG1xR8WkPzjV5OqNwbaext4Erb1V2aUyya9TG/qOulMPz2MYrAvorDeOJGrUOWMnqmDqJnNlcqNJJInHUbF3qXEQxAtbDIp2aH5Fs+npYwQ27Vhs0RxFLQnqq7iuKh/2qqtSVLRzRUNMnBO8qXgmGlc0b4Dm8HzQmxRJRmxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779209853; c=relaxed/simple;
	bh=/dxqY7vF83zqkB9TeiJY/hUNAh4ZjWZkHbYyxtAuPwA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hcoxXfADuSX0uA87rxC7aTyDD9nwqiCuSEsBNuj0XqDhO0RSmJtJ1vCXKG03A5A0Bp3AZP9IIxEPcdyOk8mfT/zcn9N5CYDHHYW+jqs6XAmfGB4tXZuPPV3U/SaAwSetBhW7ANBger+V60HzoNE51CN1/KI5M1KN88T26881FD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/ZdmZSn; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-365deee00c3so304378a91.1
        for <linux-hyperv@vger.kernel.org>; Tue, 19 May 2026 09:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779209846; x=1779814646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TXSSb+QnSoLncqTyl5C1Wf9KSszK/YhT+NIcZleisWI=;
        b=O/ZdmZSnxyCIZCAjLM7bxtrDB1QqLs+7cV6vMMKosq5UsUbTXgB9Rfoi+T9fwVXUCc
         quWxqeqNaiz5XQcYHqOqLo+IXqVjPRxPZHvYC6e8PSy45Hjovd/6svCg36YSVvAX8+80
         ZxBY1yuREZNpsp0adbai4ewHsJoC0uqnrEZ5uc2s2z6eX2d5yQUZBB87fPirmRQNG8Bn
         MrXbhp0eLJH2IcdGexbQ6MWRs45e+b6yvtX7fyWvs/B3QGBmUGas4jYVv1IGqt0Qi7Ha
         i0fysplSrsBs1VW7guG73hARhF1ioLdAODpA6K16LfJpaVkG1nkwo3Vx3uf4MkpmX72I
         GY1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779209846; x=1779814646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXSSb+QnSoLncqTyl5C1Wf9KSszK/YhT+NIcZleisWI=;
        b=K1AClbRN/B+0/imME52PNWIteYYwGxYxLOnoM1IBnuVAWNYlwM81JpkBMhtEMveKhT
         vvG90uLcvvC9cTUDC98suU4cjNDrmVepTD+qiWoUKubdkUQPZNvToAr3/Htg4ALxW3R9
         5AZHFfo9wxuuYZVrVpYyh61BavJI1rrHFmm9mo8DpnlTh9tLj9oaV66NgdDwJAkhOBI8
         EOYzpmFgXFG1owPKJqngbInE1zd7M2aWgV3r133c1WIymxnUlkyifZrxcaToCew75sxW
         vVQRR9q7YnKbWCJStE3an7Zb86p3M+4V4ecbOgi8tpx5YvyNtSGidQEYuP9fGCI9qhTN
         JHDg==
X-Forwarded-Encrypted: i=1; AFNElJ/MO2dlGDFAQ7NnPeFwg3a5IRvsmRvjucH3pgD+7/PkjpyiqxqT7yO9u76scC1aObG0hOwFZEbFKpm8hg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdC2gsos55Ifzf2gx0dk1WB2P+3LOxHX3McxU9iB7n2MZvugZS
	yJGgtVe5hanimxhSdwiqpoAtcvRSgszzd7v/HjkEGB0x/9bxmSF6wj+D
X-Gm-Gg: Acq92OFi8lAFD6R+vS+UVRrZorIFsbB4lYPyOJGhWF8ompiFsjPunXYPGL37x0jvGQ6
	aBs4+6imbEhforyyNz8cMMVuc114A2m+EF2L78deRv/XvsBCHCxqI4opsh2DoOvnMS5p0RY1Oys
	eNd5n8dcmtE+AestJaG/v9xeUBBMPFnSID5Vb8Qo9vCKNftvz0xMevM9V7wDhfyvtfcckbEKWar
	0mA95ls3P2TiS8LHZy1GbZUkTLmbriEOUG3MS88JthhlcxyYm3GYoXHrLUkYu8ZPNvHBWyndWGW
	jGcwhcVOodSNb0way+J3i4EXTvWIuKfEDFKKAE4xKjSaqQYsHWzQUbiTbqXlRxI4r53URohpGt5
	7aiHY7WWYgJygHeOy2E4lSqsnGU+vQRWdZgXJ78uM+4Asa0YtQfZ89QGWjb24CwWMGEszRnw8/I
	5c45wnQBC4jVkXZ1j1GJGsVGYIXlSG+qupOnKFlK/AVmiC
X-Received: by 2002:a17:903:2ec7:b0:2bd:9875:d457 with SMTP id d9443c01a7336-2bd9875d4fdmr109091215ad.8.1779209846248;
        Tue, 19 May 2026 09:57:26 -0700 (PDT)
Received: from gmail.com ([117.133.78.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5fe67sm204597705ad.3.2026.05.19.09.57.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 19 May 2026 09:57:25 -0700 (PDT)
From: Ziyu Zhang <ziyuzhang201@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Andy King <acking@vmware.com>,
	George Zhang <georgezhang@vmware.com>,
	Dmitry Torokhov <dtor@vmware.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	kvm@vger.kernel.org,
	baijiaju1990@gmail.com,
	r33s3n6@gmail.com,
	gality369@gmail.com,
	zhenghaoran154@gmail.com,
	hanguidong02@gmail.com,
	zzzccc427@gmail.com,
	Ziyu Zhang <ziyuzhang201@gmail.com>
Subject: [PATCH net v2] vsock: keep poll shutdown state consistent
Date: Wed, 20 May 2026 00:56:36 +0800
Message-Id: <20260519165636.62542-1-ziyuzhang201@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11028-lists,linux-hyperv=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vmware.com,microsoft.com,redhat.com,linux.alibaba.com,broadcom.com,lists.linux.dev,vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[34];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ziyuzhang201@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 33EFE582BC2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

vsock_poll() reads vsk->peer_shutdown before taking the socket lock
to set EPOLLHUP and EPOLLRDHUP, then reads it again after taking
the lock to report EOF readability. A shutdown packet can update
peer_shutdown while poll is waiting for the lock, so one poll invocation
can report EOF readability without the corresponding HUP/RDHUP bits.

For connectible sockets, take one peer_shutdown snapshot after
lock_sock() and use it for all peer-shutdown-derived poll bits. For
datagram sockets, which do not take lock_sock() in poll(), take one
lockless READ_ONCE() snapshot and pair it with WRITE_ONCE() on the
writer side.

This keeps the peer-shutdown-derived bits internally consistent for each
poll pass.

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Signed-off-by: Ziyu Zhang <ziyuzhang201@gmail.com>
---
Link: https://lore.kernel.org/netdev/20260516034745.260442-1-ziyuzhang201@gmail.com/

v2:
- Pair lockless READ_ONCE() users with WRITE_ONCE() on peer_shutdown writers.
- Move datagram shutdown handling into the SOCK_DGRAM branch and add a comment.
- Keep one connectible peer_shutdown snapshot after lock_sock() and
  restore the previous shutdown-derived mask ordering.

 net/vmw_vsock/af_vsock.c                | 49 ++++++++++++++++---------
 net/vmw_vsock/hyperv_transport.c        |  9 +++--
 net/vmw_vsock/virtio_transport_common.c | 14 ++++---
 net/vmw_vsock/vmci_transport.c          |  8 ++--
 4 files changed, 52 insertions(+), 28 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index adcba1b7b..789b00f6e 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -523,7 +523,7 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 		 */
 		sock_reset_flag(sk, SOCK_DONE);
 		sk->sk_state = TCP_CLOSE;
-		vsk->peer_shutdown = 0;
+		WRITE_ONCE(vsk->peer_shutdown, 0);
 	}
 
 	if (sk->sk_type == SOCK_SEQPACKET) {
@@ -814,7 +814,7 @@ static struct sock *__vsock_create(struct net *net,
 	vsk->rejected = false;
 	vsk->sent_request = false;
 	vsk->ignore_connecting_rst = false;
-	vsk->peer_shutdown = 0;
+	WRITE_ONCE(vsk->peer_shutdown, 0);
 	INIT_DELAYED_WORK(&vsk->connect_work, vsock_connect_timeout);
 	INIT_DELAYED_WORK(&vsk->pending_work, vsock_pending_work);
 
@@ -1122,6 +1122,25 @@ static int vsock_shutdown(struct socket *sock, int mode)
 	return err;
 }
 
+static __poll_t vsock_poll_shutdown(struct sock *sk, u32 peer_shutdown)
+{
+	__poll_t mask = 0;
+
+	/* INET sockets treat local write shutdown and peer write shutdown as a
+	 * case of EPOLLHUP set.
+	 */
+	if (sk->sk_shutdown == SHUTDOWN_MASK ||
+	    ((sk->sk_shutdown & SEND_SHUTDOWN) &&
+	     (peer_shutdown & SEND_SHUTDOWN)))
+		mask |= EPOLLHUP;
+
+	if (sk->sk_shutdown & RCV_SHUTDOWN ||
+	    peer_shutdown & SEND_SHUTDOWN)
+		mask |= EPOLLRDHUP;
+
+	return mask;
+}
+
 static __poll_t vsock_poll(struct file *file, struct socket *sock,
 			       poll_table *wait)
 {
@@ -1139,24 +1158,17 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
 		/* Signify that there has been an error on this socket. */
 		mask |= EPOLLERR;
 
-	/* INET sockets treat local write shutdown and peer write shutdown as a
-	 * case of EPOLLHUP set.
-	 */
-	if ((sk->sk_shutdown == SHUTDOWN_MASK) ||
-	    ((sk->sk_shutdown & SEND_SHUTDOWN) &&
-	     (vsk->peer_shutdown & SEND_SHUTDOWN))) {
-		mask |= EPOLLHUP;
-	}
-
-	if (sk->sk_shutdown & RCV_SHUTDOWN ||
-	    vsk->peer_shutdown & SEND_SHUTDOWN) {
-		mask |= EPOLLRDHUP;
-	}
-
 	if (sk_is_readable(sk))
 		mask |= EPOLLIN | EPOLLRDNORM;
 
 	if (sock->type == SOCK_DGRAM) {
+		u32 peer_shutdown = READ_ONCE(vsk->peer_shutdown);
+
+		/* DGRAM sockets do not take lock_sock() in poll(), so use one
+		 * lockless snapshot for all shutdown-derived mask bits.
+		 */
+		mask |= vsock_poll_shutdown(sk, peer_shutdown);
+
 		/* For datagram sockets we can read if there is something in
 		 * the queue and write as long as the socket isn't shutdown for
 		 * sending.
@@ -1171,6 +1183,7 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
 
 	} else if (sock_type_connectible(sk->sk_type)) {
 		const struct vsock_transport *transport;
+		u32 peer_shutdown;
 
 		lock_sock(sk);
 
@@ -1203,8 +1216,10 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
 		 * terminated should also be considered read, and we check the
 		 * shutdown flag for that.
 		 */
+		peer_shutdown = READ_ONCE(vsk->peer_shutdown);
+		mask |= vsock_poll_shutdown(sk, peer_shutdown);
 		if (sk->sk_shutdown & RCV_SHUTDOWN ||
-		    vsk->peer_shutdown & SEND_SHUTDOWN) {
+		    peer_shutdown & SEND_SHUTDOWN) {
 			mask |= EPOLLIN | EPOLLRDNORM;
 		}
 
diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index 432fcbbd1..16b981566 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -264,7 +264,7 @@ static void hvs_do_close_lock_held(struct vsock_sock *vsk,
 	struct sock *sk = sk_vsock(vsk);
 
 	sock_set_flag(sk, SOCK_DONE);
-	vsk->peer_shutdown = SHUTDOWN_MASK;
+	WRITE_ONCE(vsk->peer_shutdown, SHUTDOWN_MASK);
 	if (vsock_stream_has_data(vsk) <= 0)
 		sk->sk_state = TCP_CLOSING;
 	sk->sk_state_change(sk);
@@ -593,7 +593,9 @@ static int hvs_update_recv_data(struct hvsock *hvs)
 		return -EIO;
 
 	if (payload_len == 0)
-		hvs->vsk->peer_shutdown |= SEND_SHUTDOWN;
+		WRITE_ONCE(hvs->vsk->peer_shutdown,
+			   READ_ONCE(hvs->vsk->peer_shutdown) |
+			   SEND_SHUTDOWN);
 
 	hvs->recv_data_len = payload_len;
 	hvs->recv_data_off = 0;
@@ -715,7 +717,8 @@ static s64 hvs_stream_has_data(struct vsock_sock *vsk)
 			return ret;
 		return hvs->recv_data_len;
 	case 0:
-		vsk->peer_shutdown |= SEND_SHUTDOWN;
+		WRITE_ONCE(vsk->peer_shutdown,
+			   READ_ONCE(vsk->peer_shutdown) | SEND_SHUTDOWN);
 		ret = 0;
 		break;
 	default: /* -1 */
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index dcc8a1d58..71d8eac82 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1220,7 +1220,7 @@ static void virtio_transport_do_close(struct vsock_sock *vsk,
 	struct sock *sk = sk_vsock(vsk);
 
 	sock_set_flag(sk, SOCK_DONE);
-	vsk->peer_shutdown = SHUTDOWN_MASK;
+	WRITE_ONCE(vsk->peer_shutdown, SHUTDOWN_MASK);
 	if (vsock_stream_has_data(vsk) <= 0)
 		sk->sk_state = TCP_CLOSING;
 	sk->sk_state_change(sk);
@@ -1411,12 +1411,15 @@ virtio_transport_recv_connected(struct sock *sk,
 	case VIRTIO_VSOCK_OP_CREDIT_UPDATE:
 		sk->sk_write_space(sk);
 		break;
-	case VIRTIO_VSOCK_OP_SHUTDOWN:
+	case VIRTIO_VSOCK_OP_SHUTDOWN: {
+		u32 peer_shutdown = READ_ONCE(vsk->peer_shutdown);
+
 		if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SHUTDOWN_RCV)
-			vsk->peer_shutdown |= RCV_SHUTDOWN;
+			peer_shutdown |= RCV_SHUTDOWN;
 		if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SHUTDOWN_SEND)
-			vsk->peer_shutdown |= SEND_SHUTDOWN;
-		if (vsk->peer_shutdown == SHUTDOWN_MASK) {
+			peer_shutdown |= SEND_SHUTDOWN;
+		WRITE_ONCE(vsk->peer_shutdown, peer_shutdown);
+		if (peer_shutdown == SHUTDOWN_MASK) {
 			if (vsock_stream_has_data(vsk) <= 0 && !sock_flag(sk, SOCK_DONE)) {
 				(void)virtio_transport_reset(vsk, NULL);
 				virtio_transport_do_close(vsk, true);
@@ -1431,6 +1434,7 @@ virtio_transport_recv_connected(struct sock *sk,
 		if (le32_to_cpu(virtio_vsock_hdr(skb)->flags))
 			sk->sk_state_change(sk);
 		break;
+	}
 	case VIRTIO_VSOCK_OP_RST:
 		virtio_transport_do_close(vsk, true);
 		break;
diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 7eccd6708..c2231c402 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -811,7 +811,7 @@ static void vmci_transport_handle_detach(struct sock *sk)
 		/* On a detach the peer will not be sending or receiving
 		 * anymore.
 		 */
-		vsk->peer_shutdown = SHUTDOWN_MASK;
+		WRITE_ONCE(vsk->peer_shutdown, SHUTDOWN_MASK);
 
 		/* We should not be sending anymore since the peer won't be
 		 * there to receive, but we can still receive if there is data
@@ -1534,7 +1534,9 @@ static int vmci_transport_recv_connected(struct sock *sk,
 		if (pkt->u.mode) {
 			vsk = vsock_sk(sk);
 
-			vsk->peer_shutdown |= pkt->u.mode;
+			WRITE_ONCE(vsk->peer_shutdown,
+				   READ_ONCE(vsk->peer_shutdown) |
+				   pkt->u.mode);
 			sk->sk_state_change(sk);
 		}
 		break;
@@ -1551,7 +1553,7 @@ static int vmci_transport_recv_connected(struct sock *sk,
 		 * a clean shutdown.
 		 */
 		sock_set_flag(sk, SOCK_DONE);
-		vsk->peer_shutdown = SHUTDOWN_MASK;
+		WRITE_ONCE(vsk->peer_shutdown, SHUTDOWN_MASK);
 		if (vsock_stream_has_data(vsk) <= 0)
 			sk->sk_state = TCP_CLOSING;
 
-- 
2.43.0


