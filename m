Return-Path: <linux-hyperv+bounces-6143-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FB6AFC2DE
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Jul 2025 08:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD6827AFD9A
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Jul 2025 06:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865502264CF;
	Tue,  8 Jul 2025 06:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="AF3fixyn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from out198-25.us.a.mail.aliyun.com (out198-25.us.a.mail.aliyun.com [47.90.198.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBD42248BE;
	Tue,  8 Jul 2025 06:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751956619; cv=none; b=BtfFUelwAWUtnbSK+lGutF6KnIHMihxyGrvEtxJVf2I17nW5Mh04icKKDp3DCP+30kpNrf34+W22GyaGX4f/X8Xinv/PwclCP/4iGtNXrSbbxio9jnlLR17GIAj+0IiTPaNj4hTY3JeQJkV8Y9Me5xgbfaa/Nsw807cdSaD5dM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751956619; c=relaxed/simple;
	bh=/smSTVBOTYXd206lVwYMeJLOzk2Z6oW8Q2vy5QxlzrA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LKUIGBYjCgWWubx/hislOjnb4eXuXhKeXuOsZ8c5O/ew2rYG776TP/CkVrhGbjZVhg7iTJC1LtumJ1HX0FPKOYxYZx3S7l3evpW13d3dLok/NkcrPzt2sElxO0C6KvGv9J+q+/8/s0fw1H2aIzxwA6uVPvvyInO7I1d7BXCQr/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=AF3fixyn; arc=none smtp.client-ip=47.90.198.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1751956603; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	bh=BWrbRfuOAO4JIUdkE1HlpoBHmDvPPs8uqWlIP2joYso=;
	b=AF3fixynQCtgGLiCbQh54F9QWqaniJh5/Oa1MNV91PxOheAb6CyM1xgcSPRlG0dHmgeG64ZzBwSdiPj5AElSm9kdRqr6+09oFqhll0O2wZ3KilJi70zuRP0WS4/kz30nm7DS058xbWEzdZcFzp/Z2ia0AdCU2wOqWG9uz01bTnY=
Received: from 127.0.0.1(mailfrom:niuxuewei.nxw@antgroup.com fp:SMTPD_---.dhGPAbr_1751956601 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 08 Jul 2025 14:36:43 +0800
From: Xuewei Niu <niuxuewei.nxw@antgroup.com>
Date: Tue, 08 Jul 2025 14:36:11 +0800
Subject: [PATCH net-next v6 1/4] hv_sock: Return the readable bytes in
 hvs_stream_has_data()
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-siocinq-v6-1-3775f9a9e359@antgroup.com>
References: <20250708-siocinq-v6-0-3775f9a9e359@antgroup.com>
In-Reply-To: <20250708-siocinq-v6-0-3775f9a9e359@antgroup.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xuewei Niu <niuxuewei.nxw@antgroup.com>, niuxuewei97@gmail.com
X-Mailer: b4 0.14.2

From: Dexuan Cui <decui@microsoft.com>

When hv_sock was originally added, __vsock_stream_recvmsg() and
vsock_stream_has_data() actually only needed to know whether there
is any readable data or not, so hvs_stream_has_data() was written to
return 1 or 0 for simplicity.

However, now hvs_stream_has_data() should return the readable bytes
because vsock_data_ready() -> vsock_stream_has_data() needs to know the
actual bytes rather than a boolean value of 1 or 0.

The SIOCINQ ioctl support also needs hvs_stream_has_data() to return
the readable bytes.

Let hvs_stream_has_data() return the readable bytes of the payload in
the next host-to-guest VMBus hv_sock packet.

Note: there may be multiple incoming hv_sock packets pending in the
VMBus channel's ringbuffer, but so far there is not a VMBus API that
allows us to know all the readable bytes in total without reading and
caching the payload of the multiple packets, so let's just return the
readable bytes of the next single packet. In the future, we'll either
add a VMBus API that allows us to know the total readable bytes without
touching the data in the ringbuffer, or the hv_sock driver needs to
understand the VMBus packet format and parse the packets directly.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
---
 net/vmw_vsock/hyperv_transport.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index 31342ab502b4fc35feb812d2c94e0e35ded73771..432fcbbd14d4f44bd2550be8376e42ce65122758 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -694,15 +694,26 @@ static ssize_t hvs_stream_enqueue(struct vsock_sock *vsk, struct msghdr *msg,
 static s64 hvs_stream_has_data(struct vsock_sock *vsk)
 {
 	struct hvsock *hvs = vsk->trans;
+	bool need_refill;
 	s64 ret;
 
 	if (hvs->recv_data_len > 0)
-		return 1;
+		return hvs->recv_data_len;
 
 	switch (hvs_channel_readable_payload(hvs->chan)) {
 	case 1:
-		ret = 1;
-		break;
+		need_refill = !hvs->recv_desc;
+		if (!need_refill)
+			return -EIO;
+
+		hvs->recv_desc = hv_pkt_iter_first(hvs->chan);
+		if (!hvs->recv_desc)
+			return -ENOBUFS;
+
+		ret = hvs_update_recv_data(hvs);
+		if (ret)
+			return ret;
+		return hvs->recv_data_len;
 	case 0:
 		vsk->peer_shutdown |= SEND_SHUTDOWN;
 		ret = 0;

-- 
2.34.1


