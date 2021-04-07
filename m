Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE9DE356E11
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 Apr 2021 16:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352743AbhDGODL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 7 Apr 2021 10:03:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41544 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245299AbhDGODK (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 7 Apr 2021 10:03:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617804180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Uu7DUKi3aMdx30NPxijI78spi2F+sW6pd08YQfEqN7g=;
        b=jNU9sqeveZMj2pGlqMQfeNHlmZuXWU/1I1cuB4e6Fi+A//bM0k52Sd1Ful7/Z6snpF4vOx
        Hdl51QU0gcaoRls6vBLha6xDOgQegDpYXfKbUFQesqWQXKNo+ods20/ZeTYpf0jkjYe5eD
        oraTyLG2/42sf+tQ576XSQy8ZX1RXao=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-i4ra2EJkNhKtVNcswdxjWQ-1; Wed, 07 Apr 2021 10:02:58 -0400
X-MC-Unique: i4ra2EJkNhKtVNcswdxjWQ-1
Received: by mail-ed1-f71.google.com with SMTP id a2so12142083edx.0
        for <linux-hyperv@vger.kernel.org>; Wed, 07 Apr 2021 07:02:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Uu7DUKi3aMdx30NPxijI78spi2F+sW6pd08YQfEqN7g=;
        b=oDpFH6VMIedB0+dRpl+5eVISAk7Vl4MdaXL11MWTKug2eEX0c9jhVy1NS8War1ryNZ
         b0sCZj+D0vuo6jmViDqvHm+umKw9mSrOYsUthrD27M7sj3WVu+dByTmYz2dDU6F6YPTS
         3tyn9VNReUfT2U6Cpvu+9gTEHGCGIGgcWXEMXgudLB67V8fo6Z6jLlAtR0JESx+aXu/I
         qr2ixcrPbEL4TK3BCYHr+WTfovHyCnvVxjjlM3ViaD8orsZ8yYq+nwgbQlamevbTNjuQ
         D3TqrCiju6wLO9L0LVT0rBXOm2bKpRg5f+SMt0kgVttIQeg31w1P1vSUymqK/Jd6R0Lq
         QRYA==
X-Gm-Message-State: AOAM532Qfhru9fyiNyhlPxeF4Yds15XdhSiqexkZyXoD8hfZZbJ2PMQU
        dL+uc4TI6OAkVLZVVPseudbjUGaSR1CmUfN36CPkfyrYyvKifgIAUyLLDvCdDNlE1LeKHX49TlL
        KryejkoB7p/k1mRfH4Bqx1gC7
X-Received: by 2002:a05:6402:42d1:: with SMTP id i17mr4441841edc.131.1617804177636;
        Wed, 07 Apr 2021 07:02:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwRY/y/lnspEMRzFi+bpSAp/LmL7KtYGcLjTCU76MWEezzicC4MAIKqO/OW+TvYrU+991QDMw==
X-Received: by 2002:a05:6402:42d1:: with SMTP id i17mr4441825edc.131.1617804177514;
        Wed, 07 Apr 2021 07:02:57 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id x17sm12637723ejd.68.2021.04.07.07.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 07:02:57 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        wei.liu@kernel.org, ligrassi@microsoft.com, kys@microsoft.com
Subject: Re: [RFC PATCH 04/18] virt/mshv: request version ioctl
In-Reply-To: <20210407134302.ng6n4el2km7sujfp@liuwe-devbox-debian-v2>
References: <1605918637-12192-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1605918637-12192-5-git-send-email-nunodasneves@linux.microsoft.com>
 <87y2fxmlmb.fsf@vitty.brq.redhat.com>
 <194e0dad-495e-ae94-3f51-d2c95da52139@linux.microsoft.com>
 <87eeguc61d.fsf@vitty.brq.redhat.com>
 <fc88ba72-83ab-025e-682d-4981762ed4f6@linux.microsoft.com>
 <87eefmczo2.fsf@vitty.brq.redhat.com>
 <20210407134302.ng6n4el2km7sujfp@liuwe-devbox-debian-v2>
Date:   Wed, 07 Apr 2021 16:02:56 +0200
Message-ID: <875z0ychv3.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Wei Liu <wei.liu@kernel.org> writes:

> On Wed, Apr 07, 2021 at 09:38:21AM +0200, Vitaly Kuznetsov wrote:
>
>> One more though: it is probably a good idea to introduce selftests for
>> /dev/mshv (similar to KVM's selftests in
>> /tools/testing/selftests/kvm). Selftests don't really need a stable ABI
>> as they live in the same linux.git and can be updated in the same patch
>> series which changes /dev/mshv behavior. Selftests are very useful for
>> checking there are no regressions, especially in the situation when
>> there's no publicly available userspace for /dev/mshv.
>
> I think this can wait until we merge the first implementation in tree.
> There are still a lot of moving parts. Our (currently limited) internal
> test cases need more cleaning up before they are ready. I certainly
> don't want to distract Nuno from getting the foundation right.
>

I'm absolutely fine with this approach, selftests are a nice add-on, not
a requirement for the initial implementation. Also, to make them more
useful to mere mortals, a doc on how to run Linux as root Hyper-V
partition would come handy)

-- 
Vitaly

