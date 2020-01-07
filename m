Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D66C132732
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Jan 2020 14:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbgAGNKH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 7 Jan 2020 08:10:07 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39998 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbgAGNKH (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Jan 2020 08:10:07 -0500
Received: by mail-pf1-f194.google.com with SMTP id q8so28591268pfh.7;
        Tue, 07 Jan 2020 05:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L4Z8duDWCUM2mJLHo/CutVp9BmlGq7NQNayTELBVq3A=;
        b=u+mZfaCpsqbZj/Qw4NFdG+qQUVK8y3xMNT891jjwBEJ0Ovf4o8eD5wdRx+GWdDEZuA
         Oh1ShGwM2H3F4rAN5pypzbZB+bO9l6qtbIhVujRbPCGtZ5IqZIXPooE2izUzQ3xh8t6q
         qrWarSRTJPLckE8oJBLwGvIOm8vN8l2UkfQBv78nBu4qQoGQKYNtbZgq4gYoN0dgb6O1
         7C7/4nHK1cNCs/P8sLsRQWCCKcqlv17iVa9uMRfrebtcIZZ/PsgZCWWZ25paQxMv55V3
         Pca0EjRButB+z2+H9PU7pn/4nEVDFs2i6jr5UmfYBDrQkaHfhBNjlUz+tRG8y8xEw2R3
         O1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L4Z8duDWCUM2mJLHo/CutVp9BmlGq7NQNayTELBVq3A=;
        b=n7Ad1KokaSrmwA22RYDN/RWB/94qJzIPSiPNc0EZXb3jmJNUUNyLTLvNez4kn//Fnh
         J+tcwlHGyH0j1ghLdhiNvdtYjgm0hlJvqUhYon4EvIhxnilA0dv/8E/k40OWSshARE/N
         RtZBd8to2GAQ/OHbF/VlTfnu84ixxZZrkVJx46YCfYj2Gkf0gPSy73XignSTq2fR9TkB
         p1QSpZhi8H9GUXsUzbTp2LF2dpzEF7432y+KYze94JvJtkLvFBH6itTt7nwCmmBEakK/
         3lpqqHx6OdKnKrWNRfXS6GFucEP4Z3yve5lezPqkDSm9+oImJsBzCvmrcq4MXBmmWw/i
         xOtA==
X-Gm-Message-State: APjAAAUxxwobcrnyLG8ckp4C554IZSaelKaMrEmlaN0PZpY5BJJrFpqy
        xawSw1piOV1jvQAo/tMSYcM=
X-Google-Smtp-Source: APXvYqzkwOFLqU1282H6O87p4FpwS9gL6cvxA9uCi9krUbs+q7M5ZZG4wdRBe0T4EB5NPImc9YxhAQ==
X-Received: by 2002:aa7:81c7:: with SMTP id c7mr12284472pfn.203.1578402607173;
        Tue, 07 Jan 2020 05:10:07 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.5])
        by smtp.googlemail.com with ESMTPSA id m71sm27522400pje.0.2020.01.07.05.10.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Jan 2020 05:10:06 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, akpm@linux-foundation.org,
        dan.j.williams@intel.com, jgg@ziepe.ca,
        dave.hansen@linux.intel.com, richardw.yang@linux.intel.com,
        namit@vmware.com, Tianyu.Lan@microsoft.com, david@redhat.com,
        christophe.leroy@c-s.fr, michael.h.kelley@microsoft.com
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vkuznets@redhat.com, eric.devolder@oracle.com
Subject: [RFC PATCH V2 1/10] mm/resource: Move child to new resource when release mem region.
Date:   Tue,  7 Jan 2020 21:09:41 +0800
Message-Id: <20200107130950.2983-2-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20200107130950.2983-1-Tianyu.Lan@microsoft.com>
References: <20200107130950.2983-1-Tianyu.Lan@microsoft.com>
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

