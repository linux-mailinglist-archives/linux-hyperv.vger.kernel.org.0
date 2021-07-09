Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15A343C25CD
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 Jul 2021 16:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbhGIOYB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 9 Jul 2021 10:24:01 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:37488 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbhGIOYB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 9 Jul 2021 10:24:01 -0400
Received: by mail-wr1-f48.google.com with SMTP id i94so12368862wri.4;
        Fri, 09 Jul 2021 07:21:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=27l4Uz/+uYVwD8O7yGXhjHeXe9a3hQtGW17m68tCa8g=;
        b=HHaluyR3FMRCnOnsksChXewoFrOZ/5bsOjX7CrHr3OyFiFhCfispg64twcZEhsAbB7
         bsfiFdLODv9Nh7Yek8NpJtOnr2kWsp9JMiKK6cy7o641+ooY7Prlp+Fihf787d/13f0M
         qE4O4hsVAriJk6DyHrQERVf6UMnR+sQGn0H2q0A1Kd/v5jPVHQGSzAE9U00pSYFBj8rG
         +k0fS0hjTyQaQ3vRasl+WT7cV/Jp2w/lWS8W7p5JbgMws8Fbyezbg5MRklAG1ZaTf4Ib
         eWGZkE42dmzKc5QVtlPCaXvpRMmeWnoinjsiDpmjm0xoNBxj0hy6A3mhrDLvO7SNJ1l3
         0kAQ==
X-Gm-Message-State: AOAM532bc7VTY3Y5R0IdokYppyvIkijy3DvLwXp6AUV+JHJ2yHhiBCkM
        EvhKdl3bDDV/rk8XFq2Hc5bpj3zFLZA=
X-Google-Smtp-Source: ABdhPJwU8kQSV9vDkCxcapU34T3qNg4eLb3XB3zA3/6ahpSdfxcMnEegnlP/Bp0xLs8nfBCCunDgOA==
X-Received: by 2002:adf:facf:: with SMTP id a15mr20539330wrs.39.1625840476073;
        Fri, 09 Jul 2021 07:21:16 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id i12sm5625277wrp.57.2021.07.09.07.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 07:21:15 -0700 (PDT)
Date:   Fri, 9 Jul 2021 14:21:14 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        kumarpraveen@linux.microsoft.com, pasha.tatashin@soleen.com,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>
Subject: Re: [RFC v1 4/8] intel/vt-d: export intel_iommu_get_resv_regions
Message-ID: <20210709142114.r5vhxmmp6mzq3vjl@liuwe-devbox-debian-v2>
References: <20210709114339.3467637-1-wei.liu@kernel.org>
 <20210709114339.3467637-5-wei.liu@kernel.org>
 <f32e17d4-e435-cd50-8afc-68f6133fd1a0@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f32e17d4-e435-cd50-8afc-68f6133fd1a0@linux.intel.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Jul 09, 2021 at 10:17:25PM +0800, Lu Baolu wrote:
> On 2021/7/9 19:43, Wei Liu wrote:
> > When Microsoft Hypervisor runs on Intel platforms it needs to know the
> > reserved regions to program devices correctly. There is no reason to
> > duplicate intel_iommu_get_resv_regions. Export it.
> 
> Why not using iommu_get_resv_regions()?

That calls into ops->get_resv_regions.

In this patch series, get_resv_regions is hv_iommu_resv_regions, which
wants to use intel_iommu_get_resv_regions when it detects the underlying
hardware platform is from Intel.

Wei.
