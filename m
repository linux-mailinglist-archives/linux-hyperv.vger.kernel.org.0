Return-Path: <linux-hyperv+bounces-11273-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBcXFryPF2oUJQgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11273-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 02:43:40 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F7B5EB538
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 02:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C81D13098053
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 00:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBADD233950;
	Thu, 28 May 2026 00:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TVD5iDMu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0772F1E260C;
	Thu, 28 May 2026 00:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779928955; cv=none; b=DGFYjs0mq20YZTaVbezgCBzci2tA/PRFZi/6dWG/y3iaf84svq4RF+knILjwzT67T1J6VOAizJEhW8z17Q6LLsd7PLFGptJM8vX4GYsJY/xWU0/V6B+se0wyHxo5l82X2h03Zi7HawiEWGHd26nkDKRaODZMznDvtD+WAGZf+dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779928955; c=relaxed/simple;
	bh=pWi431/n5A5XMi0S5icnmYkcnDsmlDGS0CaZXhYMLz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gdC2Z8sngM2tq6F5X0IQVq7e0oA7a13fgZB1X6eDL0HNwvvsTQita3ziea9B4ESBNQv+Zxnm9JfeLXqcLAkBGcc77rShm2H5DF0nkj6VpDpWzX4c+cQk2qAUvINE1ARBHBp7nGgEKYH9K/bmFZBgSCMq9h107lpoD5/1FmXGVzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TVD5iDMu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id 64DB520B716C; Wed, 27 May 2026 17:42:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 64DB520B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779928939;
	bh=Cj1bXneZ/55tRiLo5BAzxpY6ql7Nf0vxqaPwBTnufbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TVD5iDMuv1UMsOEX1EG/iFjlf91oQMKN2LoYjUOo5nEjdyljMNqJgNV7wWGJ/8Qo6
	 5jP/DnRsCNWlUzVNF0PNicBBpFHThFLyoOnlrxBrSEzFz7uMGjvNku8H40fMJG2Hjp
	 BTlo58HNqDBNYl99jnK6sq2MEYieIsoPsIEgiGk8=
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
Subject: [RFC PATCH 11/20] kho: return virtual address of mem_map
Date: Wed, 27 May 2026 17:41:53 -0700
Message-ID: <20260528004204.1484584-12-jloeser@linux.microsoft.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,soleen.com,amazon.com,google.com,linux-foundation.org,linux.dev,suse.de,redhat.com,arm.com,alien8.de,linux.intel.com,zytor.com,zte.com.cn,linux.ibm.com,intel.com,amd.com,lists.infradead.org,vger.kernel.org,outlook.com,linux.microsoft.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11273-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:mid,linux.microsoft.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C3F7B5EB538
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Pratyush Yadav (Google)" <pratyush@kernel.org>

There are currently 3 callers of kho_get_mem_map_phys(). Two of them,
kho_mem_retrieve() and kho_extend_scratch() need the virtual address.
The third, kho_populate() doesn't care. Make things simpler by
directly returning the virtual address. Rename kho_get_mem_map_phys() to
kho_get_mem_map() to accurately reflect what it returns.

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
Signed-off-by: Jork Loeser <jloeser@linux.microsoft.com>
---
 kernel/liveupdate/kexec_handover.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index a006a883ee94..797ec285b698 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -610,10 +610,11 @@ static int __init kho_preserved_memory_reserve(unsigned long key, void *data)
 	return 0;
 }
 
-/* Returns physical address of the preserved memory map from FDT */
-static phys_addr_t __init kho_get_mem_map_phys(const void *fdt)
+/* Returns virtual address of the preserved memory map from FDT */
+static __init void *kho_get_mem_map(const void *fdt)
 {
 	const void *mem_ptr;
+	phys_addr_t mem_map_phys;
 	int len;
 
 	mem_ptr = fdt_getprop(fdt, 0, KHO_FDT_MEMORY_MAP_PROP_NAME, &len);
@@ -622,7 +623,11 @@ static phys_addr_t __init kho_get_mem_map_phys(const void *fdt)
 		return 0;
 	}
 
-	return get_unaligned((const u64 *)mem_ptr);
+	mem_map_phys = get_unaligned((const u64 *)mem_ptr);
+	if (!mem_map_phys)
+		return NULL;
+
+	return phys_to_virt(mem_map_phys);
 }
 
 /*
@@ -917,15 +922,15 @@ void __init kho_extend_scratch(void)
 		.key = kho_ext_mark_scratch,
 	};
 	struct kho_radix_tree radix;
-	phys_addr_t prev_end = 0, mem_map_phys;
+	phys_addr_t prev_end = 0;
 	int err = 0;
 
 	if (!is_kho_boot())
 		return;
 
 	/* Make sure the KHO radix tree is initialized. */
-	mem_map_phys = kho_get_mem_map_phys(kho_get_fdt());
-	err = kho_radix_init_tree(&kho_in.radix_tree, phys_to_virt(mem_map_phys));
+	err = kho_radix_init_tree(&kho_in.radix_tree,
+				  kho_get_mem_map(kho_get_fdt()));
 	if (err)
 		goto print;
 
@@ -1609,11 +1614,9 @@ static int __init kho_mem_retrieve(const void *fdt)
 	const struct kho_radix_walk_cb cb = {
 		.key = kho_preserved_memory_reserve,
 	};
-	phys_addr_t mem_map_phys;
 	int err;
 
-	mem_map_phys = kho_get_mem_map_phys(fdt);
-	err = kho_radix_init_tree(&kho_in.radix_tree, phys_to_virt(mem_map_phys));
+	err = kho_radix_init_tree(&kho_in.radix_tree, kho_get_mem_map(fdt));
 	if (err)
 		return err;
 
@@ -1838,8 +1841,7 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 {
 	unsigned int scratch_cnt = scratch_len / sizeof(*kho_scratch);
 	struct kho_scratch *scratch = NULL;
-	phys_addr_t mem_map_phys;
-	void *fdt = NULL;
+	void *fdt = NULL, *mem_map;
 	bool populated = false;
 	int err;
 
@@ -1862,8 +1864,8 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 		goto unmap_fdt;
 	}
 
-	mem_map_phys = kho_get_mem_map_phys(fdt);
-	if (!mem_map_phys)
+	mem_map = kho_get_mem_map(fdt);
+	if (!mem_map)
 		goto unmap_fdt;
 
 	scratch = early_memremap(scratch_phys, scratch_len);
-- 
2.43.0


