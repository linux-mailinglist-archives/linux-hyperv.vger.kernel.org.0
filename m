Return-Path: <linux-hyperv+bounces-10599-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GvWEarv+Gl93QIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10599-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 04 May 2026 21:12:42 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D66EB4C3098
	for <lists+linux-hyperv@lfdr.de>; Mon, 04 May 2026 21:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63C2D3067B8D
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 May 2026 19:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7873EFD35;
	Mon,  4 May 2026 19:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="M+o5u8WG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA693EF649;
	Mon,  4 May 2026 19:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777921758; cv=none; b=iSRiAhREoIafpKlz+XQnBcYtQoxf1Pnu1ptZ70nqIOBJ+F+PgVSfjorITHlF5vSmwtPvKhDIFlrEfVMfxz1+j3S1aSAAcTgLMBYS5ZTMZ2QeeLS/zOKeAYL2YQM0fmiGHMsoN9oQDRmabFNaluoom+7SsfSjP8LapgJssO+1YJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777921758; c=relaxed/simple;
	bh=GYjWWqyTKK7cBg5SnsHAOREz6qBEGUERhE4Lnc3wgzk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m4FvKPWWK+uFhcmUFTzfrHP38f00t350wRfeNBLWyyzddwrDLShrZ88Nal7RWZSIM2ckvm4O5k9s8/GRJm803oLfk5TE319einiE6msJfs587kcD7MIhIvs6vNyqO0jwbeaE4skj0esJV9qQ2gDUTZJWq81/aVPAPRkkunytG8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=M+o5u8WG; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2C4F620B7168;
	Mon,  4 May 2026 12:09:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2C4F620B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777921754;
	bh=DL4GMRkPHVQ7Vor/s+lH/kQlCeY8HVLUaycsKuMWK4A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=M+o5u8WG5OT0YfXeEmNP/7gP0YGSFLSK9cc0v1Dstjl9R9jL9Hb0twwL7Eb8KRltg
	 sXgm9IA+w+tnh5SX5xMGWX1lqFETAbn2wlYZbECbV/PuOBKqSznQ1e87Y+Iv9xjkTZ
	 5E3eQIIhWXFCuPC4nreNgkT13lC0FfTXLtH+ReEo=
Subject: [PATCH v3 04/18] mshv: Fix potential u64 overflow in region overlap
 check
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 04 May 2026 19:09:15 +0000
Message-ID: 
 <177792175560.90827.7170511956345104474.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
X-Rspamd-Queue-Id: D66EB4C3098
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-10599-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,skinsburskii-cloud-desktop.internal.cloudapp.net:mid,linux.microsoft.com:dkim]

mshv_partition_create_region() checks for overlapping guest memory
regions using arithmetic that can overflow u64:

  mem->guest_pfn + nr_pages <= rg->start_gfn

If guest_pfn is near U64_MAX, the addition wraps around to a small
value, causing the overlap check to incorrectly pass. This could allow
creation of overlapping regions.

Fix by validating the sum with check_add_overflow() before the loop and
using the pre-computed end_gfn in the comparison.

Fixes: f91bc8f61abf ("mshv: Allow mappings that overlap in uaddr")
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_root_main.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 7e4252b6bc65c..0e9b696853fcb 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1290,11 +1290,15 @@ static int mshv_partition_create_region(struct mshv_partition *partition,
 {
 	struct mshv_mem_region *rg;
 	u64 nr_pages = HVPFN_DOWN(mem->size);
+	u64 end_gfn;
+
+	if (check_add_overflow(mem->guest_pfn, nr_pages, &end_gfn))
+		return -EINVAL;
 
 	/* Reject overlapping regions */
 	spin_lock(&partition->pt_mem_regions_lock);
 	hlist_for_each_entry(rg, &partition->pt_mem_regions, hnode) {
-		if (mem->guest_pfn + nr_pages <= rg->start_gfn ||
+		if (end_gfn <= rg->start_gfn ||
 		    rg->start_gfn + rg->nr_pages <= mem->guest_pfn)
 			continue;
 		spin_unlock(&partition->pt_mem_regions_lock);



