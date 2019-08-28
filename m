Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71FEF9FC9B
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Aug 2019 10:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbfH1IH5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 28 Aug 2019 04:07:57 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35091 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbfH1IH4 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 28 Aug 2019 04:07:56 -0400
Received: by mail-pf1-f194.google.com with SMTP id d85so1209222pfd.2;
        Wed, 28 Aug 2019 01:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bzwq5Lzf2vOHlpsC8M2sMWZcNEUPweoUJnKhBuyOVxM=;
        b=mUaAE+Sx+tTGqn6H09pLb6Q/VOdWhRgt5Li6uV9XKx4BWmwyuMYcARE6VgEyQ/SvhN
         mTVf72562IkM0UYVZBKOTzIi+pDKPkbwbhyqdR8Eu06oNFf/jIbfZkRFehKsn97q2F1S
         d2wcW3xXTQsegeEBOUBoqOr5g/MwWupqbbhMbgkJTgWpITh4toWXy/ctAyVn8ZxXI5Dq
         uAnnHtGHLvh8oFR8go3I8DOjkPEnzyjyz5BrOMJJlBI1xcsf4mBH/FaYLt160zCa1DaO
         0rLc9K96L0i6EnsrxG4c5pzXFuAPmECuHmNac/qb67JgHF3to+skYS5K/ppc5C/ilo+0
         V4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bzwq5Lzf2vOHlpsC8M2sMWZcNEUPweoUJnKhBuyOVxM=;
        b=lzd9q4Wg0cVdkHCWaM3PcOdsgEuNCdGWKJbQEdyPcly5g31BT2LVCmTj4g5gOrvYaa
         7TsKCtmGCR9S8S+Y6ZDB2BJBh2gC2Ih00AXxpRK40trrsI3rc2TqGg9F/bZfP3cHpVuc
         DSD60awWL+qc7z1IqgDznwhNT6yAiYxUCY5WlYAEgClAuA5jDcV7iGUkmdSyQ17OPnSL
         ddvV81P9J7TdFc9qgYWgJmTxBuKxNz9NCA+rwYgKUl5CHoXy3F9KysIjdNtCB8gaib1Z
         b8mGZXqAE0GCp/mvTu5vAzejuh+ZVTlRCwyySs9aD4isYBPqQvcLxRYQyHjb2JHcXaB5
         Qqpg==
X-Gm-Message-State: APjAAAXeXgNlDtJ6idTeDYNcB9/nKMQsgze6D/zvaxblQTHRkfLcqlog
        w1RrxcvFxMw9P7aw1PRAPSc=
X-Google-Smtp-Source: APXvYqwBYlxPa+/RhgNHwomSbYeuT6yPtD4Axsr/uaDwXTIOM9VPBkYOF+QX1PgeyswykqQ92DwU9Q==
X-Received: by 2002:aa7:8f2e:: with SMTP id y14mr3197181pfr.113.1566979676296;
        Wed, 28 Aug 2019 01:07:56 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([167.220.255.52])
        by smtp.googlemail.com with ESMTPSA id z6sm4129360pgk.18.2019.08.28.01.07.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Aug 2019 01:07:55 -0700 (PDT)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/Hyper-V: Fix reference of pv_ops with CONFIG_PARAVIRT=N
Date:   Wed, 28 Aug 2019 16:07:47 +0800
Message-Id: <20190828080747.204419-1-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

hv_setup_sched_clock() references pv_ops and this should
be under CONFIG_PARAVIRT=Y. Fix it.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
This patch is based on git://git.kernel.org/pub/scm/linux/
kernel/git/tip/tip.git timers/core.

 arch/x86/kernel/cpu/mshyperv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 53afd33990eb..267daad8c036 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -346,7 +346,9 @@ static void __init ms_hyperv_init_platform(void)
 
 void hv_setup_sched_clock(void *sched_clock)
 {
+#ifdef CONFIG_PARAVIRT
 	pv_ops.time.sched_clock = sched_clock;
+#endif
 }
 
 const __initconst struct hypervisor_x86 x86_hyper_ms_hyperv = {
-- 
2.14.5

