Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09DCA17E6D9
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Mar 2020 19:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbgCISUa (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 9 Mar 2020 14:20:30 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36694 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727491AbgCISU3 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 9 Mar 2020 14:20:29 -0400
Received: by mail-wm1-f65.google.com with SMTP id g62so434395wme.1;
        Mon, 09 Mar 2020 11:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CPhZKMawIEg0LF+8rUefvveQC7Pbb0atv6Urs3DG3g0=;
        b=TNfw3tiIpweI6lD4bDTky927fZqaQA/LK1U5HfECEY5Eqydk2qkzgAXkFav1YIXisY
         223HVSfNAuPQLJLGjWYKJl0kenee71inhl9QQrIY/YDyXgAx+Z42I6adHMF+uMmHCVis
         N1TX2eO+gfHuhXnGYnYL4CV9g7+hmL5TdVcdZaKp48AmgA4RlEtoSNP6YU9xTZenBcKP
         HXecdLfeWqjyCPxVDx71J9vDpEo7/cqTZvnIqDyTw2qdIBFHB0Xdyyz3meBxYsc44A59
         r36/LbFhCeuCmqPldIV5dgm9rGvrwlNiMzEHxlbjxqLNJ5Wgbb1tSsLr6LXHuPziFr+2
         vJiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CPhZKMawIEg0LF+8rUefvveQC7Pbb0atv6Urs3DG3g0=;
        b=MK83Ue5DnMu+0m+yTlSKZ9dScvY8JB5eBhjBnVdKaFM++xDdnNQ9LTVNh067rGjj7C
         JbFFGLdDc88Pd8vRM4WpAkIl/g26UbI0LzUD7E0KDitn5w78IeeE7VcAZQd0xJz+HJ8P
         wI7x/bZwHuGf+T62vWn34cjSfLbYW9NPUhGdjf5cVGU9bi51ru3VYG3EXE8lMDUTQB5e
         djiV3CN71j3mmq3vpldO5BKNRn2qGeZvBD3eySNLjaTOVJDzMkodSrpnYolxHUOhLEg/
         UrygVjkKbSChB8nlZkjK+RA6pOAqTjAYL2Dd6FTK/y8S965nz6EyIzU7Al+qmLiVNYH3
         f9DQ==
X-Gm-Message-State: ANhLgQ3ldJ1UpbP1B+PJvej+66qPe2DteZT/s5FkqiMyN7MWMKoAEzwV
        6kryRjuNlWVHXExW2FlNYAJeGOWqQEo=
X-Google-Smtp-Source: ADFU+vtJJVp/SvpSTLWjaT/eQ+QNJuwwAQtNA4ugOEOmHSKxF8Ule/kJp4Tr/CBK/y+JuVLHgaxhPQ==
X-Received: by 2002:a1c:f707:: with SMTP id v7mr479325wmh.121.1583778026969;
        Mon, 09 Mar 2020 11:20:26 -0700 (PDT)
Received: from linux.local ([31.154.166.148])
        by smtp.gmail.com with ESMTPSA id t6sm8371828wrr.49.2020.03.09.11.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 11:20:26 -0700 (PDT)
From:   Jon Doron <arilou@gmail.com>
To:     kvm@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     vkuznets@redhat.com, Jon Doron <arilou@gmail.com>
Subject: [PATCH v4 0/5] x86/kvm/hyper-v: add support for synthetic debugger
Date:   Mon,  9 Mar 2020 20:20:12 +0200
Message-Id: <20200309182017.3559534-1-arilou@gmail.com>
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

Jon Doron (5):
  x86/kvm/hyper-v: Explicitly align hcall param for kvm_hyperv_exit
  x86/hyper-v: Add synthetic debugger definitions
  x86/kvm/hyper-v: Add support for synthetic debugger capability
  x86/kvm/hyper-v: enable hypercalls regardless of hypercall page
  x86/kvm/hyper-v: Add support for synthetic debugger via hypercalls

 arch/x86/include/asm/hyperv-tlfs.h |  26 +++++
 arch/x86/include/asm/kvm_host.h    |  13 +++
 arch/x86/kvm/hyperv.c              | 162 ++++++++++++++++++++++++++++-
 arch/x86/kvm/hyperv.h              |   5 +
 arch/x86/kvm/trace.h               |  51 +++++++++
 arch/x86/kvm/x86.c                 |   9 ++
 include/uapi/linux/kvm.h           |  11 ++
 7 files changed, 275 insertions(+), 2 deletions(-)

-- 
2.24.1

