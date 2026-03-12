Return-Path: <linux-hyperv+bounces-9385-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMSrM9Eis2mASgAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9385-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 21:32:17 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB102793CD
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 21:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A31E33059267
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 20:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923023DB64F;
	Thu, 12 Mar 2026 20:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SE1eoNLL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6523D8125;
	Thu, 12 Mar 2026 20:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773347299; cv=none; b=OPvhx2baI5wA9Xhv6EZJHdI2rKXLF9NxKAMxKbC+MUazIf3UD/QSjaO9Tlsh5Sbz4D5PXgaflPleVGU4TUgn2Y2Saf4Z5oyXvof418XQmfSx7Bfbcp+psCnD80IjpU7BEsqFHtvzwSpiHbI/+Sdm2o2/uAIRYMBIg3z8yn0iJp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773347299; c=relaxed/simple;
	bh=3gkyUtsSx7jHel7cmRKZSxJv14d/Oyif1xbXqVSUag8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tc1rZTvufltulLF6OzSGz/raZOd2XBENCe/MlxzsgZ1iwQ+VDilWNPUYqkl2axBSksaaHJ5es27SBbm6Au+fIbBb05PuK0DYuOxg772z1pzfbi1JGpFIwQOqQSBilUqK4mIJVougqNywMf+aEoUF+2TJyrKlSJFM/6MuCuLHiTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SE1eoNLL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE0CC2BC86;
	Thu, 12 Mar 2026 20:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773347299;
	bh=3gkyUtsSx7jHel7cmRKZSxJv14d/Oyif1xbXqVSUag8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SE1eoNLLnCchG8HnK6XRvfFeHKhyfrzwwjiWm9QdAt5SsrbT5Uw9DpSpKd50HTu4X
	 xdndXitgm96uIJn7PRDHQ7k9Hgf4LZp/zIwyQxTDnU08FmxgNaGLbcUr/QaZemp3i6
	 DkSmTS08I/Wqy4/GCxky+IbGqrb4HTAtMgXkKY6chyfRut5Zuvanm3/fJh/KyDnajD
	 zgAsNGcfUqJVqPQsSSgeeaMqILTnr1t9nv9XdS8jqAAcPSUMs8GYDUPyMJIN6ryyR7
	 WipiB8AnSPEZcCIwFfuXFjLJFpnnAcxDM1jDa9nEcFSnQ+CAffoYMGMMWgKSaFy739
	 ZBR1/mSnh9p4Q==
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
Subject: [PATCH 13/15] drivers: hv: vmbus: replace deprecated mmap hook with mmap_prepare
Date: Thu, 12 Mar 2026 20:27:28 +0000
Message-ID: <1f0408ba81f455d35bcf510ccd3dc3cb939b55ca.1773346620.git.ljs@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lwn.net,ladisch.de,arndb.de,linuxfoundation.org,microsoft.com,kernel.org,linux.intel.com,gmail.com,foss.st.com,bootlin.com,nod.at,ti.com,oracle.com,redhat.com,auristor.com,zeniv.linux.org.uk,suse.cz,google.com,suse.com,suse.de,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,kvack.org,arm.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[44];
	TAGGED_FROM(0.00)[bounces-9385-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DFB102793CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The f_op->mmap interface is deprecated, so update the vmbus driver to use
its successor, mmap_prepare.

This updates all callbacks which referenced the function pointer
hv_mmap_ring_buffer to instead reference hv_mmap_prepare_ring_buffer,
utilising the newly introduced compat_set_desc_from_vma() and
__compat_vma_mmap() to be able to implement this change.

The UIO HV generic driver is the only user of hv_create_ring_sysfs(), which
is the only function which references
vmbus_channel->mmap_prepare_ring_buffer which, in turn, is the only
external interface to hv_mmap_prepare_ring_buffer.

This patch therefore updates this caller to use mmap_prepare instead, which
also previously used vm_iomap_memory(), so this change replaces it
with its mmap_prepare equivalent, mmap_action_simple_ioremap().

Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
---
 drivers/hv/hyperv_vmbus.h    |  4 ++--
 drivers/hv/vmbus_drv.c       | 27 +++++++++++++++++----------
 drivers/uio/uio_hv_generic.c | 11 ++++++-----
 include/linux/hyperv.h       |  4 ++--
 4 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 7bd8f8486e85..31f576464f18 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -545,8 +545,8 @@ static inline int hv_debug_add_dev_dir(struct hv_device *dev)
 
 /* Create and remove sysfs entry for memory mapped ring buffers for a channel */
 int hv_create_ring_sysfs(struct vmbus_channel *channel,
-			 int (*hv_mmap_ring_buffer)(struct vmbus_channel *channel,
-						    struct vm_area_struct *vma));
+			 int (*hv_mmap_prepare_ring_buffer)(struct vmbus_channel *channel,
+							    struct vm_area_desc *desc));
 int hv_remove_ring_sysfs(struct vmbus_channel *channel);
 
 #endif /* _HYPERV_VMBUS_H */
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index bc4fc1951ae1..a76fa3f0588c 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1951,12 +1951,19 @@ static int hv_mmap_ring_buffer_wrapper(struct file *filp, struct kobject *kobj,
 				       struct vm_area_struct *vma)
 {
 	struct vmbus_channel *channel = container_of(kobj, struct vmbus_channel, kobj);
+	struct vm_area_desc desc;
+	int err;
 
 	/*
 	 * hv_(create|remove)_ring_sysfs implementation ensures that mmap_ring_buffer
 	 * is not NULL.
 	 */
-	return channel->mmap_ring_buffer(channel, vma);
+	compat_set_desc_from_vma(&desc, filp, vma);
+	err = channel->mmap_prepare_ring_buffer(channel, &desc);
+	if (err)
+		return err;
+
+	return __compat_vma_mmap(&desc, vma);
 }
 
 static struct bin_attribute chan_attr_ring_buffer = {
@@ -2048,13 +2055,13 @@ static const struct kobj_type vmbus_chan_ktype = {
 /**
  * hv_create_ring_sysfs() - create "ring" sysfs entry corresponding to ring buffers for a channel.
  * @channel: Pointer to vmbus_channel structure
- * @hv_mmap_ring_buffer: function pointer for initializing the function to be called on mmap of
+ * @hv_mmap_ring_buffer: function pointer for initializing the function to be called on mmap
  *                       channel's "ring" sysfs node, which is for the ring buffer of that channel.
  *                       Function pointer is of below type:
- *                       int (*hv_mmap_ring_buffer)(struct vmbus_channel *channel,
- *                                                  struct vm_area_struct *vma))
- *                       This has a pointer to the channel and a pointer to vm_area_struct,
- *                       used for mmap, as arguments.
+ *                       int (*hv_mmap_prepare_ring_buffer)(struct vmbus_channel *channel,
+ *                                                          struct vm_area_desc *desc))
+ *                       This has a pointer to the channel and a pointer to vm_area_desc,
+ *                       used for mmap_prepare, as arguments.
  *
  * Sysfs node for ring buffer of a channel is created along with other fields, however its
  * visibility is disabled by default. Sysfs creation needs to be controlled when the use-case
@@ -2071,12 +2078,12 @@ static const struct kobj_type vmbus_chan_ktype = {
  * Returns 0 on success or error code on failure.
  */
 int hv_create_ring_sysfs(struct vmbus_channel *channel,
-			 int (*hv_mmap_ring_buffer)(struct vmbus_channel *channel,
-						    struct vm_area_struct *vma))
+			 int (*hv_mmap_prepare_ring_buffer)(struct vmbus_channel *channel,
+							    struct vm_area_desc *desc))
 {
 	struct kobject *kobj = &channel->kobj;
 
-	channel->mmap_ring_buffer = hv_mmap_ring_buffer;
+	channel->mmap_prepare_ring_buffer = hv_mmap_prepare_ring_buffer;
 	channel->ring_sysfs_visible = true;
 
 	return sysfs_update_group(kobj, &vmbus_chan_group);
@@ -2098,7 +2105,7 @@ int hv_remove_ring_sysfs(struct vmbus_channel *channel)
 
 	channel->ring_sysfs_visible = false;
 	ret = sysfs_update_group(kobj, &vmbus_chan_group);
-	channel->mmap_ring_buffer = NULL;
+	channel->mmap_prepare_ring_buffer = NULL;
 	return ret;
 }
 EXPORT_SYMBOL_GPL(hv_remove_ring_sysfs);
diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index 3f8e2e27697f..29ec2d15ada8 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -154,15 +154,16 @@ static void hv_uio_rescind(struct vmbus_channel *channel)
  * The ring buffer is allocated as contiguous memory by vmbus_open
  */
 static int
-hv_uio_ring_mmap(struct vmbus_channel *channel, struct vm_area_struct *vma)
+hv_uio_ring_mmap_prepare(struct vmbus_channel *channel, struct vm_area_desc *desc)
 {
 	void *ring_buffer = page_address(channel->ringbuffer_page);
 
 	if (channel->state != CHANNEL_OPENED_STATE)
 		return -ENODEV;
 
-	return vm_iomap_memory(vma, virt_to_phys(ring_buffer),
-			       channel->ringbuffer_pagecount << PAGE_SHIFT);
+	mmap_action_simple_ioremap(desc, virt_to_phys(ring_buffer),
+			channel->ringbuffer_pagecount << PAGE_SHIFT);
+	return 0;
 }
 
 /* Callback from VMBUS subsystem when new channel created. */
@@ -183,7 +184,7 @@ hv_uio_new_channel(struct vmbus_channel *new_sc)
 	}
 
 	set_channel_read_mode(new_sc, HV_CALL_ISR);
