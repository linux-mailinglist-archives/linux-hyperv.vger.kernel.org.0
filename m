Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7E0918B78A
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2020 14:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgCSNeI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 19 Mar 2020 09:34:08 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:32608 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729021AbgCSNNH (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 19 Mar 2020 09:13:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584623586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hug7N4Cth2nyuPVB2cR8bkZ13Z+7sswcZX+QhUXG/m0=;
        b=Yvl+m/Rt7rlR5fCHX3AX0RajDMBYrMQYJjVfQcFliBledpSWYPMYBX8WAfhFXJ0ZvkhA1C
        +fIxqqrzIaovLDXcYcuym1gr5nOwCn5cF8ZrWoZI1eIuGlWFBrFxbTMLsC9wCdekjdFJ6f
        /fkQX70poE/j9vQIOgv/+oiS5/4wiq4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-XvjAh0FOMKWQ3YdjQvC3bA-1; Thu, 19 Mar 2020 09:13:02 -0400
X-MC-Unique: XvjAh0FOMKWQ3YdjQvC3bA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CF5DDBA3;
        Thu, 19 Mar 2020 13:13:00 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-197.ams2.redhat.com [10.36.114.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0EA0B60BF7;
        Thu, 19 Mar 2020 13:12:57 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-hyperv@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v3 7/8] mm/memory_hotplug: convert memhp_auto_online to store an online_type
Date:   Thu, 19 Mar 2020 14:12:20 +0100
Message-Id: <20200319131221.14044-8-david@redhat.com>
In-Reply-To: <20200319131221.14044-1-david@redhat.com>
References: <20200319131221.14044-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

... and rename it to memhp_default_online_type. This is a preparation
for more detailed default online behavior.

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Wei Yang <richard.weiyang@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/base/memory.c          | 10 ++++------
 include/linux/memory_hotplug.h |  3 ++-
 mm/memory_hotplug.c            | 11 ++++++-----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 8a7f29c0bf97..8d3e16dab69f 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -386,10 +386,8 @@ static DEVICE_ATTR_RO(block_size_bytes);
 static ssize_t auto_online_blocks_show(struct device *dev,
 				       struct device_attribute *attr, char *buf)
 {
-	if (memhp_auto_online)
-		return sprintf(buf, "online\n");
-	else
-		return sprintf(buf, "offline\n");
+	return sprintf(buf, "%s\n",
+		       online_type_to_str[memhp_default_online_type]);
 }
=20
 static ssize_t auto_online_blocks_store(struct device *dev,
@@ -397,9 +395,9 @@ static ssize_t auto_online_blocks_store(struct device=
 *dev,
 					const char *buf, size_t count)
 {
 	if (sysfs_streq(buf, "online"))
-		memhp_auto_online =3D true;
+		memhp_default_online_type =3D MMOP_ONLINE;
 	else if (sysfs_streq(buf, "offline"))
-		memhp_auto_online =3D false;
+		memhp_default_online_type =3D MMOP_OFFLINE;
 	else
 		return -EINVAL;
=20
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplu=
g.h
index 76f3c617a8ab..6d6f85bb66e9 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -118,7 +118,8 @@ extern int arch_add_memory(int nid, u64 start, u64 si=
ze,
 			   struct mhp_params *params);
 extern u64 max_mem_size;
=20
-extern bool memhp_auto_online;
+/* Default online_type (MMOP_*) when new memory blocks are added. */
+extern int memhp_default_online_type;
 /* If movable_node boot option specified */
 extern bool movable_node_enabled;
 static inline bool movable_node_is_enabled(void)
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index e21a7d53ade5..4efcf8cb9ac5 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -67,17 +67,17 @@ void put_online_mems(void)
 bool movable_node_enabled =3D false;
=20
 #ifndef CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE
-bool memhp_auto_online;
+int memhp_default_online_type =3D MMOP_OFFLINE;
 #else
-bool memhp_auto_online =3D true;
+int memhp_default_online_type =3D MMOP_ONLINE;
 #endif
=20
 static int __init setup_memhp_default_state(char *str)
 {
 	if (!strcmp(str, "online"))
-		memhp_auto_online =3D true;
+		memhp_default_online_type =3D MMOP_ONLINE;
 	else if (!strcmp(str, "offline"))
-		memhp_auto_online =3D false;
+		memhp_default_online_type =3D MMOP_OFFLINE;
=20
 	return 1;
 }
@@ -993,6 +993,7 @@ static int check_hotplug_memory_range(u64 start, u64 =
size)
=20
 static int online_memory_block(struct memory_block *mem, void *arg)
 {
+	mem->online_type =3D memhp_default_online_type;
 	return device_online(&mem->dev);
 }
=20
@@ -1065,7 +1066,7 @@ int __ref add_memory_resource(int nid, struct resou=
rce *res)
 	mem_hotplug_done();
=20
 	/* online pages if requested */
-	if (memhp_auto_online)
+	if (memhp_default_online_type !=3D MMOP_OFFLINE)
 		walk_memory_blocks(start, size, NULL, online_memory_block);
=20
 	return ret;
--=20
2.24.1

