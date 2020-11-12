Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B67A2B0421
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Nov 2020 12:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbgKLLny (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 12 Nov 2020 06:43:54 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36149 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728210AbgKLLmU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 12 Nov 2020 06:42:20 -0500
Received: by mail-wm1-f68.google.com with SMTP id a65so5229484wme.1;
        Thu, 12 Nov 2020 03:42:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t3kbGRAQFJSlSlG8qF3eOsDA9aWDrM+TERTtueLgetQ=;
        b=CM1Kp1bcSHEAjUTrjBwG+F8qibXhkyzMiVAJ/caKSc5CDH+hc5SiB4QPOKU83uhVEi
         7hBVsMZ5+UUoJUhzceimkpZHFosL5EckbZFc42LfDZI9Rt8PgT/Le9a7U4sT03TgsEEB
         sKNQU/O/aoqBjUO4d+CNjc+78KaDOvuEX1Sk4GcY0HozfagqjaqP8arhc3dwAEvPehVp
         6Zpb26xP1iti8fLVDUzqkYu/uyOt5R/95JVOMN7MlGMCf/zRl9aJun8p4FLDwR4mV35h
         coB0pnaLheev/vtHNz/PC7AiA8yZOOXFctuXjJn8RopD7RuTNtZKFM65ONkrT3SExyKo
         mJOA==
X-Gm-Message-State: AOAM532Vq22t/TS23SBwfrV6eZR+P4wa+LDQ6p1fxJTaNQzJCyFar5h7
        3YVePPWsN48eayrlibj2jMc=
X-Google-Smtp-Source: ABdhPJxbbKRxB3uWKzFadmb3PvRK8x9b6TbkXNmBRZUGZnXPBh64P0ODhVaf/WMQCWf15oXfkvlXXA==
X-Received: by 2002:a1c:df04:: with SMTP id w4mr9103204wmg.3.1605181337112;
        Thu, 12 Nov 2020 03:42:17 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id u6sm6123200wmj.40.2020.11.12.03.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 03:42:16 -0800 (PST)
Date:   Thu, 12 Nov 2020 11:42:15 +0000
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
Subject: Re: [PATCH v2 02/17] x86/hyperv: detect if Linux is the root
 partition
Message-ID: <20201112114215.kytfavkneta6n4qj@liuwe-devbox-debian-v2>
References: <20201105165814.29233-3-wei.liu@kernel.org>
 <202011060303.LvuPfl7N-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202011060303.LvuPfl7N-lkp@intel.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Nov 06, 2020 at 03:16:07AM +0800, kernel test robot wrote:
> Hi Wei,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on tip/x86/core]
> [also build test ERROR on asm-generic/master iommu/next tip/timers/core pci/next linus/master v5.10-rc2 next-20201105]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 

This report is incorrect.

The bot seems to have only picked up this one patch but not the whole
series. While the patch can apply cleanly to all those trees, it has a
dependency on an earlier patch in this series.

Wei.
