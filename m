Return-Path: <linux-hyperv+bounces-9661-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBFoMtfOvWneCAMAu9opvQ
	(envelope-from <linux-hyperv+bounces-9661-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Mar 2026 23:48:55 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9632E2198
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Mar 2026 23:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F29183176CE9
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Mar 2026 22:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80EB3F7E67;
	Fri, 20 Mar 2026 22:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDWrE0wg"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B6A3CB2FE;
	Fri, 20 Mar 2026 22:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774046448; cv=none; b=FtHo4lDeYroZzScLp2Zqd0Ujc0fnG99EaX6a7rBAxE883+uTjIP9OzRBCa6936OFtThvjAM4S4G1HoyY0RBR7o0rZheS9qg+cxRYX3bvKVScOzo21dB7wBMR4SEALHqiJ9TKEThV3kL7u1uYos2eoATniFzEFhlX2NmLzPjBdsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774046448; c=relaxed/simple;
	bh=rC8UhPo2hXOr5FxBAlmEyrOxvDFCNwpWMS0HCPMZ5xQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KbD4ZbXH546WLR3HmFI5OHZEiNYqpJ1tt6HK2/w/BW0ujgwTCjgMhYcKTLKM0VAhqQ7NR+8A8wge4i6o5KByKZRCwZsdZ3FDuNw+dQ8HOJnFcceIUv/9itQe20M2UYjxPqtuibOpE2gIF6zpc1gzhh0+F2jreUhfCHvU1HH6/Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDWrE0wg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 063CBC4CEF7;
	Fri, 20 Mar 2026 22:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774046448;
	bh=rC8UhPo2hXOr5FxBAlmEyrOxvDFCNwpWMS0HCPMZ5xQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jDWrE0wgPddZzCp/6MXK6JtMRXwDHcncD6Pj3A0RlrLa9zNX5JGIJM0U9t1UwvBN6
	 twzxYKnGdtV88a0F3yVb7GNg44xifk+XFDGN25B3mLjNPX8FneUvbLeJEQNdtUt+WZ
	 /WH9NUWNCW6kMFTyjb+FmMKLFX2G4JaHL5+eGKdLNhbt7+v595DrvFQy6V7DTdK6hP
	 V0/SMtHmbCkPbpX0kqrB4ikg8rPlyLYqzH6GDsIeQ1eCh6Fq+mPmF+bPpeusN4e5RB
	 MrJLikSOWypIy40O2GVpU9qtXFTnNtyqLTtrhGWOpRG0RADI3LlJbe2hP9kqnW/0Ky
	 XEbXUHAUYlzGA==
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
Subject: [PATCH v4 15/21] stm: replace deprecated mmap hook with mmap_prepare
Date: Fri, 20 Mar 2026 22:39:41 +0000
Message-ID: <9f3d559a264a83cf45518fcf35cc7ef1d7dfd500.1774045440.git.ljs@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lwn.net,ladisch.de,arndb.de,linuxfoundation.org,microsoft.com,kernel.org,linux.intel.com,gmail.com,foss.st.com,bootlin.com,nod.at,ti.com,oracle.com,redhat.com,auristor.com,zeniv.linux.org.uk,suse.cz,google.com,suse.com,suse.de,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,kvack.org,arm.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[44];
	TAGGED_FROM(0.00)[bounces-9661-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6D9632E2198
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The f_op->mmap interface is deprecated, so update driver to use its
successor, mmap_prepare.

The driver previously used vm_iomap_memory(), so this change replaces it
with its mmap_prepare equivalent, mmap_action_simple_ioremap().

Also, in order to correctly maintain reference counting, add a
vm_ops->mapped callback to increment the reference count when successfully
mapped.

Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
---
 drivers/hwtracing/stm/core.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index 37584e786bb5..f48c6a8a0654 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -666,6 +666,16 @@ static ssize_t stm_char_write(struct file *file, const char __user *buf,
 	return count;
 }
 
+static int stm_mmap_mapped(unsigned long start, unsigned long end, pgoff_t pgoff,
+			   const struct file *file, void **vm_private_data)
+{
+	struct stm_file *stmf = file->private_data;
+	struct stm_device *stm = stmf->stm;
+
+	pm_runtime_get_sync(&stm->dev);
+	return 0;
+}
+
 static void stm_mmap_open(struct vm_area_struct *vma)
 {
 	struct stm_file *stmf = vma->vm_file->private_data;
@@ -684,12 +694,14 @@ static void stm_mmap_close(struct vm_area_struct *vma)
 }
 
 static const struct vm_operations_struct stm_mmap_vmops = {
+	.mapped = stm_mmap_mapped,
 	.open	= stm_mmap_open,
 	.close	= stm_mmap_close,
 };
 
-static int stm_char_mmap(struct file *file, struct vm_area_struct *vma)
+static int stm_char_mmap_prepare(struct vm_area_desc *desc)
 {
+	struct file *file = desc->file;
 	struct stm_file *stmf = file->private_data;
 	struct stm_device *stm = stmf->stm;
 	unsigned long size, phys;
@@ -697,10 +709,10 @@ static int stm_char_mmap(struct file *file, struct vm_area_struct *vma)
 	if (!stm->data->mmio_addr)
 		return -EOPNOTSUPP;
 
-	if (vma->vm_pgoff)
+	if (desc->pgoff)
 		return -EINVAL;
 
-	size = vma->vm_end - vma->vm_start;
+	size = vma_desc_size(desc);
 
 	if (stmf->output.nr_chans * stm->data->sw_mmiosz != size)
 		return -EINVAL;
@@ -712,13 +724,12 @@ static int stm_char_mmap(struct file *file, struct vm_area_struct *vma)
 	if (!phys)
 		return -EINVAL;
 
-	pm_runtime_get_sync(&stm->dev);
-
-	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-	vm_flags_set(vma, VM_IO | VM_DONTEXPAND | VM_DONTDUMP);
-	vma->vm_ops = &stm_mmap_vmops;
-	vm_iomap_memory(vma, phys, size);
+	desc->page_prot = pgprot_noncached(desc->page_prot);
+	vma_desc_set_flags(desc, VMA_IO_BIT, VMA_DONTEXPAND_BIT,
+			   VMA_DONTDUMP_BIT);
+	desc->vm_ops = &stm_mmap_vmops;
 
+	mmap_action_simple_ioremap(desc, phys, size);
 	return 0;
 }
 
@@ -836,7 +847,7 @@ static const struct file_operations stm_fops = {
 	.open		= stm_char_open,
 	.release	= stm_char_release,
 	.write		= stm_char_write,
-	.mmap		= stm_char_mmap,
+	.mmap_prepare	= stm_char_mmap_prepare,
 	.unlocked_ioctl	= stm_char_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 };
-- 
2.53.0


