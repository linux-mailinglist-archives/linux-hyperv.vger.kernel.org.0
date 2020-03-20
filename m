Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDF118D5C0
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Mar 2020 18:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgCTR2v (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 20 Mar 2020 13:28:51 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44910 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgCTR2v (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 20 Mar 2020 13:28:51 -0400
Received: by mail-wr1-f66.google.com with SMTP id j14so623766wrb.11;
        Fri, 20 Mar 2020 10:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dpvhqwRYw1qK6j1rjp4VmuYOJGPSPljg5Ewku7G0J+c=;
        b=bImwAdo43YjbEYIAW4e1v87x+01rV4kvnpJrmHuiDYu8guEawZVIIbEyBJpbl+i6XF
         qhBTlAoxUB2KVSPhLCgUEM3XXYaLWgQ37vqn9g8jlXLjYVZrJxxl2rTFm0e6aGkwXUEp
         u1vNNx5oTg+yLfHx6lEHLVXKOS5tveVA09o9S67yw26XWmYoW7w44mSYzhemhveyo93t
         w0jfLRZxuXNl/wuyLmH9Ode7HfhvagUZBcCz8oPnVlOpBXw4y6ol0gtgolFdTJhEg3dg
         Gj1eTv2AWgG1YzvE9GXGKyYvC/vlgh3PIvHskB6MbN0gSs8sF9YC1mu6IsfUIqsqNY/s
         qi0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dpvhqwRYw1qK6j1rjp4VmuYOJGPSPljg5Ewku7G0J+c=;
        b=e4foobh5YxJT0FG1x/15e6CPKMn04IxfFC/YvzYlVZgT6rT6QjHlHEPNSGFuGBIwI1
         nSJRWZGpgzTj1eGOzN6wxxK/ADIqwWN5El1h2QetaQDGe8BqtX3JqNL5ugqrpUq49794
         7gctlMaD6kugAOmcbJHnuXQMfUN5QBYDbnFHSb/Bczr6+mY/Qa3MkUaA+c+JsToabLaY
         oSlAs01L4YIPEDsw0JJ3gjm1tnJLUHOdJEBh1OFTD/N5pwEPMJvcvjvVzu53arB09ok7
         1uTFLdwcOODssmENf1wAE7FKBvoKta7+VvbW3YX4G5vcQohFasGrc8SqJxqDld+w9gbR
         3DNA==
X-Gm-Message-State: ANhLgQ2go1ZCIxnLu6SrFuD0BON8Of7YN6o5zffzVLhtteSXKmFohGkS
        ETX7xabCIo7lYBVXTJMNf3uThcxxBTk=
X-Google-Smtp-Source: ADFU+vuqYqNrfEWDKPA1t64oIJcfbVFs/Kjhgs4cTypkOa67P8c/7QCwPUlNzRwkrqrOChHHuZKHKg==
X-Received: by 2002:adf:f309:: with SMTP id i9mr13332572wro.0.1584725328088;
        Fri, 20 Mar 2020 10:28:48 -0700 (PDT)
Received: from jondnuc.lan (IGLD-84-229-155-229.inter.net.il. [84.229.155.229])
        by smtp.gmail.com with ESMTPSA id q4sm11028333wmj.1.2020.03.20.10.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 10:28:47 -0700 (PDT)
From:   Jon Doron <arilou@gmail.com>
To:     kvm@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     vkuznets@redhat.com, Jon Doron <arilou@gmail.com>
Subject: [PATCH v9 0/6] x86/kvm/hyper-v: add support for synthetic debugger
Date:   Fri, 20 Mar 2020 19:28:33 +0200
Message-Id: <20200320172839.1144395-1-arilou@gmail.com>
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

 Documentation/virt/kvm/api.rst     |  18 +++
 arch/x86/include/asm/hyperv-tlfs.h |   6 +
 arch/x86/include/asm/kvm_host.h    |  14 ++
 arch/x86/kvm/hyperv.c              | 235 +++++++++++++++++++++++++++--
 arch/x86/kvm/hyperv.h              |  33 ++++
 arch/x86/kvm/trace.h               |  51 +++++++
 arch/x86/kvm/x86.c                 |  13 ++
 include/uapi/linux/kvm.h           |  13 ++
 8 files changed, 368 insertions(+), 15 deletions(-)

-- 
2.24.1

