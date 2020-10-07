Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5294285DF7
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 Oct 2020 13:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgJGLPr (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 7 Oct 2020 07:15:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41542 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726411AbgJGLPq (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 7 Oct 2020 07:15:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602069345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3r5XQBzMLmQ+lHSJjnDEGaGsxnKJm0CF1PWaPtea4dc=;
        b=GG8zvhq9C5PJbw0JeYKdjzed/70oj5HWbjeBFYvekhyut1Xdfd/UAQnPafg60MQsXvjyGA
        NAqOJK3IY9wy4AxtgrUWND1G1+/RyASo193fwy7GEpbr5Wksx+BAljtEgI3+cd3k8Exf9P
        wBaVBlQxCIYENgY81QEm43kfDsIRpPU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-K0ZdqCKYN-Gq6OzOU7iMVA-1; Wed, 07 Oct 2020 07:15:44 -0400
X-MC-Unique: K0ZdqCKYN-Gq6OzOU7iMVA-1
Received: by mail-wm1-f72.google.com with SMTP id s12so1967683wmj.0
        for <linux-hyperv@vger.kernel.org>; Wed, 07 Oct 2020 04:15:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3r5XQBzMLmQ+lHSJjnDEGaGsxnKJm0CF1PWaPtea4dc=;
        b=NDdYQ9tOEkxFGL11mQqUwF0K9+4XI7FAQZtQf92kuL+1lNm5CPxUtM5V0u/vAAzibj
         WJw9qmqTU2V9Bob06mGkXxFz8dGFSRHFkzdzPrJd3A5OtsfxyX5olHURLUcD1ypVal6O
         UsfYX231WDyxyUIWigGhpx1RwuSSvC+oWtIdyJWpDZXn3jJT1+3X7Qffi95ywyyDA6z4
         2ivii5HDKiObv4VmJuBV1/ZsJPODqjyeXZq3cmu1fsA2NDPEsKgtOQA0CznJfFefcM2u
         G9c32Ag51/jKj9HIbkoKaLflEojJq/Ph6sGFj0FxYPbmpbFzyRoRepUd4PM337v3F3wO
         NLnQ==
X-Gm-Message-State: AOAM532Iyw7sVehhAapTlBhAd2tyMDCGLJbW8Qhe7ugqUtcsLuhEhTcu
        4K/TwT2o7YbtjTs8rtlkDm5lfj04gJZODPR/rmSteNpBjJiQX/QIoQr8erWiIh96Tt5A9aDIZFb
        AwmzAXcuVrXoZZBKV52ur3eSD
X-Received: by 2002:a5d:46c5:: with SMTP id g5mr3072279wrs.416.1602069342761;
        Wed, 07 Oct 2020 04:15:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7sYpP9gVtxipT0pzhdsv4463xKXEPVIHdH2X3m2sQwU7XAAsdRDas6Bf2F6nO3skuNDVcig==
X-Received: by 2002:a5d:46c5:: with SMTP id g5mr3072258wrs.416.1602069342576;
        Wed, 07 Oct 2020 04:15:42 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d2f4:5943:190c:39ff? ([2001:b07:6468:f312:d2f4:5943:190c:39ff])
        by smtp.gmail.com with ESMTPSA id a15sm2556682wrn.3.2020.10.07.04.15.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2020 04:15:41 -0700 (PDT)
Subject: Re: [PATCH 13/13] x86/kvm: Add KVM_FEATURE_MSI_EXT_DEST_ID
To:     David Woodhouse <dwmw2@infradead.org>, x86@kernel.org
Cc:     iommu <iommu@lists.linux-foundation.org>,
        kvm <kvm@vger.kernel.org>, linux-hyperv@vger.kernel.org
References: <77e64f977f559412f62b467fd062d051ea288f14.camel@infradead.org>
 <20201005152856.974112-1-dwmw2@infradead.org>
 <20201005152856.974112-13-dwmw2@infradead.org>
 <472a34e3-2981-0c7b-1fb0-da8debbdc728@redhat.com>
 <b1f7e1210580acdf4673498be71eaf33acb8c146.camel@infradead.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8a502c78-71d7-83f6-7ba8-b16fd41e64fe@redhat.com>
Date:   Wed, 7 Oct 2020 13:15:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <b1f7e1210580acdf4673498be71eaf33acb8c146.camel@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 07/10/20 10:59, David Woodhouse wrote:
> Yeah, I was expecting the per-irqdomain affinity support to take a few
> iterations. But this part, still sticking with the current behaviour of
> only allowing CPUs to come online at all if they can be reached by all
> interrupts, can probably go in first.
> 
> It's presumably (hopefully!) a blocker for the qemu patch which exposes
> the same feature bit defined in this patch.

Yeah, though we could split it further and get the documentation part in
first.  That would let the QEMU part go through.

Paolo

