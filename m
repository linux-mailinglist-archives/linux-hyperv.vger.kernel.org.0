Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8A218F548
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Mar 2020 14:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbgCWNJj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 23 Mar 2020 09:09:39 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:53398 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728275AbgCWNJj (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 23 Mar 2020 09:09:39 -0400
Received: by mail-pj1-f68.google.com with SMTP id l36so6157015pjb.3;
        Mon, 23 Mar 2020 06:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UVUZSZmN0wfjBDMswnzLJO1IiNBLG8FZGAX4PW0SLkk=;
        b=e4nrWQdDZ5NyXWFxrTJOR86i5pZIZr/nwpPzSIUUS7OfQg0vG0p999rLCaZ4syxvqj
         rYTQkwVIfQvvsAibJBaJSw11yNn2RaV4LftQcZjYQihRm9SNXN5GYzLD3atDe1OuhCaa
         SBYpQFWc71X451bz9yKrmR0eTz9R0bFMPWVdY9Go6j+db3T30hfCiMvbR1zaUUuem0tD
         PZIO7xJtBsIc7PSLncYHnwHERLXXHTOB9I51bXpiP0CxGmJREOG6sWYpYj/qj/zYYeW7
         mDSPMFrSOklfZq+si3TziJ9x3inTq8V/k5204MGzOqCA9F2B6t0eSQSx3i7Hkm+IdPy4
         wjzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UVUZSZmN0wfjBDMswnzLJO1IiNBLG8FZGAX4PW0SLkk=;
        b=onxp7FADVsujDym7A+NZEQmuKQ99/bFT1OgFXIxPCVUcwGOg5Xl8om9iaJ0HMbsQ8M
         aPihbZ41M+KCPGJUBD1pdWgpEXrFLpiLg3JOhOvr1nTbSVqbd33m7Qma8XBt8UQhjBAY
         Np7mq0Ek7lr1iO477Xu+m2aRN5sElVN8fTsu2saRVx8/nVqgmCHTbIW+lo9cGDSQ+mBX
         AAcxLDhczaSFHKqSUdIETShUEqfFiOBP+AXV2t/gxy8h/3y4Ic/BrDzUXmiacJzXkXGm
         04bDy3Q3OuBYrtEBX2pM3fCetKKG9lELwFELHNyWSHFtMnoI40xFno6t6Qv/gnsNBbW8
         BPpA==
X-Gm-Message-State: ANhLgQ03ImGn6uljcFtlPtAddlR2KX6e+rj0Qf2oeBBsl6kvOuToTw8Y
        n+2SLLhS/ikois2CCQzFu4A=
X-Google-Smtp-Source: ADFU+vtB4leTBTZjE63gAMA35Rvm5e8MjeaU9ZkT+abole1ttsY0G4cq73QxN4AY1ERoj9DLZr9ndA==
X-Received: by 2002:a17:90b:30ca:: with SMTP id hi10mr24931835pjb.113.1584968978640;
        Mon, 23 Mar 2020 06:09:38 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([131.107.147.210])
        by smtp.googlemail.com with ESMTPSA id u14sm12262034pgg.67.2020.03.23.06.09.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Mar 2020 06:09:37 -0700 (PDT)
From:   ltykernel@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        liuwe@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
Subject: [PATCH V2 0/6] x86/Hyper-V: Panic code path fixes
Date:   Mon, 23 Mar 2020 06:09:18 -0700
Message-Id: <20200323130924.2968-1-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

This patchset fixes some issues in the Hyper-V panic code path.
Patch 1 resolves issue that panic system still responses network
packets.
Patch 2-3,5-6 resolves crash enlightenment issues.
Patch 4 is to set crash_kexec_post_notifiers to true for Hyper-V
VM in order to report crash data or kmsg to host before running
kdump kernel.

Tianyu Lan (6):
  x86/Hyper-V: Unload vmbus channel in hv panic callback
  x86/Hyper-V: Free hv_panic_page when fail to register kmsg dump
  x86/Hyper-V: Trigger crash enlightenment only once during  system
    crash.
  x86/Hyper-V: Report crash register data or ksmg before  running crash
    kernel
  x86/Hyper-V: Report crash register data when sysctl_record_panic_msg
    is not set
  x86/Hyper-V: Report crash data in die() when panic_on_oops is set

 arch/x86/kernel/cpu/mshyperv.c | 10 ++++++++
 drivers/hv/channel_mgmt.c      |  3 +++
 drivers/hv/vmbus_drv.c         | 55 ++++++++++++++++++++++++++++--------------
 3 files changed, 50 insertions(+), 18 deletions(-)

-- 
2.14.5

