Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9D94187EA6
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2020 11:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgCQKuE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 17 Mar 2020 06:50:04 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:30542 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726329AbgCQKuE (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 17 Mar 2020 06:50:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584442203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/zIoqC9iuXsa5f8/VSxEZwSGgHlkLg8Xk5BlvkskKTA=;
        b=JCg8NkvhTJAzgT0yctm0naF7VQsG9UUKNb1XuYUynfMl4EAqs3+jncuQcejzdi/fPRXakZ
        IaFJCLLzSNTASVKzf5X2T8MRi8eQ82utjWnZI3YOOoIY0et+hE/E8hlxJsT9g67cyKyJd+
        ADhyhmIIA+o5aESnkDI/EGtm19pxxbw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-_Xga-gJhPG62y0Zo0G7AJA-1; Tue, 17 Mar 2020 06:49:59 -0400
X-MC-Unique: _Xga-gJhPG62y0Zo0G7AJA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97A57107ACC4;
        Tue, 17 Mar 2020 10:49:57 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-112-136.ams2.redhat.com [10.36.112.136])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EF78673865;
        Tue, 17 Mar 2020 10:49:51 +0000 (UTC)
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
Subject: [PATCH v2 1/8] drivers/base/memory: rename MMOP_ONLINE_KEEP to MMOP_ONLINE
Date:   Tue, 17 Mar 2020 11:49:35 +0100
Message-Id: <20200317104942.11178-2-david@redhat.com>
In-Reply-To: <20200317104942.11178-1-david@redhat.com>
References: <20200317104942.11178-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The name is misleading and it's not really clear what is "kept". Let's ju=
st
name it like the online_type name we expose to user space ("online").

Add some documentation to the types.

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
 drivers/base/memory.c          | 9 +++++----
 include/linux/memory_hotplug.h | 6 +++++-
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 6448c9ece2cb..8c5ce42c0fc3 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -216,7 +216,7 @@ static int memory_subsys_online(struct device *dev)
 	 * attribute and need to set the online_type.
 	 */
 	if (mem->online_type < 0)
-		mem->online_type =3D MMOP_ONLINE_KEEP;
+		mem->online_type =3D MMOP_ONLINE;
=20
 	ret =3D memory_block_change_state(mem, MEM_ONLINE, MEM_OFFLINE);
=20
@@ -251,7 +251,7 @@ static ssize_t state_store(struct device *dev, struct=
 device_attribute *attr,
 	else if (sysfs_streq(buf, "online_movable"))
 		online_type =3D MMOP_ONLINE_MOVABLE;
 	else if (sysfs_streq(buf, "online"))
-		online_type =3D MMOP_ONLINE_KEEP;
+		online_type =3D MMOP_ONLINE;
 	else if (sysfs_streq(buf, "offline"))
 		online_type =3D MMOP_OFFLINE;
 	else {
@@ -262,7 +262,7 @@ static ssize_t state_store(struct device *dev, struct=
 device_attribute *attr,
 	switch (online_type) {
 	case MMOP_ONLINE_KERNEL:
 	case MMOP_ONLINE_MOVABLE:
-	case MMOP_ONLINE_KEEP:
+	case MMOP_ONLINE:
 		/* mem->online_type is protected by device_hotplug_lock */
 		mem->online_type =3D online_type;
 		ret =3D device_online(&mem->dev);
@@ -342,7 +342,8 @@ static ssize_t valid_zones_show(struct device *dev,
 	}
=20
 	nid =3D mem->nid;
-	default_zone =3D zone_for_pfn_range(MMOP_ONLINE_KEEP, nid, start_pfn, n=
r_pages);
+	default_zone =3D zone_for_pfn_range(MMOP_ONLINE, nid, start_pfn,
+					  nr_pages);
 	strcat(buf, default_zone->name);
=20
 	print_allowed_zone(buf, nid, start_pfn, nr_pages, MMOP_ONLINE_KERNEL,
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplu=
g.h
index f4d59155f3d4..261dbf010d5d 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -47,9 +47,13 @@ enum {
=20
 /* Types for control the zone type of onlined and offlined memory */
 enum {
+	/* Offline the memory. */
 	MMOP_OFFLINE =3D -1,
-	MMOP_ONLINE_KEEP,
+	/* Online the memory. Zone depends, see default_zone_for_pfn(). */
+	MMOP_ONLINE,
+	/* Online the memory to ZONE_NORMAL. */
 	MMOP_ONLINE_KERNEL,
+	/* Online the memory to ZONE_MOVABLE. */
 	MMOP_ONLINE_MOVABLE,
 };
=20
--=20
2.24.1

