Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE77187EBA
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2020 11:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgCQKuf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 17 Mar 2020 06:50:35 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:49054 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726678AbgCQKuf (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 17 Mar 2020 06:50:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584442233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Xl1YbByyYFiK6yfX6MmnHGP4uzRrFgfV39buVPYxCU=;
        b=HGaqh0MBKRh249HTC/7BHv6fkaI7UimBOnpNIYbg899CqSXrv5zoNDLXdtdao5+lUGOlpr
        tBoG+MTRbyUu1jMLe6kN+UN6K6KJ4GraoAak15uz+BzOhT6TVpK+7p3W1FGRMFVMwz6eC5
        bTeQlr3GJJUtSSt6cTNqwaK29R4TgOU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-rOenjaorNYCyOoJ8e97dKw-1; Tue, 17 Mar 2020 06:50:30 -0400
X-MC-Unique: rOenjaorNYCyOoJ8e97dKw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E8B8800D53;
        Tue, 17 Mar 2020 10:50:28 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-112-136.ams2.redhat.com [10.36.112.136])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 44EFB93531;
        Tue, 17 Mar 2020 10:50:23 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-hyperv@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 8/8] mm/memory_hotplug: allow to specify a default online_type
Date:   Tue, 17 Mar 2020 11:49:42 +0100
Message-Id: <20200317104942.11178-9-david@redhat.com>
In-Reply-To: <20200317104942.11178-1-david@redhat.com>
References: <20200317104942.11178-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

For now, distributions implement advanced udev rules to essentially
- Don't online any hotplugged memory (s390x)
- Online all memory to ZONE_NORMAL (e.g., most virt environments like
  hyperv)
- Online all memory to ZONE_MOVABLE in case the zone imbalance is taken
  care of (e.g., bare metal, special virt environments)

In summary: All memory is usually onlined the same way, however, the
kernel always has to ask user space to come up with the same answer.
E.g., Hyper-V always waits for a memory block to get onlined before
continuing, otherwise it might end up adding memory faster than
hotplugging it, which can result in strange OOM situations. This waiting
slows down adding of a bigger amount of memory.

Let's allow to specify a default online_type, not just "online" and
"offline". This allows distributions to configure the default online_type
when booting up and be done with it.

We can now specify "offline", "online", "online_movable" and
"online_kernel" via
- "memhp_default_state=3D" on the kernel cmdline
- /sys/devices/system/memory/auto_online_blocks
just like we are able to specify for a single memory block via
/sys/devices/system/memory/memoryX/state

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Wei Yang <richard.weiyang@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/base/memory.c          | 11 +++++------
 include/linux/memory_hotplug.h |  2 ++
 mm/memory_hotplug.c            |  8 ++++----
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 8d3e16dab69f..2b09b68b9f78 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -35,7 +35,7 @@ static const char *const online_type_to_str[] =3D {
 	[MMOP_ONLINE_MOVABLE] =3D "online_movable",
 };
=20
-static int memhp_online_type_from_str(const char *str)
+int memhp_online_type_from_str(const char *str)
 {
 	int i;
=20
@@ -394,13 +394,12 @@ static ssize_t auto_online_blocks_store(struct devi=
ce *dev,
 					struct device_attribute *attr,
 					const char *buf, size_t count)
 {
-	if (sysfs_streq(buf, "online"))
-		memhp_default_online_type =3D MMOP_ONLINE;
-	else if (sysfs_streq(buf, "offline"))
-		memhp_default_online_type =3D MMOP_OFFLINE;
-	else
+	const int online_type =3D memhp_online_type_from_str(buf);
+
+	if (online_type < 0)
 		return -EINVAL;
=20
+	memhp_default_online_type =3D online_type;
 	return count;
 }
=20
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplu=
g.h
index c6e090b34c4b..ef55115320fb 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -117,6 +117,8 @@ extern int arch_add_memory(int nid, u64 start, u64 si=
ze,
 			struct mhp_restrictions *restrictions);
 extern u64 max_mem_size;
=20
+extern int memhp_online_type_from_str(const char *str);
+
 /* Default online_type (MMOP_*) when new memory blocks are added. */
 extern int memhp_default_online_type;
 /* If movable_node boot option specified */
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 1975a2b99a2b..9916977b6ee1 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -74,10 +74,10 @@ int memhp_default_online_type =3D MMOP_ONLINE;
=20
 static int __init setup_memhp_default_state(char *str)
 {
-	if (!strcmp(str, "online"))
-		memhp_default_online_type =3D MMOP_ONLINE;
-	else if (!strcmp(str, "offline"))
-		memhp_default_online_type =3D MMOP_OFFLINE;
+	const int online_type =3D memhp_online_type_from_str(str);
+
+	if (online_type >=3D 0)
+		memhp_default_online_type =3D online_type;
=20
 	return 1;
 }
--=20
2.24.1

