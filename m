Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0133B51C037
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 May 2022 15:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378837AbiEENJ2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 May 2022 09:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378845AbiEENJZ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 May 2022 09:09:25 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA5612A98;
        Thu,  5 May 2022 06:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=K5gn/7sp7L1lwAyBxMpQcFTyNqRFPph4Q66pGuhOfbY=; b=TwG/Y7SJWPlxMzvXvY6UbL6sJ+
        CFdPhtngSc5X84rkj+dUERbEGZ73AHlrth6uXHT5iHF+Ye3jngcDInSWu4kT86DX2OSO8YnWqUqG4
        pAQZ9NyHCOskp48HSEIXauRLverJszCC+n5H+8mWBhsdkvUOLKX9Llx6ExJu+0irM3/ShF79oYDx5
        GWv6C1bWPCCo69R58DuhXQ+KO7UKApDx6uPydfhCGg/uVUE+Ka6kiRZJis5Y83J9M0MXPLPMXhBP7
        byVsFvVwebplom62LBjJYn+vYrdl3OKyJ2sxoIOgI7viJrbJEbgpDUOLBnUqQgTTXKrcrWDWXP9a5
        BHj9CxuQ==;
Received: from [179.113.53.197] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1nmbAj-0000uD-EM; Thu, 05 May 2022 15:05:33 +0200
Message-ID: <3bee47db-f771-b502-82a3-d6fac388aa89@igalia.com>
Date:   Thu, 5 May 2022 10:05:18 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Should arm64 have a custom crash shutdown handler?
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        will Deacon <will@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>, broonie@kernel.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
References: <427a8277-49f0-4317-d6c3-4a15d7070e55@igalia.com>
 <874k24igjf.wl-maz@kernel.org>
 <92645c41-96fd-2755-552f-133675721a24@igalia.com>
 <YnPIwjLMDXgII1vf@FVFF77S0Q05N.cambridge.arm.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <YnPIwjLMDXgII1vf@FVFF77S0Q05N.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 05/05/2022 09:53, Mark Rutland wrote:
> [...]
> Looking at those, the cleanup work is all arch-specific. What exactly would we
> need to do on arm64, and why does it need to happen at that point specifically?
> On arm64 we don't expect as much paravirtualization as on x86, so it's not
> clear to me whether we need anything at all.
> 
>> Anyway, the idea here was to gather a feedback on how "receptive" arm64
>> community would be to allow such customization, appreciated your feedback =)
> 
> ... and are you trying to do this for Hyper-V or just using that as an example?
> 
> I think we're not going to be very receptive without a more concrete example of
> what you want.
> 
> What exactly do *you* need, and *why*? Is that for Hyper-V or another hypervisor?
> 
> Thanks
> Mark.

Hi Mark, my plan would be doing that for Hyper-V - kind of the same
code, almost. For example, in hv_crash_handler() there is a stimer
clean-up and the vmbus unload - my understanding is that this same code
would need to run in arm64. Michael Kelley is CCed, he was discussing
with me in the panic notifiers thread and may elaborate more on the needs.

But also (not related with my specific plan), I've seen KVM quiesce code
on x86 as well [see kvm_crash_shutdown() on arch/x86] , I'm not sure if
this is necessary for arm64 or if this already executing in some
abstracted form, I didn't dig deep - probably Vitaly is aware of that,
hence I've CCed him here.

Cheers,


Guilherme
