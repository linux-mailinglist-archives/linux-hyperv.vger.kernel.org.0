Return-Path: <linux-hyperv+bounces-10850-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GK8eOD/IBGodOgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10850-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 20:51:43 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 462205394BE
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 20:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CEE9630556C2
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 18:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEA13ACF1D;
	Wed, 13 May 2026 18:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KERmve9R"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62BB3A875B;
	Wed, 13 May 2026 18:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778698230; cv=none; b=GFepc74Sx867IxZZYDXOogSLyy15jgA/CL5Z256XVTtsqoM/BkNdo2E5wbjspsX+SKanUFIs8TTb26tw5DlhoI9m4vEt8oPZYpEcCaGzugN4WftR5w6OWR1ZsKcjPuqPxE2NHVuy6v65vwSgAQcvdL65m6IrbTetmyyIznUJLz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778698230; c=relaxed/simple;
	bh=se2Ud7F4Qre3uWLJImPsOi9ZfSGyhfshlisuPsUuU3s=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tpg7qVTI+S2AQRD6r2vubCO1LAnQKwnvead+9ZQGrG7Y4OEaifcj31r0bl3lfefr1HQtihZDjNEJN7pQNg2T+9/oMKthHtMiG9u+hDPBITe7TtfZwq29gW2rClJWdGXdPUIEO9uxW3+31kfaoe4GgHvfyLIabgi3dn7JVqzMmpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KERmve9R; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9156A20B7166;
	Wed, 13 May 2026 11:50:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9156A20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778698225;
	bh=QrXR9ZT3txtkDsjRrtHXoBNzhNIFewb+VQbQZHEXKFk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=KERmve9R70iYobFp76hxAokdwttVgy/3OOUrE1mfQGIbml1Jgyrr8TD+dmycUuFsi
	 kSOQZZgjib8oibp22ATSid9wKoghSCo1sKFmG868xNmi0zeJOMurNBCT7E+GKkZBM3
	 BQboYHLMq5stTPYrSaUMstSvpaNjW5ugS7IZoVqA=
Subject: [PATCH v3 02/11] mshv: Don't request HMM write fault for read-only
 regions
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, skinsburskii@gmail.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 13 May 2026 18:50:28 +0000
Message-ID: 
 <177869822822.18773.2651353754916648433.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 462205394BE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10850-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,skinsburskii-cloud-desktop.internal.cloudapp.net:mid]
X-Rspamd-Action: no action

mshv_region_range_fault() unconditionally sets HMM_PFN_REQ_WRITE on
the hmm_range_fault() request.  When the region was created without
MSHV_SET_MEM_BIT_WRITABLE (so region->hv_map_flags has no
HV_MAP_GPA_WRITABLE), the request still asks HMM for writable pages.
On read-only mappings this causes hmm_range_fault() to break
copy-on-write — for example, the shared zero page or file-backed
pages — granting the guest a private writable copy of memory that
host policy intended to keep shared.

Gate HMM_PFN_REQ_WRITE on the region's HV_MAP_GPA_WRITABLE bit so
that read-only regions request read-only faults.

Note: this still asks for write on writable regions even if the
backing VMA is read-only.  A more thorough check would also consult
each VMA's vm_flags inside the fault loop; that requires iterating
VMAs and is left for a follow-up.

Fixes: b9a66cd5ccbb ("mshv: Add support for movable memory regions")
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_regions.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index 81e57f727be35..d9e1fbfefe714 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -441,7 +441,7 @@ static int mshv_region_range_fault(struct mshv_mem_region *region,
 {
 	struct hmm_range range = {
 		.notifier = &region->mreg_mni,
-		.default_flags = HMM_PFN_REQ_FAULT | HMM_PFN_REQ_WRITE,
+		.default_flags = HMM_PFN_REQ_FAULT,
 	};
 	unsigned long *pfns;
 	int ret;
@@ -455,6 +455,15 @@ static int mshv_region_range_fault(struct mshv_mem_region *region,
 	range.start = region->start_uaddr + page_offset * HV_HYP_PAGE_SIZE;
 	range.end = range.start + page_count * HV_HYP_PAGE_SIZE;
 
+	/*
+	 * Only request writable pages from HMM when the region itself
+	 * permits writes.  Without this, hmm_range_fault() would
+	 * trigger COW on read-only regions, breaking copy-on-write
+	 * semantics on shared host pages.
+	 */
+	if (region->hv_map_flags & HV_MAP_GPA_WRITABLE)
+		range.default_flags |= HMM_PFN_REQ_WRITE;
+
 	do {
 		ret = mshv_region_hmm_fault_and_lock(region, &range);
 	} while (ret == -EBUSY);



