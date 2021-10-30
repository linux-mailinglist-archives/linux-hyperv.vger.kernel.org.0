Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BACD3440631
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 Oct 2021 02:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbhJ3AKo (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 29 Oct 2021 20:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbhJ3AKk (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 29 Oct 2021 20:10:40 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C4BC061766
        for <linux-hyperv@vger.kernel.org>; Fri, 29 Oct 2021 17:08:11 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id q7-20020a25b007000000b005c1d1377abdso14097709ybf.23
        for <linux-hyperv@vger.kernel.org>; Fri, 29 Oct 2021 17:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=MitYekao9rqnFTXUAu9e8R+/MKTk3btas9HJLycPsWc=;
        b=my9LTkQDSabE3uNrKhMOQ2hYTIoQgwsz/LmNZkzGOHCRzyJkKca1ngJ6utKC9iC1/t
         QhlZalPYJZ3tgsKfRNlq+6LD1g/RkJRw3mpUHu57gpL3p8H4xmmgccC2UXx7yejWm9fR
         rSItlwVGidUiWjDE0OGLnmeeJOFw37ispjN9W2SB+/QIv5hkcfQ4EqQjaYp3VHyHuvqH
         HhZBOmCTkaaUXbGgfSaD/fhTUC4E/H6VJtf1MuAyHpTJpB19zZeudVRj7NzZWeZqDyz0
         KVjRq/ta9HEWXn0OELRkX+g6dFHCrO4QRSGfGSbBT9TEVl8SHHR4+O3IK4ZCX22eO0z/
         12vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=MitYekao9rqnFTXUAu9e8R+/MKTk3btas9HJLycPsWc=;
        b=OxlxYNFNRKdAuEHZ5azLeEr86ZulzyfvrwDQOU4R3w6bZft6k4yGvbS/MVjpiH6XEP
         cuwmcKSGGF9POi/8YD8Sl8AMsqG0BiW5N/GBGsh8cLKs6Waq7Q/KUUALL3CkubbrYFy0
         tJKsS2H8cLeWEKLrU7spMr+uB3u9lBY2jo3ZW3ACuI2j1816I9jFMUIwSgwtnCTCm1qp
         BBEKwyevOVVCOm28OYXtmgXgBj+e1NKY8TC/A5dklt6YLljskkVBz0tpLT2P8rSJt9w3
         hC2988DWntjrxjMdWee0TKZ5z/xhUZSfeyXMKoM4c4xqEEs47vxrC6btnlQbREqN49Wb
         Is1g==
X-Gm-Message-State: AOAM531Ua/YsUi3SojYXRYakf0yaEtdS1xt8vIj4Ra7WNg1HEd1G/6bV
        uGp4JCoYUob2cbzL8P72OSA9W/MjxsI=
X-Google-Smtp-Source: ABdhPJwZ2XQbbdMh4Oubf+Z+oTyEdeydN5FjqJXnMZxUNKnOYppZlMFuqVxKis25KfxbME9PXm4evnP2z0A=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:ce6:9e5f:4ab5:a0d2])
 (user=seanjc job=sendgmr) by 2002:a25:3082:: with SMTP id w124mr15887159ybw.6.1635552490730;
 Fri, 29 Oct 2021 17:08:10 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 29 Oct 2021 17:07:52 -0700
Message-Id: <20211030000800.3065132-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH v2 0/8] KVM: x86: Hyper-V hypercall fix and cleanups
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ajay Garg <ajaygargnsit@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Fix a bug where KVM incorrectly skips an "all_cpus" IPI request, and misc
cleanups and enhancements for KVM handling of Hyper-V hypercalls.

Note, I couldn't find any documentation on the DEBUG hypercalls, I'm
basically just guessing that they don't have a variable sized header
and thus should reject hypercalls with a non-zero VARHEAD field.

Sean Christopherson (8):
  KVM: x86: Ignore sparse banks size for an "all CPUs", non-sparse IPI
    req
  KVM: x86: Get the number of Hyper-V sparse banks from the VARHEAD
    field
  KVM: x86: Refactor kvm_hv_flush_tlb() to reduce indentation
  KVM: x86: Add a helper to get the sparse VP_SET for IPIs and TLB
    flushes
  KVM: x86: Don't bother reading sparse banks that end up being ignored
  KVM: x86: Shove vp_bitmap handling down into sparse_set_to_vcpu_mask()
  KVM: x86: Reject fixeds-size Hyper-V hypercalls with non-zero
    "var_cnt"
  KVM: x86: Add checks for reserved-to-zero Hyper-V hypercall fields

 arch/x86/kvm/hyperv.c             | 172 ++++++++++++++++++------------
 arch/x86/kvm/trace.h              |  14 +--
 include/asm-generic/hyperv-tlfs.h |   7 ++
 3 files changed, 120 insertions(+), 73 deletions(-)

-- 
2.33.1.1089.g2158813163f-goog

