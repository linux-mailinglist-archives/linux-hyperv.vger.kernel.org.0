Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50244264145
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Sep 2020 11:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgIJJQm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 10 Sep 2020 05:16:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30747 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730240AbgIJJOs (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 10 Sep 2020 05:14:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599729283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UKbsrpgJcVk/I/seBIDa5mjqSR3CWWtNLQlSkA+xweM=;
        b=NO/Pwa1b+vp7qL8VJNUOz0fPOG3S7afG4YBaXrdmUdmTS8inIY1tK5jrEICAnpD7QdlnSb
        OU/EHfdPEyneZFUj0G6Y38D53JwXwG5YdqlF/jiaJXAKeL0TGklvklljv/FKfpL1bhM6F+
        n1i3n/snvGXpPWHEWkIRnfkevgZnvx0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-4Ir0pFWkOr2SyXBA0eB5IQ-1; Thu, 10 Sep 2020 05:14:39 -0400
X-MC-Unique: 4Ir0pFWkOr2SyXBA0eB5IQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DEF4E18B9F11;
        Thu, 10 Sep 2020 09:14:37 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-88.ams2.redhat.com [10.36.113.88])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9B8ED1A8EC;
        Thu, 10 Sep 2020 09:14:34 +0000 (UTC)
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
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Baoquan He <bhe@redhat.com>,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH v3 5/7] virtio-mem: try to merge system ram resources
Date:   Thu, 10 Sep 2020 11:13:38 +0200
Message-Id: <20200910091340.8654-6-david@redhat.com>
In-Reply-To: <20200910091340.8654-1-david@redhat.com>
References: <20200910091340.8654-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

virtio-mem adds memory in memory block granularity, to be able to
remove it in the same granularity again later, and to grow slowly on
demand. This, however, results in quite a lot of resources when
adding a lot of memory. Resources are effectively stored in a list-based
tree. Having a lot of resources not only wastes memory, it also makes
traversing that tree more expensive, and makes /proc/iomem explode in
size (e.g., requiring kexec-tools to manually merge resources later
when e.g., trying to create a kdump header).

Before this patch, we get (/proc/iomem) when hotplugging 2G via virtio-mem
on x86-64:
        [...]
        100000000-13fffffff : System RAM
        140000000-33fffffff : virtio0
          140000000-147ffffff : System RAM (virtio_mem)
          148000000-14fffffff : System RAM (virtio_mem)
          150000000-157ffffff : System RAM (virtio_mem)
          158000000-15fffffff : System RAM (virtio_mem)
          160000000-167ffffff : System RAM (virtio_mem)
          168000000-16fffffff : System RAM (virtio_mem)
          170000000-177ffffff : System RAM (virtio_mem)
          178000000-17fffffff : System RAM (virtio_mem)
          180000000-187ffffff : System RAM (virtio_mem)
          188000000-18fffffff : System RAM (virtio_mem)
          190000000-197ffffff : System RAM (virtio_mem)
          198000000-19fffffff : System RAM (virtio_mem)
          1a0000000-1a7ffffff : System RAM (virtio_mem)
          1a8000000-1afffffff : System RAM (virtio_mem)
          1b0000000-1b7ffffff : System RAM (virtio_mem)
          1b8000000-1bfffffff : System RAM (virtio_mem)
        3280000000-32ffffffff : PCI Bus 0000:00

With this patch, we get (/proc/iomem):
        [...]
        fffc0000-ffffffff : Reserved
        100000000-13fffffff : System RAM
        140000000-33fffffff : virtio0
          140000000-1bfffffff : System RAM (virtio_mem)
        3280000000-32ffffffff : PCI Bus 0000:00

Of course, with more hotplugged memory, it gets worse. When unplugging
memory blocks again, try_remove_memory() (via
offline_and_remove_memory()) will properly split the resource up again.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index ed99e43354010..ba4de598f6636 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -424,7 +424,8 @@ static int virtio_mem_mb_add(struct virtio_mem *vm, unsigned long mb_id)
 
 	dev_dbg(&vm->vdev->dev, "adding memory block: %lu\n", mb_id);
 	return add_memory_driver_managed(nid, addr, memory_block_size_bytes(),
-					 vm->resource_name, MHP_NONE);
+					 vm->resource_name,
+					 MEMHP_MERGE_RESOURCE);
 }
 
 /*
-- 
2.26.2

