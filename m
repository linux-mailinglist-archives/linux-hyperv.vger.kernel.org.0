Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77DFF4974B1
	for <lists+linux-hyperv@lfdr.de>; Sun, 23 Jan 2022 19:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234773AbiAWSnF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 23 Jan 2022 13:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239935AbiAWSmD (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 23 Jan 2022 13:42:03 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C36C061782;
        Sun, 23 Jan 2022 10:42:03 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id v3so7875037pgc.1;
        Sun, 23 Jan 2022 10:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=I0YT/VYh6ObjnXDB7ng030sn8u8S3AAW+xjtpU6qhC0=;
        b=kq3s29g6GZf8wi2NbTnwwMbHhy8TpKIQ4eWUy/tjlH1Vpe8OzRohSKbh0NJuBIbGKE
         AWefAIJHW1zxeanlvYSDuErwI7AbVCYWnyZSnLyC+yOjjk1falLUifpAOyQfzPGRxlUm
         NCgGGZw6YahfLJMTHbzfLum4x9VUdar9NvF4YR9uJAjsjgdICCc9bGMYTiw6dhVpIj2m
         23T3yJQuFspBrGVljLlEbWLX8Hn44/lP19MFqTTsAIGZ+9GmI5K/C2rnUrTkmWn1r5Uj
         u7qZ1u+B53jjHd5jQ0n+p5ZGLFrBDziDkFTOYlcCINLApK7NL2aC6acKb3gscVOqbn1P
         UI2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I0YT/VYh6ObjnXDB7ng030sn8u8S3AAW+xjtpU6qhC0=;
        b=KQcivrMrVE+hnVKq6JgrLyf0R2yo2tRKtKlOv+8RnMyCwrEtbwcz5K1rANwYnPw7/m
         2m9CA/tmWLP/G20xdQlMLCsFb6EBjFf1JkhsmLiCfZmJ8NK5vxpdn9PqusIYHQ+skeCj
         r1NPCeNE67DVxPKCojmCjHS4okey9Ezz26YAx15Chwh4bRWV6Njz9mXXrY34QgmPtFZy
         3F2Wg+Cm7ULySXflXNcrlcANhBdrGPxZY0qxtEqlZ2k9qPU9u55j2EiIAx4ilaMNVp5z
         tLn0O2ZFX4gkUNyln9cEGYU+L4ARjaaGF2mR/a5EOCXqvdppfOUQJWWvPveBc/TtPwy3
         pQPA==
X-Gm-Message-State: AOAM5332ttlwrbU/+MhPJxix/8L9FnmMWxP0t+dgs9p3gNrT1SHAd9TZ
        dT5vcoeiuO/Jq/IAsFieujc=
X-Google-Smtp-Source: ABdhPJwmYpc9TEcV47PWOUUbisFcgskduL2L6nlnYlZH/hQG0qVGRL3+zTix+PrCha7mKeScBdPXNw==
X-Received: by 2002:a05:6a00:1995:b0:4c5:eb10:c83d with SMTP id d21-20020a056a00199500b004c5eb10c83dmr11135520pfl.70.1642963323151;
        Sun, 23 Jan 2022 10:42:03 -0800 (PST)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id h14sm14431432pfh.95.2022.01.23.10.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 10:42:02 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-hyperv@vger.kernel.org
Subject: [PATCH 43/54] drivers/hv: replace cpumask_weight with cpumask_weight_eq
Date:   Sun, 23 Jan 2022 10:39:14 -0800
Message-Id: <20220123183925.1052919-44-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220123183925.1052919-1-yury.norov@gmail.com>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

init_vp_index() calls cpumask_weight() to compare the weights of cpumasks
We can do it more efficiently with cpumask_weight_eq because conditional
cpumask_weight may stop traversing the cpumask earlier (at least one), as
soon as condition is met.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/hv/channel_mgmt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 60375879612f..7420a5fd47b5 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -762,8 +762,8 @@ static void init_vp_index(struct vmbus_channel *channel)
 		}
 		alloced_mask = &hv_context.hv_numa_map[numa_node];
 
-		if (cpumask_weight(alloced_mask) ==
-		    cpumask_weight(cpumask_of_node(numa_node))) {
+		if (cpumask_weight_eq(alloced_mask,
+			    cpumask_weight(cpumask_of_node(numa_node)))) {
 			/*
 			 * We have cycled through all the CPUs in the node;
 			 * reset the alloced map.
-- 
2.30.2

