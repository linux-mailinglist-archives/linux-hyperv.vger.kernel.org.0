Return-Path: <linux-hyperv+bounces-10319-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NpHEvTA6WkXjQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10319-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 08:49:24 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A173F44DB8F
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 08:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E5EA3010145
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 06:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833B53932EF;
	Thu, 23 Apr 2026 06:48:31 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EB134E763;
	Thu, 23 Apr 2026 06:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776926911; cv=none; b=J7JHuP0QliSTDJWWcIQXl+C68PAteNasYxbdJHjV8L2VnWOLTrdi+mV8YHYJ+mZmip1pkTwF9/vXz2cMoWjgg8Kj542TwevLbC0NI+C2uqGxMvBd7k2UXVNzrG9FMiq+7io40leLUrqJBZdYCLeAdn8hE71vcSLHBBYskdIEHXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776926911; c=relaxed/simple;
	bh=ToaTXcmIVUSTWxVWGD+zkSMr0pWVWHXd5+bQHimR08I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YgrWMhMDvmNoyZl4vQr7IQpLW41Mj5hhGMiGdEHaolcinmk2Mh3RLJS6wkhOc7/Q+sORAc/u5LlL2B4Q+Hm83If8XH3SeSPzBJNRG4xzwXYBrlZsEj1R5sIzdlIn4ES560590LnEQ1STwHU4WR9Xkuk3xLzH4lBqe5usEohvTes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1009)
	id 5FF3120B7165; Wed, 22 Apr 2026 23:48:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5FF3120B7165
From: Dexuan Cui <decui@microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	sgarzare@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	niuxuewei.nxw@antgroup.com,
	linux-hyperv@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH net v2] hv_sock: Return -EIO for malformed/short packets
Date: Wed, 22 Apr 2026 23:48:11 -0700
Message-ID: <20260423064811.1371749-1-decui@microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.04 / 15.00];
	DMARC_POLICY_REJECT(2.00)[microsoft.com : SPF not aligned (relaxed), No valid DKIM,reject];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-10319-lists,linux-hyperv=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	R_DKIM_NA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[decui@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A173F44DB8F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit f63152958994 fixes a regression, however it fails to report an
error for malformed/short packets -- normally we should never see such
packets, but let's report an error for them just in case.

Fixes: f63152958994 ("hv_sock: Report EOF instead of -EIO for FIN")
Cc: stable@vger.kernel.org
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

Commit f63152958994 is currently only in net.git's master branch.

Changes since v1:
    Integrated comments from Stefano Garzarella:

        1) access 'vsk' directly:
           s/hvs->vsk->peer_shutdown/vsk->peer_shutdown/

        2) test the error condition first and return -EIO for that.

    NO other changes.


 net/vmw_vsock/hyperv_transport.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index 76e78c83fdbc..f862988c1e86 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -704,17 +704,26 @@ static s64 hvs_stream_has_data(struct vsock_sock *vsk)
 		if (hvs->recv_desc) {
 			/* Here hvs->recv_data_len is 0, so hvs->recv_desc must
 			 * be NULL unless it points to the 0-byte-payload FIN
-			 * packet: see hvs_update_recv_data().
+			 * packet or a malformed/short packet: see
+			 * hvs_update_recv_data().
 			 *
-			 * Here all the payload has been dequeued, but
-			 * hvs_channel_readable_payload() still returns 1,
-			 * because the VMBus ringbuffer's read_index is not
-			 * updated for the FIN packet: hvs_stream_dequeue() ->
-			 * hv_pkt_iter_next() updates the cached priv_read_index
-			 * but has no opportunity to update the read_index in
-			 * hv_pkt_iter_close() as hvs_stream_has_data() returns
-			 * 0 for the FIN packet, so it won't get dequeued.
+			 * If hvs->recv_desc points to the FIN packet, here all
+			 * the payload has been dequeued and the peer_shutdown
+			 * flag is set, but hvs_channel_readable_payload() still
+			 * returns 1, because the VMBus ringbuffer's read_index
+			 * is not updated for the FIN packet:
+			 * hvs_stream_dequeue() -> hv_pkt_iter_next() updates
+			 * the cached priv_read_index but has no opportunity to
+			 * update the read_index in hv_pkt_iter_close() as
+			 * hvs_stream_has_data() returns 0 for the FIN packet,
+			 * so it won't get dequeued.
+			 *
+			 * In case hvs->recv_desc points to a malformed/short
+			 * packet, return -EIO.
 			 */
+			if (!(vsk->peer_shutdown & SEND_SHUTDOWN))
+				return -EIO;
+
 			return 0;
 		}
 
-- 
2.49.0


