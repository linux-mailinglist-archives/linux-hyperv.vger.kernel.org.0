Return-Path: <linux-hyperv+bounces-10690-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOqRFJmz/GmOSwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10690-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 07 May 2026 17:45:29 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F624EB4B3
	for <lists+linux-hyperv@lfdr.de>; Thu, 07 May 2026 17:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 715E83019D07
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 May 2026 15:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63AB44BC94;
	Thu,  7 May 2026 15:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ig0B4Y0F"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5F244D02B;
	Thu,  7 May 2026 15:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778168668; cv=none; b=IQDjjfiNDT9nybUgwyqC6osLXOT7/2Xh39+tlQnUxuyGASFVmdpRuRNEeNCa1y36DsjB82W+QMGh0/M/HCw8naYm3JAWFCwLY+FUYdJciWVTbFNVis3ym79U7aqJxy8XBjSnJlP8X6CujevOIda+NV4fJUYfQaIemS1cBWgnL6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778168668; c=relaxed/simple;
	bh=489mJxtANo4CiHpDiLS5ZFCdsBixCGFzkgwfg7/oMqc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VDhYYaGBM84pHaUbJF3IfMVRHcSBbAAXyqwXycG8d4sNgWqoApBKsDTOHhJZ3v7+Q/rHlwaryeiH23UgDRhEPeysgvYoRj0j/QNmBF7N05/WP/cOB4ugc5gcKfhOjbndkgMHhJyeIWgoF9vr2zWFHSyPLh9AWCZRYnmnhdsYLEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ig0B4Y0F; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id EB4FB20B7165;
	Thu,  7 May 2026 08:44:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EB4FB20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778168664;
	bh=sAkXH2YUz2zIfABUn2fKnt6ktvXMZuH9fBZSbeKpt+k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ig0B4Y0FqV0FrDHg5ZiHCKJsiXqBsFZd2JsWmarlCs3E0udbpLmhXiCONSn1fv4zf
	 /gEHFYBEsRCjFARfWRhvsDoqHfa3RC41P7B6aDWFC3Z/+e8dOFayUmtC2+lRcs8RZb
	 MN7U2wYcYeAF2cfmRHGBFI+/EBgN7i4tVQ/jATGg=
Subject: [PATCH v4 16/18] mshv: Validate scheduler message bounds from
 hypervisor
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 07 May 2026 15:44:26 +0000
Message-ID: 
 <177816866691.21765.15605640837157423543.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177816592843.21765.4364464279247150355.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177816592843.21765.4364464279247150355.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 34F624EB4B3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-10690-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,skinsburskii-cloud-desktop.internal.cloudapp.net:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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
index 89207aad7cf1f..5d509299f14d7 100644
--- a/drivers/hv/mshv_synic.c
+++ b/drivers/hv/mshv_synic.c
@@ -190,7 +190,9 @@ static void kick_vp(struct mshv_vp *vp)
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
@@ -230,6 +232,11 @@ handle_bitset_message(const struct hv_vp_signal_bitset_scheduler_message *msg)
 		if (bank_idx == bank_mask_size)
 			break;
 
+		if (unlikely(banks_used >= max_banks)) {
+			pr_debug("valid_bank_mask exceeds buffer capacity\n");
+			goto unlock_out;
+		}
+
 		while (true) {
 			struct mshv_vp *vp;
 
@@ -258,6 +265,7 @@ handle_bitset_message(const struct hv_vp_signal_bitset_scheduler_message *msg)
 		}
 
 		bank_contents++;
+		banks_used++;
 	}
 
 unlock_out:
@@ -274,10 +282,18 @@ handle_pair_message(const struct hv_vp_signal_pair_scheduler_message *msg)
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
 



