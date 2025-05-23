Return-Path: <linux-hyperv+bounces-5648-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C134EAC2756
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 May 2025 18:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF5803B27EC
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 May 2025 16:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693AF297126;
	Fri, 23 May 2025 16:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYOZ1Z5/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788ED296FAB;
	Fri, 23 May 2025 16:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748016948; cv=none; b=ZwPucciaGsqnTeGx85yYveg8slm0JQ23UEe2VjDGEqlUHtOYYJbAMjf8Q8/ejW2apfZWEgtHh8r/dEgtLtzKHaicZtGT1qs585m5AgKuTHjSzaT8M35DYtrsjhOz9O54pWJArBv+LmG0j+mwGAdcnzU5fnAkeAGdaXJxLGCRY3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748016948; c=relaxed/simple;
	bh=58HG41QzO98GYhQQcnvlsAQOtnfbo5y/cL4oAaFfdE0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ooxjoxzrmlgKZrv+n5KNdTWvLAqOMBKL1Far23dFCpkSuHmban6EF+4m41KWH4DeF+saJzQDX+67rQgHvvYjqyEk761TAJbQmYP3vGwhSBJHH6ZlUCVBOTWCiloDC3fkZNZmKx71QqJWrGbCXH7+hA3xG2htU2uj0qNYXaI2+eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WYOZ1Z5/; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-30ea7770bd2so155585a91.0;
        Fri, 23 May 2025 09:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748016946; x=1748621746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wUiI7uurtmihv+UWHjMJ6FiZApPhjGbJwo1AeiH3TYo=;
        b=WYOZ1Z5/hxeRUnl9PDkk028/b+u1fQrvagoymYyM0pwy8Q5hjWlFo4QNNtK/qwwOkG
         evbttiOEHuE+Mf1aSHkXIYpTJ9Jyjlo279OqAOgTub6CnnuM9goK3jDsQIA7+QRW2U3i
         ayUGSqEOnUKzBD/kIN5NcQ/7iX5T8Ki8CqLtqWfFZfRC+cLxKJv0WGxvRnD8hysOGDLf
         7LuW7Rd7HOa5LMGSPt3zGvi8NcfkUwbpm42LnNmKjKuV5Gv+uAgwyCv7Am6G+LoJ/fPZ
         LCpvmCHvvH8veW5y4hIAmCw1Dkr2I4KxZ/AI4jBCPX0anBNKsdWYuTXgdN+M2/4oQiil
         mqRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748016946; x=1748621746;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wUiI7uurtmihv+UWHjMJ6FiZApPhjGbJwo1AeiH3TYo=;
        b=BUzVAqVhy6SpSThrVQ6Dfh+n3A/VBvng4XWtcfbV4QGBeml+Sm9kJUdzzrC29t4OsD
         I8z7RkO3cpDSR+E1qKh0qT9LKcC99yO8sXr2kR6zNLxR8WxX1Oie7h6qmqul0ol/hWhD
         LjXgBoniuaO6Ue/oQEtMvGarZ+vaKqnfHme4qlbfOM0jWkq5hJXs3VJgl6cp2EA2sNX/
         eb9pR9IfrlsG4IuSdwkLfnSxvk5hLpIcILYKRfbhcFcjNmL/DET5123wfrLM51rbeNVU
         cW9cy3K0DOyb+qRGF9zLoJ1HJtGf0cr82Ue+svvnOJ7cEnwJA/stAfOqI2te0cojrHxU
         2mzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxFsy5xfvti9S4SxjoH1SGxlSTzyRoi4ZMpXMsRxc//WuoNnIe2pOwGRD7KsxImVGHn8U4c65rtWh5JA==@vger.kernel.org, AJvYcCWBrJlehceOe5MQ8kbHmJELmpik3Yy+S2GrPrszvRVbJFkygVw//IWFV0z6lRWUHuQZrsVvos60vRbd31L7@vger.kernel.org, AJvYcCX0k1UPh44jh/D8ws6j4uicHKrK5KX45p7VkjnUdicSDZeRQHph5PxYQBFCSeGGjf2BpQ7uOeYLTR35RXcx@vger.kernel.org
X-Gm-Message-State: AOJu0YxOWInvUU9IfKhdHmDZjI19Q+yBXSvGFz+WMNXXg+N8RdCO4n/r
	4d1miBvCA4Kgv8s7ayeVzNtM01oF8vfVQzLnQWeoiZPZyDK4BtT/qqsb
