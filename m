Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64D66188566
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2020 14:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgCQNZb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 17 Mar 2020 09:25:31 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39844 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgCQNZa (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 17 Mar 2020 09:25:30 -0400
Received: by mail-pg1-f194.google.com with SMTP id b22so5748972pgb.6;
        Tue, 17 Mar 2020 06:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=agG+dITcuAm3KPc+VwzNwpsgr+i8A6gZOBf/aTNCeRE=;
        b=iG0Wk+45lpTMF6Qs9ptAuWGLvyCn/OdTa5ZWDJ7CrFZLWBOV7vQsaN+wETj/Ypzo8/
         5+g1gwgRhqIIDY7bAGP+7sSPXhCqYE4CGiDNG4stIeOKHgHdZ0QP1OGU7Mbs40zcsfbd
         meweTxGdlZ5pVXW01Jm7BAPxgUXoZJmWOUBe6phYUM+5z3aMhyT+o4bxug8EPSi+boGg
         UrnhKwlf+VofnjUMkhdoGkZP8+AcA5ISstIsrVYoxsmwqBcOswUUdDyH0noKSLa+fHHa
         h38JHOEbcLeP4ZLetyy9xB9qAR2zNOWSgw/ioSS9FLWRk31/bFWmMB3rtKU8226evWBI
         cNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=agG+dITcuAm3KPc+VwzNwpsgr+i8A6gZOBf/aTNCeRE=;
        b=UNsKLiyqkroO8ZcDUx/WQWZXdVXvl8KeuuN+WY7UjCm77zGPDcHgZcoFr53nduiqOI
         GgZ2r9bgIhW9cMcAspiLOL4Jlu6XGVEW65EFiNoz4wXC5j71WEdpnrC11jfsybhoVm5z
         iIKe7YC8kqLY1LxBAJ2u10T5L+GGSLv51KGoRqIWqiFsfUe9p+ECm55y0UPumLCrZT2x
         M0T2+G9OvwvZ6OV24bGOKuAxPIOG3Agy6YZvLQyxfQQ+Wy+VIcgufXEARvzKmFuWZkn3
         WzTKZf3kdTe68uSotX/v0DADzjD2Fh0Hr29yROgjqsmPooUNNCANzoGRhSFsmt77nsLN
         wzfQ==
X-Gm-Message-State: ANhLgQ3FYdyO5vrKfhuZZNoK/P9WZ5b7Y/Iu1VpES0Da3qrTWsU6T7I6
        TjNAR86RJhN9IoJDrv4QZSQ=
X-Google-Smtp-Source: ADFU+vsLRcmJ2YKpbw2In4/U3k6OYkKkfv94ONyzhv0jHQQnV+sSmfb3hOtExDusuMk9QBCfjQ4QnA==
X-Received: by 2002:a63:348b:: with SMTP id b133mr5272049pga.372.1584451529546;
        Tue, 17 Mar 2020 06:25:29 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([167.220.2.210])
        by smtp.googlemail.com with ESMTPSA id e30sm2910902pga.6.2020.03.17.06.25.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Mar 2020 06:25:28 -0700 (PDT)
From:   ltykernel@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        liuwe@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
Subject: [PATCH 0/4] x86/Hyper-V: Panic code path fixes
Date:   Tue, 17 Mar 2020 06:25:19 -0700
Message-Id: <20200317132523.1508-1-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

This patchset fixes some issues in the Hyper-V panic code path.
Patch 1 resolves issue that panic system still responses network
packets.
Patch 2-3 resolves crash enlightenment issues.
Patch 4 is to set crash_kexec_post_notifiers to true for Hyper-V
VM in order to report crash data or kmsg to host before running
kdump kernel.

Tianyu Lan (4):
  x86/Hyper-V: Unload vmbus channel in hv panic callback
  x86/Hyper-V: Free hv_panic_page when fail to register kmsg dump
  x86/Hyper-V: Trigger crash enlightenment only once during  system
    crash.
  x86/Hyper-V: Report crash register data or ksmg before running crash
    kernel

 arch/x86/kernel/cpu/mshyperv.c | 10 ++++++++++
 drivers/hv/channel_mgmt.c      |  5 +++++
 drivers/hv/vmbus_drv.c         | 35 +++++++++++++++++++++++++----------
 3 files changed, 40 insertions(+), 10 deletions(-)

-- 
2.14.5

