Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60DF2190679
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Mar 2020 08:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbgCXHoA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 24 Mar 2020 03:44:00 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37247 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727291AbgCXHn7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 24 Mar 2020 03:43:59 -0400
Received: by mail-wm1-f66.google.com with SMTP id d1so2310735wmb.2;
        Tue, 24 Mar 2020 00:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x83RKqJB2n+t2r4ylEIrnwFiRIR5HK76vMGn1RDuu7o=;
        b=XynFwbRUPKgZuXP41JonwGOogmnAma+S9VOj5HINOPYCNrMNteFbUrS7b6Jg15Mtfi
         DYDA1ENVBivYbMky3PV7SqTquxjJTV25rvQnxi4yLEv9s4MYrRj8RZJq2v40jONwxzPm
         OAzO7CCIHPXTtUJ0xj3lZKiUkQoyrXepE2HzTqzYbJlaBBvis5P4wQadOX3CBjHBsESN
         Xee54oYy4+4MbSqoZUKuDKAD9Ldb82gLtwS2yNA7DMT9cTU0StC6zwahzMCx3jclqxaJ
         kH40jDs/iN7cq/l6U1Byu1DEB1RIyF+oB4dy1QSLzdiQJkRjMEEoQVB0D7BuoiutytHU
         DLgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x83RKqJB2n+t2r4ylEIrnwFiRIR5HK76vMGn1RDuu7o=;
        b=Jl0mre1uIaa2BqNx4oFt6erBiEC6/QDUsi9jvrtEXIRGhCOPqXIz9MSE+53OgET0ae
         PlEk6B1tIXoC8AeLkrsaQDfCif4VFBv8366/eKlFTxB7+Ez6defSkXQcnZTrldAEd4Kp
         SKhn0cnZhrKGt0TXsADRAlIKqQZggG+6MT6UZS521girsSN+xjhoTtZuHfKhmxs87mcQ
         kWhYMvP0Oc2Yojqo2iAWA5O2m0Uj5cv5aadKZTxfsGdUaf1nqfgSDfKD98DG3jhY4xlT
         3SprxrqLm5noCVDiH91oDYIAVe3OGxVmFqRF100JtmGy+2Z1HKJ+qb9iBjk4zpoZyqVI
         lL4A==
X-Gm-Message-State: ANhLgQ39BRIDB4gcXGpa5OMvOKN1WNFJZl2CIaddRVDpEuvmZjb3DlVw
        lirAtGnxKarpsndUpEKFACL04T0mtYU=
X-Google-Smtp-Source: ADFU+vuoTuJk1O6fps0iDtVnZm53HrP55jyibUyS6XqsTR2zqW67EDU6IZhQFJOlPL3XTsh0o9Qt0Q==
X-Received: by 2002:a7b:c8cc:: with SMTP id f12mr3543254wml.172.1585035837456;
        Tue, 24 Mar 2020 00:43:57 -0700 (PDT)
Received: from jondnuc.lan (IGLD-84-229-155-229.inter.net.il. [84.229.155.229])
        by smtp.gmail.com with ESMTPSA id r15sm22066122wra.19.2020.03.24.00.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 00:43:56 -0700 (PDT)
From:   Jon Doron <arilou@gmail.com>
To:     kvm@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     vkuznets@redhat.com, Jon Doron <arilou@gmail.com>
Subject: [PATCH v10 0/7] x86/kvm/hyper-v: add support for synthetic debugger
Date:   Tue, 24 Mar 2020 09:43:34 +0200
Message-Id: <20200324074341.1770081-1-arilou@gmail.com>
X-Mailer: git-send-email 2.24.1
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
 .../selftests/kvm/x86_64/hyperv_cpuid.c       | 139 ++++++----
 9 files changed, 469 insertions(+), 60 deletions(-)

-- 
2.24.1

