Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0F36BEDAE
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Mar 2023 17:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjCQQFi (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 17 Mar 2023 12:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbjCQQFd (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 17 Mar 2023 12:05:33 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86328A46;
        Fri, 17 Mar 2023 09:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fpeUbGcjjy+4WfkcXpJ+w4mJC4TfpIrgZQL8Efq/lgw=; b=VGxV1NMAY7KXNAqJyMaNjinpsw
        oHqLWeRMgw0Jevo1MImj3JaFVOnXM1HOl/5ReLa382My+evaqFMq7H4xhjlzf5Yr636RNkjdLo0Mj
        aWnWozkUOkiiogoir12UhSZrFAAe2l1xgR+AWwTR+9G3/KFSNFK49OTnQQT7gOIwiL645GiSb4dI6
        8MImcAKXy5Fso4qUmw3RFeCot6MstIYCRYOeyjjQ+NpQRGBnsdCzX1LPVG9Lh90dtJv4HwUD1DgVp
        zlqCSYN9lUTgO4M8KbvbaHT/lid48kUomIAWWz6iwpZ297ip3LAE8Tyebgv2QTmSFqRqsGvkkQslc
        logipHPA==;
Received: from [152.254.169.34] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1pdCZV-00G3gn-80; Fri, 17 Mar 2023 17:04:49 +0100
Message-ID: <ef2b7503-1023-67c1-3b06-87d611472d22@igalia.com>
Date:   Fri, 17 Mar 2023 13:04:39 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] x86/hyperv: Mark hv_ghcb_terminate() as noreturn
Content-Language: en-US
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "kernel-dev@igalia.com" <kernel-dev@igalia.com>,
        "kernel@gpiccoli.net" <kernel@gpiccoli.net>,
        Arnd Bergmann <arnd@arndb.de>
References: <20230310152442.cbrjise6uex4ak4x@treble>
 <20230310154452.1169204-1-gpiccoli@igalia.com>
 <BYAPR21MB16888EBB51D1597F9B9C212FD7BA9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <a1f40654-b3cf-5c77-561e-056f47cbff61@igalia.com>
 <BYAPR21MB1688673F3E49C9944E892894D7BD9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <20230317145327.sl7kzgxtlqgrte7j@treble>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20230317145327.sl7kzgxtlqgrte7j@treble>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 17/03/2023 11:53, Josh Poimboeuf wrote:
> [...]
>>> Hi Michael / Josh (and all), lemme know if you want me to submit a V3
>>> doing that. The function is not called inside this own definition file
>>> nor exported, so I'm not sure that'd be necessary, but glad to do so if
>>> you prefer.
>>>
>>
>> I don't have a preference.  I was just trying to make sure the details
>> are all correct.  I'll defer to those with more knowledge of the
>> __noreturn attribute than I have.
> 
> It's not required, but probably good practice to put __noreturn in both
> places to make it more self-documenting.
> 

Thanks Josh and Michael, will submit a V3 shortly with this improvement!
Cheers,


Guilherme
