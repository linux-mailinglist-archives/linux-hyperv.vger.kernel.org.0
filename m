Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309A751C1EB
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 May 2022 16:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbiEEOMC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 May 2022 10:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379552AbiEEOMB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 May 2022 10:12:01 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F41D58E7D;
        Thu,  5 May 2022 07:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8JT2x37xZIzthLtBDgRsuH3ctJdQtVKBakBAtylmM70=; b=qN2OUQgURSd4atQ9ojy4KcXFfS
        sWIuQHbJNPSlD2E1P1AYNseX/DMWERL/XxEbWf0Ln92hnX/LfynfNczq+DBV+OfTxTdwclMkS5O6d
        B5pUIzXuLcTs3oRrMsYvREgCNbi1rr5E3v9eP0PQNFUGlIsbZX30nT8Z7Fpfecrj+UabZnxoHILmC
        IezNI+AEM6kk7OR9ISOTKj+1sLlzN+Rsx6OlZrdElqLfko1pgXkuoNqmKFgsMlZClu9X31T7ETWdv
        z9SR8j82Tnr31zFYqSmR5Oiq0X3V605KjIFs9rF6sWuG7ul+kFFzulfPRxRkmmUjPVDw00dreV/2j
        icYj7m/A==;
Received: from [179.113.53.197] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1nmc9I-0005v2-8O; Thu, 05 May 2022 16:08:08 +0200
Message-ID: <53d516d2-a991-05c2-981d-640b05fc5e29@igalia.com>
Date:   Thu, 5 May 2022 11:07:47 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Should arm64 have a custom crash shutdown handler?
Content-Language: en-US
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        will Deacon <will@kernel.org>,
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
 <3bee47db-f771-b502-82a3-d6fac388aa89@igalia.com> <878rrg13zb.fsf@redhat.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <878rrg13zb.fsf@redhat.com>
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

On 05/05/2022 10:52, Vitaly Kuznetsov wrote:
> [...]
> For Hyper-V, the situation is similar: hv_crash_handler() intitiates
> VMbus unload on the crashing CPU only, there's no mechanism to do
> 'global' unload so other CPUs will likely not be able to connect Vmbus
> devices in kdump kernel but this should not be necessary.
> 
> There's a crash_kexec_post_notifiers mechanism which can be used instead
> but it's disabled by default so using machine_ops.crash_shutdown is
> better.
> 

Thanks a bunch Vitaly, for the clarification!

Just as a heads-up: there's been a panic notifiers refactor proposed [0]
in which some notifiers will run before kdump by default, not requiring
"crash_kexec_post_notifiers" (which BTW is *unfortunately* hardcoded as
'Y' for hyper-v, since a11589563e96).

Cheers,


Guilherme


[0]
https://lore.kernel.org/lkml/20220427224924.592546-1-gpiccoli@igalia.com/
