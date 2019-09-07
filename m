Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F51EAC971
	for <lists+linux-hyperv@lfdr.de>; Sat,  7 Sep 2019 23:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406843AbfIGVlj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 7 Sep 2019 17:41:39 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44367 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732468AbfIGVlj (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 7 Sep 2019 17:41:39 -0400
Received: by mail-pg1-f193.google.com with SMTP id i18so5475231pgl.11;
        Sat, 07 Sep 2019 14:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=roF+iHytDA2OpX6EAs6vae/MbSREfIb/2EmgYW70LGY=;
        b=LCqusXStz2S5t5Jo03KSnHbdxvW5JnsBIMaaxJRM/k++WE4/icVGE/B9clTcqDPqzr
         e+6bcZNXENyZPcxqezTzfGSBa1s2TTVHZSswaU1Q/gsVktt+7t4uh6VhJs2wcOEH+rK2
         7EINf8UFuBSovxqmpSsvGmkG7tPc2yxjQt9m58rxPK7IS7zOWR4d+Fv0Qwyp7lzd0wnl
         KHjiirC1iZTH9ejrMEEPJ859Vod3vSehrRREj21RGvtTebumbB5EmAPCweCBjVlNlnoX
         xhc2cIqSXEGo0SCZjGNrGJGibWee8BvXhvv/LQ1Qyc2aoKu/JzyGwG0fBb4wq6PYyw7Q
         Nl1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=roF+iHytDA2OpX6EAs6vae/MbSREfIb/2EmgYW70LGY=;
        b=eXoLuH2Dby45oU59CT8moiJknDpAkjkkFsRiue53F/xi99ERb/gzhf5Mhs1sm4tXip
         S2C3Rr3pQn2iK2of3BAvHlKVR41LrgvE2z7sDjSxVg6qJxtnSubOES8kr4DA6HteAYTB
         na9UzszQgk7oKqSmAnN/Ug1mDzPGaSIODvT8EvZvFWjWWDibZxa/GZZ8ewv8y41sofkQ
         4vem8XpjJGcPNcvWFTKXmV9krUGrJcjcnOdxqCjo8aLGKME6L/cZ21EGPMO+gmGjPRFp
         erSAIf9PsarnES5/ppMvKL+scsfBjMRa5y7DK9P0d9XN7CWS0B5QbpgzNf+6KYFoOXvw
         BxwQ==
X-Gm-Message-State: APjAAAXZeEzi8LC3lQAZFTGFehkmerQJGDCerLwmG7rAJlRxNxjXQ4Hp
        +5DDB/d1cIUrcugTOAVwRnU=
X-Google-Smtp-Source: APXvYqyFSnMx/7lAMSE2e3lPA0RN+xaQcUoIMVlsQ0qfqgUp72SQW3UUmlrUThMTSeTxYPzNir9e5Q==
X-Received: by 2002:aa7:955d:: with SMTP id w29mr18821170pfq.60.1567892498622;
        Sat, 07 Sep 2019 14:41:38 -0700 (PDT)
Received: from localhost.localdomain ([112.79.80.177])
        by smtp.gmail.com with ESMTPSA id h11sm9078516pgv.5.2019.09.07.14.41.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 07 Sep 2019 14:41:37 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, akpm@linux-foundation.org,
        david@redhat.com, osalvador@suse.com, mhocko@suse.com,
        pasha.tatashin@soleen.com, dan.j.williams@intel.com,
        richard.weiyang@gmail.com, cai@lca.pw
Cc:     linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH 3/3] mm/memory_hotplug.c: Remove __online_page_set_limits()
Date:   Sun,  8 Sep 2019 03:17:04 +0530
Message-Id: <9afe6c5a18158f3884a6b302ac2c772f3da49ccc.1567889743.git.jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1567889743.git.jrdr.linux@gmail.com>
References: <cover.1567889743.git.jrdr.linux@gmail.com>
In-Reply-To: <cover.1567889743.git.jrdr.linux@gmail.com>
References: <cover.1567889743.git.jrdr.linux@gmail.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

As both the callers of this dummy __online_page_set_limits()
is removed, this can be removed permanently.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 include/linux/memory_hotplug.h | 1 -
 mm/memory_hotplug.c            | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index f46ea71..8ee3a2a 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -105,7 +105,6 @@ extern unsigned long __offline_isolated_pages(unsigned long start_pfn,
 extern int set_online_page_callback(online_page_callback_t callback);
 extern int restore_online_page_callback(online_page_callback_t callback);
 
-extern void __online_page_set_limits(struct page *page);
 extern void __online_page_increment_counters(struct page *page);
 extern void __online_page_free(struct page *page);
 
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index c73f099..dc0118f 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -604,11 +604,6 @@ int restore_online_page_callback(online_page_callback_t callback)
 }
 EXPORT_SYMBOL_GPL(restore_online_page_callback);
 
-void __online_page_set_limits(struct page *page)
-{
-}
-EXPORT_SYMBOL_GPL(__online_page_set_limits);
-
 void __online_page_increment_counters(struct page *page)
 {
 	adjust_managed_page_count(page, 1);
-- 
1.9.1

