Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C15C1B7336
	for <lists+linux-hyperv@lfdr.de>; Fri, 24 Apr 2020 13:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgDXLiF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 24 Apr 2020 07:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbgDXLiF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 24 Apr 2020 07:38:05 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B9EC09B045;
        Fri, 24 Apr 2020 04:38:03 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id r26so10349207wmh.0;
        Fri, 24 Apr 2020 04:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YkoHdhSZDcS430ypnKrze+vC3RcbR1ZGrC/igE/91x0=;
        b=vEYYXLYJjg13oRlH8NnKctuuUQ8aL0ZVuh8anZrEa4aRi9aheaYBq1CASYE6htsCmj
         MDQGoIvrJolNA8izQix4L8fNk62GPbwyk1ELDNLMd9/cgy8/euUVTDR7dWWV7y0KnIVq
         I30WNfmO6aQc9dI+nD5xP+TGnVjqGS9kLGpdlyAlQVlKdsip2k/oytmoAfRP70E+h0el
         Ms6OlN+SDBgD4zHgpN3KA+5ClJ0ZY62cE56+hsmysHSWgKgMkkXqiw1WFPIZmvwG54fa
         Ve9SlSskohZvC31uR1tFgyoo2mO3/uUzxZko9pSwB+bu9v50fI1nqS/nvFVWXlcr0AJP
         2WGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YkoHdhSZDcS430ypnKrze+vC3RcbR1ZGrC/igE/91x0=;
        b=NLokmAoAYRH8be6CtdOelEUWoLHsOkWITRLtHkhD40hNa0uSz1P4dYi4tXADzEJTtJ
         FAjpgjPdAl+5YCAmfNTG3uXjgKcWRkJox0DAiwl1yOULNVzbilnHjd+uDcB35zm496R/
         gMx5fiOzdDupdDXKkb0garNa4aEMQZrJrPoxM9hooXR15yXT7V0EEKFHhsFZyy6pgonP
         MAr9VX2MTqylwJWqAGFfWzy588z94xxcq2tvnIpnvjc0St8C/FP9K/ED88lavfhJRtIL
         SdBFwXKTl0KIQKYqNTTxNaHBl3ecvx52CgAC50q1lCUaM08b5unLgHrifM+uX9UMVxq3
         B5dQ==
X-Gm-Message-State: AGi0PuajKwaEmZnCbtuKh2C7iNNdsBNZX5nyyW2vTx+KcMfgeDv8eTTl
        HBJtrp48jR5PhNVXoKVh+MyWONfi73s=
X-Google-Smtp-Source: APiQypK0OjvkogfSDfA9/2NWaPJ2MLr/q05Rpz5kWHZHQWjn95TFyi4oCUhDq3SVT2bJI/62hpDIUA==
X-Received: by 2002:a1c:80c3:: with SMTP id b186mr10398913wmd.117.1587728282174;
        Fri, 24 Apr 2020 04:38:02 -0700 (PDT)
Received: from jondnuc.lan (IGLD-84-229-154-20.inter.net.il. [84.229.154.20])
        by smtp.gmail.com with ESMTPSA id w83sm2451007wmb.37.2020.04.24.04.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 04:38:01 -0700 (PDT)
From:   Jon Doron <arilou@gmail.com>
To:     kvm@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     vkuznets@redhat.com, Jon Doron <arilou@gmail.com>
Subject: [PATCH v11 0/7] x86/kvm/hyper-v: add support for synthetic debugger
Date:   Fri, 24 Apr 2020 14:37:39 +0300
Message-Id: <20200424113746.3473563-1-arilou@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Add support for the synthetic debugger interface of hyper-v, the
synthetic debugger has 2 modes.
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

v11:
Fixed all reviewed by and rebased on latest origin/master

Jon Doron (6):
  x86/kvm/hyper-v: Explicitly align hcall param for kvm_hyperv_exit
  x86/kvm/hyper-v: Simplify addition for custom cpuid leafs
  x86/hyper-v: Add synthetic debugger definitions
  x86/kvm/hyper-v: Add support for synthetic debugger capability
  x86/kvm/hyper-v: enable hypercalls without hypercall page with syndbg
  x86/kvm/hyper-v: Add support for synthetic debugger via hypercalls

Vitaly Kuznetsov (1):
  KVM: selftests: update hyperv_cpuid with SynDBG tests

 Documentation/virt/kvm/api.rst                |  18 ++
 arch/x86/include/asm/hyperv-tlfs.h            |   6 +
 arch/x86/include/asm/kvm_host.h               |  14 +
 arch/x86/kvm/hyperv.c                         | 242 ++++++++++++++++--
 arch/x86/kvm/hyperv.h                         |  33 +++
 arch/x86/kvm/trace.h                          |  51 ++++
 arch/x86/kvm/x86.c                            |  13 +
 include/uapi/linux/kvm.h                      |  13 +
 .../selftests/kvm/x86_64/hyperv_cpuid.c       | 143 +++++++----
 9 files changed, 468 insertions(+), 65 deletions(-)

-- 
2.24.1

