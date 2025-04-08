Return-Path: <linux-hyperv+bounces-4826-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B2EA814C9
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Apr 2025 20:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2BFD1BA653B
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Apr 2025 18:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3EC240604;
	Tue,  8 Apr 2025 18:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvCvmddb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7749023E35D;
	Tue,  8 Apr 2025 18:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744137423; cv=none; b=aW2L1i5Eso4CXf30D5MPeR1XFNd9DBOUyu0B5X9FPtYJfY+WI7OWtleAAkzMdFBCWUcZeJQjpOGK3FR6MLdnBCk/IPeSo7QaO0yNyKDa5oXVQt+0sjIdcuYJ9qVP4uui53DFG2HN6j/D9afwenpr7keCak5WH4OnedGBx+J9Szw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744137423; c=relaxed/simple;
	bh=ez2ocKNXIhwg7rKrJqs21QJI1qA4GysMfQVZzXt2/xU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H1erM2cArXY5MaewfpW/U/2MJ8Z19Ysgi1K4Z1ClkXT0CFbrhqr5/oYiqnR39ehWR3OC3iUkNJjpvf+yGe0s5QG9HuRtMFwOdEH45SPznIvmTbGV3473nUd9mzbjEWfugTwR8FMRbYbzVX7+d4F6GZf75O7OVuKlMmO7hrPo2Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IvCvmddb; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-730517040a9so7204210b3a.0;
        Tue, 08 Apr 2025 11:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744137421; x=1744742221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yaU+5633ewJo+47cjHg1WFMmmsE9Nb6gzhZCIjFmnWA=;
        b=IvCvmddbbsaj9QUOIRwVkK7W2iTVfix2negAlrbrcPROPWWNzUIsdZg9QXtf/NDIkh
         8T6Fts5DwN5EmSHEe5zYGRmuEeuM4TO3S4gMHeVtbDffn321xU2Wc7cmYAVTnxrR9yQL
         GEqoZHWIOTIw8OBvOU+2I2Xo8sDR6o/NLP7biHyhc0kf3vH36hF1zQr0gX4PWisoxGvI
         rsKNpnwFESLGi5kqNvguVVOwLwgg8ffuoCiCV1YBK/H3OVvCFhMFbQI/u9YUZmpUdpke
         Da8NSvzGviNoI5ZuBYtl6082N8ORfZ2sZ1y4M+9AyvfJHEGdy/JS2nkYjb6UTTu31NUW
         eMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744137421; x=1744742221;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yaU+5633ewJo+47cjHg1WFMmmsE9Nb6gzhZCIjFmnWA=;
        b=qlNYgmbXLkwqT6xJT9SR9iENrc3M85mMAZhTZBLhBUEJT9p08ZyDg25Yt9piUD9OdZ
         sDhUDx274zG0S8Erbfv7HzEepAxmwA4i9PpUqlY8VWtiMYnTSiVirFemIgKm2n+BsbOv
         6O8hQe/tltIUJh3m70ClDVYFr6je5jORgNfEGFYefdP6zKYfv3Pcy4ZoTjennVjn/Qdu
         UuOqhkhRt6DRl09QxsR+DkTGlcs11kMNlPLEweY3A919bFc7yVDbxRAg7gDX38iNIX2o
         Ao3plxBEPlUAyBHrw5RCZCfIvwwSuXAskhEGElsH1rCEZNcwJ4KBBVq4oCQbRyxPvba9
         cUaw==
