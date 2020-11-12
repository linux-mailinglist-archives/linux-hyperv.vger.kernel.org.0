Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C042B04EB
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Nov 2020 13:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbgKLMWt (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 12 Nov 2020 07:22:49 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46470 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbgKLMWs (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 12 Nov 2020 07:22:48 -0500
Received: by mail-wr1-f66.google.com with SMTP id d12so5745480wrr.13;
        Thu, 12 Nov 2020 04:22:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xHCY2DjRGkOOOGpka/yFzszZn14CgeehFgZ388x4V6Q=;
        b=fhN7cv1V8MfT59d3Se+UsvzWVElFel0Miew9RrhmHH5rpbWkTTt2XEAFFKsaER/0Dc
         wc6mqJ0GQAigOLTm0znvQY74WC/ctqIq94tQguXQxwAWXdw3O2C91ZU4eh2CEdig/nzt
         8oU+at+JmjFWw5xdGmhb7FY9LSKaLImR4X1txaycJ+Sy9DT2Z6jxHhAqhYtu6suQB/NZ
         7pweeQFebM+4HKMNGTOokteSk5vuK8r5b0YP9ftLDYNHQsCsipzYwPhE2mEFzj68BfdH
         LVrrMIkYLDehUO8bGvhmSt2SXjbryiY07Hdq8lCIu4t1pCJYLramXGZsdMpubRCqILrt
         T4VQ==
X-Gm-Message-State: AOAM530rtw6FnCj/b1CfOddeu/Ekk76pxMb/d1IMBTQa9HBuptRQfQ4e
        nTGEK1PrGsHCmSwUlNWiEfw=
X-Google-Smtp-Source: ABdhPJwlmtNviTgepiWU0E5L3IkOXaRnh0pXvNGFAjg+MJQpFr2cyIhqIJ0Om9SAAtB4Po4y2uuzIQ==
X-Received: by 2002:adf:fd06:: with SMTP id e6mr35712234wrr.206.1605183766993;
        Thu, 12 Nov 2020 04:22:46 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id k16sm6879514wrl.65.2020.11.12.04.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 04:22:46 -0800 (PST)
Date:   Thu, 12 Nov 2020 12:22:45 +0000
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
Message-ID: <20201112122244.xy5zdf7yfxdnomdt@liuwe-devbox-debian-v2>
References: <20201105165814.29233-3-wei.liu@kernel.org>
 <202011060303.LvuPfl7N-lkp@intel.com>
 <20201112114215.kytfavkneta6n4qj@liuwe-devbox-debian-v2>
 <20201112114641.fstyteqqsic7h6xh@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112114641.fstyteqqsic7h6xh@liuwe-devbox-debian-v2>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Nov 12, 2020 at 11:46:41AM +0000, Wei Liu wrote:
> On Thu, Nov 12, 2020 at 11:42:15AM +0000, Wei Liu wrote:
> > On Fri, Nov 06, 2020 at 03:16:07AM +0800, kernel test robot wrote:
> > > Hi Wei,
> > > 
> > > I love your patch! Yet something to improve:
> > > 
> > > [auto build test ERROR on tip/x86/core]
> > > [also build test ERROR on asm-generic/master iommu/next tip/timers/core pci/next linus/master v5.10-rc2 next-20201105]
> > > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > > And when submitting patch, we suggest to use '--base' as documented in
> > > https://git-scm.com/docs/git-format-patch]
> > > 
> > 
> > This report is incorrect.
> > 
> > The bot seems to have only picked up this one patch but not the whole
> > series. While the patch can apply cleanly to all those trees, it has a
> > dependency on an earlier patch in this series.
> 
> I misread this report and I'm confused now. Let me fetch the config and
> try locally first.

The attached config file has

  # CONFIG_HYPERV is not set
.

The reported issue has been fixed by moving hv_root_partition to
mshyperv.c.

Wei.
