Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA1930FD3D
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Feb 2021 20:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238271AbhBDTtv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 4 Feb 2021 14:49:51 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:35309 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237980AbhBDTtt (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 4 Feb 2021 14:49:49 -0500
Received: by mail-wr1-f51.google.com with SMTP id l12so5019367wry.2;
        Thu, 04 Feb 2021 11:49:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4ZhAx+cGEjNvar8Xk79AEAJF2N1oqWk4/U3btC0HHOc=;
        b=mairimkxEjxFDsXXGaxKspwe1qSVU1BSAyPlAln5C/7nwnogD1WARvq+FRkzELoeBV
         3Fq7786oKO27fwdqI1SfyoJmyB940XR5SXaEMmzgRaRY/leJoD+Cna42mAceV5qRhp5R
         iLTM66wt5EdXDJiyuAb/X2gmWG2/lwQ1zyccUdxBRug7hZ1KMmRgbmg1TojUWK1MorsT
         pp2ZA+qMVhTEZAWvYeOlU9l7X/jyx+0XkvArX7O7EvNAOYn02Sn1T03eeCEHIchdsdJE
         h8j7drX4f+O/ZZdhXTHtf8ilp1pNI8+3QxwYH+cLlq+9MIjcLtUrIy3Qvm2WO2SJAZar
         p3WA==
X-Gm-Message-State: AOAM5312CjeFnpSa+AyFPcMPRwBwa3eNzU5E2Q1J29Vg07vimMAbusR5
        Se0wXVDsWkr1wyLTN+GzlOM08x4JFKY=
X-Google-Smtp-Source: ABdhPJyXAvIUE35zmygJw5y4IqMiGC6ixbpxZBRFuWvlGPOL9xbxanwUhIRUwlDwBz5PGspvbarn+g==
X-Received: by 2002:adf:c109:: with SMTP id r9mr1018074wre.261.1612468147405;
        Thu, 04 Feb 2021 11:49:07 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id q24sm6802640wmq.24.2021.02.04.11.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 11:49:06 -0800 (PST)
Date:   Thu, 4 Feb 2021 19:49:05 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        pasha.tatashin@soleen.com, Wei Liu <wei.liu@kernel.org>,
        sameo@linux.intel.com, robert.bradford@intel.com,
        sebastien.boeuf@intel.com
Subject: Re: [PATCH v6 00/16] Introducing Linux root partition support for
 Microsoft Hypervisor
Message-ID: <20210204194905.p3234affuzvl42o3@liuwe-devbox-debian-v2>
References: <20210203150435.27941-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203150435.27941-1-wei.liu@kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Feb 03, 2021 at 03:04:19PM +0000, Wei Liu wrote:
> Wei Liu (16):
>   asm-generic/hyperv: change HV_CPU_POWER_MANAGEMENT to
>     HV_CPU_MANAGEMENT
>   x86/hyperv: detect if Linux is the root partition
>   Drivers: hv: vmbus: skip VMBus initialization if Linux is root
>   clocksource/hyperv: use MSR-based access if running as root
>   x86/hyperv: allocate output arg pages if required
>   x86/hyperv: extract partition ID from Microsoft Hypervisor if
>     necessary
>   x86/hyperv: handling hypercall page setup for root
>   ACPI / NUMA: add a stub function for node_to_pxm()
>   x86/hyperv: provide a bunch of helper functions
>   x86/hyperv: implement and use hv_smp_prepare_cpus
>   asm-generic/hyperv: update hv_msi_entry
>   asm-generic/hyperv: update hv_interrupt_entry
>   asm-generic/hyperv: introduce hv_device_id and auxiliary structures
>   asm-generic/hyperv: import data structures for mapping device
>     interrupts
>   x86/hyperv: implement an MSI domain for root partition
>   iommu/hyperv: setup an IO-APIC IRQ remapping domain for root partition

This series is now rebased and pushed to hyperv-next.

Many thanks to all the people that provided reviews and comments.

Wei.