X-Forwarded-Encrypted: i=1; AJvYcCV0+lyCJOKjJM8x8QT2iHZ3Wqx8EVq5taveehCfX84YGL3LAACHpqb8UzTvMrNZ1R8R7hZurxpqcjfdJoip@vger.kernel.org, AJvYcCV6rXf4fedi1jNjPkLjbLwes43qTiwnVWvBtjC99jZtBHGVwCdnyJRbbArB6hTDc+X2LO/csUbr+YpTHA==@vger.kernel.org, AJvYcCVUuEZpDLk6MBnK/jEDJE9GGAT3nbSn0D/lgMskRGJmsoHORPyd9GhuyRd6uYE/OAo0IG5uIX0NdBwmOYEw@vger.kernel.org
X-Gm-Message-State: AOJu0YxPwhejS14K5KGFckeP4kyLsYgyvGbSS/npgbZGop1Fn7KSRdAz
	dNJMy7IfH9qIZOv5lRQAw/QWDTjp602jLiVpEwRhmsH/IwAcArgo
X-Gm-Gg: ASbGncvx1jxCwiCBakB+awkz7cijPz5UMYeA4+htqperi4TAKVQ97cgnc6e/Q5Pn/rB
	oSg2aFiF2Hk18sQjplTKxvlQPWD+U0Gb+YGxPWKzLqJlkEtJoo6edXGZNLEAjY+BmPE9u5XmJlw
	r7Y7Nd+0JYw9B+k4XVR8cWTZFSHo/lfJoYtqYbJISkNm9rZST3Z95dIaFuvIsaI6vNj0pXf+OLv
	9W6/Flk562f0fWxTAuRatDiNaE21Ah1Vca6pWl9xKSw0VmdUVGGtUOnEkSJ4wV3QUNn4PkmsScI
	48+AnapeWFNMZ4T4cKW0UUq3Cx68iKTvarAei+BpHGExC7W9KzV4C1G52hCntAAooI7Tk+WtDTy
	sRLAq7l7hL8mFTQkYQBGc+xE=
X-Google-Smtp-Source: AGHT+IHVHsepbXorylQC9VxOWgtbUH6lFwU2otdZFrXXy0fXuJkqEdBn0S7PNfOtArRZ51249Vrk0Q==
X-Received: by 2002:a05:6a00:114f:b0:736:2ff4:f255 with SMTP id d2e1a72fcca58-73bae527668mr78501b3a.15.1744137420544;
        Tue, 08 Apr 2025 11:37:00 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d97d32b2sm10960469b3a.5.2025.04.08.11.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 11:37:00 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: jayalk@intworks.biz,
	simona@ffwll.ch,
	deller@gmx.de,
	haiyangz@microsoft.com,
	kys@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	akpm@linux-foundation.org
Cc: weh@microsoft.com,
	tzimmermann@suse.de,
	hch@lst.de,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/3] fbdev/deferred-io: Support contiguous kernel memory framebuffers
Date: Tue,  8 Apr 2025 11:36:45 -0700
Message-Id: <20250408183646.1410-3-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250408183646.1410-1-mhklinux@outlook.com>
References: <20250408183646.1410-1-mhklinux@outlook.com>
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

Current defio code works only for framebuffer memory that is allocated
with vmalloc(). The code assumes that the underlying page refcount can
be used by the mm subsystem to manage each framebuffer page's lifecycle,
including freeing the page if the refcount goes to 0. This approach is
consistent with vmalloc'ed memory, but not with contiguous kernel memory
allocated via alloc_pages() or similar. The latter such memory pages
usually have a refcount of 0 when allocated, and would be incorrectly
freed page-by-page if used with defio. That free'ing corrupts the memory
free lists and Linux eventually panics. Simply bumping the refcount after
allocation doesn’t work because when the framebuffer memory is freed,
__free_pages() complains about non-zero refcounts.

