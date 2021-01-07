Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 776D82ED339
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Jan 2021 16:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbhAGPGm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 Jan 2021 10:06:42 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:50927 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbhAGPGm (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 Jan 2021 10:06:42 -0500
Received: by mail-wm1-f51.google.com with SMTP id 190so5467709wmz.0;
        Thu, 07 Jan 2021 07:06:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3Sjk0QtZfwMWY6YcWxhCnMUq7pIJd4NoiTIH0T1tqOg=;
        b=qRgfhugHxZh5XhSRSyY70UOg/vqWrpxu49BKEmKf2rUeGQGdTrgS4GfgIAayp/tdP3
         gsrd8SaPpzG4i61I92vWwbLbTYP3IEcC9oS4UJ7lFGGQ3sBj9Jq2cDYKrZ0fJy4vCRkQ
         CBJM/ZSldpOsSUlSejJUj4fFGRtOwXn52B5iFZThX/h/ZdKg0xIgcGqxJuHSaNRBmqs6
         EHAfnSd5Y5cXvY8UG77M5il82ewJcyDZZoRxb/+4eBnDgkBdDCn9wW2v83whxt4QTa3m
         lqMTe+/1Hn1lY9VPnwM8LDZyfX2ZFG0YOk/9DDuD8gQvjZllyYeooO7c9WpegG8HeWMT
         svcw==
X-Gm-Message-State: AOAM531eLxmqPxruAM9eQp1JK1OPPgog67QiCEk4bay45BpwVdimJ9m2
        SyW/groNz2TqPTtDQX56QMI=
X-Google-Smtp-Source: ABdhPJyO/vLnHyJh1EiVUK97kLBpjzcgLxyDiYYKHCQBBWg4lePJJMW8lVaHcYhX306QvlgrJ4mR8w==
X-Received: by 2002:a1c:b7d4:: with SMTP id h203mr8479422wmf.59.1610031959794;
        Thu, 07 Jan 2021 07:05:59 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id f77sm7906629wmf.42.2021.01.07.07.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 07:05:59 -0800 (PST)
Date:   Thu, 7 Jan 2021 15:05:58 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        kbuild-all@lists.01.org, virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>
Subject: Re: [PATCH v4 15/17] x86/hyperv: implement an MSI domain for root
 partition
Message-ID: <20210107150557.2pa3qsd4qbni4iaa@liuwe-devbox-debian-v2>
References: <20210106203350.14568-16-wei.liu@kernel.org>
 <202101070658.h9Fcg0JA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202101070658.h9Fcg0JA-lkp@intel.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Jan 07, 2021 at 06:21:24AM +0800, kernel test robot wrote:
> Hi Wei,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62]
> 
> url:    https://github.com/0day-ci/linux/commits/Wei-Liu/Introducing-Linux-root-partition-support-for-Microsoft-Hypervisor/20210107-044149
> base:    e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62
> config: i386-randconfig-m021-20210106 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> reproduce (this is a W=1 build):
>         # https://github.com/0day-ci/linux/commit/376aee69c6ab18dc23b0386590bee82d59555be8
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Wei-Liu/Introducing-Linux-root-partition-support-for-Microsoft-Hypervisor/20210107-044149
>         git checkout 376aee69c6ab18dc23b0386590bee82d59555be8
>         # save the attached .config to linux build tree
>         make W=1 ARCH=i386 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> arch/x86/hyperv/irqdomain.c:317:28: warning: no previous prototype for 'hv_create_pci_msi_domain' [-Wmissing-prototypes]
>      317 | struct irq_domain * __init hv_create_pci_msi_domain(void)
>          |                            ^~~~~~~~~~~~~~~~~~~~~~~~
> 
> 
> vim +/hv_create_pci_msi_domain +317 arch/x86/hyperv/irqdomain.c

I've fixed this locally by moving the prototype to a header file --
previously it was left in a C file.

Wei.
