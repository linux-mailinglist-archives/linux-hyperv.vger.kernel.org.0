Return-Path: <linux-hyperv+bounces-10232-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBkEHUHo5mkv1wEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10232-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 05:00:17 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF495435A55
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 05:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47ED5300B473
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 03:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BB2284693;
	Tue, 21 Apr 2026 03:00:15 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CE6283FE6;
	Tue, 21 Apr 2026 03:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776740415; cv=none; b=Qq/a00O+9iwTBNeyWVesUxOI8qLYApNC/v4kiTKRBHr25p+KcqGEx+uE9e+EGOO7Jp46nW1wDx+KjRPPwccPJ/9W1HUdxmNcJce9a8BXsyFQPMeWatWb+0R+Fg3ixAwkHyGJ0820GIKMWBgbAEvcu1N5joQY17FGur7lo8bNVHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776740415; c=relaxed/simple;
	bh=oNW7xMaTEhp1CPbPLkE7pkH+64rQO8MKAKD7dZIRLVo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cdqOr6jcoQpBPwxA2u93aEkTBAZcm+WH6xy9ln1R25H6XpWMuLCEGZND4nMUXMcqkGY4AG2xRDPQ8WJ4sGvyOHosRrP0+AS/jS8HS0K4BjbniZUP5bDt6vEGQnXaia0TQqEzafszZx4d18wmxfQfDMgFsoCca6AjHSblhyRml5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1009)
	id E12AC20B7128; Mon, 20 Apr 2026 20:00:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E12AC20B7128
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
Subject: [PATCH net v3] hv_sock: Report EOF instead of -EIO for FIN
Date: Mon, 20 Apr 2026 19:59:50 -0700
Message-ID: <20260421025950.1099495-1-decui@microsoft.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10232-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[vger.kernel.org,microsoft.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[decui@microsoft.com,linux-hyperv@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[]
X-Rspamd-Queue-Id: BF495435A55
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit f0c5827d07cb unluckily causes a regression for the FIN packet,
and the final read syscall gets an error rather than 0.

Ideally, we would want to fix hvs_channel_readable_payload() so that it
could return 0 in the FIN scenario, but it's not good for the hv_sock
driver to use the VMBus ringbuffer's cached priv_read_index, which is
internal data in the VMBus driver.

Fix the regression in hv_sock by returning 0 rather than -EIO.

In case we see a malformed/short packet, we still return -EIO.

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


Changes since v2:
    Added code to test the flag SEND_SHUTDOWN. Copilot, thanks!
    Updated the comment and the commit messages accordingly.

 net/vmw_vsock/hyperv_transport.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index 069386a74557..da150de10f0d 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -694,7 +694,6 @@ static ssize_t hvs_stream_enqueue(struct vsock_sock *vsk, struct msghdr *msg,
 static s64 hvs_stream_has_data(struct vsock_sock *vsk)
 {
 	struct hvsock *hvs = vsk->trans;
-	bool need_refill;
 	s64 ret;
 
 	if (hvs->recv_data_len > 0)
@@ -702,9 +701,31 @@ static s64 hvs_stream_has_data(struct vsock_sock *vsk)
 
 	switch (hvs_channel_readable_payload(hvs->chan)) {
 	case 1:
-		need_refill = !hvs->recv_desc;
-		if (!need_refill)
-			return -EIO;
+		if (hvs->recv_desc) {
+			/* Here hvs->recv_data_len is 0, so hvs->recv_desc must
+			 * be NULL unless it points to the 0-byte-payload FIN
+			 * packet or a malformed/short packet: see
+			 * hvs_update_recv_data().
+			 *
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
+			 */
+			if (hvs->vsk->peer_shutdown & SEND_SHUTDOWN)
+				return 0;
+			else
+				return -EIO;
+		}
 
 		hvs->recv_desc = hv_pkt_iter_first(hvs->chan);
 		if (!hvs->recv_desc)
-- 
2.49.0


