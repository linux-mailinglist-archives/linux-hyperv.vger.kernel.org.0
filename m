Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA27931599F
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Feb 2021 23:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbhBIWnz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 9 Feb 2021 17:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbhBIWVk (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 9 Feb 2021 17:21:40 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896FFC0613D6;
        Tue,  9 Feb 2021 14:21:15 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id j12so12784197pfj.12;
        Tue, 09 Feb 2021 14:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HjSiRe9FHCVaGCF52pKJiLElvBu049No/wtLMDAICXE=;
        b=ZPccq1cXTR6T3lt5wME8WuvLAa5mZge5Mw8wXRyQz0ElTK2dM1mAnAYXOysMgOvFTF
         M1Xw0/LEh9dW5Qkrenqg0x0Lv+vYZsYEyKugTwXm+DqKUU9BR7UzcXPZmO9XadLkecQv
         ApW9qLmbiPGG6qIUhUfOsDjkvmBBT3d1bIuWRorvesu1dHc8b0GYSrflEf1HFbYKj3Ps
         33QK4jBS3ZO5kHS9hN+Jy1KJAsWXHDkIkgvZxzA1ZM4RRCcfTprdS7m3wectpcSsxT5g
         gsp5xUecBmhB2lJcNcmkxhi49e7wSClMUrfkE5Gmy18NkLMWcoXbkUDEDX4QE6sQ9x5B
         IO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HjSiRe9FHCVaGCF52pKJiLElvBu049No/wtLMDAICXE=;
        b=FV6cXMBHGwiiquu/OnSzfUlvoMdbODJFRlp4vGnOddJj+blyfhgzxPkOkwy3/N9oT1
         ALjS78fgEuKZ2gBsaxorqTOs9vJ/4bEBNzadZE5BfwwRSN/NM8xDAWFo72w9kWLmGjhF
         q/t1xNZEMO2UuQ3dGmm6T0GkyxdYHGOyqkQYox2Oqv7tj7FAFjJZ6BkmRTFIghWdJ3RU
         e4H/mQkKIutQzS1u9CBPDbDDX7cl4zhRjvLBHTuIZJwBNR/8ANv9TRHA7+LccStToeZE
         +vtQTpeQH/P1jQwcaXXW7kycQXs1f+L7MUGExknyopbNVorPFf0gvYXoh/IUeOtCare8
         UVPw==
X-Gm-Message-State: AOAM530uzLF8x8Gqefd9zhw+gTS1Q5o8M9rIMpV1RPHOa2+hGh6I4kCM
        BMGLTkMWGwIZZSC+iZdS5FapeKSJ4rybzg==
X-Google-Smtp-Source: ABdhPJz3LfnWDYq7JINpREZUWfE+W5NwAF3qi+h7lRxojWAtxXFLj2+kpLvcsoQwwfGFKhWJBLAhPg==
X-Received: by 2002:a63:545f:: with SMTP id e31mr136017pgm.212.1612909274776;
        Tue, 09 Feb 2021 14:21:14 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id v9sm58601pju.33.2021.02.09.14.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 14:21:13 -0800 (PST)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Nadav Amit <namit@vmware.com>, Borislav Petkov <bp@alien8.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Sasha Levin <sashal@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org, x86@kernel.org,
        xen-devel@lists.xenproject.org
Subject: [PATCH v5 0/8] x86/tlb: Concurrent TLB flushes
Date:   Tue,  9 Feb 2021 14:16:45 -0800
Message-Id: <20210209221653.614098-1-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

This is a respin of a rebased version of an old series, which I did not
follow, as I was preoccupied with personal issues (sorry).

The series improve TLB shootdown by flushing the local TLB concurrently
with remote TLBs, overlapping the IPI delivery time with the local
flush. Performance numbers can be found in the previous version [1].

The patches are essentially the same, but rebasing on the last version
required some changes. I left the reviewed-by tags - if anyone considers
it inappropriate, please let me know (and you have my apology).

[1] https://lore.kernel.org/lkml/20190823224153.15223-1-namit@vmware.com/

v4 -> v5:
* Rebase on 5.11
* Move concurrent smp logic to smp_call_function_many_cond() 
* Remove SGI-UV patch which is not needed anymore

v3 -> v4:
* Merge flush_tlb_func_local and flush_tlb_func_remote() [Peter]
* Prevent preemption on_each_cpu(). It is not needed, but it prevents
  concerns. [Peter/tglx]
* Adding acked-, review-by tags

v2 -> v3:
* Open-code the remote/local-flush decision code [Andy]
* Fix hyper-v, Xen implementations [Andrew]
* Fix redundant TLB flushes.

v1 -> v2:
* Removing the patches that Thomas took [tglx]
* Adding hyper-v, Xen compile-tested implementations [Dave]
* Removing UV [Andy]
* Adding lazy optimization, removing inline keyword [Dave]
* Restructuring patch-set

RFCv2 -> v1:
* Fix comment on flush_tlb_multi [Juergen]
* Removing async invalidation optimizations [Andy]
* Adding KVM support [Paolo]

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Sasha Levin <sashal@kernel.org>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kvm@vger.kernel.org
Cc: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
Cc: x86@kernel.org
Cc: xen-devel@lists.xenproject.org

Nadav Amit (8):
  smp: Run functions concurrently in smp_call_function_many_cond()
  x86/mm/tlb: Unify flush_tlb_func_local() and flush_tlb_func_remote()
  x86/mm/tlb: Open-code on_each_cpu_cond_mask() for tlb_is_not_lazy()
  x86/mm/tlb: Flush remote and local TLBs concurrently
  x86/mm/tlb: Privatize cpu_tlbstate
  x86/mm/tlb: Do not make is_lazy dirty for no reason
  cpumask: Mark functions as pure
  x86/mm/tlb: Remove unnecessary uses of the inline keyword

 arch/x86/hyperv/mmu.c                 |  10 +-
 arch/x86/include/asm/paravirt.h       |   6 +-
 arch/x86/include/asm/paravirt_types.h |   4 +-
 arch/x86/include/asm/tlbflush.h       |  48 +++----
 arch/x86/include/asm/trace/hyperv.h   |   2 +-
 arch/x86/kernel/alternative.c         |   2 +-
 arch/x86/kernel/kvm.c                 |  11 +-
 arch/x86/mm/init.c                    |   2 +-
 arch/x86/mm/tlb.c                     | 177 +++++++++++++++-----------
 arch/x86/xen/mmu_pv.c                 |  11 +-
 include/linux/cpumask.h               |   6 +-
 include/trace/events/xen.h            |   2 +-
 kernel/smp.c                          | 148 +++++++++++----------
 13 files changed, 242 insertions(+), 187 deletions(-)

-- 
2.25.1

