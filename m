Return-Path: <linux-hyperv+bounces-11274-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APrIMp6PF2oUJQgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11274-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 02:43:10 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9108B5EB50D
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 02:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C7BB03060D4D
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 00:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98737233954;
	Thu, 28 May 2026 00:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bVQv5xaK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57BF21CA13;
	Thu, 28 May 2026 00:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779928955; cv=none; b=mSi6KzkqS8x+/JQkJ44blUou41+in5oTJkH7bHHs9TcT25c9+2T17heetfO7U/BF5gC1KAfS0GivjCigNsnlQVBtUWsAV8aQDjQ2rdhgH2n5N+1sqMZcDe72G2FvTwwfXTvHQTA2hfZ8ropYjP2+shYYSc+pkKpFF2d5z1rhxuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779928955; c=relaxed/simple;
	bh=VzpItX3355bHFwfgBQr6E9kkMD/Pr082tmF2fVLcemo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RQw+fGmyXUI6g+l+tuj1Au8DDlyD/CjnqGnCoiftIUgmioQIi31vwnyMBzJ2FfhHiXL4iLGvW+lF9kzweB2HiOhIra++G88LqG7hUYVx1N9kZVqDEp97WXO1nYmNJ1iY6m3Dr2sR0z6fPSlNB2kHBGEal57Xq6qFJmcZKdqXzOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bVQv5xaK; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id 44D8420B7170; Wed, 27 May 2026 17:42:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 44D8420B7170
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779928940;
	bh=+G063ctdwqAq59myRrIwk7Q0GStjlB0cHg+gbXD+SNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bVQv5xaKggle/Bw2P9ow3DP6wVgMoerP3uhclUMczMpmBc6gJzRAXV8KwcrctrbxH
	 JsjTAsUXMIHGhqkoW+8gDqhmDvAI06KFwEi2M1IPzw2+Q5lDO3d0oKRlcnmMZxR9nn
	 +z1rC4KbcHJIE9nNpT6yaPtJtlYI+ggAx7fAOGyI=
From: Jork Loeser <jloeser@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-mm@kvack.org,
	kexec@lists.infradead.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Jason Miu <jasonmiu@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Baoquan He <bhe@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kees Cook <kees@kernel.org>,
	Ran Xiaokai <ran.xiaokai@zte.com.cn>,
	Justinien Bouron <jbouron@amazon.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Pingfan Liu <piliu@redhat.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Kelley <mhklinux@outlook.com>,
	Jork Loeser <jloeser@linux.microsoft.com>
Subject: [RFC PATCH 12/20] mm/hugetlb: make bootmem allocation work with KHO
Date: Wed, 27 May 2026 17:41:54 -0700
Message-ID: <20260528004204.1484584-13-jloeser@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260528004204.1484584-1-jloeser@linux.microsoft.com>
References: <20260528004204.1484584-1-jloeser@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,soleen.com,amazon.com,google.com,linux-foundation.org,linux.dev,suse.de,redhat.com,arm.com,alien8.de,linux.intel.com,zytor.com,zte.com.cn,linux.ibm.com,intel.com,amd.com,lists.infradead.org,vger.kernel.org,outlook.com,linux.microsoft.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11274-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[37];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jloeser@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.microsoft.com:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: 9108B5EB50D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Pratyush Yadav (Google)" <pratyush@kernel.org>

Gigantic page allocation is somewhat broken currently when KHO is used.

Firstly, they break KHO scratch size accounting. RSRV_KERN is used to
track how much memory is reserved for use by the kernel. Since
alloc_bootmem() calls the memblock_alloc*() APIs, the hugepages
allocated also get marked as RSRV_KERN.

Allocations marked RSRV_KERN are used by KHO to calculate how much
scratch space it should reserve to make sure the next kernel has enough
memory to boot when it is in scratch-only phase. Counting hugepages in
that blows up scratch size, and can lead to the scratch allocation
failing, making KHO unusable. This will show up when huge pages make up
more than 50% of the system, which is a fairly common use case.

