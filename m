Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A52460AE8
	for <lists+linux-hyperv@lfdr.de>; Sun, 28 Nov 2021 23:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238098AbhK1Wzb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 28 Nov 2021 17:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235189AbhK1Wxb (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 28 Nov 2021 17:53:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E81BC061574;
        Sun, 28 Nov 2021 14:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=89ua7qdKP6T880mk2hVigb/6DUZHisrYoIWnsSLq7PM=; b=oodOHHaWTLIMIQudG7ZEfzrvpS
        GlR78B93L+U4umKVCtUlo9c4rnfsdGI9a0V5kBJRKmMnLzhEN4cbITq9KdRFI4mv0krcLvS1d8pMw
        Yysvc+M92FI1318IC3ZPpjAi3YOeo+gUockgr5jCt190CHUlNSmk4puu8qpoT/w0tmSDz5g2c/89J
        0cp3mRjg9WVmiQQy54F9BYPMsvd4wupOr2CCVeaj5KAw9H8ADf64r8bj9zKghwyTaVCO4GWb2PznN
        4ZlYMZHRFIqUTqTSz09aZ3bnbgc2kq7wcPFVw8jBgID5ty7BQ2n9DqWEAHQBH23SqbaBsXfVaWo7u
        FbyEXpKw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mrSzl-004Yt0-RY; Sun, 28 Nov 2021 22:50:07 +0000
Message-ID: <8752eeae-6280-310e-85f1-bc0e594202fc@infradead.org>
Date:   Sun, 28 Nov 2021 14:49:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] hv: utils: add PTP_1588_CLOCK to Kconfig to fix build
Content-Language: en-US
To:     Wei Liu <wei.liu@kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20211126023316.25184-1-rdunlap@infradead.org>
 <MWHPR21MB159387A26F1FF1A77CEB4255D7649@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20211128212606.ft3qzwcsy3divl7z@liuwe-devbox-debian-v2>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20211128212606.ft3qzwcsy3divl7z@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



On 11/28/21 13:26, Wei Liu wrote:
> On Sat, Nov 27, 2021 at 07:12:11PM +0000, Michael Kelley (LINUX) wrote:
>> From: Randy Dunlap <rdunlap@infradead.org> Sent: Thursday, November 25, 2021 6:33 PM
>>>
>>> The hyperv utilities use PTP clock interfaces and should depend a
>>> a kconfig symbol such that they will be built as a loadable module or
>>> builtin so that linker errors do not happen.
>>>
>>> Prevents these build errors:
>>>
>>> ld: drivers/hv/hv_util.o: in function `hv_timesync_deinit':
>>> hv_util.c:(.text+0x37d): undefined reference to `ptp_clock_unregister'
>>> ld: drivers/hv/hv_util.o: in function `hv_timesync_init':
>>> hv_util.c:(.text+0x738): undefined reference to `ptp_clock_register'
>>>
>>> Fixes: 46a971913611a ("Staging: hv: move hyperv code out of staging directory")
>>
>> Seems like the "Fixes" tag should reference something a little newer than
>> when the Hyper-V code was first added.  Either commit 3716a49a81ba
>> ("hv_utils: implement Hyper-V PTP source") or commit e5f31552674e
>> ("ethernet: fix PTP_1588_CLOCK dependencies") when
>> PTP_1588_CLOCK_OPTIONAL was added.
> [...]
>>
>> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> 
> I used 3716a49a81ba in the Fixes tag and pushed it to hyperv-fixes.
> 
> Wei.

Oh, thank you.

~Randy

