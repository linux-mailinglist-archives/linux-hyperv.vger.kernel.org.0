Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC701264146
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Sep 2020 11:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730179AbgIJJQm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 10 Sep 2020 05:16:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47981 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730224AbgIJJOq (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 10 Sep 2020 05:14:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599729282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=48UuGMu8lAd3i+T5wgFdxU+g4zP+de252WBvi4+PyDM=;
        b=X1w2bRfPpBPtQA2230bsPzi50aEABcTontEYqR9qfwmVnZnfVAB+Z4Plv46agPnMYoDqAX
        2+54XciDRGn1wR7qmkN5m1qbnLLAKBBO5/WzEMq+yA2mQRiUyDQZu5OJNJ18t1uKgAVCum
        k9qt7M5PH+nCHTXPXgN2xe8UHXoRbkc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-nJixZS_8MP68XFaEi9SX_g-1; Thu, 10 Sep 2020 05:14:37 -0400
X-MC-Unique: nJixZS_8MP68XFaEi9SX_g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44BCF1091061;
        Thu, 10 Sep 2020 09:14:34 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-88.ams2.redhat.com [10.36.113.88])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CBFC51A8EC;
        Thu, 10 Sep 2020 09:14:25 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-s390@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Julien Grall <julien@xen.org>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Baoquan He <bhe@redhat.com>,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH v3 4/7] mm/memory_hotplug: MEMHP_MERGE_RESOURCE to specify merging of System RAM resources
Date:   Thu, 10 Sep 2020 11:13:37 +0200
Message-Id: <20200910091340.8654-5-david@redhat.com>
In-Reply-To: <20200910091340.8654-1-david@redhat.com>
References: <20200910091340.8654-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Some add_memory*() users add memory in small, contiguous memory blocks.
Examples include virtio-mem, hyper-v balloon, and the XEN balloon.

This can quickly result in a lot of memory resources, whereby the actual
resource boundaries are not of interest (e.g., it might be relevant for
DIMMs, exposed via /proc/iomem to user space). We really want to merge
added resources in this scenario where possible.

Let's provide a flag (MEMHP_MERGE_RESOURCE) to specify that a resource
either created within add_memory*() or passed via add_memory_resource()
shall be marked mergeable and merged with applicable siblings.

To implement that, we need a kernel/resource interface to mark selected
System RAM resources mergeable (IORESOURCE_SYSRAM_MERGEABLE) and trigger
merging.

