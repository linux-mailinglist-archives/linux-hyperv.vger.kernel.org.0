Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC7521817FE
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Mar 2020 13:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbgCKMau (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 11 Mar 2020 08:30:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20925 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729239AbgCKMat (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 11 Mar 2020 08:30:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583929848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UUlE+YB0rqBWRKtiAZBO49OVQNayl/pvbY6RAY5FLgE=;
        b=ikbCbfbf8F06UsFPK32Lhv6LCMJY+Cjcffwjjsi+mngosauAQUwTYmaJ6e8vyy9SGQ3Ap3
        aV8w+sZkNYZN0u0r12lGxE8wbpOXlI9COymY1tglwQCySvMPSlMlXynQxFOvDmnVNcvKbu
        aaJ5QC/avVgvOFDlN16G4sOijNVZ+oM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-UdNuObYhN5-vHqPlUF5hbg-1; Wed, 11 Mar 2020 08:30:44 -0400
X-MC-Unique: UdNuObYhN5-vHqPlUF5hbg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B1CA801E53;
        Wed, 11 Mar 2020 12:30:43 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.36.118.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BAF6B5C1D4;
        Wed, 11 Mar 2020 12:30:40 +0000 (UTC)
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
Subject: [PATCH v1 2/5] drivers/base/memory: map MMOP_OFFLINE to 0
Date:   Wed, 11 Mar 2020 13:30:23 +0100
Message-Id: <20200311123026.16071-3-david@redhat.com>
In-Reply-To: <20200311123026.16071-1-david@redhat.com>
References: <20200311123026.16071-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

I have no idea why we have to start at -1. Just treat 0 as the special
case. Clarify a comment (which was wrong, when we come via
device_online() the first time, the online_type would have been 0 /
MEM_ONLINE). The default is now always MMOP_OFFLINE.

This is a preparation to use the online_type as an array index.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Wei Yang <richard.weiyang@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/base/memory.c          | 11 ++++-------
 include/linux/memory_hotplug.h |  2 +-
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 8c5ce42c0fc3..e7e77cafef80 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -211,17 +211,14 @@ static int memory_subsys_online(struct device *dev)
 		return 0;
=20
 	/*
-	 * If we are called from state_store(), online_type will be
-	 * set >=3D 0 Otherwise we were called from the device online
-	 * attribute and need to set the online_type.
+	 * When called via device_online() without configuring the online_type,
+	 * we want to default to MMOP_ONLINE.
 	 */
-	if (mem->online_type < 0)
+	if (mem->online_type =3D=3D MMOP_OFFLINE)
 		mem->online_type =3D MMOP_ONLINE;
=20
 	ret =3D memory_block_change_state(mem, MEM_ONLINE, MEM_OFFLINE);
-
-	/* clear online_type */
-	mem->online_type =3D -1;
+	mem->online_type =3D MMOP_OFFLINE;
=20
 	return ret;
 }
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplu=
g.h
index 261dbf010d5d..c2e06ed5e0e9 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -48,7 +48,7 @@ enum {
 /* Types for control the zone type of onlined and offlined memory */
 enum {
 	/* Offline the memory. */
-	MMOP_OFFLINE =3D -1,
+	MMOP_OFFLINE =3D 0,
 	/* Online the memory. Zone depends, see default_zone_for_pfn(). */
 	MMOP_ONLINE,
 	/* Online the memory to ZONE_NORMAL. */
--=20
2.24.1

