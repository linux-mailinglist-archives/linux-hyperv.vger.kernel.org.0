Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB216489814
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Jan 2022 12:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244989AbiAJLxT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 10 Jan 2022 06:53:19 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:40686 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245232AbiAJLvS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 10 Jan 2022 06:51:18 -0500
Received: by mail-wr1-f45.google.com with SMTP id x4so1069908wru.7;
        Mon, 10 Jan 2022 03:51:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fVWYnPe31TN3wo6NRP7EnmwglODEuDj2HiGbPx+TZmY=;
        b=fnLz/TFSLrObkVRoLMLgJlUnsJhK5M0s1+GFyKsDOk1Kb0SvRr4dSOJlYz+KzS2AVG
         tWkpF9wcQOSI3x9CnwJe4sUCMD6PKRQG4vMOTX17o9f2d+Iw8n2xe8n5be41IMt+huqo
         tQ5mlVSnyrQnAp3dV0AQBkudWTZ6JhreKafIOYDqgCZY2knVbO7i3YE9YlEem+V49ZTz
         Vqh+R2MGIiAPQat18U57OJMNQELmsSZ7Hne/ZOcjSLLS4Rfy9qMrmpYEoGIUgt2bVaqx
         xudZ20lxqxlPIbtkpeZJPOi1J3uO4kdePGUnMMJp9h9t+Eu9rveDKsr4nUOy3zyHf/uh
         r6YQ==
X-Gm-Message-State: AOAM533u7eUHkn2l5goPZukHkKFPDVKVp4sfj/RMLN6iAf5MVj5JwqnD
        VO4osUsg9NAzMTmgdSTL6LVdD+BnMkA=
X-Google-Smtp-Source: ABdhPJzZNE2Dpo4pqnOKM7B/3CE83uW86vTW5ZzWGI5vRXlce3sqr5qgUYP56XzldBhPM1/GMQ+FfQ==
X-Received: by 2002:a5d:59a7:: with SMTP id p7mr64016015wrr.258.1641815474270;
        Mon, 10 Jan 2022 03:51:14 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id a20sm6260816wmb.27.2022.01.10.03.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 03:51:13 -0800 (PST)
Date:   Mon, 10 Jan 2022 11:51:11 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     vkuznets <vkuznets@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/hyperv: Properly deal with empty cpumasks in
 hyperv_flush_tlb_multi()
Message-ID: <20220110115111.nmtahu5afhdgmc7z@liuwe-devbox-debian-v2>
References: <20220106094611.1404218-1-vkuznets@redhat.com>
 <MWHPR21MB15938ED874CF437A9C540050D74D9@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB15938ED874CF437A9C540050D74D9@MWHPR21MB1593.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Jan 07, 2022 at 04:56:29PM +0000, Michael Kelley (LINUX) wrote:
> From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Thursday, January 6, 2022 1:46 AM
> > 
> > KASAN detected the following issue:
> > 
> >  BUG: KASAN: slab-out-of-bounds in hyperv_flush_tlb_multi+0xf88/0x1060
> >  Read of size 4 at addr ffff8880011ccbc0 by task kcompactd0/33
> > 
> >  CPU: 1 PID: 33 Comm: kcompactd0 Not tainted 5.14.0-39.el9.x86_64+debug #1
> >  Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine,
> >      BIOS Hyper-V UEFI Release v4.0 12/17/2019
> >  Call Trace:
> >   dump_stack_lvl+0x57/0x7d
> >   print_address_description.constprop.0+0x1f/0x140
> >   ? hyperv_flush_tlb_multi+0xf88/0x1060
> >   __kasan_report.cold+0x7f/0x11e
> >   ? hyperv_flush_tlb_multi+0xf88/0x1060
> >   kasan_report+0x38/0x50
> >   hyperv_flush_tlb_multi+0xf88/0x1060
> >   flush_tlb_mm_range+0x1b1/0x200
> >   ptep_clear_flush+0x10e/0x150
> > ...
> >  Allocated by task 0:
> >   kasan_save_stack+0x1b/0x40
> >   __kasan_kmalloc+0x7c/0x90
> >   hv_common_init+0xae/0x115
> >   hyperv_init+0x97/0x501
> >   apic_intr_mode_init+0xb3/0x1e0
> >   x86_late_time_init+0x92/0xa2
> >   start_kernel+0x338/0x3eb
> >   secondary_startup_64_no_verify+0xc2/0xcb
> > 
> >  The buggy address belongs to the object at ffff8880011cc800
> >   which belongs to the cache kmalloc-1k of size 1024
> >  The buggy address is located 960 bytes inside of
> >   1024-byte region [ffff8880011cc800, ffff8880011ccc00)
> > 
> > 'hyperv_flush_tlb_multi+0xf88/0x1060' points to
> > hv_cpu_number_to_vp_number() and '960 bytes' means we're trying to get
> > VP_INDEX for CPU#240. 'nr_cpus' here is exactly 240 so we're trying to
> > access past hv_vp_index's last element. This can (and will) happen
> > when 'cpus' mask is empty and cpumask_last() will return '>=nr_cpus'.
> > 
> > Commit ad0a6bad4475 ("x86/hyperv: check cpu mask after interrupt has
> > been disabled") tried to deal with empty cpumask situation but
> > apparently didn't fully fix the issue.
> > 
> > 'cpus' cpumask which is passed to hyperv_flush_tlb_multi() is
> > 'mm_cpumask(mm)' (which is '&mm->cpu_bitmap'). This mask changes every
> > time the particular mm is scheduled/unscheduled on some CPU (see
> > switch_mm_irqs_off()), disabling IRQs on the CPU which is performing remote
> > TLB flush has zero influence on whether the particular process can get
> > scheduled/unscheduled on _other_ CPUs so e.g. in the case where the mm was
> > scheduled on one other CPU and got unscheduled during
> > hyperv_flush_tlb_multi()'s execution will lead to cpumask becoming empty.
> > 
> > It doesn't seem that there's a good way to protect 'mm_cpumask(mm)'
> > from changing during hyperv_flush_tlb_multi()'s execution. It would be
> > possible to copy it in the very beginning of the function but this is a
> > waste. It seems we can deal with changing cpumask just fine.
> > 
> > When 'cpus' cpumask changes during hyperv_flush_tlb_multi()'s
> > execution, there are two possible issues:
> > - 'Under-flushing': we will not flush TLB on a CPU which got added to
> > the mask while hyperv_flush_tlb_multi() was already running. This is
> > not a problem as this is equal to mm getting scheduled on that CPU
> > right after TLB flush.
> > - 'Over-flushing': we may flush TLB on a CPU which is already cleared
> > from the mask. First, extra TLB flush preserves correctness. Second,
> > Hyper-V's TLB flush hypercall takes 'mm->pgd' argument so Hyper-V may
> > avoid the flush if CR3 doesn't match.
> > 
> > Fix the immediate issue with
> > cpumask_last()/hv_cpu_number_to_vp_number()
> > and remove the pointless cpumask_empty() check from the beginning of the
> > function as it really doesn't protect anything. Also, avoid the hypercall
> > altogether when 'flush->processor_mask' ends up being empty.
> > 
> > Fixes: ad0a6bad4475 ("x86/hyperv: check cpu mask after interrupt has been disabled")
> > Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> > ---
> >  arch/x86/hyperv/mmu.c | 19 +++++++++----------
> >  1 file changed, 9 insertions(+), 10 deletions(-)
> > 
[...]
> 
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>

Applied to hyperv-next. Thanks.