Note: We really want to merge after the whole operation succeeded, not
directly when adding a resource to the resource tree (it would break
add_memory_resource() and require splitting resources again when the
operation failed - e.g., due to -ENOMEM).

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Kees Cook <keescook@chromium.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Roger Pau Monné <roger.pau@citrix.com>
Cc: Julien Grall <julien@xen.org>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/ioport.h         |  4 +++
 include/linux/memory_hotplug.h |  7 ++++
 kernel/resource.c              | 60 ++++++++++++++++++++++++++++++++++
 mm/memory_hotplug.c            |  7 ++++
 4 files changed, 78 insertions(+)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index d7620d7c941a0..7e61389dcb017 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -60,6 +60,7 @@ struct resource {
 
 /* IORESOURCE_SYSRAM specific bits. */
 #define IORESOURCE_SYSRAM_DRIVER_MANAGED	0x02000000 /* Always detected via a driver. */
+#define IORESOURCE_SYSRAM_MERGEABLE		0x04000000 /* Resource can be merged. */
 
 #define IORESOURCE_EXCLUSIVE	0x08000000	/* Userland may not map this resource */
 
@@ -253,6 +254,9 @@ extern void __release_region(struct resource *, resource_size_t,
 extern void release_mem_region_adjustable(struct resource *, resource_size_t,
 					  resource_size_t);
 #endif
+#ifdef CONFIG_MEMORY_HOTPLUG
+extern void merge_system_ram_resource(struct resource *res);
+#endif
 
 /* Wrappers for managed devices */
 struct device;
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index e53d1058f3443..869a59006cd8e 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -62,6 +62,13 @@ typedef int __bitwise mhp_t;
 
 /* No special request */
 #define MHP_NONE		((__force mhp_t)0)
+/*
+ * Allow merging of the added System RAM resource with adjacent,
+ * mergeable resources. After a successful call to add_memory_resource()
+ * with this flag set, the resource pointer must no longer be used as it
+ * might be stale, or the resource might have changed.
+ */
+#define MEMHP_MERGE_RESOURCE	((__force mhp_t)BIT(0))
 
 /*
  * Extended parameters for memory hotplug:
diff --git a/kernel/resource.c b/kernel/resource.c
index 36b3552210120..7a91b935f4c20 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1363,6 +1363,66 @@ void release_mem_region_adjustable(struct resource *parent,
 }
 #endif	/* CONFIG_MEMORY_HOTREMOVE */
 
+#ifdef CONFIG_MEMORY_HOTPLUG
+static bool system_ram_resources_mergeable(struct resource *r1,
+					   struct resource *r2)
+{
+	/* We assume either r1 or r2 is IORESOURCE_SYSRAM_MERGEABLE. */
+	return r1->flags == r2->flags && r1->end + 1 == r2->start &&
+	       r1->name == r2->name && r1->desc == r2->desc &&
+	       !r1->child && !r2->child;
+}
+
+/*
+ * merge_system_ram_resource - mark the System RAM resource mergeable and try to
+ * merge it with adjacent, mergeable resources
+ * @res: resource descriptor
+ *
+ * This interface is intended for memory hotplug, whereby lots of contiguous
+ * system ram resources are added (e.g., via add_memory*()) by a driver, and
+ * the actual resource boundaries are not of interest (e.g., it might be
+ * relevant for DIMMs). Only resources that are marked mergeable, that have the
+ * same parent, and that don't have any children are considered. All mergeable
+ * resources must be immutable during the request.
+ *
+ * Note:
+ * - The caller has to make sure that no pointers to resources that are
+ *   marked mergeable are used anymore after this call - the resource might
+ *   be freed and the pointer might be stale!
+ * - release_mem_region_adjustable() will split on demand on memory hotunplug
+ */
+void merge_system_ram_resource(struct resource *res)
+{
+	const unsigned long flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
+	struct resource *cur;
+
+	if (WARN_ON_ONCE((res->flags & flags) != flags))
+		return;
+
+	write_lock(&resource_lock);
+	res->flags |= IORESOURCE_SYSRAM_MERGEABLE;
+
+	/* Try to merge with next item in the list. */
+	cur = res->sibling;
+	if (cur && system_ram_resources_mergeable(res, cur)) {
+		res->end = cur->end;
+		res->sibling = cur->sibling;
+		free_resource(cur);
+	}
+
+	/* Try to merge with previous item in the list. */
+	cur = res->parent->child;
+	while (cur && cur->sibling != res)
+		cur = cur->sibling;
+	if (cur && system_ram_resources_mergeable(cur, res)) {
+		cur->end = res->end;
+		cur->sibling = res->sibling;
+		free_resource(res);
+	}
+	write_unlock(&resource_lock);
+}
+#endif	/* CONFIG_MEMORY_HOTPLUG */
+
 /*
  * Managed region resource
  */
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 8f0bd7c9a63a5..553c718226b3e 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1102,6 +1102,13 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 	/* device_online() will take the lock when calling online_pages() */
 	mem_hotplug_done();
 
+	/*
+	 * In case we're allowed to merge the resource, flag it and trigger
+	 * merging now that adding succeeded.
+	 */
+	if (mhp_flags & MEMHP_MERGE_RESOURCE)
+		merge_system_ram_resource(res);
+
 	/* online pages if requested */
 	if (memhp_default_online_type != MMOP_OFFLINE)
 		walk_memory_blocks(start, size, NULL, online_memory_block);
-- 
2.26.2

