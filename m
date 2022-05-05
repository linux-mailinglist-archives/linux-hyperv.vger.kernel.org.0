Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB0351BFB2
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 May 2022 14:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356337AbiEEMsr (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 May 2022 08:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241946AbiEEMsr (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 May 2022 08:48:47 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB495535D;
        Thu,  5 May 2022 05:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=u3aGIMaSKSuXe0aOwXTF+DSUOA0MrbhCM2LmuOADZeQ=; b=JlBfZ7HAD+GX8IyDFPeDjKpa7U
        thWd55Q2hoN9Dylk9JbG2sonLgz2vPTLyafarA9yaQ2+bRtEdIuXAu6s+IS+eKcwGhgkHs1YboGg1
        kIF8UmjfEkGaQM4HFJzQfUlYB6jUDcfOGncazwv+9yiUFbIJ+2c0FgrURCMJZgSCffX9RRezrkphr
        JP1/NAwGnhbG8ZHeKzyc04ogsHi4OOph7P3hQfPirKsJ+e0PL04kijgaNntmGyf0GyLiGi3bKWcX/
        LIrIOW9KKvPCAYi8LfaTML0RpI7uF8NhdkSm6MISGSsUTiWI3Y7++P7XJfU1vMAsQ0rhGOYaCsp6v
        6y6eIGxg==;
Received: from [179.113.53.197] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1nmaqX-000C4H-C3; Thu, 05 May 2022 14:44:41 +0200
Message-ID: <92645c41-96fd-2755-552f-133675721a24@igalia.com>
Date:   Thu, 5 May 2022 09:44:25 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Should arm64 have a custom crash shutdown handler?
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>, mark.rutland@arm.com
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        will Deacon <will@kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>, broonie@kernel.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
References: <427a8277-49f0-4317-d6c3-4a15d7070e55@igalia.com>
 <874k24igjf.wl-maz@kernel.org>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <874k24igjf.wl-maz@kernel.org>
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

On 05/05/2022 04:29, Marc Zyngier wrote:
> [...]
> Not having any 'machine_ops' indirection was a conscious decision on
> arm64, if only to avoid the nightmare that 32bit was at a time with
> every single platform doing their own stuff. Introducing them would
> not be an improvement, but simply the admission that hypervisors are
> simply too broken for words. And I don't buy the "but x86 has it!"
> argument. x86 is a nightmare of PV mess that we can happily ignore,
> because we don't do PV for core operations at all.
> 
> If something has to be done to quiesce the system, it probably is
> related to the system topology, and must be linked to it. We already
> have these requirements in order to correctly stop ongoing DMA, shut
> down IOMMUs, and other similar stuff. What other requirements does
> your favourite hypervisor have?
> 

Thanks Marc and Mark for the details. I agree with most part of it, and
in fact panic notifiers was the trigger for this discussion (and they
are in fact used for this purpose to some extent in Hyper-V).

The idea of having this custom handler from kexec comes from Hyper-V
discussion - I feel it's better to show the code, so please take a look
at functions: hv_machine_crash_shutdown()
[arch/x86/kernel/cpu/mshyperv.c] and the one called from there,
hv_crash_handler() [drivers/hv/vmbus_drv.c].

These routines perform last minute clean-ups, right before kdump/kexec
happens, but *after* the panic notifiers. It seems there is no way to
accomplish that without architecture involvement or core kexec code
pollution heh

Anyway, the idea here was to gather a feedback on how "receptive" arm64
community would be to allow such customization, appreciated your feedback =)

Cheers,


Guilherme
