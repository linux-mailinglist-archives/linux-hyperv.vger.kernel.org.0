Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2E44E6C92
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Mar 2022 03:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357779AbiCYCep (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 24 Mar 2022 22:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357782AbiCYCeo (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 24 Mar 2022 22:34:44 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7C0CD6;
        Thu, 24 Mar 2022 19:33:07 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id b189so5031216qkf.11;
        Thu, 24 Mar 2022 19:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vw/ACGTLfd24TEwOsMtKP4JjvUnmGhYZJwx+5xNDMTo=;
        b=aTFV1PR6CO4w0h+dPvEkd94PPa5+MUuVTFoV2GN6oOUNO1CE6g4mQCQa9qxVo61907
         hktftE9csq6AtkHwwvFp10OR0ijgnn2yRpCXTk6Mmz8J+uV4FIU8pAz1ScaigtQZ3eEn
         ZH3C2ihv8yDLtzyPKgbW7m9MEaRPUanFV6HipTzAcjVXsa2cTqR5n5NDK+LsqCg45OBe
         H+7n5+WgTVIEKZP7jgpcTiZ3QIQrVgX6coZ9OXQdvJvDyvMVSsr1XPj/lIhi9C7EHYqC
         RgGnlhDfqr8PBXZif7l9+2tK2XxGJsY9soT4sDTXEUrdwqa43HNNeHzBMMLUJm9tCGp7
         EdkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vw/ACGTLfd24TEwOsMtKP4JjvUnmGhYZJwx+5xNDMTo=;
        b=QPgI0fygTXPyVLaEYhex2UOiZ4N0Tv5X+chASHm6SOlziM9QHfPnzLeJsSSocUx6zU
         AR8H3abmtkOl1Q/TMyKHKo7V9zCcQyk301ttj254h4NHTFab+1uGgOdGWrWqFSIyFVNL
         UPNnvXLiMk5y3wzA4UEJDarGdIZdbTz2EAXxg/dEfrkFMt2mGSr5AkeHoUnbgKBqocKv
         EVH7RpMT2SVYhE/F99gdwTLQPVF4DtuwvYHIBPTxjFTFk30NIeA7Ard4XFzIPL3GYmW0
         iYGqC+YfpRrnrKXTwm9yQ0fShOnOWLsRbYxOn6bt9eyjTIdn5rQQ21Z4D9GJkMa0elsl
         GgIg==
X-Gm-Message-State: AOAM532J0Wf+S7j7z+ht88/4nm0foh0EpPQjViU7flNI3AnSLhGKzkkL
        ME5d4KFnehefWcD5qqAMI3Q=
X-Google-Smtp-Source: ABdhPJwVZhPntslu4pfq0kZWLhN5okKsenhhKKE3cL+8rlT/JWxJfPbEdlo2o8CtuJ7/kX6wvCHKrg==
X-Received: by 2002:a05:620a:b43:b0:67d:942c:2e03 with SMTP id x3-20020a05620a0b4300b0067d942c2e03mr5427638qkg.303.1648175586629;
        Thu, 24 Mar 2022 19:33:06 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id y15-20020a05622a004f00b002e1aaa1738dsm4009736qtw.12.2022.03.24.19.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 19:33:05 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 7C3F827C005A;
        Thu, 24 Mar 2022 22:33:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 24 Mar 2022 22:33:04 -0400
X-ME-Sender: <xms:4Ck9YuoLSbL5dk9QkvnUArqaZwfIEa-2yxIJEAnmb9cU-XrCItStKA>
    <xme:4Ck9YspqfLnNKMxbCtpmg4bttywSADezJUHV9Jfv3xNLbU33EEszBCa7nr43sj3Ks
    TtC06xB7edpIXrj0A>
X-ME-Received: <xmr:4Ck9YjNMg1f9wfEjkeAW5z0waZ-Ha407geaAb8PLUtCABAJy4PkEeMqUrLE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudehtddggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedvveetfefgiedutedtfeevvddvleekjeeuffffleeguefhhfejteekieeu
    ueelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:4Ck9Yt6vRPfZt87GeH8RMfORf2_cF35rIKn9I54HZh7BHs1v3oYcgQ>
    <xmx:4Ck9Yt4ZLN-yVQXYHOi7Dvmnpcdr40jBeSeIYYiSXnycF1hVswli5g>
    <xmx:4Ck9YtgTk4KyY5qOXjfhwBz8CvQmvt_atgxzgl4BidWQ1RQs5dtNPw>
    <xmx:4Ck9YiGEfV_D2YMGZAbNScl6KuQpTYjFOXbaWj6mBPgaY1m0MPv8RA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Mar 2022 22:33:03 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-hyperv@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH v2 1/2] Drivers: hv: balloon: Support status report for larger page sizes
Date:   Fri, 25 Mar 2022 10:32:11 +0800
Message-Id: <20220325023212.1570049-2-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220325023212.1570049-1-boqun.feng@gmail.com>
References: <20220325023212.1570049-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

DM_STATUS_REPORT expects the numbers of pages in the unit of 4k pages
(HV_HYP_PAGE) instead of guest pages, so to make it work when guest page
sizes are larger than 4k, convert the numbers of guest pages into the
numbers of HV_HYP_PAGEs.

Note that the numbers of guest pages are still used for tracing because
tracing is internal to the guest kernel.

Reported-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/hv/hv_balloon.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index f2d05bff4245..062156b88a87 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -17,6 +17,7 @@
 #include <linux/slab.h>
 #include <linux/kthread.h>
 #include <linux/completion.h>
+#include <linux/count_zeros.h>
 #include <linux/memory_hotplug.h>
 #include <linux/memory.h>
 #include <linux/notifier.h>
@@ -1130,6 +1131,7 @@ static void post_status(struct hv_dynmem_device *dm)
 	struct dm_status status;
 	unsigned long now = jiffies;
 	unsigned long last_post = last_post_time;
+	unsigned long num_pages_avail, num_pages_committed;
 
 	if (pressure_report_delay > 0) {
 		--pressure_report_delay;
@@ -1154,16 +1156,21 @@ static void post_status(struct hv_dynmem_device *dm)
 	 * num_pages_onlined) as committed to the host, otherwise it can try
 	 * asking us to balloon them out.
 	 */
-	status.num_avail = si_mem_available();
-	status.num_committed = vm_memory_committed() +
+	num_pages_avail = si_mem_available();
+	num_pages_committed = vm_memory_committed() +
 		dm->num_pages_ballooned +
 		(dm->num_pages_added > dm->num_pages_onlined ?
 		 dm->num_pages_added - dm->num_pages_onlined : 0) +
 		compute_balloon_floor();
 
-	trace_balloon_status(status.num_avail, status.num_committed,
+	trace_balloon_status(num_pages_avail, num_pages_committed,
 			     vm_memory_committed(), dm->num_pages_ballooned,
 			     dm->num_pages_added, dm->num_pages_onlined);
+
+	/* Convert numbers of pages into numbers of HV_HYP_PAGEs. */
+	status.num_avail = num_pages_avail * NR_HV_HYP_PAGES_IN_PAGE;
+	status.num_committed = num_pages_committed * NR_HV_HYP_PAGES_IN_PAGE;
+
 	/*
 	 * If our transaction ID is no longer current, just don't
 	 * send the status. This can happen if we were interrupted
-- 
2.35.1

