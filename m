Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB562B0475
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Nov 2020 12:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbgKLLzA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 12 Nov 2020 06:55:00 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33282 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728154AbgKLLyh (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 12 Nov 2020 06:54:37 -0500
Received: by mail-wr1-f68.google.com with SMTP id b8so5724988wrn.0;
        Thu, 12 Nov 2020 03:54:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YMky5SUDB3o1VN706BTn/4cBuTwsTWBcLyKW+mG88xw=;
        b=MVmrWDi1izHolbblEx/pXLLIhQ28JPwoCH1x4afU1oyOWq8IcIfTF/S2SuFzNLE7rG
         KTrLjUqbb7UEggkhmwPDFdGBAhzRBZGZP5A+AZHOEJfcwwrLpM9CDbCExb0Xx0pc6sNl
         xZDXsyjY3DLTCmr3TGCb2FlXfeZ5XYsPFHuMvo6g1ztH63cUcToEMKkcxaPJMIvH/dl8
         jJH5y1M4gWfku4rlIDEq5Dd5NCuJCEgiKnlqUoNbpaWKYOJJSmt8rrx2yKdJbglOFj6T
         E+2T0sRr2wx7RR3sz57j0iBQnOndpBl7NHNZH8vrFux+epBbE8k6iIz1ha1lP4j34spD
         Sr7w==
X-Gm-Message-State: AOAM531MsHLgKrr3IP307G09WcOdtaV4jjAZ8xZZ0MqN2mgdIEWu0y8L
        QJj1Vk1/9OqeRKYRDmrZ2BA=
X-Google-Smtp-Source: ABdhPJy+shNfhSBtNsKTiassxubwWmTTQROgyAvJFDIyXXsjGHiPKcLvk8oTktdaMIhooUlZhv54NQ==
X-Received: by 2002:adf:ead1:: with SMTP id o17mr35456869wrn.396.1605182075765;
        Thu, 12 Nov 2020 03:54:35 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id d10sm6536236wro.89.2020.11.12.03.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 03:54:35 -0800 (PST)
Date:   Thu, 12 Nov 2020 11:54:34 +0000
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
        Lillian Grassin-Drake <ligrassi@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>
Subject: Re: [PATCH v2 07/17] x86/hyperv: extract partition ID from Microsoft
 Hypervisor if necessary
Message-ID: <20201112115433.ecdaq3pomgtswzpl@liuwe-devbox-debian-v2>
References: <20201105165814.29233-8-wei.liu@kernel.org>
 <202011060401.AnOzSVE1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202011060401.AnOzSVE1-lkp@intel.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Nov 06, 2020 at 04:07:33AM +0800, kernel test robot wrote:
> Hi Wei,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on tip/x86/core]
> [also build test WARNING on asm-generic/master iommu/next tip/timers/core pci/next linus/master v5.10-rc2 next-20201105]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Wei-Liu/Introducing-Linux-root-partition-support-for-Microsoft-Hypervisor/20201106-010058
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 238c91115cd05c71447ea071624a4c9fe661f970
> config: i386-randconfig-r002-20201104 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> reproduce (this is a W=1 build):
>         # https://github.com/0day-ci/linux/commit/83c03b4e30e729a77688b8c0ffeffa2a555dcce7
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Wei-Liu/Introducing-Linux-root-partition-support-for-Microsoft-Hypervisor/20201106-010058
>         git checkout 83c03b4e30e729a77688b8c0ffeffa2a555dcce7
>         # save the attached .config to linux build tree
>         make W=1 ARCH=i386 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> arch/x86/hyperv/hv_init.c:341:13: warning: no previous prototype for 'hv_get_partition_id' [-Wmissing-prototypes]
>      341 | void __init hv_get_partition_id(void)
>          |             ^~~~~~~~~~~~~~~~~~~

This function can be made static since the only user is in the same
file.

Wei.
