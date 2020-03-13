Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6884D1847E4
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Mar 2020 14:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgCMNU5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 13 Mar 2020 09:20:57 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40813 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgCMNU4 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 13 Mar 2020 09:20:56 -0400
Received: by mail-wr1-f65.google.com with SMTP id f3so5073864wrw.7;
        Fri, 13 Mar 2020 06:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uwCiu2+wFwTgNtqnIu7f8w30xax2anlVmGhqQ2d23uI=;
        b=JJqctYwYpYLlkRXcaX+NqzFqPyV5AhCG9giq/MX7SCx0v1V1Lg/VU6idMdl32TRG24
         MPoS6r5ckEgPARi0LgtLgm6vP25doAlEKk+N3lSb6tr4oG3vug6UsjwRBN/AjY2tkPxW
         XRR7NpX5/jVtArwaOA0n8/LhiqG8IYJKOmBzEKm0uFIK82lflmDZOMa3K0voiGWgrR9g
         lBqw3jepyfxr4ijjCEZ8gGcJAS2Jv97v259M2rISiOM8viWyK/BPodyLqydsVsPHBDRD
         M0cVsoY6od7Ls8j09JPXytlmeVGliW7uqQQmdtZk0GoLg0PoOsUxCT7UQqSOC6pzMTCX
         P7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uwCiu2+wFwTgNtqnIu7f8w30xax2anlVmGhqQ2d23uI=;
        b=janNMJMNhpJNvaubtmi8xdALxkN8yW89p7xm7p6Z/O7FDyuepbxw6LcEvsWpie4JEH
         eI9gUZZy0y1OBRzQXCJkdU1mqDsjNRPMQWcE3Q1PpkzHyga0cYP5d7Xy66KJkJ7inhuf
         zlcqt7CiGXe4+qNLeL6M2sk+x7fV2XEclTpRaHot6PvQm1jtZ67+1aBtFrbmfLekBgSS
         UUoL6ObbXYH7DncPCCRR2chmVUxr8N7X/xbKBOQb9nX/oy9ydk0pHksO9kZJNlims9As
         OQN3G6B1qFjg3CvO6MhhTeWQHwx6Iyzy/y5Z6nm9cnr7J8RzHs1y2e5ZzakiGIvsQstt
         Qjyg==
X-Gm-Message-State: ANhLgQ0CzwL3YTPyYmCFSoqeB8dDbxmk2UcSVs037dDTjTP5FA01Z7DS
        JZ3PSbiFrm8P0Xb3yhiwJ6fM40BrpBU=
X-Google-Smtp-Source: ADFU+vsveTEgaA9u+6b5flsmtaadZk8zvbxpPt83ExWqQmGeOxLfmJtW0NfRc5e2j7uJwXPZIB713Q==
X-Received: by 2002:a05:6000:12c6:: with SMTP id l6mr18691775wrx.217.1584105654145;
        Fri, 13 Mar 2020 06:20:54 -0700 (PDT)
Received: from jondnuc.lan (IGLD-84-229-155-229.inter.net.il. [84.229.155.229])
        by smtp.gmail.com with ESMTPSA id v8sm77112121wrw.2.2020.03.13.06.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 06:20:53 -0700 (PDT)
From:   Jon Doron <arilou@gmail.com>
To:     kvm@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     vkuznets@redhat.com, Jon Doron <arilou@gmail.com>
Subject: [PATCH v5 0/5] x86/kvm/hyper-v: add support for synthetic debugger
Date:   Fri, 13 Mar 2020 15:20:29 +0200
Message-Id: <20200313132034.132315-1-arilou@gmail.com>
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

Jon Doron (5):
  x86/kvm/hyper-v: Explicitly align hcall param for kvm_hyperv_exit
  x86/hyper-v: Add synthetic debugger definitions
  x86/kvm/hyper-v: Add support for synthetic debugger capability
  x86/kvm/hyper-v: enable hypercalls regardless of hypercall page
  x86/kvm/hyper-v: Add support for synthetic debugger via hypercalls

 Documentation/virt/kvm/api.rst     |  18 ++++
 arch/x86/include/asm/hyperv-tlfs.h |   6 ++
 arch/x86/include/asm/kvm_host.h    |  13 +++
 arch/x86/kvm/hyperv.c              | 162 ++++++++++++++++++++++++++++-
 arch/x86/kvm/hyperv.h              |  27 +++++
 arch/x86/kvm/trace.h               |  51 +++++++++
 arch/x86/kvm/x86.c                 |   9 ++
 include/uapi/linux/kvm.h           |  13 +++
 8 files changed, 297 insertions(+), 2 deletions(-)

-- 
2.24.1

