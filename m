Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24DC6B5641
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Mar 2023 01:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjCKASU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 10 Mar 2023 19:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjCKASS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 10 Mar 2023 19:18:18 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EB3132F1;
        Fri, 10 Mar 2023 16:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+ARHuQPtw7KkJSupWbvgPmLwfErv+FHHapYCCtQE1SE=; b=T0HC0AQIG7hZwmwjzA66tz6EPL
        os0gfCEu9WoLgo4B6OqTf3bgLNX0pe2V2xsg2d+DaPH7HKXz/pmQbxnuY2tMA0dFwMN2XulLR2T13
        fO1xwKsNsfB/1EDZ5VNs9H9zc/EDQldu4ERIDMDASzfQ5DHACQQMPT57spauza28xtVY68a/qSMOz
        gn7ZaGpFnxvU+ROwaJJYLMhVWm28GZYTYhN1oePMK5U6J+aiGx7srjYWwtiA9f+hnHendw3pG5nxC
        HLKYq74BL/wO5dtcDhUTwftsJmwQzUunLWCHddVIP8zPtI4p7qQz9SbYZB2Qg8dOQr+mTPhZi5aJU
        AVG7PGbg==;
Received: from 201-68-164-191.dsl.telesp.net.br ([201.68.164.191] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1pamvv-003TXQ-Ps; Sat, 11 Mar 2023 01:17:59 +0100
Message-ID: <4de10796-d6fc-f485-064d-cb0cecea80c8@igalia.com>
Date:   Fri, 10 Mar 2023 21:17:49 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] x86/hyperv: Mark hv_ghcb_terminate() as noreturn
Content-Language: en-US
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "kernel-dev@igalia.com" <kernel-dev@igalia.com>,
        "kernel@gpiccoli.net" <kernel@gpiccoli.net>,
        Arnd Bergmann <arnd@arndb.de>
References: <20230310152442.cbrjise6uex4ak4x@treble>
 <20230310154452.1169204-1-gpiccoli@igalia.com>
 <BYAPR21MB16888EBB51D1597F9B9C212FD7BA9@BYAPR21MB1688.namprd21.prod.outlook.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <BYAPR21MB16888EBB51D1597F9B9C212FD7BA9@BYAPR21MB1688.namprd21.prod.outlook.com>
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

On 10/03/2023 18:17, Michael Kelley (LINUX) wrote:
> From: Guilherme G. Piccoli <gpiccoli@igalia.com>
>>
>> Annotate the function prototype as noreturn to prevent objtool
>> warnings like:
> 
> Just curious:  Should the actual function also be updated with
> __noreturn?   In similar situations, such as snp_abort(), the
> __noreturn attribute is both places.   I don't know what the 
> guidance is on this question.
> 
> In any case, thanks for doing this cleanup!
> 
> Michael

Thanks Michael!

In my understanding (anybody please correct me if I'm wrong) any user of
this function that rely on this header will "inherit" the attribute -
hence, if this function is not used in any other header or statically
inside it's own definition file, it's not necessary.

But I'm glad in submitting a V3 with that if it's better, let me know.
Cheers,


Guilherme
