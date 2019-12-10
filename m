Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 212BE118CE6
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Dec 2019 16:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfLJPqf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 10 Dec 2019 10:46:35 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37726 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbfLJPqf (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 10 Dec 2019 10:46:35 -0500
Received: by mail-pl1-f195.google.com with SMTP id c23so38009plz.4;
        Tue, 10 Dec 2019 07:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CZlrbcP0R+6P+fN+m63h/3S5RDdyDRFNSXhYFi//Vj0=;
        b=cjuMjt4euAnrX3p2nGOu85BL/zhPkgkPTkUECiMejrpa4dHCbZj0+nWNdEb3BATVy7
         rutEc6OHzaR89xAl+Pag+h3tnK+PUjCmrek7tLL8+RDhe3XPN+Cne3RJH/BBmkejydT8
         QUG5OAeMSRfR2v9Qfn6vcubbVzgZinKGmKpZn8wg9SHA0ewVX2os8J1DE+h0/g3jMFvp
         hcGCzUzJGR6lNBdZvrWVW5Yj/uwlLemkResl8ObtFEbJ2zZbGaLCL5F6Wu0r7c6x0AgA
         l0Wy0Ct8TMVkavZkfcidkxpRQqqk1Z9p9otgffOH0mMFLM/JHuACNkbXiMQbR8zoHVvN
         XEaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CZlrbcP0R+6P+fN+m63h/3S5RDdyDRFNSXhYFi//Vj0=;
        b=dO7ZBCHkMqpQwccvNSc2/8injEXrRrQ5bBBive+4jhFRCNQk5d9GFPWUAUAIWhPiOb
         rQgLKNNvKx/rlt/UyT3ePpP2jdTjwT6L0s85/UkMiz+HrPxu4jUasmfOu8uGGgybbdu8
         i7XwQV10cL2Nh9pggUGv5rJQYxXpt7ITatczde9iP+vlfB0QRxd7xon1ZxBSGR20dzPM
         61/zKnQSg2FrDgOtGgXeRxPt7gF/jTQpx71kxaQbtKOxJ5buLbpaVZLUHRFUvlkxU3HQ
         euRqXdO7SCAg+JVTBKEb4ct3TzzZrV0db2zvSWWLlIa1TRh//dL0TuIpSsA6LoQRgPW6
         LBIA==
X-Gm-Message-State: APjAAAWBkeM3UAuX2wZBuuFvoVu/cOJTpdRdcY93WJ+XCso8f/vTiZig
        RPKfG1UCZINlw0G0wRNpgV4=
X-Google-Smtp-Source: APXvYqwgKgXxjEp6ccHDndsVKuAZNMI3KJXsJrXJ3HHikiQT2SB4OHh6ipUxPWQF61rM8d0kv7jiOA==
X-Received: by 2002:a17:902:8306:: with SMTP id bd6mr36661149plb.303.1575992794302;
        Tue, 10 Dec 2019 07:46:34 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.5])
        by smtp.googlemail.com with ESMTPSA id k13sm4113815pfp.48.2019.12.10.07.46.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Dec 2019 07:46:33 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, akpm@linux-foundation.org,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vkuznets@redhat.com, eric.devolder@oracle.com
Subject: [RFC PATCH 2/4] mm/hotplug: Expose is_mem_section_removable() and offline_pages()
Date:   Tue, 10 Dec 2019 23:46:09 +0800
Message-Id: <20191210154611.10958-3-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20191210154611.10958-1-Tianyu.Lan@microsoft.com>
References: <20191210154611.10958-1-Tianyu.Lan@microsoft.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

Hyper-V driver adds memory hot remove function and will use
these interfaces in Hyper-V balloon driver which may be built
as a module. Expose these function.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 mm/memory_hotplug.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 07e5c67f48a8..4b358ebcc3d7 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1191,6 +1191,7 @@ bool is_mem_section_removable(unsigned long start_pfn, unsigned long nr_pages)
 	/* All pageblocks in the memory block are likely to be hot-removable */
 	return true;
 }
+EXPORT_SYMBOL_GPL(is_mem_section_removable);
 
 /*
  * Confirm all pages in a range [start, end) belong to the same zone.
@@ -1612,6 +1613,7 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 {
 	return __offline_pages(start_pfn, start_pfn + nr_pages);
 }
+EXPORT_SYMBOL_GPL(offline_pages);
 
 static int check_memblock_offlined_cb(struct memory_block *mem, void *arg)
 {
-- 
2.14.5

