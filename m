Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA49328CAEE
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Oct 2020 11:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389030AbgJMJZ3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 13 Oct 2020 05:25:29 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39946 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729391AbgJMJZ3 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 13 Oct 2020 05:25:29 -0400
Received: by mail-wr1-f68.google.com with SMTP id h5so13051438wrv.7;
        Tue, 13 Oct 2020 02:25:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5ujasMN43CkN2/roKSf/OFVPM4luboaqc0FmVeOIrG0=;
        b=TadbwUK/k4AOFdIC8YLRdgRm8l6eYxT1p8qtyOvJmI8EvNXG2tG71O3ir7iPiu4J4c
         uZE4b6fHHEVYa5D00KqlILonUDXN7jArYlXGWRubOcdUa3yvD7sWpT/8kuWn+m3MvVWS
         +fyCaVFSR532dVaXH6abCJH/nG4a50orR2tu59c0Bar6QQxFUKLbQkRFjgf4GtsJO5zs
         S731WTrid9oUbA4wkHtAxlH3mCB5y2WGZx5MzBZe26GNw9DYTi351erBrHZc7WDXrrXt
         oiOEZpCRaB77xaYjmLjRmGy65Vf670Yu0tY8s7KrJpCD3mIa8YS4erWRDRPLt9gWlfaU
         yNtA==
X-Gm-Message-State: AOAM531Jv9UBXR+wABBISTnD4PTgsKgUDQiNAuUnIuLNAe9cJnQhsjUW
        S/4tYSBQH47+8WPhOoEIK+g=
X-Google-Smtp-Source: ABdhPJyhV0kvMoeS7S0kfvdKJbQIWW0fxf0LvIibkHR0S2QWG0Wmy5h7WqQWqymZK9sfYOVV16BeyA==
X-Received: by 2002:a5d:448b:: with SMTP id j11mr19786577wrq.129.1602581127306;
        Tue, 13 Oct 2020 02:25:27 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id v3sm29403029wre.17.2020.10.13.02.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 02:25:26 -0700 (PDT)
Date:   Tue, 13 Oct 2020 09:25:25 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com, vkuznets@redhat.com,
        mikelley@microsoft.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH v2 1/2] x86/hyper-v: guard against cpu mask changes in
 hyperv_flush_tlb_others()
Message-ID: <20201013092525.4po4glgjn2vodytf@liuwe-devbox-debian-v2>
References: <20201005233739.2560641-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005233739.2560641-1-sashal@kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Oct 05, 2020 at 07:37:38PM -0400, Sasha Levin wrote:
> cpumask can change underneath us, which is generally safe except when we
> call into hv_cpu_number_to_vp_number(): if cpumask ends up empty we pass
> num_cpu_possible() into hv_cpu_number_to_vp_number(), causing it to read
> garbage. As reported by KASAN:
> 
> [   83.504763] BUG: KASAN: slab-out-of-bounds in hyperv_flush_tlb_others (include/asm-generic/mshyperv.h:128 arch/x86/hyperv/mmu.c:112)
> [   83.908636] Read of size 4 at addr ffff888267c01370 by task kworker/u8:2/106
> [   84.196669] CPU: 0 PID: 106 Comm: kworker/u8:2 Tainted: G        W         5.4.60 #1
> [   84.196669] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS 090008  12/07/2018
> [   84.196669] Workqueue: writeback wb_workfn (flush-8:0)
> [   84.196669] Call Trace:
> [   84.196669] dump_stack (lib/dump_stack.c:120)
> [   84.196669] print_address_description.constprop.0 (mm/kasan/report.c:375)
> [   84.196669] __kasan_report.cold (mm/kasan/report.c:507)
> [   84.196669] kasan_report (arch/x86/include/asm/smap.h:71 mm/kasan/common.c:635)
> [   84.196669] hyperv_flush_tlb_others (include/asm-generic/mshyperv.h:128 arch/x86/hyperv/mmu.c:112)
> [   84.196669] flush_tlb_mm_range (arch/x86/include/asm/paravirt.h:68 arch/x86/mm/tlb.c:798)
> [   84.196669] ptep_clear_flush (arch/x86/include/asm/tlbflush.h:586 mm/pgtable-generic.c:88)
> 

What is the easiest way to reproduce this? Just enable KASAN in the
guest and run it normally? I want to have a chance to verify my earlier
reply.

Thanks,
Wei.
