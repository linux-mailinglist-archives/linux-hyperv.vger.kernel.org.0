Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1E6743F2A6
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 Oct 2021 00:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbhJ1WY0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 28 Oct 2021 18:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbhJ1WYZ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 28 Oct 2021 18:24:25 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1783CC061745
        for <linux-hyperv@vger.kernel.org>; Thu, 28 Oct 2021 15:21:58 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id w199-20020a25c7d0000000b005bea7566924so10837485ybe.20
        for <linux-hyperv@vger.kernel.org>; Thu, 28 Oct 2021 15:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=PqjjRvX15zED8OdTh3J1r3VA59T74vznUoYXXlWKQUc=;
        b=e+hAzVuvA6pZEdq7ha9j/xZ/wi+tB54o3Cg4uhZp8Vrfl4yCNs96yhs/i/fR6/f7+U
         M8pGUHDA7w0nSKXzjtwPSgHXl1e4uKsHZw5dXrMqSLxGCVNB8JNbE+auE4zRqRqpS88X
         I3Vtg1f6Hw3cKHJNXydZ+toZKxwe1Zag1CPyoCJh/V0c3i402VDdoTx9FSLEV+tNM6Uc
         0r5t6mv3cYXMd+aHHrNqM3CUYWlFINfbohoBc3XYUGsIqlrk/ZScAUrlPyA4Pe+aeBsB
         zhJi3oPs9R54W8Y485icAVY8fB8lfn0P49ayeDPuEGU6kRdI8zSzhyP7uz2ocGwItbwl
         a0JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=PqjjRvX15zED8OdTh3J1r3VA59T74vznUoYXXlWKQUc=;
        b=TPjMtfKQzm6hebK/wbGW6yjyRWA1tw6844O2WXltPDQ07gHxgTEObMuIH5aSFyE0Vo
         6lppN4+cSNHlqAXVRNPCbJRjfGPBfN09tSD7DHcRy7tE3srwA+BGl1YiIZ6QZ4EKI3rl
         1cnT9g72ut9GJ1zRVQBYkS3tcnv6/yabXltexkI4m8+2e24CP8K74RKi9wG7cAsGKRxR
         YtxqqtrDmiEAt4Yve361xEfbFwi3pV03rQdhTeblTA7Q2I/g+OAn6lwG5P2WxU5GBYzo
         /NhBRxjelcuWJESMvMirbhJVpcwvm6tBSJQnokqTjqowdoTK1i82wYXwfEHeMa7TCUuD
         C12A==
X-Gm-Message-State: AOAM533rer6etT2wpC6xmYm/O1PvYafcvb1oioa2opRdipmJ47yAhem+
        PWDk4mQZOV6eTXN/SpTmwhBf3JY4sQs=
X-Google-Smtp-Source: ABdhPJx5X6GZdx3nKSM3DFNGC4xUMnmjf5Z6+uBL2u8x5+06D3F+RbR57apuMl+589B0v/rWWayC5rs4Kyw=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:cbc8:1a0d:eab9:2274])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1029:: with SMTP id
 x9mr8512263ybt.67.1635459717288; Thu, 28 Oct 2021 15:21:57 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 28 Oct 2021 15:21:46 -0700
Message-Id: <20211028222148.2924457-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH 0/2] x86/hyperv: Bug fix and what I hope is an enhancement
From:   Sean Christopherson <seanjc@google.com>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Patch 01 is a fix for a NULL pointer deref that I ran into with a bad VMM
configuration.

Patch 02 effectively makes the required MSRs mandatory for recognizing
Hyper-V at all.  I'm not confident this is truly desirable, e.g. there
might be some features that are still kinda sorta usable, but on the other
hand there's a large pile of features that end up being a waste of cycles
to worm their way back to the native ops.

QEMU 5.1 (and other versions) makes it all too easy to advertise Hyper-V
and a slew of features without advertising the Hyper-V HYPERCALL MSR, e.g.
forcing QEMU features +hv-ipi,+hv-tlbflush,+hv-vpindex,+hv-reenlightenment
advertises a bunch of things, but not the HYPERCALL MSR.

That results in the guest identifying Hyper-V and setting a variety of PV
ops that then get ignored because hyperv_init() silently disables Hyper-V
for all intents and purposes.  The VMM (or its controller) is obviously
off in the weeds, but ideally the guest kernel would acknowledge the bad
setup in some way.

Sean Christopherson (2):
  x86/hyperv: Fix NULL deref in set_hv_tscchange_cb() if Hyper-V setup
    fails
  x86/hyperv: Move required MSRs check to initial platform probing

 arch/x86/hyperv/hv_init.c      | 16 +++++++---------
 arch/x86/kernel/cpu/mshyperv.c | 20 +++++++++++++++-----
 2 files changed, 22 insertions(+), 14 deletions(-)

-- 
2.33.0.1079.g6e70778dc9-goog

