Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4A17866C4
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Aug 2023 06:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238674AbjHXEeB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 24 Aug 2023 00:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239511AbjHXEdx (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 24 Aug 2023 00:33:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C4D10F0;
        Wed, 23 Aug 2023 21:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=LSXnJD44VIR9JsXcB9/2yi/FqjF9d8bRSrOH7J7jbr4=; b=AgzR/Knk2DJX3oW1rvjsKVixln
        66mgxRxSjB0xJTr8b/eHdpZl6tM3v8q3cy7mr3BQ/1O+aGYq1Feg2Ziw3rzItAtzqiy0+sdNp6iTX
        YVVnUKwZJgcRxys2B3yNwIclfDmGC+dqvbs/rawcMVBxREAyw2zrXTrV0i+/p75fhi4vPbGoANMXD
        odCtywue7Z0LD3H4reArHI8Mo8pLgrP61QmUVQeCml8qJvjHDtwG1lUueL09y5IrGjaMOVXob2vF+
        KaL3hdX2RF/bvAYdC/i8CvuxuUkgq2o9HYuIaBDbjXkSbnfOJ2kCP2WVIOZt6oB6eGOGu8Eh8vPVm
        +bzEAO1Q==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qZ22O-0029JV-0g;
        Thu, 24 Aug 2023 04:33:40 +0000
Message-ID: <f6f098c1-74de-be02-5882-bf07cc41d6d5@infradead.org>
Date:   Wed, 23 Aug 2023 21:33:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: linux-next: Tree for Aug 23 (hyperv)
Content-Language: en-US
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
References: <20230823161428.3af51dee@canb.auug.org.au>
 <449fdf75-6d5c-46c3-2a1e-23c55a73b62e@infradead.org>
 <ZObLMtemsJap3UX+@liuwe-devbox-debian-v2>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ZObLMtemsJap3UX+@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



On 8/23/23 20:14, Wei Liu wrote:
> On Wed, Aug 23, 2023 at 06:45:07PM -0700, Randy Dunlap wrote:
>>
>>
>> On 8/22/23 23:14, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> Changes since 20230822:
>>>
>>
>> on x86_64:
>>
>> In file included from ../arch/x86/hyperv/hv_init.c:20:
>> ../arch/x86/include/asm/mshyperv.h:272:12: warning: 'hv_snp_boot_ap' defined but not used [-Wunused-function]
>>   272 | static int hv_snp_boot_ap(int cpu, unsigned long start_ip) { return 0; }
>>       |            ^~~~~~~~~~~~~~
> [...]
>>
>> Full randconfig file is attached.
> 
> Thanks for the email.
> 
> I think this is already fixed in hyperv-next. In the latest code,
> hv_snp_boot_ap in has `inline` attribute.
> 

Sounds good. Thanks.

-- 
~Randy
