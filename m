Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDED32B773
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Mar 2021 12:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350805AbhCCLJi (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 3 Mar 2021 06:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2360338AbhCBWTZ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 2 Mar 2021 17:19:25 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472E5C061756
        for <linux-hyperv@vger.kernel.org>; Tue,  2 Mar 2021 14:18:43 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id f12so17714755wrx.8
        for <linux-hyperv@vger.kernel.org>; Tue, 02 Mar 2021 14:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1CRYhVcuu8s4Cw5PFiF8tO9YJ5r25Xl8k6gov04ULEU=;
        b=icZDFe3+5TQTPgxaJkRi0J2naNUIKvlSGc38uO678KNK/kmA4zNGfQrjNBdFvJRRY3
         tOQHpH3X2D0muDmTiQVzK2sP5DQ340sdSPgUaPxnBNG0+Zn+PEvPwCrWeSh2ALqCssex
         FhtkzNF5IHQro9Y4yssjBtOX3z4QRy/zriTrWCTReS6Mwc3Sqcq8AvTN2xfMaEEb5RP5
         OgEL31hFr0HKBtYVIGoI6CvNwsiq8H7n0IPNd2n0GlK1TqD4pf+OeXsJAAkAL6za97TA
         lUtyt0u/gchUFIkW8MT+nfmla4DXFy7dFZOXF9YcmBAiye/3DgGk8aWguq22rIbmG3JB
         pzkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1CRYhVcuu8s4Cw5PFiF8tO9YJ5r25Xl8k6gov04ULEU=;
        b=T1BX9KdB8mFMNYWaDP0StcKSksRvKnj0oFalYGMGMajMivyujvynINGiGQetnWbjkj
         D9SF+YIZfikQ81kvkHo30Gsfx5ZYRwjjOD23KeP4pjHEIgPnoWXjyV1FdffWDd5u0Bam
         gBT1x/O+6+huwfmefyHMSGekXKyBAXbN7PvH6RMPXmyYRvVQpco/aWwLizYMdC5X4M4P
         MVejtVfHd0jR/Ymngz4MNaGcVAN0QPPmIDBbFroYL3trfPlNkgcmc9EHQUtIQ9yBnECa
         nH0PyLoV47wsusswY8UFE2+6MKS2Gzrx+axs7iRqAhqPhb2PcpXfk2WKV1TTAcRpIJTj
         GwYA==
X-Gm-Message-State: AOAM530TIDIkNzcOhsJ0OR+Yk0hKWHlm7wMCjU9RDXni5T5DJbRJAGvV
        gvGHXbZL3wMag8sFmyMzfXitsA==
X-Google-Smtp-Source: ABdhPJyNXUSge9K5nPTyXhUQBFjlbqjElfe2HIxgZfCooI4E6F8xsZ+4MPQtGnu5E3gbpTLk90dpyA==
X-Received: by 2002:a5d:4443:: with SMTP id x3mr8722557wrr.49.1614723521783;
        Tue, 02 Mar 2021 14:18:41 -0800 (PST)
Received: from [192.168.0.41] (lns-bzn-59-82-252-144-192.adsl.proxad.net. [82.252.144.192])
        by smtp.googlemail.com with ESMTPSA id i8sm18569330wrx.43.2021.03.02.14.18.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Mar 2021 14:18:41 -0800 (PST)
Subject: Re: [PATCH v3 10/10] clocksource/drivers/hyper-v: Move handling of
 STIMER0 interrupts
To:     Michael Kelley <mikelley@microsoft.com>, sthemmin@microsoft.com,
        kys@microsoft.com, wei.liu@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, arnd@arndb.de,
        linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arch@vger.kernel.org
References: <1614721102-2241-1-git-send-email-mikelley@microsoft.com>
 <1614721102-2241-11-git-send-email-mikelley@microsoft.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <5495b52c-e619-90c4-0c4f-fdbde9e1ce58@linaro.org>
Date:   Tue, 2 Mar 2021 23:18:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1614721102-2241-11-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 02/03/2021 22:38, Michael Kelley wrote:
> STIMER0 interrupts are most naturally modeled as per-cpu IRQs. But
> because x86/x64 doesn't have per-cpu IRQs, the core STIMER0 interrupt
> handling machinery is done in code under arch/x86 and Linux IRQs are
> not used. Adding support for ARM64 means adding equivalent code
> using per-cpu IRQs under arch/arm64.
> 
> A better model is to treat per-cpu IRQs as the normal path (which it is
> for modern architectures), and the x86/x64 path as the exception. Do this
> by incorporating standard Linux per-cpu IRQ allocation into the main
> SITMER0 driver code, and bypass it in the x86/x64 exception case. For
> x86/x64, special case code is retained under arch/x86, but no STIMER0
> interrupt handling code is needed under arch/arm64.
> 
> No functional change.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

[ ... ]

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
