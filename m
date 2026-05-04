Return-Path: <linux-hyperv+bounces-10610-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCuMCWPw+Gl93QIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10610-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 04 May 2026 21:15:47 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2224C319A
	for <lists+linux-hyperv@lfdr.de>; Mon, 04 May 2026 21:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2E0E30A60D2
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 May 2026 19:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02C03F0A98;
	Mon,  4 May 2026 19:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Cx/WPd67"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1283EFD04;
	Mon,  4 May 2026 19:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777921817; cv=none; b=Tw6Pye9XXyErQmNOd2knGfb6XvxuGYRahvf/rO+QZrMD5jxpvHZOvrTAD8NV6fWXb6xQYmbMYfhXO5X0nSej3Dj1/qc5fGXtyLqzzQa6UGiFEywq+lKNNRpeECys4kMHUs76iJmycc3kiVUCiEDGKOqOVbwxLFYMG6sQ0UuVfCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777921817; c=relaxed/simple;
	bh=EPfKiBXlBtnvFwf7V+ju0rV7FJ/HqFbX9sy4THdrpiU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sMMSWAU3D74JMFlo08fr7J9ZPJBMmPZM8Fdg81b35j2W2sFJ3uz8A3HmdbJPYHMOkifC9Z+nAvuGvQ8WpMCoMiz2/hnlKhaAOKitxPpUKvYDMejpZAPWhkAg1Scup1YdzdDpfpsZwkUpi/V7ToW/t5iotT126TJVmDI8wVsEQ+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Cx/WPd67; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id B6E0F20B7168;
	Mon,  4 May 2026 12:10:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B6E0F20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777921813;
	bh=C8jPCExxYovq7VS/EFFDAQDeVKh3s3SW3kKuhhukPMI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Cx/WPd677CgscBWRQTK95E3J8oP37yvz00WMyVxlC1OC6feXDolxgRhVAF8an750L
	 AyjsYQMDJ8f2wPJfmvOdWqsu1+t+b16+egpNUMUU9aiOsWP2yji+5Xeyqtld3Q2LcK
	 pKZ0DnTelNkmhELeKap3uEvATebJlHi3Iu90mgzY=
Subject: [PATCH v3 15/18] mshv: Add missing vp_index bounds check in intercept
 ISR
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 04 May 2026 19:10:15 +0000
Message-ID: 
 <177792181518.90827.9607275376159867974.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
X-Rspamd-Queue-Id: CC2224C319A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-10610-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,skinsburskii-cloud-desktop.internal.cloudapp.net:mid,linux.microsoft.com:dkim]

mshv_intercept_isr() reads vp_index from the intercept message payload
and uses it directly to index into partition->pt_vp_array without
validating it against MSHV_MAX_VPS. A malformed or corrupted hypervisor
message with a vp_index beyond the array bounds would cause an
out-of-bounds memory access in interrupt context, likely crashing the
host.

Use READ_ONCE() when reading vp_index from the shared SynIC message
page to prevent the compiler from re-fetching the value between the
bounds check and the array access.

Both handle_bitset_message() and handle_pair_message() already validate
vp_index before use. Add the same check to mshv_intercept_isr() for
consistency.

Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_synic.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
index 43f1bcbbf2d34..39c6b22e1e11e 100644
--- a/drivers/hv/mshv_synic.c
+++ b/drivers/hv/mshv_synic.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/nospec.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
 #include <linux/interrupt.h>
@@ -382,8 +383,13 @@ mshv_intercept_isr(struct hv_message *msg)
 	 * (because the vp is only deleted when the partition is), no additional
 	 * locking is needed here
 	 */
-	vp_index =
-	       ((struct hv_opaque_intercept_message *)msg->u.payload)->vp_index;
+	vp_index = READ_ONCE(
+	       ((struct hv_opaque_intercept_message *)msg->u.payload)->vp_index);
+	if (unlikely(vp_index >= MSHV_MAX_VPS)) {
+		pr_debug("VP index %u out of bounds\n", vp_index);
+		goto unlock_out;
+	}
+	vp_index = array_index_nospec(vp_index, MSHV_MAX_VPS);
 	vp = partition->pt_vp_array[vp_index];
 	if (unlikely(!vp)) {
 		pr_debug("failed to find VP %u\n", vp_index);



