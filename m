Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5387151C082
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 May 2022 15:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236579AbiEENXj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 May 2022 09:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379120AbiEENXf (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 May 2022 09:23:35 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADD656F94;
        Thu,  5 May 2022 06:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1DNfkVatFPseIRLRTaf5GG9N3vrErBYge1wmaOwIZns=; b=LZPrJ/vjUPasOI43ov6ddZJwu/
        p0j9nUctyDj+SFAaWk7zI/PPi78KLqVLLq7RTp94cYeImH/Oz48mhUea8dNQwA1mwowWHdOQsW6Eg
        J9jMvU+x/33EcKgIVyWm0n8bR0BGRO5lxV56aAC+ZiKkzr7QN6HHEuJe/z6LDqeVex0+JBQrvmL32
        aVZeBYzmKvwP1cTw04LEGcx5Ku3dP26Y06ygZFvgIBF4N9l3WAyf1CRHjPuNa99Apa0axXvsaCvB2
        XF+dUTRht+ESY831J5TV75e00FEes8HLRzqS9eAvvPd25eOysvNknOidWwX4l6Ek+jpeGolt7tcpV
        USHVIKPg==;
Received: from [179.113.53.197] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1nmbOP-0001q2-IE; Thu, 05 May 2022 15:19:41 +0200
Message-ID: <3a52c5ac-e8c3-64dc-d94f-e210ccb19a70@igalia.com>
Date:   Thu, 5 May 2022 10:19:27 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Should arm64 have a custom crash shutdown handler?
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Marc Zyngier <maz@kernel.org>,
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
 <3bee47db-f771-b502-82a3-d6fac388aa89@igalia.com>
 <YnPN33qN7oVQa4fA@FVFF77S0Q05N.cambridge.arm.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <YnPN33qN7oVQa4fA@FVFF77S0Q05N.cambridge.arm.com>
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

On 05/05/2022 10:15, Mark Rutland wrote:
> [...]
> Without a strong justification, we wouldn't add such hooks to arm64.
> 
> Could you start by trying to use the notifiers, and if you encounter a problem,
> *then* we consider an alternative? That should mean we have a concrete reason.
> 
> Thanks,
> Mark.

That's a good idea Mark. I'm not expert in Hyper-V - I could try that
for a fact, but let's see if Michael has a strong reason on why this
need to be done in arch code and panic notifiers aren't enough.

Thanks,


Guilherme
