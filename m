Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B416BDAE1
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Mar 2023 22:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjCPVZX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 16 Mar 2023 17:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjCPVZT (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 16 Mar 2023 17:25:19 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A341EC88A7;
        Thu, 16 Mar 2023 14:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lEtgciX7neRpN1XQOXz6KezY/vo1Oq9FDcCtCH4M8hQ=; b=MWExHWH9oA8T3OoibBzdZ5lRgb
        Yf4ksNBBI2QcsKqAwWnIFmhjlEBibomydD7ehO40k+rMRCZF7MO2ZIf0NFk+eO21eE9fO0mkYEI9W
        K8Hz7tdyAZOtl2cWPLXW//nnQfsYTTBaW5jqD2uzlf1Qnjl+L6yIXvKKFRrtYgdRP7xZ+r8HH5oUY
        MRZV8sAQiJk7n85s4Cg+AaXQp2zSkePnEaQBbORAYIFMJ2fng0CiW7yoivGhLJ+W7/J25731VIOEx
        4OaV+5UXnH8G0mvmPL6aYVkC3HKtIPjBZjnwUSUPESeYNmKtcQlxRnsTs2O+kHboLmGLCJo82pOw3
        2yqAi7XA==;
Received: from [152.254.169.34] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1pcv5j-00ERKN-7b; Thu, 16 Mar 2023 22:24:55 +0100
Message-ID: <a1f40654-b3cf-5c77-561e-056f47cbff61@igalia.com>
Date:   Thu, 16 Mar 2023 18:24:21 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] x86/hyperv: Mark hv_ghcb_terminate() as noreturn
Content-Language: en-US
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>
Cc:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
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
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <BYAPR21MB16888EBB51D1597F9B9C212FD7BA9@BYAPR21MB1688.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 10/03/2023 18:17, Michael Kelley (LINUX) wrote:
> [...]
> Just curious:  Should the actual function also be updated with
> __noreturn?   In similar situations, such as snp_abort(), the
> __noreturn attribute is both places.   I don't know what the 
> guidance is on this question.
> 

Hi Michael / Josh (and all), lemme know if you want me to submit a V3
doing that. The function is not called inside this own definition file
nor exported, so I'm not sure that'd be necessary, but glad to do so if
you prefer.

Thanks,


Guilherme
