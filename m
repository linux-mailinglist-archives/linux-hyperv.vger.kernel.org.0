Return-Path: <linux-hyperv+bounces-10194-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHcyFTw14WkEqgAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10194-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Apr 2026 21:15:08 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AA941401E
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Apr 2026 21:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9A868302398C
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Apr 2026 19:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD97347BC4;
	Thu, 16 Apr 2026 19:15:05 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F3234D919;
	Thu, 16 Apr 2026 19:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776366905; cv=none; b=VWq48FO3xcDNM7e+bPbls4i1A0x9K+b8EJTflWiXDD40a7F+U3RMG8lfuMnIfwXBiZlvG5vrfId+AXa4jGSixhnGu3/meXQKHi4CS7v0fjZ18GuSq3kymSXexSIPCayvCrg3G0CYIrbGf1BJn530UZH/3sK1VFwghQLYWFahliw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776366905; c=relaxed/simple;
	bh=pxExjy9+COVofPKPelAFl6ZTZDTzl6NhBpiM4c7aFVI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CgpqzcrevI2cjzoXwvEAZCkPthyKAe1ZiM3eoyUBMO9IruWyetvck5brs1r/spN24PBlv0qjifzX/+EU8JP9HXSABwHj6OFCHyCWudXn8dTxqY89PGjUhefXhjQY9CIp6dSvUjQydl8kGDZ51GWLoB7DT1mRLG0E0jOtMEkX1lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1009)
	id A080C20B7128; Thu, 16 Apr 2026 12:15:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A080C20B7128
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
Cc: stable@vger.kernel.org,
	Ben Hillis <Ben.Hillis@microsoft.com>,
	Mitchell Levy <levymitchell0@gmail.com>
Subject: [PATCH net v2] hv_sock: Report EOF instead of -EIO for FIN
Date: Thu, 16 Apr 2026 12:14:33 -0700
Message-ID: <20260416191433.840637-1-decui@microsoft.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10194-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[vger.kernel.org,microsoft.com,gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FROM_NEQ_ENVFROM(0.00)[decui@microsoft.com,linux-hyperv@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 71AA941401E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit f0c5827d07cb unluckily causes a regression for the FIN packet,
and the final read syscall gets an error rather than 0.

Ideally, we would want to fix hvs_channel_readable_payload() so that it
could return 0 in the FIN scenario, but it's not good for the hv_sock
driver to use the VMBus ringbuffer's cached priv_read_index, which is
internal data in the VMBus driver.

Fix the regression in hv_sock by returning 0 rather than -EIO.

Fixes: f0c5827d07cb ("hv_sock: Return the readable bytes in hvs_stream_has_data()")
Cc: stable@vger.kernel.org
Reported-by: Ben Hillis <Ben.Hillis@microsoft.com>
Reported-by: Mitchell Levy <levymitchell0@gmail.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

Changes since v1:
    Removed the local variable 'need_refill' to make the code more 
    readable. Stefano, thanks!

    No other change.

 net/vmw_vsock/hyperv_transport.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index 069386a74557..e5ee7aa14d0c 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -694,7 +694,6 @@ static ssize_t hvs_stream_enqueue(struct vsock_sock *vsk, struct msghdr *msg,
 static s64 hvs_stream_has_data(struct vsock_sock *vsk)
 {
 	struct hvsock *hvs = vsk->trans;
-	bool need_refill;
 	s64 ret;
 
 	if (hvs->recv_data_len > 0)
@@ -702,9 +701,22 @@ static s64 hvs_stream_has_data(struct vsock_sock *vsk)
 
 	switch (hvs_channel_readable_payload(hvs->chan)) {
 	case 1:
-		need_refill = !hvs->recv_desc;
-		if (!need_refill)
-			return -EIO;
+		if (hvs->recv_desc) {
+			/* Here hvs->recv_data_len is 0, so hvs->recv_desc must
+			 * be NULL unless it points to the 0-byte-payload FIN
+			 * packet: see hvs_update_recv_data().
+			 *
+			 * Here all the payload has been dequeued, but
+			 * hvs_channel_readable_payload() still returns 1,
+			 * because the VMBus ringbuffer's read_index is not
+			 * updated for the FIN packet: hvs_stream_dequeue() ->
+			 * hv_pkt_iter_next() updates the cached priv_read_index
+			 * but has no opportunity to update the read_index in
+			 * hv_pkt_iter_close() as hvs_stream_has_data() returns
+			 * 0 for the FIN packet, so it won't get dequeued.
+			 */
+			return 0;
+		}
 
 		hvs->recv_desc = hv_pkt_iter_first(hvs->chan);
 		if (!hvs->recv_desc)
-- 
2.49.0


