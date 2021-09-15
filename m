Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F137840C5BA
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Sep 2021 14:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbhIOM42 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 15 Sep 2021 08:56:28 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:39838 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbhIOM42 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 15 Sep 2021 08:56:28 -0400
Received: by mail-wr1-f50.google.com with SMTP id u15so3743602wru.6;
        Wed, 15 Sep 2021 05:55:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=16y5SfDQXr5CzV5bnn7etqRk/KF1HIYhzKh8q2gKtww=;
        b=OLNvQZPSTSq49RA+sFoQoDmSJTUY+QqUheQ0+dUrIMIKLN8Cb9YxwHPjKfhFcxCT8I
         ZhvJk5RmxhtYMeM7oI+4+Hbh0eC1VHV+F6j2sHhwyKnl41NdnZ59BqRDGFNpW7UgJEGV
         /HInMgM7kSCsvuzbY3owAjXqF7QDFN8y5p+IDt+h/IhPbWtjjJxy7dMI+jFsqiUj2h5W
         c7fXr3dgKhdbQhJ+Q85JxKBmOjr2j4TFNV0KFatnq9eSetPp2yWqMn93D/02Y5DO4Acu
         6YPC/wbTzo9z2hFyuQYK4d/j3Mg6B8D4tyZxzh2zDrUV+cllKLFtR4h6VlC4cNPVuces
         F9AQ==
X-Gm-Message-State: AOAM531MzDjCq+MmVVDLW1KWbE19pkuUALtxw7DvQvf7UUqrrUksdP4V
        7bLk5RsxGh33i6kILgZSu0w=
X-Google-Smtp-Source: ABdhPJynpNhVOcF1KcYdNT9DL2nnD/c+XXUG+ZMvUU10bKhhC2kmV+1DIybnCJESewF/z/Elh4EIKg==
X-Received: by 2002:a05:6000:2cf:: with SMTP id o15mr2731076wry.364.1631710508566;
        Wed, 15 Sep 2021 05:55:08 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id q7sm10166178wrr.10.2021.09.15.05.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 05:55:07 -0700 (PDT)
Date:   Wed, 15 Sep 2021 12:55:06 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        sthemmin@microsoft.com
Subject: [GIT PULL] Hyper-V fixes for 5.15-rc2
Message-ID: <20210915125506.4zra6p2b7qu7fz4d@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Linus

The following changes since commit 7d2a07b769330c34b4deabeed939325c77a7ec2f:

  Linux 5.14 (2021-08-29 15:04:50 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20210915

for you to fetch changes up to dfb5c1e12c28e35e4d4e5bc8022b0e9d585b89a7:

  x86/hyperv: remove on-stack cpumask from hv_send_ipi_mask_allbutself (2021-09-11 15:41:00 +0000)

----------------------------------------------------------------
hyperv-fixes for 5.15-rc2
  - Fix kernel crash caused by uio driver (Vitaly Kuznetsov)
  - Remove on-stack cpumask from HV APIC code (Wei Liu)
----------------------------------------------------------------
Vitaly Kuznetsov (1):
      Drivers: hv: vmbus: Fix kernel crash upon unbinding a device from uio_hv_generic driver

Wei Liu (2):
      asm-generic/hyperv: provide cpumask_to_vpset_noself
      x86/hyperv: remove on-stack cpumask from hv_send_ipi_mask_allbutself

 arch/x86/hyperv/hv_apic.c      | 43 +++++++++++++++++++++++++-----------------
 drivers/hv/ring_buffer.c       |  1 +
 include/asm-generic/mshyperv.h | 21 +++++++++++++++++++--
 3 files changed, 46 insertions(+), 19 deletions(-)
