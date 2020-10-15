Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71E528F6D6
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Oct 2020 18:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388946AbgJOQcy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 15 Oct 2020 12:32:54 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40083 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389147AbgJOQcy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 15 Oct 2020 12:32:54 -0400
Received: by mail-wm1-f68.google.com with SMTP id k18so4430795wmj.5;
        Thu, 15 Oct 2020 09:32:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ZxyFlDAhLqNGLQjK2TRdoeg3UYe4lOP/y4EhwxNytxE=;
        b=HN0+XPLcW6Lp6yv0UtebRqdviGB+EqMcUn4DZzMyPEVftjEs0TuyhHvhSD6UNVnpVH
         pd3ErnvOPpLxE9WKOt2SgAA9jkKAX1pAYl/PIYtOLmNNF5thtCvdjODGlH0qS28Tx5y2
         eDyuiYDPq3YMJd8bD4xFimKu25wQonc3BjWMghmJ8ML9TzbfrsGQRKzBmdgohIZkUZjo
         xDUoKQHIm52XCMD2coicOjCm4cMWkMtfc7upFDAu+YbLZ1YuXwywKAa5aH1HwpUUSdfK
         +/DAP97MxtSkRlF2ZLukfYbYn0gQFP1RRakq//+54iGpbQVBu2SPSHHXx1ynZRDBBXhX
         +/Zw==
X-Gm-Message-State: AOAM530h2kpEExafNgY533tf388dGaE4sXBfQD/F83jFmn8JW9twzRzJ
        KLNdcJ0nTWkD4XCG9aeXnk0=
X-Google-Smtp-Source: ABdhPJw6HiJGqJxS1+Zb3VqlF2TFDHUHFtD0tYhEBtYjob+4ZCuHBwhp2Q8mvVMLA9LRnYQpXEwaxA==
X-Received: by 2002:a1c:bd0a:: with SMTP id n10mr4844493wmf.177.1602779570750;
        Thu, 15 Oct 2020 09:32:50 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id a3sm4882848wmb.46.2020.10.15.09.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 09:32:50 -0700 (PDT)
Date:   Thu, 15 Oct 2020 16:32:48 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wei Liu <wei.liu@kernel.org>, kys@microsoft.com,
        sthemmin@microsoft.com, haiyangz@microsoft.com,
        Michael Kelley <mikelley@microsoft.com>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Hyper-V commits for 5.10, part 2
Message-ID: <20201015163248.yo3ior67vxtvojra@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Linus,

I accidentally dropped one patch that was supposed to be merged in this
merge window from my first pull request.

Please pull the following changes since commit 1f3aed01473c41c9f896fbf4c30d330655e8aa7c:

  hv: clocksource: Add notrace attribute to read_hv_sched_clock_*() functions (2020-09-28 09:04:48 +0000)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed

for you to fetch changes up to 626b901f60446355e35e8c76c6b391a7d7491203:

  Drivers: hv: vmbus: Add parsing of VMbus interrupt in ACPI DSDT (2020-10-14 19:14:51 +0000)

----------------------------------------------------------------
hyperv-next for 5.10, part 2

  - One patch from Michael to get VMbus interrupt from ACPI DSDT

----------------------------------------------------------------
Michael Kelley (1):
      Drivers: hv: vmbus: Add parsing of VMbus interrupt in ACPI DSDT

 arch/x86/include/asm/mshyperv.h |  1 +
 arch/x86/kernel/cpu/mshyperv.c  |  7 ++++++-
 drivers/hv/hv.c                 |  2 +-
 drivers/hv/vmbus_drv.c          | 30 +++++++++++++++++++++++++++---
 include/asm-generic/mshyperv.h  |  4 +++-
 5 files changed, 38 insertions(+), 6 deletions(-)
