Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8CB31FAC67
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Jun 2020 11:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725843AbgFPJ3n (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 16 Jun 2020 05:29:43 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38150 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726452AbgFPJ3m (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 16 Jun 2020 05:29:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592299780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w27PppGCNHa7BlqB4ZmBJJKBjKDuXsEEjvN7xI5y/wY=;
        b=Mlg8KpYDjYtaONKT58fK2riKQdALbp+H/bl8bRQQxP1U9TBxYBKH0XrJ2F+SMeBeS1Xu2/
        I3MEq1qA7kxQERddHQhOl5kpluzG5rfAQ21Y/HGsisGDPNn6Gat5DBeCv9ZpabPso3jD1S
        HLFflo5cKTYyBZQY4YmwQp46c6kA8nI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-ul-MU_3sPqq0ZyetMruQ6Q-1; Tue, 16 Jun 2020 05:29:38 -0400
X-MC-Unique: ul-MU_3sPqq0ZyetMruQ6Q-1
Received: by mail-ej1-f69.google.com with SMTP id z21so9115603ejl.6
        for <linux-hyperv@vger.kernel.org>; Tue, 16 Jun 2020 02:29:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=w27PppGCNHa7BlqB4ZmBJJKBjKDuXsEEjvN7xI5y/wY=;
        b=rsakZq4xQeNfkhJrfpY9Bnwjvtwo5KD6Y1FPpxezggRCqr6ZnvnJbOA+zB2ZnRDiyp
         3owbwwYWEOW829ijGoTsvESXopqWo9kwnh2Xtt76usB3chKz+Xm68Q5dHSB7qz7+oRWn
         v42EhubVMmZBn089/4KzPpv5yNvwLilbBFOX+HSKhXtLqNDTW4ChPqMbTan+48pR9opc
         Q+8fEKOyY3feUhRERK+islXPhR7oScra11bpDXJgn2S+v+a/64sog2GkrXneb2J3ky1E
         ln3dHX0YKlEZ4dxzX1SQ7scClN7UE4Ltgm5tldAo9GMyncSxIHBqxMUs0qaSQvNXFLIQ
         aq5A==
X-Gm-Message-State: AOAM532yxC3gO05R6kVdUuSKVimCpqUyl/6rik0Rq4BJEe2yGhXGY9bH
        rdbU+OHsW7sxeZfMMVcTUh+oFv3DXlTqfpI1i2ejh6IXEBL0VjKZtZcoPyBfyF1ZSlleb4CeYQB
        6K2W0w1yPCqp/olRmGg70PpMq
X-Received: by 2002:a50:a661:: with SMTP id d88mr1750437edc.34.1592299775723;
        Tue, 16 Jun 2020 02:29:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7r8cYFV60rjN5o4yKdkb8nWDxUEa81BhQvUY5yHr8NVP+hKyKpOqlSIbnDs5cmA4czkq4Yg==
X-Received: by 2002:a50:a661:: with SMTP id d88mr1750417edc.34.1592299775484;
        Tue, 16 Jun 2020 02:29:35 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id b26sm10694420eju.6.2020.06.16.02.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 02:29:34 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Dexuan Cui <decui@microsoft.com>, Christoph Hellwig <hch@lst.de>
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Michael Kelley <mikelley@microsoft.com>,
        Ju-Hyoung Lee <juhlee@microsoft.com>,
        "x86\@kernel.org" <x86@kernel.org>,
        "linux-hyperv\@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>
Subject: RE: hv_hypercall_pg page permissios
In-Reply-To: <HK0P153MB0322EB3EE51073CC021D4AEABF9C0@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM>
References: <20200407073830.GA29279@lst.de> <C311EB52-A796-4B94-AADD-CCABD19B377E@amacapital.net> <HK0P153MB0322D52F61E540CA7515CC4BBF810@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM> <87y2ooiv5k.fsf@vitty.brq.redhat.com> <HK0P153MB0322DE798AA39BCCD4A208E4BF9C0@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM> <HK0P153MB0322EB3EE51073CC021D4AEABF9C0@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM>
Date:   Tue, 16 Jun 2020 11:29:33 +0200
Message-ID: <87blljicjm.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Dexuan Cui <decui@microsoft.com> writes:

>> From: linux-hyperv-owner@vger.kernel.org
>> <linux-hyperv-owner@vger.kernel.org> On Behalf Of Dexuan Cui
>> Sent: Monday, June 15, 2020 10:42 AM
>> > >
>> > > Hi hch,
>> > > The patch is merged into the mainine recently, but unluckily we noticed
>> > > a warning with CONFIG_DEBUG_WX=y
>> > >
>> > > Should we revert this patch, or figure out a way to ask the DEBUG_WX
>> > > code to ignore this page?
>> >
>> > Are you sure it is hv_hypercall_pg?
>> Yes, 100% sure. I printed the value of hv_hypercall_pg and and it matched the
>> address in the warning line " x86/mm: Found insecure W+X mapping at
>> address".
>
> I did this experiment:
>   1. export vmalloc_exec and ptdump_walk_pgd_level_checkwx.
>   2. write a test module that calls them.
>   3. It turns out that every call of vmalloc_exec() triggers such a warning.
>
> vmalloc_exec() uses PAGE_KERNEL_EXEC, which is defined as
>    (__PP|__RW|   0|___A|   0|___D|   0|___G)
>
> It looks the logic in note_page() is: for_each_RW_page, if the NX bit is unset,
> then report the page as an insecure W+X mapping. IMO this explains the
> warning?

Yea, bummer.

it seems we need something like PAGE_KERNEL_READONLY_EXEC but we don't
seem to have one on x86. Hypercall page is special in a way that the
guest doesn't need to write there at all. vmalloc_exec() seems to have
only one other user on x86: module_alloc() and it has other needs. On
ARM, alloc_insn_page() does the following:

arch/arm64/kernel/probes/kprobes.c:     page = vmalloc_exec(PAGE_SIZE);
arch/arm64/kernel/probes/kprobes.c-     if (page) {
arch/arm64/kernel/probes/kprobes.c-             set_memory_ro((unsigned long)page, 1);
arch/arm64/kernel/probes/kprobes.c-             set_vm_flush_reset_perms(page);
arch/arm64/kernel/probes/kprobes.c-     }

What if we do the same? (almost untested):

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index e2137070386a..31aadfea589b 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -23,6 +23,7 @@
 #include <linux/kernel.h>
 #include <linux/cpuhotplug.h>
 #include <linux/syscore_ops.h>
+#include <linux/set_memory.h>
 #include <clocksource/hyperv_timer.h>
 
 void *hv_hypercall_pg;
@@ -383,6 +384,8 @@ void __init hyperv_init(void)
                wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
                goto remove_cpuhp_state;
        }
+       set_memory_ro((unsigned long)hv_hypercall_pg, 1);
+       set_vm_flush_reset_perms(hv_hypercall_pg);
 
        rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
        hypercall_msr.enable = 1;

-- 
Vitaly

