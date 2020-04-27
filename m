Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 713721BA236
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2020 13:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgD0LTu (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 27 Apr 2020 07:19:50 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34448 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbgD0LTu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 27 Apr 2020 07:19:50 -0400
Received: by mail-wm1-f65.google.com with SMTP id v4so15707721wme.1;
        Mon, 27 Apr 2020 04:19:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=nxQk4cEc0aiSGCEEBf1pbnwbO1uRcVsKiwXYVrEzomM=;
        b=TEriAgfo/JwWsqNtPYb2ZmmZgMba65g3iFLb7ElM/BX5qL4dMIixo4iGySqYDj/FNx
         Y69PTly26+ud+bzWgovwTvGlOI4w45oqUxHI8R2CM72whn5j7oMWOk0SfDpc661kFaem
         KnGO9j5/Fuh3kvj3r4a9NVl+VQTW9HkF7psKybzwx2nkJA+F++RSswNFPRze4E4+oXs7
         FVhU1QqR6V9sdK9W+OVdLIweByKllH1WVI0QkmVyLzkVacUaCzq31/zlHzY1EzvpVtV0
         f/W85Wb20igxIYNA/dIEVuVpYNAk6nmvD/o0Tm5kscR/XhrhhN557pcAXyh8ixyMWPz+
         grnQ==
X-Gm-Message-State: AGi0PuYEnQ+ASE1N/6J7bp6ofb8jyV+rSnW3BM6mNM/QA+tv6oIMJf93
        OAPWqrmWW8Lru3FzfjB3frc=
X-Google-Smtp-Source: APiQypJ3tLDw/B9cJp+h+N49181NXJK1IyEIZ0rry8f+0usSARqtE+0sepnxxtHL84+7T+2ABET+3Q==
X-Received: by 2002:a1c:4b15:: with SMTP id y21mr25802152wma.150.1587986388306;
        Mon, 27 Apr 2020 04:19:48 -0700 (PDT)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id s8sm20648434wru.38.2020.04.27.04.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 04:19:47 -0700 (PDT)
Date:   Mon, 27 Apr 2020 11:19:45 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>, kys@microsoft.com,
        sthemmin@microsoft.com, haiyangz@microsoft.com
Subject: [GIT PULL] Hyper-V commits for 5.7-rc4
Message-ID: <20200427111945.6qdvgimt3nt3ja57@liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Linus

Please pull the following changes since commit
f3a99e761efa616028b255b4de58e9b5b87c5545:

  x86/Hyper-V: Report crash data in die() when panic_on_oops is set (2020-04-11 17:19:07 +0100)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed

for you to fetch changes up to f081bbb3fd03f949bcdc5aed95a827d7c65e0f30:

  hyper-v: Remove internal types from UAPI header (2020-04-22 21:10:05 +0100)

----------------------------------------------------------------
hyperv-fixes for 5.7-rc4

 - Two patches from Dexuan fixing suspension bugs
 - Three cleanup patches from Andy and Michael

----------------------------------------------------------------
Andy Shevchenko (2):
      hyper-v: Use UUID API for exporting the GUID
      hyper-v: Remove internal types from UAPI header

Dexuan Cui (2):
      Drivers: hv: vmbus: Fix Suspend-to-Idle for Generation-2 VM
      x86/hyperv: Suspend/resume the VP assist page for hibernation

Michael Kelley (1):
      Drivers: hv: Move AEOI determination to architecture dependent code

 arch/x86/hyperv/hv_init.c       | 12 ++++++++++--
 arch/x86/include/asm/mshyperv.h |  2 ++
 drivers/hv/hv.c                 |  6 +-----
 drivers/hv/hv_trace.h           |  4 ++--
 drivers/hv/vmbus_drv.c          | 43 ++++++++++++++++++++++++++++++++---------
 include/uapi/linux/hyperv.h     |  4 ++--
 6 files changed, 51 insertions(+), 20 deletions(-)
