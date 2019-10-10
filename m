Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB99D21DD
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Oct 2019 09:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732993AbfJJHiJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 10 Oct 2019 03:38:09 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45188 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732926AbfJJH3I (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 10 Oct 2019 03:29:08 -0400
Received: by mail-pl1-f194.google.com with SMTP id u12so2331058pls.12;
        Thu, 10 Oct 2019 00:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZRrVLXwmpo4xQzXPyPqYPbJsiga9xziaedvCp7FhOE0=;
        b=FDDOEmTJXVTCe/j4jUtg65bcxfOZ96Hb33qWjaE8DKhPm28ZhA5kCRW9NXghUcH+me
         KTvCIX5X6m6l1j32jnPXL8/8twUioHrEAk+IshxyxXsavy2lx/PUL4hic5U4LHFgVaUn
         fa621I3JVaSQyZTwoEKxyH8LGpY2gBRl6jWfk76q/megCp34fZwcsCJ+Tbk287tivvk+
         o6qmbAfIiBAaLa+eOXhSYPl3w1vjPUuDsYLca27EuDknhq7VAsKxLOOa3sf6L88eXku3
         FGhmyiLnh53HUF06rIrC1RQT0iTGjr3eommjmnLRNpBf2Am1U7F9o59qwy81suDSpV75
         1EPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZRrVLXwmpo4xQzXPyPqYPbJsiga9xziaedvCp7FhOE0=;
        b=dx1UtC/dr30NmH8jPDTaowHtrzkomq59IC+cLd2Q75eYnbxHXBJjdl+E9mGbRQ6DP8
         F6f7AEcawmTn+zT5DKDlEF5ZzCz5BlRf8vwVdYAEckmQMT5e9gQ5hPx/MhCzZsY4D79l
         WffbvHdN+diLC7XSx1NF1Nu7p3u6FoTu5s4grZvO4XHa+ajtkGarlqbAEpyg2Tnyv0IL
         RHnuQrkWG9BnybyqhRNZvqcek2kDXkxOQIR06N5iGaa1smllOzIfSu01Bess3K0X05Oy
         u9oV0yaReIce4s2nug1KWbz6Jv0iL+r3sEZvMYLuTR44WLqDVn0GBPBZSLrjw1rK5q8i
         63FA==
X-Gm-Message-State: APjAAAW+ZZa4+kdaDJ4Vj+N2L0Arm7m+6+HjD2Y1wD5zOlod9d8i+l1T
        xQ4XZ9xINh1Z/7QS+HtRKpQ=
X-Google-Smtp-Source: APXvYqyn0W2pI1YMiNV1UgZzss1HUG1vYlIM7U9NlK7YdxNTCuDuWlIW4Ge1hh0t3JyUP1nKi9G1uQ==
X-Received: by 2002:a17:902:47:: with SMTP id 65mr7783959pla.94.1570692548062;
        Thu, 10 Oct 2019 00:29:08 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([167.220.255.39])
        by smtp.googlemail.com with ESMTPSA id v8sm12673274pje.6.2019.10.10.00.29.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Oct 2019 00:29:07 -0700 (PDT)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     dan.j.williams@intel.com, dave.hansen@linux.intel.com,
        mingo@kernel.org, mpe@ellerman.id.au, pasha.tatashin@soleen.com,
        osalvador@suse.de, richardw.yang@linux.intel.com,
        Tianyu.Lan@microsoft.com, christophe.leroy@c-s.fr, bp@suse.de,
        rdunlap@infradead.org, michael.h.kelley@microsoft.com,
        kys@microsoft.com, sashal@kernel.org
Cc:     linux-kernel@vger.kernel.org, vkuznets@redhat.com,
        linux-hyperv@vger.kernel.org
Subject: [PATCH] mm/resource: Move child to new resource when release mem region.
Date:   Thu, 10 Oct 2019 15:28:56 +0800
Message-Id: <20191010072856.20079-1-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
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
index 158f04ec1d4f..7856347adfd2 100644
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
 /* Return the conflict entry if you can't request it */
 static struct resource * __request_resource(struct resource *root, struct resource *new)
 {
@@ -1231,9 +1263,6 @@ EXPORT_SYMBOL(__release_region);
  * Note:
  * - Additional release conditions, such as overlapping region, can be
  *   supported after they are confirmed as valid cases.
- * - When a busy memory resource gets split into two entries, the code
- *   assumes that all children remain in the lower address entry for
- *   simplicity.  Enhance this logic when necessary.
  */
 int release_mem_region_adjustable(struct resource *parent,
 				  resource_size_t start, resource_size_t size)
@@ -1316,11 +1345,12 @@ int release_mem_region_adjustable(struct resource *parent,
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

