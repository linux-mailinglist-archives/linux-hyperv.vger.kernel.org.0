Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324B91E7F10
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2020 15:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgE2Np6 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 29 May 2020 09:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgE2Np6 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 29 May 2020 09:45:58 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA10EC03E969;
        Fri, 29 May 2020 06:45:57 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f185so3626352wmf.3;
        Fri, 29 May 2020 06:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lt8GDMAcJKU5ya03CSoRbKBcFkXL1yVXIOxpta4MSb8=;
        b=LVrxuwSZmt9IGUEYm/FhDtReg7fS7VlQC1m48P9ftkfwz0YB9ZSmw8NubX768fo6ZF
         x94Dr4f9aTQzWsmxefJKzeL2GKHe0EAgxMkaqNJyyGxyMHNJGaV7NF+Su1IGtOPSAdrI
         E95tQ7LdV7Ox+34FLaq1sxvFCsHxUVkTGdnJEwO4E5sLwEFmWO8WqnXn4IviY7ex0UpA
         +62FzQzuHlQyEnWn37I6PtnIqORtiPDHvHH+jbE9QqW1fvzIQOTvFzixN+lsWQobwRTm
         sW5iAYARcz8TsD1gpObS255gnkrnRHGhJzJKwyJQvSUeLkqoQavkdPENAWpNTDKKV8Qe
         AGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lt8GDMAcJKU5ya03CSoRbKBcFkXL1yVXIOxpta4MSb8=;
        b=b/3fh9l/fP4X9kJtncebsBj7NFLPQaFQXEKb0z50+gFtTnGXZd2vOzcXL2H4Th3pYw
         IR2L/exSJaDZv1RTJ0nFGSyo7jsoOjIXF9vCOyVkYdDUHXEpDPU+XqE7ReI5ddR/2LUY
         ZV9gJH3CvNe3b3/dXAfFEZmjV/X6nwAZ1C5pkN2Ra3JzkouSG6PDXpuaPiERW9lxifj8
         Oc9eM4w+eDJix97AMFLPYc+zIv5RxT3jpEyj1nMtk+TJDJ0b4I/IpbK9lo1bknUnILJK
         Mscsm6CN3m4QTZeHCdgWKIvvWKxfDKhk+y7VGUEjmuMMR99BtgMz0Q87JUkN0lUPYYQP
         1KfQ==
X-Gm-Message-State: AOAM5301N3YGea/y3nOJNZ1lOFEgm2b3x7JWnmlZR8pTd5fyZlLIy4pO
        6JMzhFhKBCE4ETmhE0Mh3bBg3Q8g
X-Google-Smtp-Source: ABdhPJyZGd1D68ogyDq+rAQAHt7NL0PRFJ25fZc7vLzDOHQq8zhKw3JzPTtp/nMfVS6pxIcpefvMSw==
X-Received: by 2002:a05:600c:23ce:: with SMTP id p14mr8690786wmb.77.1590759956289;
        Fri, 29 May 2020 06:45:56 -0700 (PDT)
Received: from jondnuc.lan (IGLD-84-229-154-20.inter.net.il. [84.229.154.20])
        by smtp.gmail.com with ESMTPSA id y37sm12347263wrd.55.2020.05.29.06.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 06:45:55 -0700 (PDT)
From:   Jon Doron <arilou@gmail.com>
To:     kvm@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     vkuznets@redhat.com, pbonzini@redhat.com, rvkagan@yandex-team.ru,
        Jon Doron <arilou@gmail.com>
Subject: [PATCH v12 0/6] x86/kvm/hyper-v: add support for synthetic
Date:   Fri, 29 May 2020 16:45:37 +0300
Message-Id: <20200529134543.1127440-1-arilou@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Add support for the synthetic debugger interface of hyper-v, the synthetic
debugger has 2 modes.
1. Use a set of MSRs to send/recv information (undocumented so it's not
   going to the hyperv-tlfs.h)
2. Use hypercalls

The first mode is based the following MSRs:
1. Control/Status MSRs which either asks for a send/recv .
2. Send/Recv MSRs each holds GPA where the send/recv buffers are.
3. Pending MSR, holds a GPA to a PAGE that simply has a boolean that
   indicates if there is data pending to issue a recv VMEXIT.

The first mode implementation is to simply exit to user-space when
either the control MSR or the pending MSR are being set.
Then it's up-to userspace to implement the rest of the logic of sending/recving.

In the second mode instead of using MSRs KNet will simply issue
Hypercalls with the information to send/recv, in this mode the data
being transferred is UDP encapsulated, unlike in the previous mode in
which you get just the data to send.

The new hypercalls will exit to userspace which will be incharge of
re-encapsulating if needed the UDP packets to be sent.

There is an issue though in which KDNet does not respect the hypercall
page and simply issues vmcall/vmmcall instructions depending on the cpu
type expecting them to be handled as it a real hypercall was issued.

It's important to note that part of this feature has been subject to be
removed in future versions of Windows, which is why some of the
defintions will not be present the the TLFS but in the kvm hyperv header
instead.

v12:
- Rebased on latest origin/master
- Make the KVM_CAP_HYPERV_SYNDBG always enabled, in previous version
  userspace was required to explicitly enable the syndbg capability just
  like with the EVMCS feature.

Jon Doron (5):
  x86/kvm/hyper-v: Explicitly align hcall param for kvm_hyperv_exit
  x86/hyper-v: Add synthetic debugger definitions
  x86/kvm/hyper-v: Add support for synthetic debugger capability
  x86/kvm/hyper-v: enable hypercalls regardless of hypercall page
  x86/kvm/hyper-v: Add support for synthetic debugger via hypercalls

Vitaly Kuznetsov (1):
  KVM: selftests: update hyperv_cpuid with SynDBG tests

 Documentation/virt/kvm/api.rst                |  18 ++
 arch/x86/include/asm/hyperv-tlfs.h            |   6 +
 arch/x86/include/asm/kvm_host.h               |  13 ++
 arch/x86/kvm/hyperv.c                         | 180 +++++++++++++++++-
 arch/x86/kvm/hyperv.h                         |  32 ++++
 arch/x86/kvm/trace.h                          |  51 +++++
 arch/x86/kvm/x86.c                            |   9 +
 include/uapi/linux/kvm.h                      |  13 ++
 .../selftests/kvm/x86_64/hyperv_cpuid.c       | 103 +++++-----
 9 files changed, 374 insertions(+), 51 deletions(-)

-- 
2.24.1