Commit 37b4837959cb ("video: deferred io with physically contiguous
memory") from the year 2008 purported to add support for contiguous
kernel memory framebuffers. The motivating device, sh_mobile_lcdcfb, uses
dma_alloc_coherent() to allocate framebuffer memory, which is likely to
use alloc_pages(). It's unclear to me how this commit actually worked at
the time, unless dma_alloc_coherent() was pulling from a CMA pool instead
of alloc_pages(). Or perhaps alloc_pages() worked differently or on the
arm32 architecture on which sh_mobile_lcdcfb is used.

In any case, for x86 and arm64 today, commit 37b4837959cb9 is not
sufficient to support contiguous kernel memory framebuffers. The problem
can be seen with the hyperv_fb driver, which may allocate the framebuffer
memory using vmalloc() or alloc_pages(), depending on the configuration
of the Hyper-V guest VM (Gen 1 vs. Gen 2) and the size of the framebuffer.

Fix this limitation by adding defio support for contiguous kernel memory
framebuffers. A driver with a framebuffer allocated from contiguous
kernel memory must set the FBINFO_KMEMFB flag to indicate such.

Tested with the hyperv_fb driver in both configurations -- with a vmalloc()
framebuffer and with an alloc_pages() framebuffer on x86. Also verified a
vmalloc() framebuffer on arm64. Hardware is not available to me to verify
that the older arm32 devices still work correctly, but the path for
vmalloc() framebuffers is essentially unchanged.

Even with these changes, defio does not support framebuffers in MMIO
space, as defio code depends on framebuffer memory pages having
corresponding 'struct page's.

Fixes: 3a6fb6c4255c ("video: hyperv: hyperv_fb: Use physical memory for fb on HyperV Gen 1 VMs.")
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/video/fbdev/core/fb_defio.c | 126 +++++++++++++++++++++++-----
 include/linux/fb.h                  |   1 +
 2 files changed, 107 insertions(+), 20 deletions(-)

diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/core/fb_defio.c
index 4fc93f253e06..0879973a4572 100644
--- a/drivers/video/fbdev/core/fb_defio.c
+++ b/drivers/video/fbdev/core/fb_defio.c
@@ -8,11 +8,38 @@
  * for more details.
  */
 
+/*
+ * Deferred I/O ("defio") allows framebuffers that are mmap()'ed to user space
+ * to batch user space writes into periodic updates to the underlying
+ * framebuffer hardware or other implementation (such as with a virtualized
+ * framebuffer in a VM). At each batch interval, a callback is invoked in the
+ * framebuffer's kernel driver, and the callback is supplied with a list of
+ * pages that have been modified in the preceding interval. The callback can
+ * use this information to update the framebuffer hardware as necessary. The
+ * batching can improve performance and reduce the overhead of updating the
+ * hardware.
+ *
+ * Defio is supported on framebuffers allocated using vmalloc() and allocated
+ * as contiguous kernel memory using alloc_pages(), kmalloc(), or
+ * dma_alloc_coherent(), the latter of which might allocate from CMA. These
+ * memory allocations all have corresponding "struct page"s. Framebuffers
+ * in MMIO space are *not* supported because MMIO space does not have
+ * corrresponding "struct page"s.
+ *
+ * For framebuffers allocated using vmalloc(), struct fb_info must have
+ * "screen_buffer" set to the vmalloc address of the framebuffer. For
+ * framebuffers allocated from contiguous kernel memory, FBINFO_KMEMFB must
+ * be set, and "fix.smem_start" must be set to the physical address of the
+ * frame buffer. In both cases, "fix.smem_len" must be set to the framebuffer
+ * size in bytes.
+ */
+
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
+#include <linux/pfn_t.h>
 #include <linux/vmalloc.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
@@ -37,7 +64,7 @@ static struct page *fb_deferred_io_get_page(struct fb_info *info, unsigned long
 	else if (info->fix.smem_start)
 		page = pfn_to_page((info->fix.smem_start + offs) >> PAGE_SHIFT);
 
-	if (page)
+	if (page && !(info->flags & FBINFO_KMEMFB))
 		get_page(page);
 
 	return page;
@@ -137,6 +164,15 @@ static vm_fault_t fb_deferred_io_fault(struct vm_fault *vmf)
 
 	BUG_ON(!info->fbdefio->mapping);
 
+	if (info->flags & FBINFO_KMEMFB)
+		/*
+		 * In this path, the VMA is marked VM_PFNMAP, so mm assumes
+		 * there is no struct page associated with the page. The
+		 * PFN must be directly inserted and the created PTE will be
+		 * marked "special".
+		 */
+		return vmf_insert_pfn(vmf->vma, vmf->address, page_to_pfn(page));
+
 	vmf->page = page;
 	return 0;
 }
@@ -163,13 +199,14 @@ EXPORT_SYMBOL_GPL(fb_deferred_io_fsync);
 
 /*
  * Adds a page to the dirty list. Call this from struct
- * vm_operations_struct.page_mkwrite.
+ * vm_operations_struct.page_mkwrite or .pfn_mkwrite.
  */
-static vm_fault_t fb_deferred_io_track_page(struct fb_info *info, unsigned long offset,
+static vm_fault_t fb_deferred_io_track_page(struct fb_info *info, struct vm_fault *vmf,
 					    struct page *page)
 {
 	struct fb_deferred_io *fbdefio = info->fbdefio;
 	struct fb_deferred_io_pageref *pageref;
+	unsigned long offset = vmf->pgoff << PAGE_SHIFT;
 	vm_fault_t ret;
 
 	/* protect against the workqueue changing the page list */
@@ -182,20 +219,34 @@ static vm_fault_t fb_deferred_io_track_page(struct fb_info *info, unsigned long
 	}
 
 	/*
-	 * We want the page to remain locked from ->page_mkwrite until
-	 * the PTE is marked dirty to avoid mapping_wrprotect_range()
-	 * being called before the PTE is updated, which would leave
-	 * the page ignored by defio.
-	 * Do this by locking the page here and informing the caller
-	 * about it with VM_FAULT_LOCKED.
+	 * The PTE must be marked writable before the defio deferred work runs
+	 * again and potentially marks the PTE write-protected. If the order
+	 * should be switched, the PTE would become writable without defio
+	 * tracking the page, leaving the page forever ignored by defio.
+	 *
+	 * For vmalloc() framebuffers, the associated struct page is locked
+	 * before releasing the defio lock. mm will later mark the PTE writaable
+	 * and release the struct page lock. The struct page lock prevents
+	 * the page from being prematurely being marked write-protected.
+	 *
+	 * For FBINFO_KMEMFB framebuffers, mm assumes there is no struct page,
+	 * so the PTE must be marked writable while the defio lock is held.
 	 */
-	lock_page(pageref->page);
+	if (info->flags & FBINFO_KMEMFB) {
+		unsigned long pfn = page_to_pfn(pageref->page);
+
+		ret = vmf_insert_mixed_mkwrite(vmf->vma, vmf->address,
+					       __pfn_to_pfn_t(pfn, PFN_SPECIAL));
+	} else {
+		lock_page(pageref->page);
+		ret = VM_FAULT_LOCKED;
+	}
 
 	mutex_unlock(&fbdefio->lock);
 
 	/* come back after delay to process the deferred IO */
 	schedule_delayed_work(&info->deferred_work, fbdefio->delay);
-	return VM_FAULT_LOCKED;
+	return ret;
 
 err_mutex_unlock:
 	mutex_unlock(&fbdefio->lock);
@@ -207,10 +258,10 @@ static vm_fault_t fb_deferred_io_track_page(struct fb_info *info, unsigned long
  * @fb_info: The fbdev info structure
  * @vmf: The VM fault
  *
- * This is a callback we get when userspace first tries to
- * write to the page. We schedule a workqueue. That workqueue
- * will eventually mkclean the touched pages and execute the
- * deferred framebuffer IO. Then if userspace touches a page
+ * This is a callback we get when userspace first tries to write to a
+ * page. We schedule a workqueue. That workqueue will eventually do
+ * mapping_wrprotect_range() on the written pages and execute the
+ * deferred framebuffer IO. Then if userspace writes to a page
  * again, we repeat the same scheme.
  *
  * Returns:
@@ -218,12 +269,11 @@ static vm_fault_t fb_deferred_io_track_page(struct fb_info *info, unsigned long
  */
 static vm_fault_t fb_deferred_io_page_mkwrite(struct fb_info *info, struct vm_fault *vmf)
 {
-	unsigned long offset = vmf->pgoff << PAGE_SHIFT;
 	struct page *page = vmf->page;
 
 	file_update_time(vmf->vma->vm_file);
 
-	return fb_deferred_io_track_page(info, offset, page);
+	return fb_deferred_io_track_page(info, vmf, page);
 }
 
 /* vm_ops->page_mkwrite handler */
@@ -234,9 +284,25 @@ static vm_fault_t fb_deferred_io_mkwrite(struct vm_fault *vmf)
 	return fb_deferred_io_page_mkwrite(info, vmf);
 }
 
+/*
+ * Similar to fb_deferred_io_mkwrite(), but for first writes to pages
+ * in VMAs that have VM_PFNMAP set.
+ */
+static vm_fault_t fb_deferred_io_pfn_mkwrite(struct vm_fault *vmf)
+{
+	struct fb_info *info = vmf->vma->vm_private_data;
+	unsigned long offset = vmf->pgoff << PAGE_SHIFT;
+	struct page *page = phys_to_page(info->fix.smem_start + offset);
+
+	file_update_time(vmf->vma->vm_file);
+
+	return fb_deferred_io_track_page(info, vmf, page);
+}
+
 static const struct vm_operations_struct fb_deferred_io_vm_ops = {
 	.fault		= fb_deferred_io_fault,
 	.page_mkwrite	= fb_deferred_io_mkwrite,
+	.pfn_mkwrite	= fb_deferred_io_pfn_mkwrite,
 };
 
 static const struct address_space_operations fb_deferred_io_aops = {
@@ -246,11 +312,31 @@ static const struct address_space_operations fb_deferred_io_aops = {
 int fb_deferred_io_mmap(struct fb_info *info, struct vm_area_struct *vma)
 {
 	vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
+	vm_flags_t flags = VM_DONTEXPAND | VM_DONTDUMP;
 
 	vma->vm_ops = &fb_deferred_io_vm_ops;
-	vm_flags_set(vma, VM_DONTEXPAND | VM_DONTDUMP);
-	if (!(info->flags & FBINFO_VIRTFB))
-		vm_flags_set(vma, VM_IO);
+	if (info->flags & FBINFO_KMEMFB) {
+		/*
+		 * I/O fault path calls vmf_insert_pfn(), which bug checks
+		 * if the vma is not marked shared. mmap'ing the framebuffer
+		 * as PRIVATE doesn't really make sense anyway, though doing
+		 * so isn't harmful for vmalloc() framebuffers. So there's
+		 * no prohibition for that case.
+		 */
+		if (!(vma->vm_flags & VM_SHARED))
+			return -EINVAL;
+		/*
+		 * Set VM_PFNMAP so mm code will not try to manage the pages'
+		 * lifecycles. We don't want individual pages to be freed
+		 * based on refcount. Instead the memory must be returned to
+		 * the free pool in the usual way. Cf. the implementation of
+		 * remap_pfn_range() and remap_pfn_range_internal().
+		 */
+		flags |= VM_PFNMAP | VM_IO;
+	} else if (!(info->flags & FBINFO_VIRTFB)) {
+		flags |= VM_IO;
+	}
+	vm_flags_set(vma, flags);
 	vma->vm_private_data = info;
 	return 0;
 }
diff --git a/include/linux/fb.h b/include/linux/fb.h
index cd653862ab99..ea2092757a18 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -402,6 +402,7 @@ struct fb_tile_ops {
 
 /* hints */
 #define FBINFO_VIRTFB		0x0004 /* FB is System RAM, not device. */
+#define FBINFO_KMEMFB		0x0008 /* FB is allocated in contig kernel mem */
 #define FBINFO_PARTIAL_PAN_OK	0x0040 /* otw use pan only for double-buffering */
 #define FBINFO_READS_FAST	0x0080 /* soft-copy faster than rendering */
 
-- 
2.25.1


