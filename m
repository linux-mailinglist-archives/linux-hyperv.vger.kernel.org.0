Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 515DEA5E94
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Sep 2019 02:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725306AbfICA05 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 2 Sep 2019 20:26:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:46300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbfICA04 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 2 Sep 2019 20:26:56 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FBD3217D7;
        Tue,  3 Sep 2019 00:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567470415;
        bh=CpSh531kSMsWVsg+csCc9LQY9qSB04mGRxQu2mgSbJI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=snDUKYufOttJ2mzWfSL/XrmIysIy8evUufnMgLvADai4NPgj0SG5bUDfRAvT4Ydm9
         Onoz3J0RfG5BdVHDxuVkd5PHdmY5x6URWVGPdpr8TkmUhjOI6ja4yeyMHs87ZDUZgG
         OYa2yM5TEci4+fSZOlE/acb+4mU1D56IEh4spFqI=
Date:   Mon, 2 Sep 2019 20:26:54 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        "m.maya.nakamura" <m.maya.nakamura@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 4/5] HID: hv: Remove dependencies on PAGE_SIZE for
 ring buffer
Message-ID: <20190903002654.GC5281@sasha-vm>
References: <cover.1562916939.git.m.maya.nakamura@gmail.com>
 <5cfa6f8ded52ee709ede57a97fc71e8671b1ceb1.1562916939.git.m.maya.nakamura@gmail.com>
 <DM5PR21MB013708BF1876B7282C049B76D7BC0@DM5PR21MB0137.namprd21.prod.outlook.com>
 <nycvar.YFH.7.76.1909021330230.27147@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1909021330230.27147@cbobk.fhfr.pm>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Sep 02, 2019 at 01:30:44PM +0200, Jiri Kosina wrote:
>On Sat, 31 Aug 2019, Michael Kelley wrote:
>
>> From: Maya Nakamura <m.maya.nakamura@gmail.com>  Sent: Friday, July 12, 2019 1:28 AM
>> >
>> > Define the ring buffer size as a constant expression because it should
>> > not depend on the guest page size.
>> >
>> > Signed-off-by: Maya Nakamura <m.maya.nakamura@gmail.com>
>> > Reviewed-by: Michael Kelley <mikelley@microsoft.com>
>>
>> Jiri and Benjamin -- OK if this small patch for the Hyper-V HID driver
>> goes through the Hyper-V tree maintained by Sasha Levin?   It's a purely
>> Hyper-V change so the ring buffer size isn't bigger when running
>> on ARM64 where the page size might be 16K or 64K.
>
>Yeah; FWIW feel free to add
>
>	Acked-by: Jiri Kosina <jkosina@suse.cz>

Queued up for hyperv-next, thanks!

--
Thanks,
Sasha
