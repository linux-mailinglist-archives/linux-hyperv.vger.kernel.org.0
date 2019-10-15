Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCF4D7363
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Oct 2019 12:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730767AbfJOKfg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 15 Oct 2019 06:35:36 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44776 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfJOKfg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 15 Oct 2019 06:35:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id z9so23184378wrl.11;
        Tue, 15 Oct 2019 03:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DZhF+IJMFrGCNSt/DYaWxJMskyfNVl1OJiwVFgA4loI=;
        b=phKt1qHNEFEJNA1t+ZpAsxyeHJG01qYZqf07iMDNOj/R/AI+QF4k4ftjUBAEhBLqfW
         B8PgmrupMXS+crT4mizGWEuCs7N71Yw1VHfvuQrvJfe+vU3CNE78lpWCx9Povq4P/kTp
         Ii4xaqThvDDlCnIJMwM5A8M3uw6svphS7iaTWIF+bm5z1vizxpGupIQSMAiGmvutI4+Q
         VBQ4FDtRWOamvRSMBSokcMxypAuzgkn83Lhh7B2xef/SEGYKJ/L5Dg8BHBDjDHlkRzJT
         2M5IXf4Ada1fRUk5OzPzkFihvjAuvTgvNOtkWp5Vgqc9Kz5o1Qg7wVAdt6Soe+jfLo3B
         7a1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DZhF+IJMFrGCNSt/DYaWxJMskyfNVl1OJiwVFgA4loI=;
        b=eOMd9KdIYFTiZdugH4WiTXixlWmz5RgDnIaHPtddU1QYTKDCq5axbZQ4lPouIYYbf1
         Oo/KdLog3xJhRSSgQ8dcE+Suka07QnWQ6pojCKynI5NONHgKvgXxIVOyXdouL6JfpMN7
         OiWXPh7kHebGCzbWzde0aqWajyW6S60lnHDGrAaNJkIXOd6Mq63AXGWWm9U3Ecl0EO9n
         bqnFKWQOplxQJh3XIjjMBeP1w+wIul+q56TbbRnju/PsesuRdyKpAJLAr4tGmDMUtohb
         Q+6PUB/6WGYYocEwVyqVD8D0AKXpkBd1c/moj5jqWrA9uzqQbfGMtmDav/RUpHf5L+Dm
         CU6w==
X-Gm-Message-State: APjAAAUNSiMvxn8u97WrRD4cfA4t2Oa9FXl2Q3xLO2fc2QQkdYIZlmRw
        F6up5qnNxONvMPDPqu0Umu0urASZBmy7zQ==
X-Google-Smtp-Source: APXvYqwbx/z0JfB8Tw+7CM0PNbXcRtKsIyNEpzo53nL0HJKVRpO4HUFgZ70IHYwoWPeSM3Na+kuHdQ==
X-Received: by 2002:a5d:6949:: with SMTP id r9mr27369305wrw.106.1571135733069;
        Tue, 15 Oct 2019 03:35:33 -0700 (PDT)
Received: from andrea.corp.microsoft.com ([2a01:110:8012:1010:8d42:cc61:bfff:65c2])
        by smtp.gmail.com with ESMTPSA id a13sm55546549wrf.73.2019.10.15.03.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 03:35:32 -0700 (PDT)
From:   Andrea Parri <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        x86@kernel.org
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Andrea Parri <parri.andrea@gmail.com>
Subject: [PATCH v2] x86/hyperv: Set pv_info.name to "Hyper-V"
Date:   Tue, 15 Oct 2019 12:35:02 +0200
Message-Id: <20191015103502.13156-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Michael reported that the x86/hyperv initialization code printed the
following dmesg when running in a VM on Hyper-V:

  [    0.000738] Booting paravirtualized kernel on bare hardware

Let the x86/hyperv initialization code set pv_info.name to "Hyper-V";
with this addition, the dmesg read:

  [    0.000172] Booting paravirtualized kernel on Hyper-V

Reported-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
Changes since v1 ([1]):
  - move the setting of pv_info.name to ms_hyperv_init_platform() (Wei Liu)

[1] https://lkml.kernel.org/r/20191015092937.11244-1-parri.andrea@gmail.com

 arch/x86/kernel/cpu/mshyperv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 267daad8c0360..e7f0776e2a811 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -216,6 +216,8 @@ static void __init ms_hyperv_init_platform(void)
 	int hv_host_info_ecx;
 	int hv_host_info_edx;
 
+	pv_info.name = "Hyper-V";
+
 	/*
 	 * Extract the features and hints
 	 */
-- 
2.23.0

