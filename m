Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 050A917C31B
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Mar 2020 17:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgCFQjL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 6 Mar 2020 11:39:11 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54823 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbgCFQjL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 6 Mar 2020 11:39:11 -0500
Received: by mail-wm1-f67.google.com with SMTP id i9so3171262wml.4;
        Fri, 06 Mar 2020 08:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rbE3tgX9IDkq6AOPA7A4EoyYR/J2nofK1ZsBKFjymL0=;
        b=LkGXvpX06maPjCBjn0DVOiVmp7mTGiFcWZPIO6OiAKfscrub3qXMJq8hha8ExqwbR7
         APRVJxtve78UPfSEpC6vIh36dmZUJfp9KmLK08FoIVhKSyTo1JT8ehVgq3Qy0G0sJY4p
         t0qiiMvn7nEqD0XM3s6lxy6o7QOGxGL83gVMCvpNFxTnd2Yv/pqQL5W/qaqb92Fu427R
         cMVzGBSLnnEKDgLa8eyAFcEOiPTcgXM0SnMd2d337cV4XvYrLc2T2E2AmNH7eKr2UHgM
         R8vl8IbZOTtI6ZzmT6dg9FQ6gXyyogqYWY0f7Pmrep721xWyFE+r4sJ5OhUm+qVo5sOF
         owRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rbE3tgX9IDkq6AOPA7A4EoyYR/J2nofK1ZsBKFjymL0=;
        b=bN22h3friZ+PDZCa5J8l6brD3VDvrl0UIa8pReI6LS7Pa1knxoPbaFcZRnlhUxfJk2
         Q3TkZPiTa3k8dOMv+l67qrqSRMzjF0g6sVqmJ/Kmf2GnPgztn9ETlwiGOyHVF8OHQKfI
         1mEWfjx4ARt1KUED3a/y8sa3CPitzjna7gtzTbti7h+KDUrimBK4O7CVhci1BilLhRc6
         Qi0p2m32DrwE8vsE36odZMt3fpRgyJMA31pguZi/Gi+vNHPz1KA6Kq1JZsurATdfS24/
         VoK5sXwSBaoh46hlsEhAqZt4ABvbJmsJG6Pg4Ld6sj3h55IQHeoF0qn1EOkltugLrXX6
         DiGg==
X-Gm-Message-State: ANhLgQ2aOA+zwIBPlClW4lcvohpT4NUVUmMMKigE/IEuJs5Xn0XsAGEH
        MvJNXf3sMPVVvaFaPkuHyHU5QtTL
X-Google-Smtp-Source: ADFU+vsjnUAaIK6l49ok4fI+XxVUgl1BAY7j37FFk3An892kplijaY+tUbx05ukFUzcibVLoqRnJ9g==
X-Received: by 2002:a7b:cc04:: with SMTP id f4mr4718806wmh.134.1583512748761;
        Fri, 06 Mar 2020 08:39:08 -0800 (PST)
Received: from linux.local ([199.203.162.213])
        by smtp.gmail.com with ESMTPSA id n24sm8812760wra.61.2020.03.06.08.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 08:39:08 -0800 (PST)
From:   Jon Doron <arilou@gmail.com>
To:     kvm@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     vkuznets@redhat.com, Jon Doron <arilou@gmail.com>
Subject: [PATCH v3 0/5] x86/kvm/hyper-v: add support for synthetic debugger
Date:   Fri,  6 Mar 2020 18:39:04 +0200
Message-Id: <20200306163909.1020369-1-arilou@gmail.com>
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
 arch/x86/kvm/hyperv.c              | 161 ++++++++++++++++++++++++++++-
 arch/x86/kvm/hyperv.h              |   5 +
 arch/x86/kvm/trace.h               |  48 +++++++++
 arch/x86/kvm/x86.c                 |   9 ++
 include/uapi/linux/kvm.h           |  11 ++
 7 files changed, 271 insertions(+), 2 deletions(-)

-- 
2.24.1

