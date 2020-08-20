Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D2024C738
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Aug 2020 23:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgHTVjO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 20 Aug 2020 17:39:14 -0400
Received: from linux.microsoft.com ([13.77.154.182]:38128 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgHTVjN (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 20 Aug 2020 17:39:13 -0400
Received: from viremana-dev.fwjladdvyuiujdukmejncen4mf.xx.internal.cloudapp.net (unknown [13.66.132.26])
        by linux.microsoft.com (Postfix) with ESMTPSA id 832E320B4908;
        Thu, 20 Aug 2020 14:39:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 832E320B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1597959552;
        bh=2H5J51gfYomnZO7gO0OSn0mfMlYSdm+2t/COROltWJk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L8Xc757whT9VGBAlNfTbZP2IUNTBjn5l9aAU4aVMa+NrFXAlLtFNUGr18jxDkhbZa
         x8rJ+O/011M8foZM1gay5fWqaiXh9WEa2uBRQOZld4doNSr3/+fd7KI2ubMhqspE8a
         dPscSCUZ0+elGrfU+x9MfxmSZvcXVBpC66tXTwYY=
Date:   Thu, 20 Aug 2020 21:39:12 +0000
From:   Vineeth Pillai <viremana@linux.microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hv_utils: return error if host timesysnc update is stale
Message-ID: <20200820213912.fmttvj6wcirn5sas@viremana-dev.fwjladdvyuiujdukmejncen4mf.xx.internal.cloudapp.net>
References: <20200819174527.47156-1-viremana@linux.microsoft.com>
 <MW2PR2101MB10527EAC115BF49715BF4722D75A0@MW2PR2101MB1052.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW2PR2101MB10527EAC115BF49715BF4722D75A0@MW2PR2101MB1052.namprd21.prod.outlook.com>
User-Agent: NeoMutt/20171215
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


Hi Michael,

> > +const u64 HOST_TIMESYNC_DELAY_THRESH = 600 * NSEC_PER_SEC;
> 
> Kernel test robot has already complained that this should be static,
> and about the potential overflow based on the types of the constants in
> the right side expression.  I didn't check the details, but I suspect the
> complaint is when building in 32-bit mode.  This code does get built in
> 32-bit mode and it's possible for run 32-bit Linux guests on Hyper-V.
> 
NSEC_PER_SEC is defined long and it caused the warning with i386 build.
Casting it to u64 would fix the issue. Will fix the static warning as well
in the next iteration.

> > +		pr_warn("TIMESYNC IC: Stale time stamp, %llu nsecs old\n",
> > +			HOST_TIMESYNC_DELAY_THRESH);
> 
> Let's provide the timediff_adj in the message instead of the constant
> threshold value so we know the degree of staleness. :-)
> 
> Also, I'm wondering if this should be pr_warn_once().  Presumably
> chronyd or whoever is reading /dev/ptp0 will give up after getting
> this error, but if not, it would be nice to avoid filling up the console
> with these error messages.
> 
Makes sense, will fix this also.

Thanks,
Vineeth

