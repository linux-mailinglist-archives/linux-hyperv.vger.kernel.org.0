Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13399403FF3
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Sep 2021 21:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350604AbhIHTn4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 8 Sep 2021 15:43:56 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:44791 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235043AbhIHTnz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 8 Sep 2021 15:43:55 -0400
Received: by mail-wr1-f54.google.com with SMTP id d6so4884123wrc.11
        for <linux-hyperv@vger.kernel.org>; Wed, 08 Sep 2021 12:42:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ePrC4gam/Smx2WOkX8yEMb+46laSjQab0O9CYUJMDJA=;
        b=28JXHiVc+L1Jl2Dv6k5qwIIkkCIipj8FZyZ0ZcjSNQYOSoyd1k/h+dc6n8C0YdT9e0
         V49QhQovtJNtfHDvyhawkL+WRQaKi/oU1ycaAA0JlvE5ahFDpPN6fu56C8oqrkVJ0vcU
         q+gBVVQFXtwDTDGQmAHCsYfFJdi6vSIdVLBcOCqROqsg+V8sv8Ix3t9um6RaqMpYBIX5
         Bc/Tv82onk/zkyKODsZXA5Q6Y+vk+4NGLol2HJ6M8R41ebmEtb4sqp3riLmpuLwOmH0+
         bc1POvL9SUb67ta8HQ9KO4Oto4ahupmthfeNaIhBOI8IUcsDhu3GpEawzrg/bzLl8HJy
         w7tQ==
X-Gm-Message-State: AOAM530Hs3Hm8bQJDwP+9sx9Z2f4kIYn53lTSOmlWmNRDHeOY8kKUir3
        sPXGen0rnUQbVsc9pX5I6jRTxpPZS94=
X-Google-Smtp-Source: ABdhPJzi8ZdhOB/VWn4LmgxXiIfgFHO1TScuscCLMgCmYo5SCz/IxeaDTkHkdU/29qa5yl9jDSI9DQ==
X-Received: by 2002:adf:c184:: with SMTP id x4mr7922wre.266.1631130166471;
        Wed, 08 Sep 2021 12:42:46 -0700 (PDT)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id p5sm72852wrd.25.2021.09.08.12.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 12:42:45 -0700 (PDT)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     Michael Kelley <mikelley@microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, decui@microsoft.com,
        sthemmin@microsoft.com, Wei Liu <wei.liu@kernel.org>
Subject: [PATCH 0/2] Remove on-stack cpumask in hv_apic.c
Date:   Wed,  8 Sep 2021 19:42:41 +0000
Message-Id: <20210908194243.238523-1-wei.liu@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Wei Liu (2):
  asm-generic/hyperv: provide cpumask_to_vpset_noself
  x86/hyperv: remove on-stack cpumask from hv_send_ipi_mask_allbutself

 arch/x86/hyperv/hv_apic.c      | 32 ++++++++++++++++----------------
 include/asm-generic/mshyperv.h | 20 ++++++++++++++++++--
 2 files changed, 34 insertions(+), 18 deletions(-)

-- 
2.30.2

