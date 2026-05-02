Return-Path: <linux-hyperv+bounces-10567-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBngGZB99WnZLgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10567-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 02 May 2026 06:29:04 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 508204B0DA3
	for <lists+linux-hyperv@lfdr.de>; Sat, 02 May 2026 06:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E5109300E288
	for <lists+linux-hyperv@lfdr.de>; Sat,  2 May 2026 04:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9731228C84A;
	Sat,  2 May 2026 04:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YvSOHSGI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4645D292918;
	Sat,  2 May 2026 04:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777696115; cv=none; b=Jp7UXs4Gzkl6OifuEtmio88ZbpaPNvITKwPKETknyk6qRxW5zqSRki7wb7KKHG6U5P1wGCqVYNIZQ8uLgA0j+bdKdHGZfc3LPyrwwlmLHt2CUa5N9MTpH45fVljZv1l6mhOpAAiCLjxvMQbHxeXHWV7/hX7aXJ8qGMMnNhw0Qrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777696115; c=relaxed/simple;
	bh=MPw1goUKrvzYTCcZY2tx4XbRSP9h8K39h50jJRuSPAo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CE9BDBX0fO0t0srjg1JWszszboRJHiJiLZLq3iogKoZrm/4ZJ76wATV/Q0f7eEcxgAXe0cXCjLVO55th9PzucD6TrOfsmBKaKvkBAY4U21c61ThVAydwZfrd+ziFhz/JkiCPe6bMx2QL687f8ADGzaK47wTzNI2g0OlIbFCqonc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YvSOHSGI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id AD56820B717A;
	Fri,  1 May 2026 21:28:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AD56820B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777696113;
	bh=zsY4s4dGQRPVNY3092cku/i7GYzN6YlO9juXy/J5K/o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=YvSOHSGIipvrAuHI8hHsM9xGYSMjYt73KnHqFxnfRHa0TSu57TsjXhK8wd2lM9ih2
	 8C8MTD7NKOJGZRAd06CBGkootMjNOIeksRXFKi19Ey9EtZqXoLo326SAk2yj3iiOFR
	 zQHVTAdupuawdpwI0kujqDQcjGz3BuZ6pNo0h2qc=
Subject: [PATCH v2 15/18] mshv: Add missing vp_index bounds check in intercept
 ISR
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 02 May 2026 04:28:33 +0000
Message-ID: 
 <177769611374.222166.15865834490772204413.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177769588777.222166.3414280094142944420.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177769588777.222166.3414280094142944420.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 508204B0DA3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-10567-lists,linux-hyperv=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+]

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
 drivers/hv/mshv_synic.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
index 43f1bcbbf2d34..d4d98fa771189 100644
--- a/drivers/hv/mshv_synic.c
+++ b/drivers/hv/mshv_synic.c
@@ -382,8 +382,12 @@ mshv_intercept_isr(struct hv_message *msg)
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
 	vp = partition->pt_vp_array[vp_index];
 	if (unlikely(!vp)) {
 		pr_debug("failed to find VP %u\n", vp_index);



