Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED34D18AC87
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2020 06:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgCSF67 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 19 Mar 2020 01:58:59 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56127 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgCSF67 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 19 Mar 2020 01:58:59 -0400
Received: by mail-wm1-f66.google.com with SMTP id 6so627300wmi.5;
        Wed, 18 Mar 2020 22:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OWn1mIT2Bjb41CmPi8mP+JBp2pXqXnT3uc7wL4wPFfk=;
        b=UDJ7/1W6rCWk3HuWUqETnkxwC2HVaH4COHKvtN5D0wJr+RPVcshC0zyA+Hg+g+/Iys
         nhzda9O2UzEPjjOvsmq/C5Y4G5tynGheLnYUN+RU8Gm9AtRS/2sWuKhgv1Ma6flC2mnK
         E8JZIP9RIP9n4R56Zqfwultve5jX7tR5Q2g8pJpP+zEo3ZKr/dfkG2lSbFJJOPeGkFo9
         UivJxEQh4S8tIcii1CsDVHCdUVMBxtIxzEcNnGbbuuqts8vYlA4Ipk3xl4ZcIdkvfl5i
         phVleJs627vb3qb+TWsUAhBPW7kGlqTZWyP+/bVc6mzCAFSft+dApGfs1evi1/FTw9tH
         qXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OWn1mIT2Bjb41CmPi8mP+JBp2pXqXnT3uc7wL4wPFfk=;
        b=bOQS8xDYkRMQKVjRTfJnV8j358Elom0Gvj8b+2tD21n9WqujlSS9/EDC3nPjdap/kY
         2Ir2CVbAcNh1yTyO8j5CqQOkRuX7VE0SVUL1mmqPg86QCyx+twW7MpFVT0goaO8UZPr2
         7H2Pj50+Rl8CALQ38O2XdCW1HseURQQFYKYRu11igZ4dfXAmcw2SUuwTwnYSLgc6YsQF
         9i83b4I1CzZRPAYRasdgwzD2+gjf1lY+iXlvLhfnZ6vCM2aZGgZdNadooOFwK2yId4/J
         HQTUC00xXiEYm/YIUsDwoCGr4exEoh4V4BmZMmxN+R5q6ATtzwr1gJ/JfI/ciK0XduMy
         4xtg==
X-Gm-Message-State: ANhLgQ28E4lAk9gaJMO5FXVgrJWhXabsNT2oZTu7t8Uu3pCWRtbhWvZW
        Wc7N6OzANQOevZNiN9iH1O1HSyYu3OY=
X-Google-Smtp-Source: ADFU+vvn7IqrHJg02ILGeDBVCEexjz30hIOviyWE6cPLKQGeaYpJkS4liq3odMuLq/9DVdPuY+rQ6g==
X-Received: by 2002:a7b:c414:: with SMTP id k20mr1557534wmi.119.1584597536758;
        Wed, 18 Mar 2020 22:58:56 -0700 (PDT)
Received: from jondnuc.lan (IGLD-84-229-155-229.inter.net.il. [84.229.155.229])
        by smtp.gmail.com with ESMTPSA id n2sm1884174wro.25.2020.03.18.22.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 22:58:56 -0700 (PDT)
From:   Jon Doron <arilou@gmail.com>
To:     kvm@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     vkuznets@redhat.com, Jon Doron <arilou@gmail.com>
Subject: [PATCH v7 0/5] x86/kvm/hyper-v: add support for synthetic debugger
Date:   Thu, 19 Mar 2020 07:58:37 +0200
Message-Id: <20200319055842.673513-1-arilou@gmail.com>
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
 arch/x86/kvm/hyperv.c              | 177 ++++++++++++++++++++++++++++-
 arch/x86/kvm/hyperv.h              |  33 ++++++
 arch/x86/kvm/trace.h               |  51 +++++++++
 arch/x86/kvm/x86.c                 |  13 +++
 include/uapi/linux/kvm.h           |  13 +++
 8 files changed, 323 insertions(+), 2 deletions(-)

-- 
2.24.1

