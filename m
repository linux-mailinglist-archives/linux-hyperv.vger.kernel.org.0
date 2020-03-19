Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6BF18B78D
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2020 14:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgCSNeQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 19 Mar 2020 09:34:16 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:55169 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729071AbgCSNND (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 19 Mar 2020 09:13:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584623583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=38am6RN7Bm2kfcXgkJSkgPaR6wvQXg6WIoFGRH6C3xg=;
        b=aUXVd44WLGDh0pG0HZ7LeqNMjL8f+/j/e6uGvCwLYYX0DKd23uIVOZorfntEaP+YE4KmKB
        1m+Y3EtNyLt0fL/dBW+lqYGyN7wTw9Z3AhzqplktFwpOiLgXFJfXpjhX+kBwLSC0MY9GEi
        A7g+Rm782AfbhKZhJSJ7s94u/ouR7NE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-E-o1ezAiPpKpEayhPcdwgg-1; Thu, 19 Mar 2020 09:12:59 -0400
X-MC-Unique: E-o1ezAiPpKpEayhPcdwgg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B32DD18B9FC2;
        Thu, 19 Mar 2020 13:12:57 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-197.ams2.redhat.com [10.36.114.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5FAEF60BF7;
        Thu, 19 Mar 2020 13:12:55 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-hyperv@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v3 6/8] mm/memory_hotplug: unexport memhp_auto_online
Date:   Thu, 19 Mar 2020 14:12:19 +0100
Message-Id: <20200319131221.14044-7-david@redhat.com>
In-Reply-To: <20200319131221.14044-1-david@redhat.com>
References: <20200319131221.14044-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

All in-tree users except the mm-core are gone. Let's drop the export.

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
Acked-by: Michal Hocko <mhocko@suse.com>
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
index da6aab272c9b..e21a7d53ade5 100644
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

