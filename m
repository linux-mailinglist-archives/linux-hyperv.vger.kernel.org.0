Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 679B143F2A8
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 Oct 2021 00:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbhJ1WY1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 28 Oct 2021 18:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbhJ1WY1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 28 Oct 2021 18:24:27 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C222C061570
        for <linux-hyperv@vger.kernel.org>; Thu, 28 Oct 2021 15:22:00 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id x16-20020a25b910000000b005b6b7f2f91cso10968944ybj.1
        for <linux-hyperv@vger.kernel.org>; Thu, 28 Oct 2021 15:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=8CcTf3pQkseQsKnmfaBBHuXTwJk1xIeHhVdYMof8Tdc=;
        b=QTDTiv9Wm1gqOM2tHZvaWkNUm13AJ8nTO+UYBHPctKi9zAmXMLcDqiB4qAUC+axZFV
         uOW+uK/vZHHJBOtET2aAK72Zd2NWS/AjicBIxZUo7WReE9LVhNRHsBsYjG6rEInWBGve
         cFnY9uf8Px1t65rAMgQp6BAw1wDZegIA5gU5j8Bhq8KJmLnGThha/MzAbYaEvYJ0dvBY
         eMmL2siGJGPHXYXlHYoe43GkwY5NRypz3GBas3HSuV+nFfygs449UXCu0/ZXarzVHi0t
         ori799z4VpWDth8OrvGBT+LxEsm9grRuwzfYROAK+dQBT23Y0aLuhDUeeCfqXRatKuMZ
         fyow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=8CcTf3pQkseQsKnmfaBBHuXTwJk1xIeHhVdYMof8Tdc=;
        b=W8JwBk+B9Wby4lU1HuNYYv1OZiB6VdcMrZoLRMhnBIhBUI8Xptm1YNZonr7cO23wOO
         yehKCG5dUsRgY+v5bPNON4lTZTBzkZCioWoWxEyvd6bgQjpSboycqh/+Z9b/Mi5868av
         NfAWIx6gglFNBlsm3fa4C9/ACWzey+n84fyCLb4Yhp1N4yBSnn8R0J2EKbBw2SJSXVxw
         CDS+9QboZUhXHm+nCial/fFOmuqxLgUIWe7TP+XpkG6aTkAImRrS00vsjp+GJx0W6TvV
         v9EGRcvpJrU5evNGHFzsv1a0e4r/4t/c/WLXWrvfboPItRYKZxf5gjfwlOEDbDrDY4DO
         ipbw==
X-Gm-Message-State: AOAM533amoT23C5PY2nCxXVr1SqRKqwk2BuvqPXvTOTAAchrlQW4+pvm
        XYtQHucAbP6ewCAfz95FAb48hChtaro=
X-Google-Smtp-Source: ABdhPJx23cCFNn1aEDHYrI6T+1I8tWVsIZJYfGDo3WJTG7PHPHY5C9iPiQPZsBpNJvmSfblhkH+6fZCbxFI=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:cbc8:1a0d:eab9:2274])
 (user=seanjc job=sendgmr) by 2002:a5b:886:: with SMTP id e6mr7160533ybq.198.1635459719316;
 Thu, 28 Oct 2021 15:21:59 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 28 Oct 2021 15:21:47 -0700
In-Reply-To: <20211028222148.2924457-1-seanjc@google.com>
Message-Id: <20211028222148.2924457-2-seanjc@google.com>
Mime-Version: 1.0
References: <20211028222148.2924457-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH 1/2] x86/hyperv: Fix NULL deref in set_hv_tscchange_cb() if
 Hyper-V setup fails
From:   Sean Christopherson <seanjc@google.com>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Check for re-enlightenment support and for a valid hv_vp_index array
prior to derefencing hv_vp_index when setting Hyper-V's TSC change
callback.  If Hyper-V setup failed in hyperv_init(), e.g. because of a
bad VMM config that doesn't advertise the HYPERCALL MSR, the kernel will
still report that it's running under Hyper-V, but will have silently
disabled nearly all functionality.

  BUG: kernel NULL pointer dereference, address: 0000000000000010
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 0 P4D 0
  Oops: 0000 [#1] SMP
  CPU: 4 PID: 1 Comm: swapper/0 Not tainted 5.15.0-rc2+ #75
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
  RIP: 0010:set_hv_tscchange_cb+0x15/0xa0
  Code: <8b> 04 82 8b 15 12 17 85 01 48 c1 e0 20 48 0d ee 00 01 00 f6 c6 08
  ...
  Call Trace:
   kvm_arch_init+0x17c/0x280
   kvm_init+0x31/0x330
   vmx_init+0xba/0x13a
   do_one_initcall+0x41/0x1c0
   kernel_init_freeable+0x1f2/0x23b
   kernel_init+0x16/0x120
   ret_from_fork+0x22/0x30

Fixes: 93286261de1b ("x86/hyperv: Reenlightenment notifications support")
Cc: stable@vger.kernel.org
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/hyperv/hv_init.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 708a2712a516..6cc845c026d4 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -139,7 +139,7 @@ void set_hv_tscchange_cb(void (*cb)(void))
 	struct hv_reenlightenment_control re_ctrl = {
 		.vector = HYPERV_REENLIGHTENMENT_VECTOR,
 		.enabled = 1,
-		.target_vp = hv_vp_index[smp_processor_id()]
+		.target_vp = -1,
 	};
 	struct hv_tsc_emulation_control emu_ctrl = {.enabled = 1};
 
@@ -148,6 +148,11 @@ void set_hv_tscchange_cb(void (*cb)(void))
 		return;
 	}
 
+	if (!hv_vp_index)
+		return;
+
+	re_ctrl.target_vp = hv_vp_index[smp_processor_id()];
+
 	hv_reenlightenment_cb = cb;
 
 	/* Make sure callback is registered before we write to MSRs */
-- 
2.33.0.1079.g6e70778dc9-goog

