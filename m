Return-Path: <linux-hyperv+bounces-10612-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sP70M9fw+Gmr3QIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10612-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 04 May 2026 21:17:43 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1A84C31F6
	for <lists+linux-hyperv@lfdr.de>; Mon, 04 May 2026 21:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99F63307EA36
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 May 2026 19:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFFF3EFD11;
	Mon,  4 May 2026 19:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TPt40JBs"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31973DEAD3;
	Mon,  4 May 2026 19:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777921829; cv=none; b=KvylzHBXdikwNNI6wRcZrg5MQsZKRoIK51/MSEUxDCaButXL3JaieaTOj+uM+ngnwciOvZ1tHbXS6PsK/Cv/56VgWjeiJOVRyUMhXtx4D8adSKACmOYDlI7RQlWGl/aBZAxm34vs0ql8fxy66X+he4RpAwPhg5KrApAg/IHlSGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777921829; c=relaxed/simple;
	bh=23uFN3aTfegN05JADAkN5Fk/VzhZPWRcqc2ALoEGgwQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MBnIZDxCc5AMl8pIHICEWlMjdx0IR3IsrdjwULvge9b6CTs0kBwHKwfx6pASBRQlSRPOq9tFhXbOHjlxrcCHfnz4ZCPdosZvflUj+GFCzfwuZ/GL2ndGlaTy9FGjxj3CuPxbcuHH1RisdKF/1kzYtfa9O+K5kVCnBBr7jtSp0As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TPt40JBs; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id BDE1D20B716E;
	Mon,  4 May 2026 12:10:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BDE1D20B716E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777921825;
	bh=+/OS16j+VhuAuVSyAhwRdWvfpap5jyQ3hygi2+yjJlY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=TPt40JBs4W6FhQRGDyOUH+/qC8itdn+vqiPW7Z5HgI9zXHpDBN5W6KXsXecsGX+Df
	 IYD9lyUHiKxbLnMta6YVvUELLE/YpT7N/+598PibwMp7/haDF2rA7GxSDNWunUhOnN
	 VCXGf0132AJqfx4AK7FbnTFVr2N3Uod6dYLPi0wg=
Subject: [PATCH v3 17/18] mshv: Validate scheduler message bounds from
 hypervisor
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 04 May 2026 19:10:27 +0000
Message-ID: 
 <177792182717.90827.9796078628160388810.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177792164525.90827.16672331609214066870.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177792164525.90827.16672331609214066870.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5F1A84C31F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-10612-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[skinsburskii-cloud-desktop.internal.cloudapp.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:dkim]

handle_pair_message() iterates up to msg->vp_count without verifying it
against HV_MESSAGE_MAX_PARTITION_VP_PAIR_COUNT. Since vp_count is read
from untrusted hypervisor data, a malformed message with a large value
would cause out-of-bounds reads from the partition_ids and vp_indexes
arrays.

handle_bitset_message() iterates over set bits in valid_bank_mask (up to
64) and advances bank_contents for each one. However, the payload buffer
only has space for 16 bank entries. A valid_bank_mask with more than 16
bits set causes bank_contents to read beyond the message buffer.

Fix both by adding bounds validation:
- Clamp vp_count to HV_MESSAGE_MAX_PARTITION_VP_PAIR_COUNT
- Track banks consumed and stop before exceeding buffer capacity

Fixes: 621191d709b1 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_synic.c |   20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
index a916a39888aad..3eb2e535efbcd 100644
--- a/drivers/hv/mshv_synic.c
+++ b/drivers/hv/mshv_synic.c
@@ -188,7 +188,9 @@ static void kick_vp(struct mshv_vp *vp)
 static void
 handle_bitset_message(const struct hv_vp_signal_bitset_scheduler_message *msg)
 {
-	int bank_idx, vps_signaled = 0, bank_mask_size;
+	int bank_idx, vps_signaled = 0, bank_mask_size, banks_used = 0;
+	const int max_banks = sizeof(msg->vp_bitset.bitset_buffer) /
+			      sizeof(u64) - 2; /* subtract format + mask */
 	struct mshv_partition *partition;
 	const struct hv_vpset *vpset;
 	const u64 *bank_contents;
@@ -228,6 +230,11 @@ handle_bitset_message(const struct hv_vp_signal_bitset_scheduler_message *msg)
 		if (bank_idx == bank_mask_size)
 			break;
 
+		if (unlikely(banks_used >= max_banks)) {
+			pr_debug("valid_bank_mask exceeds buffer capacity\n");
+			goto unlock_out;
+		}
+
 		while (true) {
 			struct mshv_vp *vp;
 
@@ -256,6 +263,7 @@ handle_bitset_message(const struct hv_vp_signal_bitset_scheduler_message *msg)
 		}
 
 		bank_contents++;
+		banks_used++;
 	}
 
 unlock_out:
@@ -272,10 +280,18 @@ handle_pair_message(const struct hv_vp_signal_pair_scheduler_message *msg)
 	struct mshv_partition *partition = NULL;
 	struct mshv_vp *vp;
 	int idx;
+	u8 vp_count = msg->vp_count;
+
+	if (unlikely(vp_count > HV_MESSAGE_MAX_PARTITION_VP_PAIR_COUNT)) {
+		pr_debug("pair message vp_count %u exceeds max %lu\n",
+			 vp_count,
+			 (unsigned long)HV_MESSAGE_MAX_PARTITION_VP_PAIR_COUNT);
+		return;
+	}
 
 	rcu_read_lock();
 
-	for (idx = 0; idx < msg->vp_count; idx++) {
+	for (idx = 0; idx < vp_count; idx++) {
 		u64 partition_id = msg->partition_ids[idx];
 		u32 vp_index = msg->vp_indexes[idx];
 



