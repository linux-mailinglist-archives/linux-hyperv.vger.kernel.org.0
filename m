Return-Path: <linux-hyperv+bounces-9377-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EOHHaois2m5SQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9377-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 21:31:38 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F19B0279396
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 21:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30D55312C1F2
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 20:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008DA38F635;
	Thu, 12 Mar 2026 20:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LfFsDlKL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA783803EF;
	Thu, 12 Mar 2026 20:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773347280; cv=none; b=itjex1aVRYLD0NdIAG+r5dg55sDx9z86/Xrzfs+QOCNGrwFu+/Cpn//jI7PVrMqpMprNWbdNT2tWXFvo+5MK5EW8kb4LmrueD+tkekcoBdh2s1D8xZM5taklvDlaEyA3SWohGZMZhzc9c4uC6xuAEwkbuO1ycqK+ooDDx4KUWLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773347280; c=relaxed/simple;
	bh=+y+8TQWjiS/6OrohqiWfuyvPwbhSgEN2DOnPq14pRqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YbMfedfqDUDIFxL2JoL5zUWiXtKC/jfMtjtghuqe2jL+zPZXO127jwWu2T8sNlL32Agm0qo1wYalAcJYznpyR1osg8OrIkUbbDYN7rYV0XMkl7z0Byphg4PpH8XI4YdOA27Z1Ifp3Rm1jxE1rHJTsGlBZc4nMsBSSTlmy6XAKDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LfFsDlKL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB1CFC4CEF7;
	Thu, 12 Mar 2026 20:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773347280;
	bh=+y+8TQWjiS/6OrohqiWfuyvPwbhSgEN2DOnPq14pRqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LfFsDlKLNAp/oUkhFt8+RJpJFNYhJzB9jojo7IzLuXDt50MFkYyLL3CyAZ4orGL89
	 khtFo/M99wAIHGfgccHgA4i9BOZL5xKbg+QwXzkPEfJGsVsqudSj1PcBlmszAf6jUb
	 ZdlUOHKcaob0y3vsG/pBzy4NU5HZTOTpdAht1Fp4UVqk0c69cBrynC1//SoepQdeej
	 tzFBQxTBarGSS/viTR8OOOWGPKeCyBr/USYqWgbRQ/5DPHfa1oDWDRhxg/xB4dHxSF
	 p5vuEySpbc07otTTLQ4eERmCocSh+bkDcVL8rWtVelKhT6mEOsZ0bVdv3mUICoipaS
	 atIMiOhViZuxQ==
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
Subject: [PATCH 05/15] fs: afs: correctly drop reference count on mapping failure
Date: Thu, 12 Mar 2026 20:27:20 +0000
Message-ID: <4a5fa45119220b9d99ed72a36308aed01a30d2c1.1773346620.git.ljs@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773346620.git.ljs@kernel.org>
References: <cover.1773346620.git.ljs@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lwn.net,ladisch.de,arndb.de,linuxfoundation.org,microsoft.com,kernel.org,linux.intel.com,gmail.com,foss.st.com,bootlin.com,nod.at,ti.com,oracle.com,redhat.com,auristor.com,zeniv.linux.org.uk,suse.cz,google.com,suse.com,suse.de,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,kvack.org,arm.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[44];
	TAGGED_FROM(0.00)[bounces-9377-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F19B0279396
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit 9d5403b1036c ("fs: convert most other generic_file_*mmap() users to
.mmap_prepare()") updated AFS to use the mmap_prepare callback in favour of
the deprecated mmap callback.

However, it did not account for the fact that mmap_prepare can fail to map
due to an out of memory error, and thus should not be incrementing a
reference count on mmap_prepare.

With the newly added vm_ops->mapped callback available, we can simply defer
this operation to that callback which is only invoked once the mapping is
successfully in place (but not yet visible to userspace as the mmap and VMA
write locks are held).

Therefore add afs_mapped() to implement this callback for AFS.

In practice the mapping allocations are 'too small to fail' so this is
something that realistically should never happen in practice (or would do
so in a case where the process is about to die anyway), but we should still
handle this.

Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
---
 fs/afs/file.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index f609366fd2ac..69ef86f5e274 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -28,6 +28,8 @@ static ssize_t afs_file_splice_read(struct file *in, loff_t *ppos,
 static void afs_vm_open(struct vm_area_struct *area);
 static void afs_vm_close(struct vm_area_struct *area);
 static vm_fault_t afs_vm_map_pages(struct vm_fault *vmf, pgoff_t start_pgoff, pgoff_t end_pgoff);
+static int afs_mapped(unsigned long start, unsigned long end, pgoff_t pgoff,
+		      const struct file *file, void **vm_private_data);
 
 const struct file_operations afs_file_operations = {
 	.open		= afs_open,
@@ -61,6 +63,7 @@ const struct address_space_operations afs_file_aops = {
 };
 
 static const struct vm_operations_struct afs_vm_ops = {
+	.mapped		= afs_mapped,
 	.open		= afs_vm_open,
 	.close		= afs_vm_close,
 	.fault		= filemap_fault,
@@ -500,13 +503,22 @@ static int afs_file_mmap_prepare(struct vm_area_desc *desc)
 	afs_add_open_mmap(vnode);
 
 	ret = generic_file_mmap_prepare(desc);
-	if (ret == 0)
-		desc->vm_ops = &afs_vm_ops;
-	else
-		afs_drop_open_mmap(vnode);
+	if (ret)
+		return ret;
+
+	desc->vm_ops = &afs_vm_ops;
 	return ret;
 }
 
+static int afs_mapped(unsigned long start, unsigned long end, pgoff_t pgoff,
+		      const struct file *file, void **vm_private_data)
+{
+	struct afs_vnode *vnode = AFS_FS_I(file_inode(file));
+
+	afs_add_open_mmap(vnode);
+	return 0;
+}
+
 static void afs_vm_open(struct vm_area_struct *vma)
 {
 	afs_add_open_mmap(AFS_FS_I(file_inode(vma->vm_file)));
-- 
2.53.0


