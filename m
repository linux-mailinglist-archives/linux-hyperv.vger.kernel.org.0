Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEBD1BE36D
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2020 18:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgD2QIu (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 29 Apr 2020 12:08:50 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26045 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726853AbgD2QIt (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 29 Apr 2020 12:08:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588176527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uhuWZGDE9ZNfsUlRzjnVfD2BmrQPIPuqvz9+u5pM+h4=;
        b=iAt9ZbRTwyAierkY82djN/bjTNfedMKw9wi6s7saue4KzVLJOa/zuKTdkryJJzrip1GMEc
        2kIMs8u6KjBBxqt1la983q/woNfO3s+A7pMf9wGV4arVFvhMSmMB8c61nYK+o+n2gi2DpF
        7MHEPZuPmq8FUwIV9dgkLqVG2s+QuyE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-JfUNgq6rMea1vtiPscJa6Q-1; Wed, 29 Apr 2020 12:08:43 -0400
X-MC-Unique: JfUNgq6rMea1vtiPscJa6Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C4CC462;
        Wed, 29 Apr 2020 16:08:41 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-55.ams2.redhat.com [10.36.114.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7BC8E60621;
        Wed, 29 Apr 2020 16:08:32 +0000 (UTC)
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
Subject: [PATCH v1 2/3] mm/memory_hotplug: Introduce MHP_DRIVER_MANAGED
Date:   Wed, 29 Apr 2020 18:08:02 +0200
Message-Id: <20200429160803.109056-3-david@redhat.com>
In-Reply-To: <20200429160803.109056-1-david@redhat.com>
References: <20200429160803.109056-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Some paravirtualized devices that add memory via add_memory() and
friends (esp. virtio-mem) don't want to create entries in
/sys/firmware/memmap/ - primarily to hinder kexec from adding this
memory to the boot memmap of the kexec kernel.

In fact, such memory is never exposed via the firmware (e.g., e820), but
only via the device, so exposing this memory via /sys/firmware/memmap/ is
wrong:
 "kexec needs the raw firmware-provided memory map to setup the
  parameter segment of the kernel that should be booted with
  kexec. Also, the raw memory map is useful for debugging. For
  that reason, /sys/firmware/memmap is an interface that provides
  the raw memory map to userspace." [1]

We want to let user space know that memory which is always detected,
added, and managed via a (device) driver - like memory managed by
virtio-mem - is special. It cannot be used for placing kexec segments
and the (device) driver is responsible for re-adding memory that
(eventually shrunk/grown/defragmented) memory after a reboot/kexec. It
should e.g., not be added to a fixed up firmware memmap. However, it shou=
ld
be dumped by kdump.

Also, such memory could behave differently than an ordinary DIMM - e.g.,
memory managed by virtio-mem can have holes inside added memory resource,
which should not be touched, especially for writing.

Let's expose that memory as "System RAM (driver managed)" e.g., via
/pro/iomem.

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
 include/linux/memory_hotplug.h |  8 ++++++++
 mm/memory_hotplug.c            | 20 ++++++++++++++++----
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplu=
g.h
index bf0e3edb8688..cc538584b39e 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -68,6 +68,14 @@ struct mhp_params {
 	pgprot_t pgprot;
 };
=20
+/* Flags used for add_memory() and friends. */
+
+/*
+ * Don't create entries in /sys/firmware/memmap/ and expose memory as
+ * "System RAM (driver managed)" in e.g., /proc/iomem
+ */
+#define MHP_DRIVER_MANAGED		1
+
 /*
  * Zone resizing functions
  *
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index ebdf6541d074..cfa0721280aa 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -98,11 +98,11 @@ void mem_hotplug_done(void)
 u64 max_mem_size =3D U64_MAX;
=20
 /* add this memory to iomem resource */
-static struct resource *register_memory_resource(u64 start, u64 size)
+static struct resource *register_memory_resource(u64 start, u64 size,
+						 const char *resource_name)
 {
 	struct resource *res;
 	unsigned long flags =3D  IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
-	char *resource_name =3D "System RAM";
=20
 	/*
 	 * Make sure value parsed from 'mem=3D' only restricts memory adding
@@ -1058,7 +1058,8 @@ int __ref add_memory_resource(int nid, struct resou=
rce *res,
 	BUG_ON(ret);
=20
 	/* create new memmap entry */
-	firmware_map_add_hotplug(start, start + size, "System RAM");
+	if (!(flags & MHP_DRIVER_MANAGED))
+		firmware_map_add_hotplug(start, start + size, "System RAM");
=20
 	/* device_online() will take the lock when calling online_pages() */
 	mem_hotplug_done();
@@ -1081,10 +1082,21 @@ int __ref add_memory_resource(int nid, struct res=
ource *res,
 /* requires device_hotplug_lock, see add_memory_resource() */
 int __ref __add_memory(int nid, u64 start, u64 size, unsigned long flags=
)
 {
+	const char *resource_name =3D "System RAM";
 	struct resource *res;
 	int ret;
=20
-	res =3D register_memory_resource(start, size);
+	/*
+	 * Indicate that memory managed by a driver is special. It's always
+	 * detected and added via a driver, should not be given to the kexec
+	 * kernel for booting when manually crafting the firmware memmap, and
+	 * no kexec segments should be placed on it. However, kdump should
+	 * dump this memory.
+	 */
+	if (flags & MHP_DRIVER_MANAGED)
+		resource_name =3D "System RAM (driver managed)";
+
+	res =3D register_memory_resource(start, size, resource_name);
 	if (IS_ERR(res))
 		return PTR_ERR(res);
=20
--=20
2.25.3

