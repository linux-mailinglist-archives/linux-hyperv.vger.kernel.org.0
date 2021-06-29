Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0446C3B72F2
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Jun 2021 15:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbhF2NJZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 29 Jun 2021 09:09:25 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:36588 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234038AbhF2NJX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 29 Jun 2021 09:09:23 -0400
Received: by mail-wr1-f54.google.com with SMTP id v5so79894wrt.3;
        Tue, 29 Jun 2021 06:06:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0fbcOFNv/fEL1LfPvVYhvBfReGmmVneZTwjkE/yWKPk=;
        b=Z9ptE7BRiz6naFjQ1Jz7qURGUau+CPHaQKeOMDkKqlqKT/RCCkGvOoLR61hQysKpOq
         4nxyDJhFNREC9JGo83udjRQ18Ehcq1Rk1h3z8LJbFjW6zzOiDKVWvx3STaKfMTSkNnw7
         ZAWiLfUjrVtg/ZpjhvAr6G/qTdT17kwMEAuO97HzhQxqG0qDa6bvtRHbDzWS2huNF3jN
         ogUG0CttadVgbTwjQThg3ykSTpAOUkHAfvwJAnyqW9iyTO20L/jEtCsMCXyn8OkKl1Zo
         n3VLKHQNdTIUQBYWiDcgfOL2jKuSL1JpmkbE3aMq1arpgX4F0gt+jtZnme3JyMmr07TH
         99kQ==
X-Gm-Message-State: AOAM5330yYMNW8goJ8Ue25OQ54isEMRAPI17k7Of/ebmyggGRfUXLMxW
        lXa8LVrt15nWpnE4l3M7Atw=
X-Google-Smtp-Source: ABdhPJw+psSY+vnhRGp9ggD8WHxGcdbWQm+iba+bXos+lgbx39Lm8t49GQCAD7yxjw38Ax4o+q76Tw==
X-Received: by 2002:a5d:410f:: with SMTP id l15mr33771817wrp.82.1624972014754;
        Tue, 29 Jun 2021 06:06:54 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id n8sm18228054wrt.95.2021.06.29.06.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 06:06:54 -0700 (PDT)
Date:   Tue, 29 Jun 2021 13:06:52 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Vineeth Pillai <viremana@linux.microsoft.com>
Cc:     Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 06/17] mshv: SynIC port and connection hypercalls
Message-ID: <20210629130652.lzydiyqgwd47lhue@liuwe-devbox-debian-v2>
References: <cover.1622654100.git.viremana@linux.microsoft.com>
 <3125953aae8e7950a6da4c311ef163b79d6fb6b3.1622654100.git.viremana@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3125953aae8e7950a6da4c311ef163b79d6fb6b3.1622654100.git.viremana@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jun 02, 2021 at 05:20:51PM +0000, Vineeth Pillai wrote:
> Hyper-V enables inter-partition communication through the port and
> connection constructs. More details about ports and connections in
> TLFS chapter 11.
> 
> Implement hypercalls related to ports and connections for enabling
> inter-partiion communication.
> 
> Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>

Vineeth, feel free to squash the following patch.

---8<---
From afb9ab422895364216acb4261399f6f5154eea17 Mon Sep 17 00:00:00 2001
From: Wei Liu <wei.liu@kernel.org>
Date: Tue, 29 Jun 2021 12:58:47 +0000
Subject: [PATCH] fixup! mshv: SynIC port and connection hypercalls

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 drivers/hv/hv_call.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hv/hv_call.c b/drivers/hv/hv_call.c
index d5cdbe4e93da..30aefcbdda85 100644
--- a/drivers/hv/hv_call.c
+++ b/drivers/hv/hv_call.c
@@ -797,7 +797,7 @@ hv_call_create_port(u64 port_partition_id, union hv_port_id port_id,
 		if (status != HV_STATUS_INSUFFICIENT_MEMORY) {
 			pr_err("%s: %s\n",
 			       __func__, hv_status_to_string(status));
-			ret = -hv_status_to_errno(status);
+			ret = hv_status_to_errno(status);
 			break;
 		}
 		ret = hv_call_deposit_pages(NUMA_NO_NODE,
@@ -826,7 +826,7 @@ hv_call_delete_port(u64 port_partition_id, union hv_port_id port_id)
 
 	if (status != HV_STATUS_SUCCESS) {
 		pr_err("%s: %s\n", __func__, hv_status_to_string(status));
-		return -hv_status_to_errno(status);
+		return hv_status_to_errno(status);
 	}
 
 	return 0;
@@ -866,7 +866,7 @@ hv_call_connect_port(u64 port_partition_id, union hv_port_id port_id,
 		if (status != HV_STATUS_INSUFFICIENT_MEMORY) {
 			pr_err("%s: %s\n",
 			       __func__, hv_status_to_string(status));
-			ret = -hv_status_to_errno(status);
+			ret = hv_status_to_errno(status);
 			break;
 		}
 		ret = hv_call_deposit_pages(NUMA_NO_NODE,
@@ -896,7 +896,7 @@ hv_call_disconnect_port(u64 connection_partition_id,
 
 	if (status != HV_STATUS_SUCCESS) {
 		pr_err("%s: %s\n", __func__, hv_status_to_string(status));
-		return -hv_status_to_errno(status);
+		return hv_status_to_errno(status);
 	}
 
 	return 0;
@@ -918,7 +918,7 @@ hv_call_notify_port_ring_empty(u32 sint_index)
 
 	if (status != HV_STATUS_SUCCESS) {
 		pr_err("%s: %s\n", __func__, hv_status_to_string(status));
-		return -hv_status_to_errno(status);
+		return hv_status_to_errno(status);
 	}
 
 	return 0;
-- 
2.30.2

