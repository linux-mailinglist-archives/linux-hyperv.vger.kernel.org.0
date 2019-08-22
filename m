Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9558E996A1
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Aug 2019 16:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733137AbfHVOaf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 22 Aug 2019 10:30:35 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33262 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732789AbfHVOaf (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 22 Aug 2019 10:30:35 -0400
Received: by mail-pl1-f193.google.com with SMTP id go14so3581696plb.0;
        Thu, 22 Aug 2019 07:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tDRFmgdNOn89BNEOePAuDKx2szX/hZIctu/3Yr6F4SY=;
        b=GcpWx0alS4jSrHm66E2XU1peda1oBep0K+w9L2px9b14LBgA6xy/ISrhhtK8mg/w/4
         TnFvf9R3krlEFyZKKwmrRU4OArQX0zpLujT73xRdF9X01F3Cd5zpDgPJxQrmV7DiR/4J
         CoxdcK/1ItS1/h3ShD4cilXzjv+bV4Nqxqg9i4zmIfntX9EqBFFM3hqTCFxmjil19oKO
         L51GUnnnMAIqdELQclX+fpHjdEmFZlf/9wsWhQqMab8go17GiyzYwqtG6aFDErp4b2VI
         D1tQaHItI8JQiK35fs7BLtTxXxpz+UBcujtZihIsLRZH6i+Ri+NRjgwEb22bMgEEkmtH
         EApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tDRFmgdNOn89BNEOePAuDKx2szX/hZIctu/3Yr6F4SY=;
        b=jpWiTad/eRvYU3L6aIAb8NwbYI8x/qbejtXIGJJSsrUyk7nx9SDe4ouxFoHQDOcVw1
         44m9DuId2ZYTBCsc/2ln9HOqdPksiZzMpxJq9I5PESMOISggl+E1UGPIzaKoX+361Rzm
         AYK4/JSWgof7CFrd44Y8lP6FF8WvXoowJza0XloY9w/ZbKWsfellbb+MICwRrd1TTG4d
         Q5YGr8ufb2pfej4+oeK/ISF2JSLFXOfgaaGvEGnRjipCuEgWJNeB7Mi2ZhBeqRA2HtUh
         cenJqqBW8Sd4cz3xNZxPC39mPtwHlmIpbBynx5hbaZMqi3QCVw2KnA5REUA7mGyP7+we
         TQHg==
X-Gm-Message-State: APjAAAWlLx8wluPJsw8QYf8dVhXC0oNcqeJ/vASyBuvhLt7ZuVQ2C/Ku
        EQPPr0HW1J4lfDJ0pWx/szc=
X-Google-Smtp-Source: APXvYqw3uqWAVTZJzp78Lvd64ZCkRs9PAqZfr8g9qiVxMHxM+hHWnzzYrq4pCpeuhee1evkxC8YUiQ==
X-Received: by 2002:a17:902:8649:: with SMTP id y9mr36937329plt.252.1566484234243;
        Thu, 22 Aug 2019 07:30:34 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([167.220.255.114])
        by smtp.googlemail.com with ESMTPSA id r23sm32263161pfg.10.2019.08.22.07.30.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Aug 2019 07:30:33 -0700 (PDT)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     pbonzini@redhat.com, rkrcmar@redhat.com, corbet@lwn.net,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkuznets@redhat.com
Subject: [PATCH V4 0/3] KVM/Hyper-V: Add Hyper-V direct tlb flush support
Date:   Thu, 22 Aug 2019 22:30:18 +0800
Message-Id: <20190822143021.7518-1-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

This patchset is to add Hyper-V direct tlb support in KVM. Hyper-V
in L0 can delegate L1 hypervisor to handle tlb flush request from
L2 guest when direct tlb flush is enabled in L1.

Patch 2 introduces new cap KVM_CAP_HYPERV_DIRECT_TLBFLUSH to enable
feature from user space. User space should enable this feature only
when Hyper-V hypervisor capability is exposed to guest and KVM profile
is hided. There is a parameter conflict between KVM and Hyper-V hypercall.
We hope L2 guest doesn't use KVM hypercall when the feature is
enabled. Detail please see comment of new API "KVM_CAP_HYPERV_DIRECT_TLBFLUSH"

Change since v3:
       - Update changelog in each patches. 

Change since v2:
       - Move hv assist page(hv_pa_pg) from struct kvm  to struct kvm_hv.

Change since v1:
       - Fix offset issue in the patch 1.
       - Update description of KVM KVM_CAP_HYPERV_DIRECT_TLBFLUSH.

Tianyu Lan (2):
  x86/Hyper-V: Fix definition of struct hv_vp_assist_page
  KVM/Hyper-V: Add new KVM capability KVM_CAP_HYPERV_DIRECT_TLBFLUSH

Vitaly Kuznetsov (1):
  KVM/Hyper-V/VMX: Add direct tlb flush support

 Documentation/virtual/kvm/api.txt  | 13 +++++++++++++
 arch/x86/include/asm/hyperv-tlfs.h | 24 ++++++++++++++++++-----
 arch/x86/include/asm/kvm_host.h    |  4 ++++
 arch/x86/kvm/vmx/evmcs.h           |  2 ++
 arch/x86/kvm/vmx/vmx.c             | 39 ++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/x86.c                 |  8 ++++++++
 include/uapi/linux/kvm.h           |  1 +
 7 files changed, 86 insertions(+), 5 deletions(-)

-- 
2.14.5

