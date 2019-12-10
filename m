Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0E5F118CE3
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Dec 2019 16:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfLJPqb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 10 Dec 2019 10:46:31 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36822 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbfLJPqb (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 10 Dec 2019 10:46:31 -0500
Received: by mail-pl1-f193.google.com with SMTP id d15so40410pll.3;
        Tue, 10 Dec 2019 07:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Rhfl0pj5au2KnJmwhjeT97g46p4i/DRaXShR2ok5irQ=;
        b=ogjctMbSOB5Sb9JjVoRGf7ox57Lu/1pkqV8At4y7SRHAPT0c9FrBGsWmqPgHvczTtL
         z6q9kVYaV6WKxVmFm56AOT4b55pUPorEO4eN71kVqYBobcpypfxq0n3MizCEwWW/6spW
         mj8YrFyUwY/Im+qLvrntjDVmZGsGU3STAMyZ4gDWXqf1m0hhgyq4iLEUo5dLldVx8VI+
         6a1MI+EN1sC2mO/nzdEyDvTqGNHilYcrrmwulYkV3sK3I1bfWtcWLUrzhR8ZrNmsaePP
         vYV10k/IUNQJBSb5rwFDavORfULYxmc5/wegGxpN1Te2E+JkdEvrw7tLNkIOKmK/nxmp
         OuJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Rhfl0pj5au2KnJmwhjeT97g46p4i/DRaXShR2ok5irQ=;
        b=NHwC25yNxOzz2rwEucvSVzj2S3kkYx74Pn2G+6nbCz4fcTlNxPIT6pqIeUMUNDzoOX
         kzthheJ/Eo+S0KzvKVbfrixGtElbz6AFlhgMRnC7ofB51ldME1F2bzvvKn3ZHDIwA+Uo
         zTfXROi4kWFe8+6159CfUJn4f3vKzf9JqQOuXRx3yBg0pwxS4supireCXnJDqG67Bjcs
         V0b0/KO+VkHrHRQCm75FTOo0f2SZsEF9XWWeJDaEJweffu2Y/ncwcCelCqST21USqP+X
         T8tnpEKZh/TvUxSoJ3/MSthvk9aUfEO/Bqhx1rSlOZYtA2gLqJ439leO5oyxU8grGWJj
         SMBw==
X-Gm-Message-State: APjAAAUQZVKGrS+mmRzHmSV6NcjVn7VFs2EGy0xrelgkW1RURtYOhvJE
        IAuRF7B7GgM7zIOI3+GyBpc=
X-Google-Smtp-Source: APXvYqwUisIpRC5v3E6jdY7aD+c/0u3eTGW1biMT4kYCSUD9kmjZnHYWUO97ANOmELGjB+FpxrDykA==
X-Received: by 2002:a17:90a:fc94:: with SMTP id ci20mr5918591pjb.6.1575992790504;
        Tue, 10 Dec 2019 07:46:30 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.5])
        by smtp.googlemail.com with ESMTPSA id k13sm4113815pfp.48.2019.12.10.07.46.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Dec 2019 07:46:30 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, akpm@linux-foundation.org,
        dan.j.williams@intel.com, jgg@ziepe.ca,
        dave.hansen@linux.intel.com, david@redhat.com, namit@vmware.com,
        richardw.yang@linux.intel.com, christophe.leroy@c-s.fr,
        tglx@linutronix.de, Tianyu.Lan@microsoft.com, osalvador@suse.de,
        michael.h.kelley@microsoft.com
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vkuznets@redhat.com, eric.devolder@oracle.com
Subject: [RFC PATCH 1/4] mm/resource: Move child to new resource when release mem region.
Date:   Tue, 10 Dec 2019 23:46:08 +0800
Message-Id: <20191210154611.10958-2-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20191210154611.10958-1-Tianyu.Lan@microsoft.com>
References: <20191210154611.10958-1-Tianyu.Lan@microsoft.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

When release mem region, old mem region may be splited to
two regions. Current allocate new struct resource for high
end mem region but not move child resources whose ranges are
in the high end range to new resource. When adjust old mem
region's range, adjust_resource() detects child region's range
is out of new range and return error. Move child resources to
high end resource before adjusting old mem range.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
This patch is to prepare for memory hot-remove function
in Hyper-V balloon driver.
---
 kernel/resource.c | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 76036a41143b..1c7362825134 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -181,6 +181,38 @@ static struct resource *alloc_resource(gfp_t flags)
 	return res;
 }
 
+static void move_child_to_newresource(struct resource *old,
+				      struct resource *new)
+{
+	struct resource *tmp, **p, **np;
+
+	if (!old->child)
+		return;
+
+	p = &old->child;
+	np = &new->child;
+
+	for (;;) {
+		tmp = *p;
+		if (!tmp)
+			break;
+
+		if (tmp->start >= new->start && tmp->end <= new->end) {
+			tmp->parent = new;
+			*np = tmp;
+			np = &tmp->sibling;
+			*p = tmp->sibling;
+
+			if (!tmp->sibling)
+				*np = NULL;
+			continue;
+		}
+
+		p = &tmp->sibling;
+	}
+}
+
+
 /* Return the conflict entry if you can't request it */
 static struct resource * __request_resource(struct resource *root, struct resource *new)
 {
@@ -1246,9 +1278,6 @@ EXPORT_SYMBOL(__release_region);
  * Note:
  * - Additional release conditions, such as overlapping region, can be
  *   supported after they are confirmed as valid cases.
- * - When a busy memory resource gets split into two entries, the code
- *   assumes that all children remain in the lower address entry for
- *   simplicity.  Enhance this logic when necessary.
  */
 int release_mem_region_adjustable(struct resource *parent,
 				  resource_size_t start, resource_size_t size)
@@ -1331,11 +1360,12 @@ int release_mem_region_adjustable(struct resource *parent,
 			new_res->sibling = res->sibling;
 			new_res->child = NULL;
 
+			move_child_to_newresource(res, new_res);
+			res->sibling = new_res;
 			ret = __adjust_resource(res, res->start,
 						start - res->start);
 			if (ret)
 				break;
-			res->sibling = new_res;
 			new_res = NULL;
 		}
 
-- 
2.14.5