Secondly, while not supported right now, huge pages are user memory and
can be preserved via KHO. The scratch spaces should not have any
preserved memory. Allocating hugepages from scratch (on a KHO boot) can
lead to them being un-preservable.

Introduce memblock_alloc_nid_user(). This does two things: first, it
instructs __memblock_alloc_range_nid() to not use scratch areas to
fulfill allocation. If KHO is in scratch-only mode, allocations will
only be made from extended scratch areas. Second, it removes RSRV_KERN
from the allocation to make sure it doesn't mess up scratch size
accounting.

To reduce duplication, introduce __memblock_alloc_range_nid() which does
exactly what memblock_alloc_range_nid() used to do, but takes the flags
from its caller. Then make memblock_alloc_range_nid() a wrapper to it.
This lets memblock_alloc_nid_user() re-use most of the logic without
causing churn to update all callers of memblock_alloc_range_nid() and
adding yet another argument to it.

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
Signed-off-by: Jork Loeser <jloeser@linux.microsoft.com>
---
 include/linux/memblock.h |   4 ++
 mm/hugetlb.c             |  19 ++----
 mm/memblock.c            | 138 ++++++++++++++++++++++++++++++---------
 3 files changed, 116 insertions(+), 45 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 4f535ca4947a..c7056cf3f0f2 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -160,6 +160,7 @@ int memblock_mark_nomap(phys_addr_t base, phys_addr_t size);
 int memblock_clear_nomap(phys_addr_t base, phys_addr_t size);
 int memblock_reserved_mark_noinit(phys_addr_t base, phys_addr_t size);
 int memblock_reserved_mark_kern(phys_addr_t base, phys_addr_t size);
+int memblock_reserved_clear_kern(phys_addr_t base, phys_addr_t size);
 int memblock_mark_kho_scratch(phys_addr_t base, phys_addr_t size);
 int memblock_mark_kho_scratch_ext(phys_addr_t base, phys_addr_t size);
 int memblock_clear_kho_scratch(phys_addr_t base, phys_addr_t size);
@@ -431,6 +432,9 @@ void *memblock_alloc_try_nid(phys_addr_t size, phys_addr_t align,
 			     phys_addr_t min_addr, phys_addr_t max_addr,
 			     int nid);
 
