Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84DD41A7859
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Apr 2020 12:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438295AbgDNKYS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 14 Apr 2020 06:24:18 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45635 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438287AbgDNKVV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 14 Apr 2020 06:21:21 -0400
Received: by mail-wr1-f65.google.com with SMTP id t14so435278wrw.12;
        Tue, 14 Apr 2020 03:21:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=EYaPeiECDQ5ZXShj8p9XCOhGGkLuneAOUv8e9e/QTQQ=;
        b=BXtTxS6Nh9AGjbv+xl5m6pltKvjPF5MhpJyV1UeseGEI/3AHg1SbjFEAJPQkYpH/e+
         BpVlbG7cEeX/35AMpXYA0cXNHEcpp31zKtJJOrlFVhYYNB3gJoknc2whOpbMj1MYkboM
         46nFM2olpVR8VbTH8/LfUQDxDhSW7/p8DIYkO191Jhvbjx/jGxD8E3ADjVWsLN3VbB0L
         +e1VU9+4OU+CFpfgN35AWFitjrjgEIPP6ShTFolWQQtNbqXAr+J+3F27WOWnP6KLaWBq
         SZ41OVXt2S/3+rrmSfKR2Azdxh2Ao5UsQZ2ZlCZ4x5iShADVesNsmVmM2XxgfQmn8ZSH
         FWXA==
X-Gm-Message-State: AGi0PuYqkrFEOMhwiA4h3McYK0tM57tlSLOH0syLHo/SZ/Qscq3ntRhy
        OW1f/n/0Z/F9anFIMi4xVfg=
X-Google-Smtp-Source: APiQypJfL641U3oiX9dTXxf/ghp8OKYDWYbORn6FwzR3xNZYsyAebrfet+aQW3p3qkLc/MCFbrsuHA==
X-Received: by 2002:a5d:6584:: with SMTP id q4mr11223043wru.403.1586859664926;
        Tue, 14 Apr 2020 03:21:04 -0700 (PDT)
Received: from debian (44.142.6.51.dyn.plus.net. [51.6.142.44])
        by smtp.gmail.com with ESMTPSA id t16sm17621540wmi.27.2020.04.14.03.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 03:21:04 -0700 (PDT)
Date:   Tue, 14 Apr 2020 11:21:02 +0100
From:   Wei Liu <wei.liu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wei Liu <wei.liu@kernel.org>, kys@microsoft.com,
        sthemmin@microsoft.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        haiyangz@microsoft.com
Subject: [GIT PULL] Hyper-V fixes for 5.7-rc1
Message-ID: <20200414102102.7jci4pzsp5tdoifr@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Linus,

Please pull from the tag hyperv-fixes-signed for the first batch of
Hyper-V fixes for 5.7-rc.

The following changes since commit fb33c6510d5595144d585aa194d377cf74d31911:

  Linux 5.6-rc6 (2020-03-15 15:01:23 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed

for you to fetch changes up to f3a99e761efa616028b255b4de58e9b5b87c5545:

  x86/Hyper-V: Report crash data in die() when panic_on_oops is set (2020-04-11 17:19:07 +0100)

----------------------------------------------------------------
hyperv-fixes for 5.7-rc1

  - Patch series from Tianyu Lan to fix crash reporting on Hyper-V
  - Three miscellaneous cleanup patches

----------------------------------------------------------------
Gustavo A. R. Silva (1):
      hv: hyperv_vmbus.h: Replace zero-length array with flexible-array member

Olaf Hering (1):
      x86: hyperv: report value of misc_features

Tianyu Lan (6):
      x86/Hyper-V: Unload vmbus channel in hv panic callback
      x86/Hyper-V: Free hv_panic_page when fail to register kmsg dump
      x86/Hyper-V: Trigger crash enlightenment only once during system crash.
      x86/Hyper-V: Report crash register data or kmsg before running crash kernel
      x86/Hyper-V: Report crash register data when sysctl_record_panic_msg is not set
      x86/Hyper-V: Report crash data in die() when panic_on_oops is set

YueHaibing (1):
      hv_debugfs: Make hv_debug_root static

 arch/x86/hyperv/hv_init.c      |  6 +++-
 arch/x86/kernel/cpu/mshyperv.c | 14 ++++++++--
 drivers/hv/channel_mgmt.c      |  3 ++
 drivers/hv/hv_debugfs.c        |  2 +-
 drivers/hv/hyperv_vmbus.h      |  2 +-
 drivers/hv/vmbus_drv.c         | 62 ++++++++++++++++++++++++++++++------------
 include/asm-generic/mshyperv.h |  2 +-
 7 files changed, 67 insertions(+), 24 deletions(-)
