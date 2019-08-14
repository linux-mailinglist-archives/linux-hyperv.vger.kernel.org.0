Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBDBB8CCF0
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Aug 2019 09:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfHNHe6 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 14 Aug 2019 03:34:58 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46236 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfHNHe6 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 14 Aug 2019 03:34:58 -0400
Received: by mail-pf1-f193.google.com with SMTP id q139so4786687pfc.13;
        Wed, 14 Aug 2019 00:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RHOMr4ptKfjquPk5bhUDtq5uLFKfISVcupJSVaOf/TA=;
        b=FBi/8nGE8HcVC+P34RYHPJ9g24kSlA2MLqh/h6tXLHEDmsvkRu1ZcmKJQYTkbdfJoJ
         cBACdIbmQsqSzhry0zkObXx60Y4ZEqjl2lMl2vqZ+ku+oDS1mPhZjBcB5E3VTa+jgzOd
         f+Vzm3pjeyQOzUd6R34loEr9V6PZmL1m718Dh3pY+Xp1b3AAsP9UPbTZAswnZRMq0BlY
         lVkenWT/0tKIjO22TX713kE+0k6mMfZh5loTOnBiJTf3cMX+YwZ/4jsFGO896yPUQMSM
         7ppi95qVM1xYvbnqaTKZ8MXiDlCVpIFgvaLyaj2W1oeza8FJwleyN1+bWf2fBiIuP8XK
         HLlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RHOMr4ptKfjquPk5bhUDtq5uLFKfISVcupJSVaOf/TA=;
        b=f5ca3j0wnw5wkiBdoJkDYhXkZrjvY/hktiErP6u4nqs+u/Mn62xdVao8M3W8A6/leI
         jOAcyyFw56NAlGa20kPVWUKF9B/y8F4F8HtvHcYF8X9u4O6Bm2k01lm9LoKjZb8Qb8xs
         Q8wBR4uM8jlihgcapBfw8/0aKcDXjUH8X37HuqbSERZT7PJUPJ7/HbTPm9i/295CO9/P
         azF8VWMKlXF3MLszijohhNLeYCaXjbAqWW3mNEmuyTeU4zqNCDa4w7Fgyh0gnPhgN/Pe
         nHJ2IzXNIDc5s1Gsxs4QA02/NrUa7vnHjEzLxjW5JVCwm6bmQX5JApvzx+LKwEv4qKxh
         Gzrg==
X-Gm-Message-State: APjAAAVZGXpqm9JFxkhxxDLl/F2wGQpQVrEzxiHN2xPmo274+vddzr9r
        gigc9jHCVNdZIYV7FnzrmpE=
X-Google-Smtp-Source: APXvYqznL4dsNbQONSJciPqTQxe+yFkIGRzx4cM9Q0lLHaDfbY7p0gHdYdXVzAJPhJQVqIjLYM32gQ==
X-Received: by 2002:a17:90a:9202:: with SMTP id m2mr5879136pjo.16.1565768097390;
        Wed, 14 Aug 2019 00:34:57 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([167.220.255.114])
        by smtp.googlemail.com with ESMTPSA id v184sm109639230pfb.82.2019.08.14.00.34.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Aug 2019 00:34:56 -0700 (PDT)
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
Subject: [PATCH V2 0/3] KVM/Hyper-V: Add Hyper-V direct tlb flush support
Date:   Wed, 14 Aug 2019 15:34:44 +0800
Message-Id: <20190814073447.96141-1-Tianyu.Lan@microsoft.com>
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

Change since v1:
       - Fix offset issue in the patch 1.
       - Update description of KVM KVM_CAP_HYPERV_DIRECT_TLBFLUSH.

Tianyu Lan (2):
  x86/Hyper-V: Fix definition of struct hv_vp_assist_page
  KVM/Hyper-V: Add new KVM cap KVM_CAP_HYPERV_DIRECT_TLBFLUSH

Vitaly Kuznetsov (1):
  KVM/Hyper-V/VMX: Add direct tlb flush support

 Documentation/virtual/kvm/api.txt  | 12 ++++++++++++
 arch/x86/include/asm/hyperv-tlfs.h | 24 +++++++++++++++++++-----
 arch/x86/include/asm/kvm_host.h    |  2 ++
 arch/x86/kvm/vmx/evmcs.h           |  2 ++
 arch/x86/kvm/vmx/vmx.c             | 38 ++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/x86.c                 |  8 ++++++++
 include/linux/kvm_host.h           |  1 +
 include/uapi/linux/kvm.h           |  1 +
 8 files changed, 83 insertions(+), 5 deletions(-)

-- 
2.14.5

