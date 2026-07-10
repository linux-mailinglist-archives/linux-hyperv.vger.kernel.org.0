Return-Path: <linux-hyperv+bounces-11921-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id atuvObtlUWreDwMAu9opvQ
	(envelope-from <linux-hyperv+bounces-11921-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jul 2026 23:35:55 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAD073F013
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jul 2026 23:35:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=PS+elB01;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11921-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11921-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 795E230B86D4
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jul 2026 21:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9C63BB11D;
	Fri, 10 Jul 2026 21:26:56 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0A43B9D83
	for <linux-hyperv@vger.kernel.org>; Fri, 10 Jul 2026 21:26:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718816; cv=none; b=TOBOuMhE2B3DYIwzPPWZm5GclPCEzcPh0iMtfgHUhUMee6ylgiZhvWmuyP269WNpO0Mv/mD+8ovsxAlB//5ikYnnS6YKaJQwPn86PXLsTkgS2TVsQ0PpxcFEckJewetDwvmadVj/6iPxVEv4/HpZhpckGa9rRwpQEd4awAGcijQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718816; c=relaxed/simple;
	bh=UH8EdkvxcBQr7tFP4cWIxItcXG4Yona++Xa1OoLjzWw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IzyuQZ4vbSIsOIQzh+DzK4LFkp2g71d/zIWE5Asfdz9LfAyBBxMnSzcjXGTFhsF9CgzEGpJ/Bf0tyRvIUPIxBcM6D0y1Ho4XJ16te7IOKJJMULZ43trjg1WgtsxQhrs4L2lWZughETteEVAsuBESPKIANrAh3qdbUEflcXaA8u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PS+elB01; arc=none smtp.client-ip=209.85.214.170
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cad8076b01so16881535ad.2
        for <linux-hyperv@vger.kernel.org>; Fri, 10 Jul 2026 14:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783718814; x=1784323614; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=3sr6piRbjR+cpoS2FsjQdy3tGYWA8BG46QjFZOECUzI=;
        b=PS+elB011jwqaknWI3rbhruNlyMs7K66rAnCdNtjmlTTNBp+Av55fUFSi/OFOLpXuu
         4hOprDlzJe+ADXayf9himYn0L49KlhKVLfvhOkKJjVFZghqGHPslBBwomaSYndjkm+33
         IZjNe1ISOAOD4VuAwc5okbzUzGhQWKXNlJgTLhX8/FNoeu7VqHe18PpJrj0EIoNrWglo
         YhunuWdBiBzC0JrXTcou9vz6fyY36vbBDkjmHNJM8jju2inJbO6EBiofJdXJjfg+q6Sb
         rQPXjPGYCl5rJlsuwc2Lq4ilyNnC4vrCBaCU24kX1gWZdvjopWq5iIeXnC4zxGVPTYHO
         vSgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783718814; x=1784323614;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3sr6piRbjR+cpoS2FsjQdy3tGYWA8BG46QjFZOECUzI=;
        b=MG6hvxmFN9gdlQE8kzWVdywabpRJ9gPenbZziXR5zNoM7deGBQgnEaDeP1zJD6yW/O
         EGmZ7omyD496XM+fs4TRQ6HlgEJ72k3X6RiHsDyxbGMFs/7f3g7dzM3GB0Y7R9Vbik4z
         5C53yooEhg2z8vPjboJluqOHqUW7sAiSC7oBZ4EjKCdGgfwGefoB6PN6CMvLSxBN4m7Q
         MVG6p3muADgyaCdZjRwhqeSaaQqdwlH6MvH5RS9+B3uZn/yq+VikKdqgtx6L5kIG6bm+
         wC7x48OFiG2AlOvq8blyiNkRC2KDKLBHSGWRLR1j7ltj8LZKr+STqIYdVAsG1lMVFgg6
         GfEQ==
X-Forwarded-Encrypted: i=1; AHgh+Rojo8yWn7kjJ9UAcMq1PneJ9OgBNLSmroctosaFyZEKuCOuYpg+kZ+NE5V4Ae61LVTK9EavusxMDxvChCg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfut1r7CIXkOdvcUgJQy5leExLaRuLHkWbz2tObmCPSBaJU1MU
	f7Vn70hp6ibq+1Mr0xgmUpy0O4LXKLhghLJ3af8Nh73CdoaiyVmuDD4c
X-Gm-Gg: AfdE7ckMckIu78MKbAP0TqglFEhqy+mlYc6L4gH/5ki2ULL8Vg6CB/0cF2I47Wj58XJ
	EFi4ifFqvV9clHDX6WyRkXo1PxAnQuLWUeNt5kyf1CxU2uc8UlyEJAw830f2kOoUOKfAQz51p4w
	UC2VnMYUJa5EZCQ9RsmQgCLnwE8yzpO3NOoz5PK8d+6QSpr9a7djxvD5BzmC2WjwHF+79WJVueJ
	+hOcU3BKhrd/Tj4tRYWj/ikJ6/oK4C2xxVl11quHPWZCbWhv2NeC/P/oTROny1GdKuyhB/UxEF8
	oGQF0mm0bwK98V41ePxbMnHMJNcfY7Of7c9czYH3ZA7N1x0Ls0JGyKFIAAoN0cqBkUArrn8iVV2
	k6AqKlBv4refC8892HyH4PU/laV0m7VQLm98ToR3HEyFcYvGHCDRLptSFY2u4L4y67beIfh4edT
	Tx5ZnfQVgqUOJEw1Gh3smzC1n6mTgoWiQzjiSVXiiHEtFdkX7R5mdEhQFA1PA=
X-Received: by 2002:a17:902:dacf:b0:2c2:7baf:139f with SMTP id d9443c01a7336-2ce9ef1bd15mr7721375ad.30.1783718813633;
        Fri, 10 Jul 2026 14:26:53 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net. [98.225.44.182])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d1e0c4sm66015545ad.49.2026.07.10.14.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 14:26:53 -0700 (PDT)
