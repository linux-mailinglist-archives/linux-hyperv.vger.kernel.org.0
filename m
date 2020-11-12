Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAD72B043E
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Nov 2020 12:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgKLLq7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 12 Nov 2020 06:46:59 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:47024 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728203AbgKLLqp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 12 Nov 2020 06:46:45 -0500
Received: by mail-wr1-f65.google.com with SMTP id d12so5629855wrr.13;
        Thu, 12 Nov 2020 03:46:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9jL9FUqxLDIX1r+bLqA4BxTMQd6KKBsm8f4f5MhHfBo=;
        b=r79Bd+dhAVO9cPqvIcR+jSaTnZDb7o0eYb66U8V1I7dzvwOpsIFnbnINwWWKwFVreP
         cE8WOmsr5H6+hlo/Vwr9YMsp+n4dolkuqTFl2QqbXgqOrjPEPDNH/FmgIhY5ipwkagNQ
         aWzFZr2a7/6F/bi/X+NLZSxZlKngi2aqau1cV2drQ5zN0ES9w5pK+7pAyFU6+cBXLgZi
         XAm/haJYhqLPC3Qkd/E1RfJN3vllWg3nfhTUjETAITaGOpTgjNqfmgI2IAET0nvHBRS7
         BikVwAycEmTv9IG/WV1Tdx626UuFfylWJ8o5oVve8mtwxIBX/6HZlOlZP4EgCF9rCCq/
         hfaA==
X-Gm-Message-State: AOAM531A6YRKh+BtFnmDGGTnQdeiedLSfEorf6pp8OUGBTGEEfb8nDXh
        hLgNA059JPR5XuocewjMFdieaAIRHr4=
X-Google-Smtp-Source: ABdhPJzwcVtzji8/dSn8xXDo7eMvY9+n/MPB9taxXXmbXA8Fk4exE+jlCHts3xuDQMcVvE5V0SXwCw==
X-Received: by 2002:adf:e541:: with SMTP id z1mr7057091wrm.389.1605181603454;
        Thu, 12 Nov 2020 03:46:43 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id 34sm6405320wrq.27.2020.11.12.03.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 03:46:42 -0800 (PST)
Date:   Thu, 12 Nov 2020 11:46:41 +0000
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
Message-ID: <20201112114641.fstyteqqsic7h6xh@liuwe-devbox-debian-v2>
References: <20201105165814.29233-3-wei.liu@kernel.org>
 <202011060303.LvuPfl7N-lkp@intel.com>
 <20201112114215.kytfavkneta6n4qj@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112114215.kytfavkneta6n4qj@liuwe-devbox-debian-v2>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Nov 12, 2020 at 11:42:15AM +0000, Wei Liu wrote:
> On Fri, Nov 06, 2020 at 03:16:07AM +0800, kernel test robot wrote:
> > Hi Wei,
> > 
> > I love your patch! Yet something to improve:
> > 
> > [auto build test ERROR on tip/x86/core]
> > [also build test ERROR on asm-generic/master iommu/next tip/timers/core pci/next linus/master v5.10-rc2 next-20201105]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch]
> > 
> 
> This report is incorrect.
> 
> The bot seems to have only picked up this one patch but not the whole
> series. While the patch can apply cleanly to all those trees, it has a
> dependency on an earlier patch in this series.

I misread this report and I'm confused now. Let me fetch the config and
try locally first.

Wei.