+void *memblock_alloc_nid_user(phys_addr_t size, phys_addr_t align, int nid,
+			      bool exact_nid);
+
 static __always_inline void *memblock_alloc(phys_addr_t size, phys_addr_t align)
 {
 	return memblock_alloc_try_nid(size, align, MEMBLOCK_LOW_LIMIT,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 571212b80835..46f2b1bd5abe 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3033,26 +3033,19 @@ static __init void *alloc_bootmem(struct hstate *h, int nid, bool node_exact)
 	if (hugetlb_early_cma(h))
 		m = hugetlb_cma_alloc_bootmem(h, &listnode, node_exact);
 	else {
-		if (node_exact)
-			m = memblock_alloc_exact_nid_raw(huge_page_size(h),
-				huge_page_size(h), 0,
-				MEMBLOCK_ALLOC_ACCESSIBLE, nid);
-		else {
-			m = memblock_alloc_try_nid_raw(huge_page_size(h),
-				huge_page_size(h), 0,
-				MEMBLOCK_ALLOC_ACCESSIBLE, nid);
+		m = memblock_alloc_nid_user(huge_page_size(h), huge_page_size(h),
+					    nid, node_exact);
+		if (m) {
 			/*
 			 * For pre-HVO to work correctly, pages need to be on
 			 * the list for the node they were actually allocated
 			 * from. That node may be different in the case of
-			 * fallback by memblock_alloc_try_nid_raw. So,
-			 * extract the actual node first.
+			 * fallback by memblock_alloc_try_nid_raw. So, extract
+			 * the actual node first.
 			 */
-			if (m)
+			if (node_exact)
 				listnode = early_pfn_to_nid(PHYS_PFN(__pa(m)));
-		}
 
-		if (m) {
 			m->flags = 0;
 			m->cma = NULL;
 		}
diff --git a/mm/memblock.c b/mm/memblock.c
index 6f76a6bb96d6..8cd52d34ad6e 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -178,11 +178,21 @@ bool __init_memblock memblock_has_mirror(void)
 	return system_has_some_mirror;
 }
 
-static enum memblock_flags __init_memblock choose_memblock_flags(void)
+static enum memblock_flags __init_memblock choose_memblock_flags(bool user)
 {
 	/* skip non-scratch memory for kho early boot allocations */
-	if (kho_scratch_only)
-		return MEMBLOCK_KHO_SCRATCH | MEMBLOCK_KHO_SCRATCH_EXT;
+	if (kho_scratch_only) {
+		enum memblock_flags flags = MEMBLOCK_KHO_SCRATCH_EXT;
+
+		/*
+		 * Scratch can only be used for kernel memory, since user memory
+		 * might be preserved and thus can not be in scratch.
+		 */
+		if (!user)
+			flags |= MEMBLOCK_KHO_SCRATCH;
+
+		return flags;
+	}
 
 	return system_has_some_mirror ? MEMBLOCK_MIRROR : MEMBLOCK_NONE;
 }
@@ -346,7 +356,7 @@ static phys_addr_t __init_memblock memblock_find_in_range(phys_addr_t start,
 					phys_addr_t align)
 {
 	phys_addr_t ret;
-	enum memblock_flags flags = choose_memblock_flags();
+	enum memblock_flags flags = choose_memblock_flags(false);
 
 again:
 	ret = memblock_find_in_range_node(size, align, start, end,
@@ -1175,6 +1185,20 @@ int __init_memblock memblock_reserved_mark_kern(phys_addr_t base, phys_addr_t si
 				    MEMBLOCK_RSRV_KERN);
 }
 
+/**
+ * memblock_reserved_clear_kern - Clear MEMBLOCK_RSRV_KERN flag for region
+ *
+ * @base: the base phys addr of the region
+ * @size: the size of the region
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int __init_memblock memblock_reserved_clear_kern(phys_addr_t base, phys_addr_t size)
+{
+	return memblock_setclr_flag(&memblock.reserved, base, size, 0,
+				    MEMBLOCK_RSRV_KERN);
+}
+
 /**
  * memblock_mark_kho_scratch - Mark a memory region as MEMBLOCK_KHO_SCRATCH.
  * @base: the base phys addr of the region
@@ -1534,37 +1558,11 @@ int __init_memblock memblock_set_node(phys_addr_t base, phys_addr_t size,
 	return 0;
 }
 
-/**
- * memblock_alloc_range_nid - allocate boot memory block
- * @size: size of memory block to be allocated in bytes
- * @align: alignment of the region and block's size
- * @start: the lower bound of the memory region to allocate (phys address)
- * @end: the upper bound of the memory region to allocate (phys address)
- * @nid: nid of the free area to find, %NUMA_NO_NODE for any node
- * @exact_nid: control the allocation fall back to other nodes
- *
- * The allocation is performed from memory region limited by
- * memblock.current_limit if @end == %MEMBLOCK_ALLOC_ACCESSIBLE.
- *
- * If the specified node can not hold the requested memory and @exact_nid
- * is false, the allocation falls back to any node in the system.
- *
- * For systems with memory mirroring, the allocation is attempted first
- * from the regions with mirroring enabled and then retried from any
- * memory region.
- *
- * In addition, function using kmemleak_alloc_phys for allocated boot
- * memory block, it is never reported as leaks.
- *
- * Return:
- * Physical address of allocated memory block on success, %0 on failure.
- */
-phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
+static phys_addr_t __init __memblock_alloc_range_nid(phys_addr_t size,
 					phys_addr_t align, phys_addr_t start,
 					phys_addr_t end, int nid,
-					bool exact_nid)
+					bool exact_nid, enum memblock_flags flags)
 {
-	enum memblock_flags flags = choose_memblock_flags();
 	phys_addr_t found;
 
 	/*
@@ -1633,6 +1631,41 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
 	return found;
 }
 
+/**
+ * memblock_alloc_range_nid - allocate boot memory block
+ * @size: size of memory block to be allocated in bytes
+ * @align: alignment of the region and block's size
+ * @start: the lower bound of the memory region to allocate (phys address)
+ * @end: the upper bound of the memory region to allocate (phys address)
+ * @nid: nid of the free area to find, %NUMA_NO_NODE for any node
+ * @exact_nid: control the allocation fall back to other nodes
+ *
+ * The allocation is performed from memory region limited by
+ * memblock.current_limit if @end == %MEMBLOCK_ALLOC_ACCESSIBLE.
+ *
+ * If the specified node can not hold the requested memory and @exact_nid
+ * is false, the allocation falls back to any node in the system.
+ *
+ * For systems with memory mirroring, the allocation is attempted first
+ * from the regions with mirroring enabled and then retried from any
+ * memory region.
+ *
+ * In addition, function using kmemleak_alloc_phys for allocated boot
+ * memory block, it is never reported as leaks.
+ *
+ * Return:
+ * Physical address of allocated memory block on success, %0 on failure.
+ */
+phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
+					phys_addr_t align, phys_addr_t start,
+					phys_addr_t end, int nid,
+					bool exact_nid)
+{
+	enum memblock_flags flags = choose_memblock_flags(false);
+
+	return __memblock_alloc_range_nid(size, align, start, end, nid, exact_nid, flags);
+}
+
 /**
  * memblock_phys_alloc_range - allocate a memory block inside specified range
  * @size: size of memory block to be allocated in bytes
@@ -1784,6 +1817,47 @@ void * __init memblock_alloc_try_nid_raw(
 				       false);
 }
 
+/**
+ * memblock_alloc_nid_user - allocate boot memory for use by userspace
+ * @size: size of the memory block to be allocated in bytes
+ * @align: alignment of the region and block's size
+ * @exact_nid: control the allocation fall back to other nodes
+ *
+ * Public function, provides additional debug information (including caller
+ * info), if enabled. Does not zero allocated memory, does not panic if request
+ * cannot be satisfied.
+ *
+ * If the specified node can not hold the requested memory and @exact_nid is
+ * false, the allocation falls back to any node in the system. The allocated
+ * memory has no restrictions on minimum or maximum address, and does not count
+ * towards %MEMBLOCK_RSRV_KERN.
+ *
+ * Return:
+ * Virtual address of allocated memory block on success, %NULL on failure.
+ */
+void * __init memblock_alloc_nid_user(phys_addr_t size, phys_addr_t align,
+				      int nid, bool exact_nid)
+{
+	enum memblock_flags flags = choose_memblock_flags(true);
+	phys_addr_t alloc;
+
+	memblock_dbg("%s: %llu bytes align=0x%llx nid=%d %pS\n",
+		     __func__, (u64)size, (u64)align, nid, (void *)_RET_IP_);
+
+	alloc = __memblock_alloc_range_nid(size, align, 0, MEMBLOCK_ALLOC_ACCESSIBLE,
+					   nid, exact_nid, flags);
+	if (!alloc)
+		return NULL;
+
+	/* User memory should not be marked with RSRV_KERN. */
+	if (memblock_reserved_clear_kern(alloc, size)) {
+		memblock_phys_free(alloc, size);
+		return NULL;
+	}
+
+	return phys_to_virt(alloc);
+}
+
 /**
  * memblock_alloc_try_nid - allocate boot memory block
  * @size: size of memory block to be allocated in bytes
-- 
2.43.0