Subject: [PATCH v8 4/8] mshv: Use hmm_range_fault_unlocked_timeout() for
 region faults
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
To: airlied@gmail.com, akhilesh@ee.iitb.ac.in, akpm@linux-foundation.org,
 corbet@lwn.net, dakr@kernel.org, david@kernel.org, decui@microsoft.com,
 haiyangz@microsoft.com, jgg@ziepe.ca, kees@kernel.org, kys@microsoft.com,
 leon@kernel.org, liam@infradead.org, lizhi.hou@amd.com, ljs@kernel.org,
 longli@microsoft.com, lyude@redhat.com, maarten.lankhorst@linux.intel.com,
 mamin506@gmail.com, mhocko@suse.com, mripard@kernel.org,
 nouveau@lists.freedesktop.org, ogabbay@kernel.org, oleg@redhat.com,
 rppt@kernel.org, shuah@kernel.org, simona@ffwll.ch,
 skhan@linuxfoundation.org, skinsburskii@gmail.com, surenb@google.com,
 tzimmermann@suse.de, vbabka@kernel.org, wei.liu@kernel.org,
 skinsburskii@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-rdma@vger.kernel.org
Date: Fri, 10 Jul 2026 14:26:50 -0700
Message-ID: <178371881034.900500.5214601525971121683.stgit@skinsburskii>
In-Reply-To: <178371866223.900500.12312667138651735591.stgit@skinsburskii>
References: <178371866223.900500.12312667138651735591.stgit@skinsburskii>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11921-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,ee.iitb.ac.in,linux-foundation.org,lwn.net,kernel.org,microsoft.com,ziepe.ca,infradead.org,amd.com,redhat.com,linux.intel.com,suse.com,lists.freedesktop.org,ffwll.ch,linuxfoundation.org,google.com,suse.de];
	FORGED_SENDER(0.00)[skinsburskii@gmail.com,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[41];
	FORGED_RECIPIENTS(0.00)[m:airlied@gmail.com,m:akhilesh@ee.iitb.ac.in,m:akpm@linux-foundation.org,m:corbet@lwn.net,m:dakr@kernel.org,m:david@kernel.org,m:decui@microsoft.com,m:haiyangz@microsoft.com,m:jgg@ziepe.ca,m:kees@kernel.org,m:kys@microsoft.com,m:leon@kernel.org,m:liam@infradead.org,m:lizhi.hou@amd.com,m:ljs@kernel.org,m:longli@microsoft.com,m:lyude@redhat.com,m:maarten.lankhorst@linux.intel.com,m:mamin506@gmail.com,m:mhocko@suse.com,m:mripard@kernel.org,m:nouveau@lists.freedesktop.org,m:ogabbay@kernel.org,m:oleg@redhat.com,m:rppt@kernel.org,m:shuah@kernel.org,m:simona@ffwll.ch,m:skhan@linuxfoundation.org,m:skinsburskii@gmail.com,m:surenb@google.com,m:tzimmermann@suse.de,m:vbabka@kernel.org,m:wei.liu@kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-mm@kvack.org,m:linux-doc@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@gmail.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,skinsburskii:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5AAD073F013

MSHV currently faults movable memory regions by taking mmap_read_lock()
around hmm_range_fault(). That prevents the fault path from handling VMAs
whose fault handlers need to drop mmap_lock, such as userfaultfd-backed
mappings.

Use hmm_range_fault_unlocked_timeout() instead. Passing a timeout of 0
preserves MSHV's existing unbounded retry behavior while letting the HMM
helper own mmap_lock acquisition and refresh range->notifier_seq internally
before walking the range. After the fault succeeds, MSHV still takes
mreg_mutex and checks mmu_interval_read_retry() before installing the pages
into the region, so the existing invalidation synchronization is preserved.

Fold the small fault-and-lock helper into mshv_region_range_fault(), since
the remaining retry path is just the standard "fault, take the driver lock,
check the interval notifier sequence" pattern.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/hv/mshv_regions.c |   54 ++++++++-------------------------------------
 1 file changed, 10 insertions(+), 44 deletions(-)

diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index 6d65e5b42152..dddaade31b5d 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -381,46 +381,6 @@ int mshv_region_get(struct mshv_mem_region *region)
 	return kref_get_unless_zero(&region->mreg_refcount);
 }
 
-/**
- * mshv_region_hmm_fault_and_lock - Handle HMM faults and lock the memory region
- * @region: Pointer to the memory region structure
- * @range: Pointer to the HMM range structure
- *
- * This function performs the following steps:
- * 1. Reads the notifier sequence for the HMM range.
- * 2. Acquires a read lock on the memory map.
- * 3. Handles HMM faults for the specified range.
- * 4. Releases the read lock on the memory map.
- * 5. If successful, locks the memory region mutex.
- * 6. Verifies if the notifier sequence has changed during the operation.
- *    If it has, releases the mutex and returns -EBUSY to match with
- *    hmm_range_fault() return code for repeating.
- *
- * Return: 0 on success, a negative error code otherwise.
- */
-static int mshv_region_hmm_fault_and_lock(struct mshv_mem_region *region,
-					  struct hmm_range *range)
-{
-	int ret;
-
-	range->notifier_seq = mmu_interval_read_begin(range->notifier);
-	mmap_read_lock(region->mreg_mni.mm);
-	ret = hmm_range_fault(range);
-	mmap_read_unlock(region->mreg_mni.mm);
-	if (ret)
-		return ret;
-
-	mutex_lock(&region->mreg_mutex);
-
-	if (mmu_interval_read_retry(range->notifier, range->notifier_seq)) {
-		mutex_unlock(&region->mreg_mutex);
-		cond_resched();
-		return -EBUSY;
-	}
-
-	return 0;
-}
-
 /**
  * mshv_region_range_fault - Handle memory range faults for a given region.
  * @region: Pointer to the memory region structure.
@@ -452,13 +412,19 @@ static int mshv_region_range_fault(struct mshv_mem_region *region,
 	range.start = region->start_uaddr + page_offset * HV_HYP_PAGE_SIZE;
 	range.end = range.start + page_count * HV_HYP_PAGE_SIZE;
 
-	do {
-		ret = mshv_region_hmm_fault_and_lock(region, &range);
-	} while (ret == -EBUSY);
-
+again:
+	ret = hmm_range_fault_unlocked_timeout(&range, 0);
 	if (ret)
 		goto out;
 
+	mutex_lock(&region->mreg_mutex);
+
+	if (mmu_interval_read_retry(range.notifier, range.notifier_seq)) {
+		mutex_unlock(&region->mreg_mutex);
+		cond_resched();
+		goto again;
+	}
+
 	for (i = 0; i < page_count; i++)
 		region->mreg_pages[page_offset + i] = hmm_pfn_to_page(pfns[i]);
 



