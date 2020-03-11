Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41EC71817FF
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Mar 2020 13:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbgCKMax (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 11 Mar 2020 08:30:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53565 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729238AbgCKMax (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 11 Mar 2020 08:30:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583929852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EdxfJCF7xzkoVVDPgtAvv+vhs38SZ2AEeiWuNCr8aIE=;
        b=et1NRAD+od4+2GWcezUi0eI4kUD2zZU5zcsirPV7+oH+GOgBTPEkXjWOcOjr3Ag6CSGrXv
        axhGE67TA3B8kwHfpFsCnV/NWpLqd8ufStDkLCnMM9AApbJT9Sbk+nRoYsH7+OQjl3LN1y
        g802qaio3nbO5fvgEgssTAHw5kz9CBM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-8YruXUlWMsCI7s9QgkT7jw-1; Wed, 11 Mar 2020 08:30:48 -0400
X-MC-Unique: 8YruXUlWMsCI7s9QgkT7jw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9B211084420;
        Wed, 11 Mar 2020 12:30:46 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.36.118.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 74D105C1D4;
        Wed, 11 Mar 2020 12:30:43 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-hyperv@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Baoquan He <bhe@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH v1 3/5] drivers/base/memory: store mapping between MMOP_* and string in an array
Date:   Wed, 11 Mar 2020 13:30:24 +0100
Message-Id: <20200311123026.16071-4-david@redhat.com>
In-Reply-To: <20200311123026.16071-1-david@redhat.com>
References: <20200311123026.16071-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Let's use a simple array which we can reuse soon. While at it, move the
string->mmop conversion out of the device hotplug lock.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Wei Yang <richard.weiyang@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/base/memory.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index e7e77cafef80..8a7f29c0bf97 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -28,6 +28,24 @@
=20
 #define MEMORY_CLASS_NAME	"memory"
=20
+static const char *const online_type_to_str[] =3D {
+	[MMOP_OFFLINE] =3D "offline",
+	[MMOP_ONLINE] =3D "online",
+	[MMOP_ONLINE_KERNEL] =3D "online_kernel",
+	[MMOP_ONLINE_MOVABLE] =3D "online_movable",
+};
+
+static int memhp_online_type_from_str(const char *str)
+{
+	int i;
+
+	for (i =3D 0; i < ARRAY_SIZE(online_type_to_str); i++) {
+		if (sysfs_streq(str, online_type_to_str[i]))
+			return i;
+	}
+	return -EINVAL;
+}
+
 #define to_memory_block(dev) container_of(dev, struct memory_block, dev)
=20
 static int sections_per_block;
@@ -236,26 +254,17 @@ static int memory_subsys_offline(struct device *dev=
)
 static ssize_t state_store(struct device *dev, struct device_attribute *=
attr,
 			   const char *buf, size_t count)
 {
+	const int online_type =3D memhp_online_type_from_str(buf);
 	struct memory_block *mem =3D to_memory_block(dev);
-	int ret, online_type;
+	int ret;
+
+	if (online_type < 0)
+		return -EINVAL;
=20
 	ret =3D lock_device_hotplug_sysfs();
 	if (ret)
 		return ret;
=20
-	if (sysfs_streq(buf, "online_kernel"))
-		online_type =3D MMOP_ONLINE_KERNEL;
-	else if (sysfs_streq(buf, "online_movable"))
-		online_type =3D MMOP_ONLINE_MOVABLE;
-	else if (sysfs_streq(buf, "online"))
-		online_type =3D MMOP_ONLINE;
-	else if (sysfs_streq(buf, "offline"))
-		online_type =3D MMOP_OFFLINE;
-	else {
-		ret =3D -EINVAL;
-		goto err;
-	}
-
 	switch (online_type) {
 	case MMOP_ONLINE_KERNEL:
 	case MMOP_ONLINE_MOVABLE:
@@ -271,7 +280,6 @@ static ssize_t state_store(struct device *dev, struct=
 device_attribute *attr,
 		ret =3D -EINVAL; /* should never happen */
 	}
=20
-err:
 	unlock_device_hotplug();
=20
 	if (ret < 0)
--=20
2.24.1

