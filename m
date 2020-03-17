Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 572B9187EB3
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2020 11:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgCQKu1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 17 Mar 2020 06:50:27 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:28395 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726597AbgCQKu0 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 17 Mar 2020 06:50:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584442225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W1ZItiR0fGCoPQzSFyQeGz8JcCDMjEvAN/mZpA28NqM=;
        b=A9E00r/S3zfJRZJ2gtjUQP7kEymlFHbyyVHqt+y3P0WFeX5bsE5kYutmGUYz7HIyi7Rzzk
        ZJXWPdh9SKcbjWwFKiAz8Z6jmLEuRdLH340xOt76XmYyfjBxTigVc0AgmuLJ2D9MkMRPo2
        w4IbhNu3SKkcg7d6vboT9lapwltq01s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-gaeQSTPxMpOQNYmvpKkHCw-1; Tue, 17 Mar 2020 06:50:22 -0400
X-MC-Unique: gaeQSTPxMpOQNYmvpKkHCw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4644B107ACC7;
        Tue, 17 Mar 2020 10:50:20 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-112-136.ams2.redhat.com [10.36.112.136])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1BDEC73865;
        Tue, 17 Mar 2020 10:50:17 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-hyperv@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Baoquan He <bhe@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH v2 6/8] mm/memory_hotplug: unexport memhp_auto_online
Date:   Tue, 17 Mar 2020 11:49:40 +0100
Message-Id: <20200317104942.11178-7-david@redhat.com>
In-Reply-To: <20200317104942.11178-1-david@redhat.com>
References: <20200317104942.11178-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

All in-tree users except the mm-core are gone. Let's drop the export.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Wei Yang <richard.weiyang@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory_hotplug.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 1a00b5a37ef6..2d2aae830b92 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -71,7 +71,6 @@ bool memhp_auto_online;
 #else
 bool memhp_auto_online =3D true;
 #endif
-EXPORT_SYMBOL_GPL(memhp_auto_online);
=20
 static int __init setup_memhp_default_state(char *str)
 {
--=20
2.24.1

