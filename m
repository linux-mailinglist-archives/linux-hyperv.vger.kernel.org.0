Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E19717A706
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Mar 2020 15:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgCEOBl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Mar 2020 09:01:41 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42144 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgCEOBk (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Mar 2020 09:01:40 -0500
Received: by mail-wr1-f68.google.com with SMTP id v11so5198349wrm.9;
        Thu, 05 Mar 2020 06:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KdIXn7KFlU+BLAhj4v00VAp1VIZz+zjZjmRj9J5ZrXM=;
        b=nK3vdZUiOeawGy2FGMrVCmtgYTG6YJhGQzXFfPQF+OFXMgJ8t2LLX7PhiRxzrAeVOZ
         yXtUijNaWJd1DKuctoPKJjwn38KRSLrPrNi/ElR76K3SXjwo5PemjnEDn69WvoGO+T2O
         rabQ2E/QAJ9BWYeK7ReieBXAouMPR/dAOnd6XvVyceE3uYB2ShRYCJtdTBrTQwljhxv3
         943AHTqXdu/ceL9X451jfuXfTaV3rs9v77L9fPzsxrIeUhYh3W0793d8kEEPwhIgLmX7
         xeJ89McsYam+LStpRFc3UguXmdWQhFoEDo2b1HYBPI6x68BTtEnW7v2N3Gk5vow3/c54
         QBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KdIXn7KFlU+BLAhj4v00VAp1VIZz+zjZjmRj9J5ZrXM=;
        b=rLoC9M2Hc5vBCvQ0aSGlQEK45tW7leUWEifJCu2PM0xKiPtCiszFV35HI+Mem0jHaD
         yEihkrR8z4Q5SomSLtjww04m2QJ4xUpcpgN8T6rLyR5fQCfyja2iyUw8tuJ7iARGLAmy
         JNT93/niFinjID5MQOaKOmGvUGegZrcJNbQ/QzoU46wby61v3r1/Hb5X3A4CUzcuhRaH
         NnqfHHSuxohPgagRTT/qH0YKgReIMXRWCtAIINJeNWgMZbT94QiL7JHiQWyXsARzOOrY
         btYGlhWQe5E8L3H2SxhzzwxIw4PxcazqWMYH3NZmKBCxWTgEOps+Fi+py0Aj5gumbtQh
         HRcA==
X-Gm-Message-State: ANhLgQ2ZxnlOcDCI7rURmgcLiP2zNEoJmeW6t9GDXKW3h9I1+Uzi/Up0
        Gh4ixL7EQTEo99qEkXVi3A1ztAK3
X-Google-Smtp-Source: ADFU+vv2/QxGHV9O6XBuCWBrYgNKKMmH0ZypNp2Rpgx4JtApn6S7E21yuLskeOJ9lyqbIE+tj7rG3Q==
X-Received: by 2002:a5d:6385:: with SMTP id p5mr10261244wru.167.1583416898425;
        Thu, 05 Mar 2020 06:01:38 -0800 (PST)
Received: from linux.local ([31.154.166.148])
        by smtp.gmail.com with ESMTPSA id c72sm3379824wme.35.2020.03.05.06.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 06:01:37 -0800 (PST)
From:   Jon Doron <arilou@gmail.com>
To:     kvm@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     vkuznets@redhat.com, Jon Doron <arilou@gmail.com>
Subject: [PATCH v2 0/4] x86/kvm/hyper-v: add support for synthetic debugger
Date:   Thu,  5 Mar 2020 16:01:38 +0200
Message-Id: <20200305140142.413220-1-arilou@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Add support for the synthetic debugger interface of hyper-v, the
synthetic debugger has 2 modes.
1. Use a set of MSRs to send/recv information
2. Use hypercalls

The first mode is based the following MSRs:
1. Control/Status MSRs which either asks for a send/recv .
2. Send/Recv MSRs each holds GPA where the send/recv buffers are.
3. Pending MSR, holds a GPA to a PAGE that simply has a boolean that
   indicates if there is data pending to issue a recv VMEXIT.

In the first patch the first mode is being implemented in the sense that
it simply exits to user-space when a control MSR is being written and
when the pending MSR is being set, then it's up-to userspace to
implement the rest of the logic of sending/recving.

In the second mode instead of using MSRs KNet will simply issue
Hypercalls with the information to send/recv, in this mode the data
being transferred is UDP encapsulated, unlike in the previous mode in
which you get just the data to send.

The new hypercalls will exit to userspace which will be incharge of
re-encapsulating if needed the UDP packets to be sent.

There is an issue though in which KDNet does not respect the hypercall
page and simply issues vmcall/vmmcall instructions depending on the cpu
type expecting them to be handled as it a real hypercall was issued.

Jon Doron (4):
  x86/kvm/hyper-v: Align the hcall param for kvm_hyperv_exit
  x86/kvm/hyper-v: Add support for synthetic debugger capability
  x86/kvm/hyper-v: enable hypercalls regardless of hypercall page
  x86/kvm/hyper-v: Add support for synthetic debugger via hypercalls

 arch/x86/include/asm/hyperv-tlfs.h |  21 +++++
 arch/x86/include/asm/kvm_host.h    |  13 +++
 arch/x86/kvm/hyperv.c              | 136 ++++++++++++++++++++++++++++-
 arch/x86/kvm/hyperv.h              |   5 ++
 arch/x86/kvm/trace.h               |  25 ++++++
 arch/x86/kvm/x86.c                 |   9 ++
 include/uapi/linux/kvm.h           |  11 +++
 7 files changed, 218 insertions(+), 2 deletions(-)

-- 
2.24.1

