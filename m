Return-Path: <linux-hyperv+bounces-6025-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3975BAEB18C
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Jun 2025 10:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC6E04A603D
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Jun 2025 08:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6C124E4AF;
	Fri, 27 Jun 2025 08:44:56 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DB917741;
	Fri, 27 Jun 2025 08:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751013896; cv=none; b=WO5QVqyOuEv2lQ2iK0yaLymAzLz97xL5mKedTEkxnO5N4zK4L/OhikP0fqpdK02zoZmvPM3n3h1t/p/gDtkhqvk6uuy+MvJIT0ICoirDKegn/H0SqXpkrMffo4gm5MOI7nabV4xG09aN7OMT+4ir3Z2TE6WMMQPkuyuXfW2iPD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751013896; c=relaxed/simple;
	bh=8ESayO/o4fZLFo6BTDMsLxcg6Akk7tZYwJwweA8EbdQ=;
	h=From:To:Subject:Date:Message-Id; b=AsSMXq5XCFSzDcl4/q9fqv8gH7+eCtqdwQTgfIEpVpdO9dAc50AeqApxC8lLu4pPwNwGUgRNBLSi+uARQhgkjvk4Qr+5rozRfzQn8gqkSMMiMmkvw2wtlJgpIY9Kc+Zr590B4LXQkpEuTmGBvRhdnOuQY9NjV8pjnI0iMIYftq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1009)
	id 01BAA204159D; Fri, 27 Jun 2025 01:44:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 01BAA204159D
From: Dexuan Cui <decui@microsoft.com>
To: niuxuewei97@gmail.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	sgarzare@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-hyperv@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hv_sock: Return the readable bytes in hvs_stream_has_data()
Date: Fri, 27 Jun 2025 01:44:49 -0700
Message-Id: <1751013889-4951-1-git-send-email-decui@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

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

Note: there may be multpile incoming hv_sock packets pending in the
VMBus channel's ringbuffer, but so far there is not a VMBus API that
allows us to know all the readable bytes in total without reading and
caching the payload of the multiple packets, so let's just return the
readable bytes of the next single packet. In the future, we'll either
add a VMBus API that allows us to know the total readable bytes without
touching the data in the ringbuffer, or the hv_sock driver needs to
understand the VMBus packet format and parse the packets directly.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

Hi maintainers, please don't take the patch for now.

Hi Xuewei Niu, please help to re-post this patch with the next version
of your patchset "vsock: Introduce SIOCINQ ioctl support". See
https://lore.kernel.org/virtualization/BL1PR21MB3115F69C544B0FAA145FA4EABF7BA@BL1PR21MB3115.namprd21.prod.outlook.com/#t
https://lore.kernel.org/virtualization/20250626050219.1847316-1-niuxuewei.nxw@antgroup.com/
Feel free to add your Signed-off-by, if you need.

 net/vmw_vsock/hyperv_transport.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index 31342ab502b4..64f1290a9ae7 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -694,15 +694,25 @@ static ssize_t hvs_stream_enqueue(struct vsock_sock *vsk, struct msghdr *msg,
 static s64 hvs_stream_has_data(struct vsock_sock *vsk)
 {
 	struct hvsock *hvs = vsk->trans;
+	bool need_refill = !hvs->recv_desc;
 	s64 ret;
 
 	if (hvs->recv_data_len > 0)
-		return 1;
+		return hvs->recv_data_len;
 
 	switch (hvs_channel_readable_payload(hvs->chan)) {
 	case 1:
-		ret = 1;
-		break;
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
2.49.0


