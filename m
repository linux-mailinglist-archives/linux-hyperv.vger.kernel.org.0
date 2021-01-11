Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189962F11AC
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Jan 2021 12:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbhAKLmy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 11 Jan 2021 06:42:54 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:40864 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729674AbhAKLmy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 11 Jan 2021 06:42:54 -0500
Received: by mail-wm1-f43.google.com with SMTP id r4so14730905wmh.5;
        Mon, 11 Jan 2021 03:42:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=kU+5ZIShFLlRS86WVYUr53zj33ppDQeh+yN7XDrg+rs=;
        b=pTYstYvpljE+S/9IFfoWfAMlgiuVXkRrookSDTmdk0qSX6bwOZ12IZl5CHnzobebuX
         MIXPsAMBAOW2bc9y/hg1ysanHNdaa5ro1KJVpLNjhs/zBjZbGXvjPhoNo9ZTeivzYg/i
         eqVQ/88lseWK0OJ4OUSwZOx0JA/RaO3Vv/aHD4FhhtNE/lUPEgAepO/+UQ/fb4GCY1hW
         5rWa/nLWUNUOhPiqEGI1/JHIf3sY8ejpPwNQRmsv4AwjsGZg5sQCDTh5fZdbbnopPU7X
         O9I80ceKfuBAR+Pi6FtcE+OzWSj2BoZtyohxYMWO0e/wvIbttpOyXkk+co7Y5FjLKTjM
         adwQ==
X-Gm-Message-State: AOAM531ZM7IpxZOVNs2Gwtdu35Wxv61c+W2dxCH7WxugH2AKueqIC1gH
        4QsYd/kZCYTzcyY2iSMciKKgjP8lqVQ=
X-Google-Smtp-Source: ABdhPJxabsakOLEUzPpm8QyqqUvVMzaaP2huKpM8HcMnzo8WHAzPXp/5mVsvqwe1RZ1159LnCi+S8A==
X-Received: by 2002:a7b:cf37:: with SMTP id m23mr14227433wmg.37.1610365332633;
        Mon, 11 Jan 2021 03:42:12 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id a14sm23765945wrn.3.2021.01.11.03.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 03:42:12 -0800 (PST)
Date:   Mon, 11 Jan 2021 11:42:10 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wei Liu <wei.liu@kernel.org>, kys@microsoft.com,
        sthemmin@microsoft.com, haiyangz@microsoft.com,
        Michael Kelley <mikelley@microsoft.com>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Hyper-V fixes for 5.11-rc4
Message-ID: <20210111114210.zpuskk7pct6ibf6d@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Linus,

The following changes since commit e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62:

  Linux 5.11-rc2 (2021-01-03 15:55:30 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20210111

for you to fetch changes up to ad0a6bad44758afa3b440c254a24999a0c7e35d5:

  x86/hyperv: check cpu mask after interrupt has been disabled (2021-01-06 11:03:16 +0000)

----------------------------------------------------------------
hyperv-fixes for 5.11-rc4
  - One patch from Dexuan Cui to fix kexec panic/hang
  - One patch from Wei Liu to fix occasional crashes when flushing TLB
----------------------------------------------------------------
Dexuan Cui (1):
      x86/hyperv: Fix kexec panic/hang issues

Wei Liu (1):
      x86/hyperv: check cpu mask after interrupt has been disabled

 arch/x86/hyperv/hv_init.c       |  4 ++++
 arch/x86/hyperv/mmu.c           | 12 +++++++++---
 arch/x86/include/asm/mshyperv.h |  2 ++
 arch/x86/kernel/cpu/mshyperv.c  | 18 ++++++++++++++++++
 drivers/hv/vmbus_drv.c          |  2 --
 5 files changed, 33 insertions(+), 5 deletions(-)
