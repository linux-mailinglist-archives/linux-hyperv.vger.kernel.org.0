Return-Path: <linux-hyperv+bounces-9652-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AO2xEBLNvWnFCAMAu9opvQ
	(envelope-from <linux-hyperv+bounces-9652-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Mar 2026 23:41:22 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE542E1E3B
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Mar 2026 23:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E390306B39F
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Mar 2026 22:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEEF3B19A7;
	Fri, 20 Mar 2026 22:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KUQ4yJnN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E2037B008;
	Fri, 20 Mar 2026 22:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774046426; cv=none; b=ANwP8rHIWelxD/JxGS2uAUxjmcD7dpo0EMdyso8RE2YMJ16QLIiqDQm53agB+SiKt7p80S6hN+XHUyivj7eoV3DUsPTEM4U2VTTkp6RmPXelHMCI0xGJcmmJb32OI3z92ulTWSX8KP4r+kTH2ZUYT5wCU09Ip9Xm+K9Mkkqq3k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774046426; c=relaxed/simple;
	bh=5B0UudB5t6IvoUSjas4gSsitxv5wljP/xv5/LMRSwMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=njpI+uR4fdBuKZ1m4+twCRk7NFA76GfSSmGV12zh6njZ7MZhB8uMrkqlPJAEqCO0pdrfv/UeU/zhzRzyu4GXxQukX2Muo6KAEziTe+L5HWgAyvMxeVrWrRrids9hpGJEYFZygGyxDR4vt4/DYq20vvaV9c6klhkZ5bYwovcRVHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KUQ4yJnN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF76C2BCB0;
	Fri, 20 Mar 2026 22:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774046423;
	bh=5B0UudB5t6IvoUSjas4gSsitxv5wljP/xv5/LMRSwMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KUQ4yJnN/WuHnEHkwKNXjPL29+3niu71Tepf6T8MO4WkDdogsFLE72V8PeJFDVlF4
	 Bgq2IUCnGX2DqjqxgG9VU/AJ9tvaRvZoXCJ/edOpA2ecyHNMPx/827tzdtxUxlno1b
	 kB/jx2f29BxgqysOfNJm2thngFQSBiZldAHGABhZEbYYZtllNjGAzqunIUk7syMpWE
	 q4F2EYNQ3xjEpxq+z70oW/TZyTdZnIe3eNlH70hr0fh7kvql3+XaNSIzX6J9joDX/J
	 Wo7adkEJHy2wBoh1A0sfY4bHYjqE6KjPrlgSkBE1+cXFhZzg9cVq3BIUNXtQCYbYf7
	 VMR8sVXp9E6aw==
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Clemens Ladisch <clemens@ladisch.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Bodo Stroesser <bostroesser@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	David Hildenbrand <david@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mtd@lists.infradead.org,
	linux-staging@lists.linux.dev,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Ryan Roberts <ryan.roberts@arm.com>
Subject: [PATCH v4 06/21] mm/vma: remove superfluous map->hold_file_rmap_lock
Date: Fri, 20 Mar 2026 22:39:32 +0000
Message-ID: <42c3fbb701e361a17193ecda0d2dabcc326288a5.1774045440.git.ljs@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1774045440.git.ljs@kernel.org>
References: <cover.1774045440.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lwn.net,ladisch.de,arndb.de,linuxfoundation.org,microsoft.com,kernel.org,linux.intel.com,gmail.com,foss.st.com,bootlin.com,nod.at,ti.com,oracle.com,redhat.com,auristor.com,zeniv.linux.org.uk,suse.cz,google.com,suse.com,suse.de,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,kvack.org,arm.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[44];
	TAGGED_FROM(0.00)[bounces-9652-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CFE542E1E3B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We don't need to reference this field, it's confusing as it duplicates
mmap_action->hide_from_rmap_until_complete, so thread the mmap_action
through to __mmap_new_vma() instead and use the same field consistently.

Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
---
 mm/vma.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 3fc5fe4f1a7c..6105f54cea61 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -38,8 +38,6 @@ struct mmap_state {
 
 	/* Determine if we can check KSM flags early in mmap() logic. */
 	bool check_ksm_early :1;
-	/* If we map new, hold the file rmap lock on mapping. */
-	bool hold_file_rmap_lock :1;
 	/* If .mmap_prepare changed the file, we don't need to pin. */
 	bool file_doesnt_need_get :1;
 };
@@ -2531,10 +2529,12 @@ static int __mmap_new_file_vma(struct mmap_state *map,
  *
  * @map:  Mapping state.
  * @vmap: Output pointer for the new VMA.
+ * @action: Any mmap_prepare action that is still to complete.
  *
  * Returns: Zero on success, or an error.
  */
-static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
+static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap,
+	struct mmap_action *action)
 {
 	struct vma_iterator *vmi = map->vmi;
 	int error = 0;
@@ -2583,7 +2583,7 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
 	vma_start_write(vma);
 	vma_iter_store_new(vmi, vma);
 	map->mm->map_count++;
-	vma_link_file(vma, map->hold_file_rmap_lock);
+	vma_link_file(vma, action->hide_from_rmap_until_complete);
 
 	/*
 	 * vma_merge_new_range() calls khugepaged_enter_vma() too, the below
@@ -2650,8 +2650,6 @@ static int call_action_prepare(struct mmap_state *map,
 	if (err)
 		return err;
 
-	if (desc->action.hide_from_rmap_until_complete)
-		map->hold_file_rmap_lock = true;
 	return 0;
 }
 
@@ -2741,7 +2739,7 @@ static int call_action_complete(struct mmap_state *map,
 	err = mmap_action_complete(vma, action);
 
 	/* If we held the file rmap we need to release it. */
-	if (map->hold_file_rmap_lock) {
+	if (action->hide_from_rmap_until_complete) {
 		struct file *file = vma->vm_file;
 
 		i_mmap_unlock_write(file->f_mapping);
@@ -2795,7 +2793,7 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 
 	/* ...but if we can't, allocate a new VMA. */
 	if (!vma) {
-		error = __mmap_new_vma(&map, &vma);
+		error = __mmap_new_vma(&map, &vma, &desc.action);
 		if (error)
 			goto unacct_error;
 		allocated_new = true;
-- 
2.53.0


