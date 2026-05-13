Return-Path: <linux-hyperv+bounces-10849-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOEIAC3IBGodOgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10849-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 20:51:25 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 625815394A0
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 20:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E6EE301C6F7
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 18:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95793A7F4A;
	Wed, 13 May 2026 18:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HU+on9Z9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675C23F4112;
	Wed, 13 May 2026 18:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778698224; cv=none; b=K6XMPaH/xNLHmjR4cUe+0D/cs8JGw1K65YCW5jGPYREuDhALbv1IzuI+oFyPJowrQYJrZCWkfY80AJmifKkB88IBxHs7xscqwma7k8oxNomEJtYalYx/+QYRANwbONfPdhChr8V3ByTk/VAT0Uu2uSZsLDdohlxCjQUA2zuX7JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778698224; c=relaxed/simple;
	bh=JlZdvz5nA1wqiJQgKxXJY8D/ls/OstX57GkHRY4qSUU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=co34nuxf7ecrI5OLxbkaCKC8b1tD3bdywfxGTgtlLTKtGdumoWSgxTL7Y9ZyGAIDQDBPrDdt/EJT33O9qxzv7t+RZbNpuQ+NfSKpz9qS5n7uaPb9PTPfKQR7yIJGkxV+pS2bwuu/drDtY1K5IiDdLO+9VqX2NfFcQwGo8Ushnq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HU+on9Z9; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2060720B7166;
	Wed, 13 May 2026 11:50:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2060720B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778698220;
	bh=ppmjFGl0E3kqOJvlQdNh+2LO9EPGvXf/FCpEdli3M64=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=HU+on9Z9bWjlfToAIe+nAmdIdoGEGlGMgAUTzVCSd3yV6IIq6RZWxnEvJUmO/gCmq
	 K26pcQljJHPIHTGxLDr4PESUqwVutBsT0afE0unraH5aTiOlB3OmTB6sY1HjJ2dxRU
	 0l2R2LsqAsNogIOMtf6LHz1RcHNnSQ8ffHXwqUis=
Subject: [PATCH v3 01/11] mshv: Don't reject huge-page stride on unaligned
 region length
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, skinsburskii@gmail.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 13 May 2026 18:50:22 +0000
Message-ID: 
 <177869822277.18773.14108741062244642035.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177869813422.18773.515308662914055136.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177869813422.18773.515308662914055136.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 625815394A0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10849-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,skinsburskii-cloud-desktop.internal.cloudapp.net:mid]
X-Rspamd-Action: no action

mshv_chunk_stride() rejected huge-page stride whenever pfn_count was
not a multiple of PTRS_PER_PMD, even though the same-stride scan in
mshv_region_process_pfns() already handles the transition between
huge-page and 4K stride for the tail of a run. As a result, a region
backed by a 2 MiB folio with a length that wasn't a multiple of 512
PFNs was processed entirely at 4K stride, issuing one hypercall per
PFN instead of one per 2 MiB.

Reject huge-page stride only when fewer than PTRS_PER_PMD PFNs are
available from this point.  The starting GFN alignment requirement is
unchanged.  The same-stride scan continues to handle the tail
correctly.

Fixes: 259add0d982cb ("mshv: Align huge page stride with guest mapping")
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_regions.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index fdffd4f002f6f..81e57f727be35 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -43,7 +43,7 @@ static int mshv_chunk_stride(struct page *page,
 	 */
 	if (!PageCompound(page) || !PageHead(page) ||
 	    !IS_ALIGNED(gfn, PTRS_PER_PMD) ||
-	    !IS_ALIGNED(page_count, PTRS_PER_PMD))
+	    page_count < PTRS_PER_PMD)
 		return 1;
 
 	page_order = folio_order(page_folio(page));



