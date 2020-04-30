Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14C731BF571
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Apr 2020 12:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbgD3K37 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 30 Apr 2020 06:29:59 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46254 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726857AbgD3K35 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 30 Apr 2020 06:29:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588242596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cBxdneYzv1oFt6rUtmxHP8L8tmn6FMG5Rn0MO+hCbf0=;
        b=GRc1AOxPVSP5nuHEWrXjyi/msXQ0zbqJmYJrnrUMnBMgWRZeMevzIvGaFLkugFIFcgkVrV
        QVgvBqje0bXGeEMvcM98GRSr1ODO6I1j6l2GA54ykkDm7wIHNH/tL3iW/6Q7blEJBradq6
        erGTZhdH6d8APCUbHXTN2O1RqAEuTzA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-ZkDsTUQ-OxW7sjqOoV_anw-1; Thu, 30 Apr 2020 06:29:51 -0400
X-MC-Unique: ZkDsTUQ-OxW7sjqOoV_anw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 920BB45F;
        Thu, 30 Apr 2020 10:29:49 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-172.ams2.redhat.com [10.36.113.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B43035EDEB;
        Thu, 30 Apr 2020 10:29:40 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, virtio-dev@lists.oasis-open.org,
        virtualization@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-hyperv@vger.kernel.org,
        linux-s390@vger.kernel.org, xen-devel@lists.xenproject.org,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Baoquan He <bhe@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH v2 2/3] mm/memory_hotplug: Introduce MHP_NO_FIRMWARE_MEMMAP
Date:   Thu, 30 Apr 2020 12:29:07 +0200
Message-Id: <20200430102908.10107-3-david@redhat.com>
In-Reply-To: <20200430102908.10107-1-david@redhat.com>
References: <20200430102908.10107-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Some devices/drivers that add memory via add_memory() and friends (e.g.,
dax/kmem, but also virtio-mem in the future) don't want to create entries
in /sys/firmware/memmap/ - primarily to hinder kexec from adding this
memory to the boot memmap of the kexec kernel.

In fact, such memory is never exposed via the firmware memmap as System
RAM (e.g., e820), so exposing this memory via /sys/firmware/memmap/ is
wrong:
 "kexec needs the raw firmware-provided memory map to setup the
  parameter segment of the kernel that should be booted with
  kexec. Also, the raw memory map is useful for debugging. For
  that reason, /sys/firmware/memmap is an interface that provides
  the raw memory map to userspace." [1]

We don't have to worry about firmware_map_remove() on the removal path.
If there is no entry, it will simply return with -EINVAL.

[1] https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-firmware-m=
emmap

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Wei Yang <richard.weiyang@gmail.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/memory_hotplug.h | 8 ++++++++
 mm/memory_hotplug.c            | 3 ++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplu=
g.h
index 0151fb935c09..4ca418a731eb 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -68,6 +68,14 @@ struct mhp_params {
 	pgprot_t pgprot;
 };
=20
+/* Flags used for add_memory() and friends. */
+
+/*
+ * Don't create entries in /sys/firmware/memmap/. The memory is detected=
 and
+ * added via a device driver, not via the initial (firmware) memmap.
+ */
+#define MHP_NO_FIRMWARE_MEMMAP		1
+
 /*
  * Zone resizing functions
  *
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index c01be92693e3..e94ede9cad00 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1062,7 +1062,8 @@ int __ref add_memory_resource(int nid, struct resou=
rce *res,
 	BUG_ON(ret);
=20
 	/* create new memmap entry */
-	firmware_map_add_hotplug(start, start + size, "System RAM");
+	if (!(flags & MHP_NO_FIRMWARE_MEMMAP))
+		firmware_map_add_hotplug(start, start + size, "System RAM");
=20
 	/* device_online() will take the lock when calling online_pages() */
 	mem_hotplug_done();
--=20
2.25.3