X-Gm-Gg: ASbGncv2GAnTs7QCEZjbwI2Aa97L0+f7VH0ID528GSKZxFBY5HmY3FyEEyfD4o9TNdd
	d4ImebGTpUV+juZMPmK21g2TbreLfaNs8FHobS2GHj/JNKG/jM7VD3JqXSaWeV9Ppajg7VDhi82
	E9gWvtN67Cvyt1EgD9aai6ntJ9EUV1XgLw/JYHkOaggBU4TmdiU96MsKZ7dpSyFEIEcqVliK++M
	AZHYzBuwqjOlRMswsu0X8GXj5p+3aCaEwxw0thxjtgkFG6FxGNBleg4um9rIIn6ekTUmmjfEyFx
	wD8amSs6ZxprrNn3mrNPz/TRshbcnzpaDZQ1UvnZEBW+hR5oZDKM4gaZKuRXCJgfAzdKkq6eUgJ
	xC/NvF2wj4B7aXmB2PViUkzYvysD6lX5vhgN9nDHh
X-Google-Smtp-Source: AGHT+IHZaxwJ79cc+ke533wgd3iPzfray3lMS/1ONJk0NIBROI1NmeDHZii9+TWr1XyrOD/clKoaLA==
X-Received: by 2002:a17:90b:38c5:b0:30e:9aa2:6d34 with SMTP id 98e67ed59e1d1-30e9aa26e5bmr45205405a91.0.1748016945520;
        Fri, 23 May 2025 09:15:45 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f365d46ffsm7526565a91.25.2025.05.23.09.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 09:15:45 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: simona@ffwll.ch,
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
Subject: [PATCH v3 3/4] fbdev/deferred-io: Support contiguous kernel memory framebuffers
Date: Fri, 23 May 2025 09:15:21 -0700
Message-Id: <20250523161522.409504-4-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250523161522.409504-1-mhklinux@outlook.com>
References: <20250523161522.409504-1-mhklinux@outlook.com>
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
Changes in v3:
* Moved definition of FBINFO_KMEMFB flag to a separate patch
  preceeding this one in the patch set [Helge Deller]
Changes in v2:
* Tweaked code comments regarding framebuffers allocated with
  dma_alloc_coherent() [Christoph Hellwig]

 drivers/video/fbdev/core/fb_defio.c | 128 +++++++++++++++++++++++-----
 1 file changed, 108 insertions(+), 20 deletions(-)

diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/core/fb_defio.c
index 4fc93f253e06..f8ae91a1c4df 100644
--- a/drivers/video/fbdev/core/fb_defio.c
+++ b/drivers/video/fbdev/core/fb_defio.c
@@ -8,11 +8,40 @@
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
+ * as contiguous kernel memory using alloc_pages() or kmalloc(). These
+ * memory allocations all have corresponding "struct page"s. Framebuffers
+ * allocated using dma_alloc_coherent() should not be used with defio.
+ * Such allocations should be treated as a black box owned by the DMA
+ * layer, and should not be deconstructed into individual pages as defio
+ * does. Framebuffers in MMIO space are *not* supported because MMIO space
+ * does not have corrresponding "struct page"s.
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
@@ -37,7 +66,7 @@ static struct page *fb_deferred_io_get_page(struct fb_info *info, unsigned long
 	else if (info->fix.smem_start)
 		page = pfn_to_page((info->fix.smem_start + offs) >> PAGE_SHIFT);
 
-	if (page)
+	if (page && !(info->flags & FBINFO_KMEMFB))
 		get_page(page);
 
 	return page;
@@ -137,6 +166,15 @@ static vm_fault_t fb_deferred_io_fault(struct vm_fault *vmf)
 
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
@@ -163,13 +201,14 @@ EXPORT_SYMBOL_GPL(fb_deferred_io_fsync);
 
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
@@ -182,20 +221,34 @@ static vm_fault_t fb_deferred_io_track_page(struct fb_info *info, unsigned long
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
@@ -207,10 +260,10 @@ static vm_fault_t fb_deferred_io_track_page(struct fb_info *info, unsigned long
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
@@ -218,12 +271,11 @@ static vm_fault_t fb_deferred_io_track_page(struct fb_info *info, unsigned long
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
@@ -234,9 +286,25 @@ static vm_fault_t fb_deferred_io_mkwrite(struct vm_fault *vmf)
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
@@ -246,11 +314,31 @@ static const struct address_space_operations fb_deferred_io_aops = {
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
-- 
2.25.1


