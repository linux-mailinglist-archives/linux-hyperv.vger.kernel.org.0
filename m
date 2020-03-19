Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D98518B792
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2020 14:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbgCSNM5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 19 Mar 2020 09:12:57 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:26227 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729027AbgCSNM4 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 19 Mar 2020 09:12:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584623575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JlnwwL4csnhrfpFsCAW7BWsCLUc5f6XxMI4ECvmcmKg=;
        b=MhELTk5hyA655r8QYFw8AxHpPnxSJsnuaZdWgTSs4HjnU4mbZUA5uJiAcHjOhuvHIG6XIM
        XXa4jPXMxvApYaeXiqFUZDD84BS+5v6T6rpRMSpnlkg50EJOL2aXQiOeNHCAOr4Wcvqr6q
        KVbOkdquh5AomQNdwqEkAdaysyYMrA0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-zo0jgjcNNi6uvY7zDpcOsg-1; Thu, 19 Mar 2020 09:12:51 -0400
X-MC-Unique: zo0jgjcNNi6uvY7zDpcOsg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5394F801E74;
        Thu, 19 Mar 2020 13:12:49 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-197.ams2.redhat.com [10.36.114.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C1CF60BF7;
        Thu, 19 Mar 2020 13:12:43 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-hyperv@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v3 4/8] powernv/memtrace: always online added memory blocks
Date:   Thu, 19 Mar 2020 14:12:17 +0100
Message-Id: <20200319131221.14044-5-david@redhat.com>
In-Reply-To: <20200319131221.14044-1-david@redhat.com>
References: <20200319131221.14044-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Let's always try to online the re-added memory blocks. In case add_memory=
()
already onlined the added memory blocks, the first device_online() call
will fail and stop processing the remaining memory blocks.

This avoids manually having to check memhp_auto_online.

Note: PPC always onlines all hotplugged memory directly from the kernel
as well - something that is handled by user space on other
architectures.

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Wei Yang <richard.weiyang@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/powerpc/platforms/powernv/memtrace.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/memtrace.c b/arch/powerpc/pla=
tforms/powernv/memtrace.c
index d6d64f8718e6..13b369d2cc45 100644
--- a/arch/powerpc/platforms/powernv/memtrace.c
+++ b/arch/powerpc/platforms/powernv/memtrace.c
@@ -231,16 +231,10 @@ static int memtrace_online(void)
 			continue;
 		}
=20
-		/*
-		 * If kernel isn't compiled with the auto online option
-		 * we need to online the memory ourselves.
-		 */
-		if (!memhp_auto_online) {
-			lock_device_hotplug();
-			walk_memory_blocks(ent->start, ent->size, NULL,
-					   online_mem_block);
-			unlock_device_hotplug();
-		}
+		lock_device_hotplug();
+		walk_memory_blocks(ent->start, ent->size, NULL,
+				   online_mem_block);
+		unlock_device_hotplug();
=20
 		/*
 		 * Memory was added successfully so clean up references to it
--=20
2.24.1

