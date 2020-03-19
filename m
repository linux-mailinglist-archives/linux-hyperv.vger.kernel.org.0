Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7707618ACE1
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2020 07:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbgCSGiw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 19 Mar 2020 02:38:52 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40550 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbgCSGiw (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 19 Mar 2020 02:38:52 -0400
Received: by mail-wm1-f68.google.com with SMTP id z12so700843wmf.5;
        Wed, 18 Mar 2020 23:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gUcps1XM9Cn7Ral3obTmLHmlyiV6Ruxu367UiIJawY8=;
        b=My9EpVpa5DWwqQPRF2N8bCYCYC5/m49C3+ZuNWTRsSk8vPx9vBNRa/W+hnmcKq1kub
         uRXNkl01SJR33kVLqk3gyqBEsYww/ztTjq3fUzDLiphupb0D6ZkQ0LEqwtNSxwcnhg9D
         3pfC1m8cfDLN36utNyTiZnQZvZPkQDogwbbGsNCZKGO/2PCzp3WzEFO05KCAAnWp6Mh3
         wlU6i2LmWw6mSiKde3eloOf95h4hVm4pIl33tht86zx0mPC0+bJ/td8xpHplAzZA3OcG
         ACLQXgkCWb1uK5l+JOXpc8YlbzGQRwFT4z3dPxA9sUL4kPOPSNyvX2WACAAr6ViVCX6S
         o8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gUcps1XM9Cn7Ral3obTmLHmlyiV6Ruxu367UiIJawY8=;
        b=oai7kGMa9VkXcTOChgnbexiQgJ0LKN4jZVlaGQgDmRfHb65kVjtTS/VBb/nmLsaX6x
         OENtFAEy16ye0Lf2Hej46SS5ZlFSj37WFrDQ0p/11Ywg1Kn1vkiAnrXFBAvohreSIyPB
         12vakT5/086UeWq8xvKrePRbII6oi92KPFk0jUadYQEYEL09wLZK5EhljT5k+yCb7rGG
         0RU2Mx4m1T/gSD2uPdnhxHj8BnuUcT/dlg85hhG72aS/9SpdYPJLTEMpIX9PojL9UBNG
         1HOxLNvbED66bhF+Pt3YNieEw+3MhopHQ4S9CIRAvIrOtNfqkrwV3muldAQ+c2YJ12V9
         FmCw==
X-Gm-Message-State: ANhLgQ214Qt3Iij0B2S3T09LC8JjGUonKRWSbrWQ24rGKrMP/mFV5APZ
        p+8I34Gmxn2MtcAjjCSTWyrgWLzrwQo=
X-Google-Smtp-Source: ADFU+vtwpaGid4XmsOar+JdBuJb6aiDNGDn48cGf7cu+d0Kw8mwCD6O4raWD9X1iFlr1TUbfMe7/bA==
X-Received: by 2002:a7b:cd97:: with SMTP id y23mr1731000wmj.161.1584599928867;
        Wed, 18 Mar 2020 23:38:48 -0700 (PDT)
Received: from jondnuc.lan (IGLD-84-229-155-229.inter.net.il. [84.229.155.229])
        by smtp.gmail.com with ESMTPSA id l13sm1945665wrm.57.2020.03.18.23.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 23:38:48 -0700 (PDT)
From:   Jon Doron <arilou@gmail.com>
To:     kvm@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     vkuznets@redhat.com, Jon Doron <arilou@gmail.com>
Subject: [PATCH v8 0/5] x86/kvm/hyper-v: add support for synthetic debugger
Date:   Thu, 19 Mar 2020 08:38:31 +0200
Message-Id: <20200319063836.678562-1-arilou@gmail.com>
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

Jon Doron (5):
  x86/kvm/hyper-v: Explicitly align hcall param for kvm_hyperv_exit
  x86/hyper-v: Add synthetic debugger definitions
  x86/kvm/hyper-v: Add support for synthetic debugger capability
  x86/kvm/hyper-v: enable hypercalls without hypercall page with syndbg
  x86/kvm/hyper-v: Add support for synthetic debugger via hypercalls

 Documentation/virt/kvm/api.rst     |  18 +++
 arch/x86/include/asm/hyperv-tlfs.h |   6 +
 arch/x86/include/asm/kvm_host.h    |  14 +++
 arch/x86/kvm/hyperv.c              | 179 ++++++++++++++++++++++++++++-
 arch/x86/kvm/hyperv.h              |  33 ++++++
 arch/x86/kvm/trace.h               |  51 ++++++++
 arch/x86/kvm/x86.c                 |  13 +++
 include/uapi/linux/kvm.h           |  13 +++
 8 files changed, 325 insertions(+), 2 deletions(-)

-- 
2.24.1

