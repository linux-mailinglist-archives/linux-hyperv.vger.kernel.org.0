Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D278187841
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2020 04:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgCQDs0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 16 Mar 2020 23:48:26 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37171 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgCQDs0 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 16 Mar 2020 23:48:26 -0400
Received: by mail-wr1-f67.google.com with SMTP id 6so23825290wre.4;
        Mon, 16 Mar 2020 20:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FrKlI3sd00+t1N/OzNDhMxZ6Gkz1BB4AwGkkgntEVIU=;
        b=D0YlpZUxZXl0ocStqqZ8JRBOU64KdAWnHdiKFg9shQ/OR4Op9SINZCdUQmm4gXN+Ul
         wLtpt98z6sc9LqYUwfcTqIcxjf3mgkKpY0Gw/rXk6FS90olTq44DQpHF94l1cHRW0Tz/
         gI818jSLzO1dx1NwwR/+d3ushN/uEMktaw+/XJzt2MMOol6SBKTQmFb5T5uc9XUycgCY
         Z6lJ4BSdd+MFvCr96qOue2seEd9LckycNO3Qdk5XYjENSaqlBxlvy3//7X8Xf7Jq9nbi
         Eq0GwhXGIW5JAaFU1yftfTGpdi6G2+wItF1gnwsil8eWRcBmf5JZKWrf0dqUPI+9/Vx+
         KaZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FrKlI3sd00+t1N/OzNDhMxZ6Gkz1BB4AwGkkgntEVIU=;
        b=GT8mOkhpQofmY0ky+blyx3FjWyFYFYLlhnxIuys7EMkY/UHXKmmQ34RoZv1Om83FGz
         8omHLbI82Bc+u3C91beKnv4lMlwV8uuNrqVa5MG6pcI8GZqmx4G9pSkaXh3Qsn/KGV/V
         wyrzQRAYMbP9tln6QjDJ0xP+7oxXe+5t1pga8ijnMmf4sp1qU4MKd0jnS5AV+nmccHwI
         NcEkKTP/O94+dfWrJo4ptLIBUdBZHupSuGiPwrALybIyTUmvRQbKfgoEi100+i6r6Fh0
         EvcjBthhm7n2Do4wbfuLaCR2GYkMD4BvFcmYYHKOWfNStyj4HssbVxe2hLSeBywooVV5
         gKWg==
X-Gm-Message-State: ANhLgQ1fwPGvX6h+FPwZE/hR2gS8rw7/HEccdI5P/KxHGacne1C0QSeX
        zEkD9GncDktgSE7PJ3craTnc8ZyoCK4=
X-Google-Smtp-Source: ADFU+vsOLrCitUkZGjpfFFU6lT84rq+gBAhbdnqEN6gYJq5Z/Rs0bY3AKGXGLxi6NHK129Hkljb6jg==
X-Received: by 2002:a5d:69c1:: with SMTP id s1mr3239639wrw.351.1584416904565;
        Mon, 16 Mar 2020 20:48:24 -0700 (PDT)
Received: from jondnuc.lan (IGLD-84-229-155-229.inter.net.il. [84.229.155.229])
        by smtp.gmail.com with ESMTPSA id c23sm1457757wrb.79.2020.03.16.20.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 20:48:23 -0700 (PDT)
From:   Jon Doron <arilou@gmail.com>
To:     kvm@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     vkuznets@redhat.com, Jon Doron <arilou@gmail.com>
Subject: [PATCH v6 0/5] x86/kvm/hyper-v: add support for synthetic debugger
Date:   Tue, 17 Mar 2020 05:47:59 +0200
Message-Id: <20200317034804.112538-1-arilou@gmail.com>
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
  x86/kvm/hyper-v: enable hypercalls regardless of hypercall page
  x86/kvm/hyper-v: Add support for synthetic debugger via hypercalls

 Documentation/virt/kvm/api.rst     |  18 ++++
 arch/x86/include/asm/hyperv-tlfs.h |   6 ++
 arch/x86/include/asm/kvm_host.h    |  13 +++
 arch/x86/kvm/hyperv.c              | 162 ++++++++++++++++++++++++++++-
 arch/x86/kvm/hyperv.h              |  32 ++++++
 arch/x86/kvm/trace.h               |  51 +++++++++
 arch/x86/kvm/x86.c                 |   9 ++
 include/uapi/linux/kvm.h           |  13 +++
 8 files changed, 302 insertions(+), 2 deletions(-)

-- 
2.24.1

