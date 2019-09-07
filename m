Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE02DAC96D
	for <lists+linux-hyperv@lfdr.de>; Sat,  7 Sep 2019 23:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406818AbfIGVlZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 7 Sep 2019 17:41:25 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43724 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732468AbfIGVlZ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 7 Sep 2019 17:41:25 -0400
Received: by mail-pg1-f196.google.com with SMTP id u72so5480753pgb.10;
        Sat, 07 Sep 2019 14:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Zj674LUoNkKvSpexmegA5PsZaKcGFKG4/kThw6ZXlmw=;
        b=Ujox5d061GkoJp1y4gs3/uinU01AK46f9UdarPx27G2y1doaNX1SE5I+pgGob0a5xq
         D7naagu+P+UhLSm36uYT2/ZbPOVD/+lYyDb62ieH655Wfp1Twoitw1+DetYB6tJoYZV7
         mAPa5PZfA5MTIzejdGl0ftr1u6aapyu99pEq4yrW30hF6rh0oBUjUsVaWDhokWEfSmEy
         YHkz/g2ZSRovh5Hz45kJJynuABEvmOrcI9AmcO/Pzqhro3NT3c7vO5cgFaH4d4Hk15Px
         KAy/zaOFRAsiJiQ2Iqpeigz8cpiyCt5vtvHH12MLqnzlhnDJ87YKjN09D3C9lwP5wCTo
         0mfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Zj674LUoNkKvSpexmegA5PsZaKcGFKG4/kThw6ZXlmw=;
        b=QRO9NztZa9FA2URgKhf8Rr1jIQ+9AYX1xkZhiD+r33DdpdgVi9M3kmvH3urDVi5P80
         LpYQMUJZ9931H+AxDOh9/R7xDeDtDQX6X08/ncC4zxMdWJl2smsQ7RE6pgn0IRB7lqY7
         hpNLI6wOr5K4ENvCvYeJCjhcyUFsSuG30EtLW9SuCB6MJWD5BnMF4NtuKDHCOowtTSqI
         kyiqA92PZdaeKvEC9D6UNsGrvxsxMCpP41TsteJzyExEch4dqeFZDXqRnXjxn3rnnR1B
         6lZAXemwM4MMNnS6443Q2CqyWDzT0JsHhpsZltIWIHXlqtAn3CptDnUkAy4HIWiAVylr
         hKJQ==
X-Gm-Message-State: APjAAAWUUqS0ZjKgSISe7HagUAwefuw9DFnPZk6hOMdW/DJoAu3Nzh9T
        /CM3Cv30bA/RyHCef9rxLC4=
X-Google-Smtp-Source: APXvYqxfWkn27m4YwwErHi0RMDLqVgW7yc2OyNzSnRttW+TV1ma82at8a0X804W7PsbzNHRM+aaXvw==
X-Received: by 2002:a65:430b:: with SMTP id j11mr14111649pgq.383.1567892484556;
        Sat, 07 Sep 2019 14:41:24 -0700 (PDT)
Received: from localhost.localdomain ([112.79.80.177])
        by smtp.gmail.com with ESMTPSA id h11sm9078516pgv.5.2019.09.07.14.41.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 07 Sep 2019 14:41:23 -0700 (PDT)
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
Subject: [PATCH 1/3] hv_ballon: Avoid calling dummy function __online_page_set_limits()
Date:   Sun,  8 Sep 2019 03:17:02 +0530
Message-Id: <8e1bc9d3b492f6bde16e95ebc1dee11d6aefabd7.1567889743.git.jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1567889743.git.jrdr.linux@gmail.com>
References: <cover.1567889743.git.jrdr.linux@gmail.com>
In-Reply-To: <cover.1567889743.git.jrdr.linux@gmail.com>
References: <cover.1567889743.git.jrdr.linux@gmail.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

__online_page_set_limits() is a dummy function and an extra call
to this function can be avoided.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/hv/hv_balloon.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index 6fb4ea5..9bab443 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -680,7 +680,6 @@ static void hv_page_online_one(struct hv_hotadd_state *has, struct page *pg)
 		__ClearPageOffline(pg);
 
 	/* This frame is currently backed; online the page. */
-	__online_page_set_limits(pg);
 	__online_page_increment_counters(pg);
 	__online_page_free(pg);
 
-- 
1.9.1

