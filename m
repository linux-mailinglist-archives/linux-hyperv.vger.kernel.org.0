Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C201B42511A
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Oct 2021 12:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240868AbhJGKeu (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 Oct 2021 06:34:50 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:35651 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240726AbhJGKet (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 Oct 2021 06:34:49 -0400
Received: by mail-wr1-f45.google.com with SMTP id v25so17530521wra.2;
        Thu, 07 Oct 2021 03:32:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=7Xmki6fF5vViToxMGr5FsbK+wRiXFgs+grhsOFW8tw8=;
        b=a28XSEkKiz4p86tIVi7YKyczw/bYhQiaegN3iF/G3lG9K6RsEMxSl4i6sSqdJXwACA
         SqJrRt23Mx/T838GyTAVcaSpViUWCxxPp87KUVVOXnRmQW1Qgxx0Jn8NUhc4I+flAm5u
         xlJXuYjxU5uA/xjMCGAGleIkCKmHF7lAQduxUqUob8nPLKMc3t0/9iuhEclMQzgytHBG
         IrbT1r3xCUa7/ZEKYhWnQ6VoPRXiCXmUC+ru7A7gwMuAlI6KDtykIrt7TsexrtezT1iH
         Sc5BvjvcqSO7xKPn1Z2u8lFgVccvfqrr3D8dBZeKnzJv9MEfHZHS011Hkju2u6vGizAw
         Dr9w==
X-Gm-Message-State: AOAM531DSIXW8QsmCN7c8ZZEOaG9xhB+fP53wcWrIkdFGG10/JbUthw7
        nEmmKnUpxJlel+OKnSo09onRrJpSmHY=
X-Google-Smtp-Source: ABdhPJwLMoMHFNctErtMFmGemYZdEZ8XXA36zgtdDZN5fAfcY7qMGN/l5Vyo5LLTXaQCpJe5+VwrIw==
X-Received: by 2002:a5d:64e9:: with SMTP id g9mr4364354wri.99.1633602774988;
        Thu, 07 Oct 2021 03:32:54 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id d7sm24080006wrh.13.2021.10.07.03.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 03:32:54 -0700 (PDT)
Date:   Thu, 7 Oct 2021 10:32:53 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, decui@microsoft.com, sthemmin@microsoft.com
Subject: [GIT PULL] Hyper-V fixes for 5.15-rc8
Message-ID: <20211007103253.t5w5pgpmzvkffvwp@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Linus,

The following changes since commit dfb5c1e12c28e35e4d4e5bc8022b0e9d585b89a7:

  x86/hyperv: remove on-stack cpumask from hv_send_ipi_mask_allbutself (2021-09-11 15:41:00 +0000)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20211007

for you to fetch changes up to f5c20e4a5f18677e22d8dd2846066251b006a62d:

  x86/hyperv: Avoid erroneously sending IPI to 'self' (2021-10-06 15:56:45 +0000)

----------------------------------------------------------------
hyperv-fixes for 5.15
  - Replace uuid.h with types.h in a header (Andy Shevchenko)
  - Avoid sleeping in atomic context in PCI driver (Long Li)
  - Avoid sending IPI to self when it shouldn't (Vitaly Kuznetsov)

----------------------------------------------------------------
Andy Shevchenko (1):
      hyper-v: Replace uuid.h with types.h

Long Li (1):
      PCI: hv: Fix sleep while in non-sleep context when removing child devices from the bus

Vitaly Kuznetsov (1):
      x86/hyperv: Avoid erroneously sending IPI to 'self'

 arch/x86/hyperv/hv_apic.c           | 20 +++++++++++++++-----
 drivers/pci/controller/pci-hyperv.c | 13 ++++++++++---
 include/uapi/linux/hyperv.h         |  2 +-
 3 files changed, 26 insertions(+), 9 deletions(-)