-	ret = hv_create_ring_sysfs(new_sc, hv_uio_ring_mmap);
+	ret = hv_create_ring_sysfs(new_sc, hv_uio_ring_mmap_prepare);
 	if (ret) {
 		dev_err(device, "sysfs create ring bin file failed; %d\n", ret);
 		vmbus_close(new_sc);
@@ -366,7 +367,7 @@ hv_uio_probe(struct hv_device *dev,
 	 * or decoupled from uio_hv_generic probe. Userspace programs can make use of inotify
 	 * APIs to make sure that ring is created.
 	 */
-	hv_create_ring_sysfs(channel, hv_uio_ring_mmap);
+	hv_create_ring_sysfs(channel, hv_uio_ring_mmap_prepare);
 
 	hv_set_drvdata(dev, pdata);
 
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index dfc516c1c719..3a721b1853a4 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1015,8 +1015,8 @@ struct vmbus_channel {
 	/* The max size of a packet on this channel */
 	u32 max_pkt_size;
 
-	/* function to mmap ring buffer memory to the channel's sysfs ring attribute */
-	int (*mmap_ring_buffer)(struct vmbus_channel *channel, struct vm_area_struct *vma);
+	/* function to mmap_prepare ring buffer memory to the channel's sysfs ring attribute */
+	int (*mmap_prepare_ring_buffer)(struct vmbus_channel *channel, struct vm_area_desc *desc);
 
 	/* boolean to control visibility of sysfs for ring buffer */
 	bool ring_sysfs_visible;
-- 
2.53.0


