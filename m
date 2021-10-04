Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B6A4214D9
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 Oct 2021 19:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238157AbhJDRKY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 4 Oct 2021 13:10:24 -0400
Received: from linux.microsoft.com ([13.77.154.182]:48224 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238154AbhJDRKX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 4 Oct 2021 13:10:23 -0400
Received: from [10.0.0.179] (c-67-168-106-253.hsd1.wa.comcast.net [67.168.106.253])
        by linux.microsoft.com (Postfix) with ESMTPSA id 64D1520B861E;
        Mon,  4 Oct 2021 10:08:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 64D1520B861E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1633367314;
        bh=Rbd9RF6P4cr+/hPmLdlhjReNaN0Mq2ubykM7bwNnxjg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VNDG4z85s0SO5J2nfFk9q0DaWAtEL4AxxV2m2vOgCLHGRJFCrZrYzyg1eiLrLFLF+
         KrbwsZDGnTOS0IpBNPJKgDJUkUDllJz+3aLK8dRC+tkRTH31GpcH5NZ3itB3JDzVGq
         ZsLGeAd2/K9+5ng/TaHF54sLsQ1b3tpTVlB1AiYI=
Subject: Re: [PATCH v3 08/19] drivers/hv: map and unmap guest memory
To:     Wei Liu <wei.liu@kernel.org>, Olaf Hering <olaf@aepfle.de>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mikelley@microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        vkuznets@redhat.com, ligrassi@microsoft.com, kys@microsoft.com,
        sthemmin@microsoft.com, anbelski@linux.microsoft.com
References: <1632853875-20261-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1632853875-20261-9-git-send-email-nunodasneves@linux.microsoft.com>
 <20210928232702.700ef605.olaf@aepfle.de>
 <20210930141734.gx2th6sz6dbnyr6m@liuwe-devbox-debian-v2>
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
Message-ID: <e39a2b44-ea1a-8cb0-8b71-64137a2dd1a3@linux.microsoft.com>
Date:   Mon, 4 Oct 2021 10:08:33 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210930141734.gx2th6sz6dbnyr6m@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



On 9/30/2021 7:17 AM, Wei Liu wrote:
> On Tue, Sep 28, 2021 at 11:27:02PM +0200, Olaf Hering wrote:
>> Am Tue, 28 Sep 2021 11:31:04 -0700
>> schrieb Nuno Das Neves <nunodasneves@linux.microsoft.com>:
>>
>>> +++ b/include/asm-generic/hyperv-tlfs.h
>>> -#define HV_HYP_PAGE_SHIFT      12
>>> +#define HV_HYP_PAGE_SHIFT		12
>>
>> I think in case this change is really required, it should be in a separate patch.
> 
> I don't think this hunk should be in this patch. It is just changing
> whitespaces.
> 

Thanks, good point. I think I'll remove this hunk from the series altogether.

> Wei.
> 
>>
>>
>> Olaf
> 
