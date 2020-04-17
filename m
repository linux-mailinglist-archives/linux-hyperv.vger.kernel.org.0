Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE2121ADCD6
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Apr 2020 14:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730574AbgDQMDu (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 17 Apr 2020 08:03:50 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33249 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730573AbgDQMDu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 17 Apr 2020 08:03:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587125028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2HiKgLpGjG4i07nP9rVsSUNxw62w4Q5rV6+Enm1/11o=;
        b=B6tKDx2GEeh2COwS3r5mJTbcdidDZ3foXNFzBZWni//yM8ikmOIYaHJAdsvE+gVqfeit9G
        DsXecrFoLPmz+GmIcsMviI53g9KuDjXEJ8TISKEXgU4yrZp4Rg45KqPExltty1YtNmhTez
        CEJJXwag6caaA1WgAIwDagLZN4EV0oo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-lXowUQc2MVGg14abOadaaA-1; Fri, 17 Apr 2020 08:03:42 -0400
X-MC-Unique: lXowUQc2MVGg14abOadaaA-1
Received: by mail-wr1-f70.google.com with SMTP id r17so855467wrg.19
        for <linux-hyperv@vger.kernel.org>; Fri, 17 Apr 2020 05:03:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=2HiKgLpGjG4i07nP9rVsSUNxw62w4Q5rV6+Enm1/11o=;
        b=r5UyZEprqSc6RRqT+jBCiY4wpabn0cqZl7j/uk4XskxbcX830/gI54e66H2cpU2xf8
         cKan2rD/4CN8WsscG7PUwjxgbKu2NGmKmJqXoWp51EMcYBIdG5/5lpY/GXNLAoujSQPU
         Gsp214ViRVsluhpjSvdRD54ioi7AWuopydCmf5BsCzZ3N4vDFSMrBorHjo3sd279SH/4
         lMSWzUzk5IDD3OhWRP4KT1/usyI1uoUaZ8GC4aEvCAlTAw+CB3WlwVRPsCK1fARXf47r
         gf/4APNvqlO5WOScB4zg/1W1mjf4JKf4RGrSb3VVV479AZXCJcY8tppcs1nImVRuhre/
         DKgQ==
X-Gm-Message-State: AGi0PuZOOMjxjPH1fL46Eknp3v0P/+8tmzB+BoIIw3X9yr0VOxq6KVuh
        cxlUtsjn/EVb9GjXGoD4yPr6ItbdipRuOS0ABqJvbYaTlFU/evD7k44DyRDJ1D/Cqr8NofGPAPI
        1/tKs2JVKB9viHooj1fINvlhI
X-Received: by 2002:a5d:6785:: with SMTP id v5mr3410283wru.376.1587125021306;
        Fri, 17 Apr 2020 05:03:41 -0700 (PDT)
X-Google-Smtp-Source: APiQypJZMS5NEiNrai0mI6AMbtXgPZDaZhTg25gyTNcbiTpAwqbWLD1UsuLFebcZ5vd8dvU/UoiDZg==
X-Received: by 2002:a5d:6785:: with SMTP id v5mr3410255wru.376.1587125021043;
        Fri, 17 Apr 2020 05:03:41 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id c190sm7668458wme.10.2020.04.17.05.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 05:03:40 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Dexuan Cui <decui@microsoft.com>, bp@alien8.de,
        haiyangz@microsoft.com, hpa@zytor.com, kys@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, sthemmin@microsoft.com, tglx@linutronix.de,
        x86@kernel.org, mikelley@microsoft.com, wei.liu@kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH] x86/hyperv: Suspend/resume the VP assist page for hibernation
In-Reply-To: <20200417105558.2jkqq2lih6vvoip2@debian>
References: <1587104999-28927-1-git-send-email-decui@microsoft.com> <87blnqv389.fsf@vitty.brq.redhat.com> <20200417105558.2jkqq2lih6vvoip2@debian>
Date:   Fri, 17 Apr 2020 14:03:38 +0200
Message-ID: <87wo6etj39.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Wei Liu <wei.liu@kernel.org> writes:

> On Fri, Apr 17, 2020 at 12:03:18PM +0200, Vitaly Kuznetsov wrote:
>> Dexuan Cui <decui@microsoft.com> writes:
>> 
>> > Unlike the other CPUs, CPU0 is never offlined during hibernation. So in the
>> > resume path, the "new" kernel's VP assist page is not suspended (i.e.
>> > disabled), and later when we jump to the "old" kernel, the page is not
>> > properly re-enabled for CPU0 with the allocated page from the old kernel.
>> >
>> > So far, the VP assist page is only used by hv_apic_eoi_write().
>> 
>> No, not only for that ('git grep hv_get_vp_assist_page')
>> 
>> KVM on Hyper-V also needs VP assist page to use Enlightened VMCS. In
>> particular, Enlightened VMPTR is written there.
>> 
>> This makes me wonder: how does hibernation work with KVM in case we use
>> Enlightened VMCS and we have VMs running? We need to make sure VP Assist
>> page content is preserved.
>
> The page itself is preserved, isn't it?
>

Right, unlike hyperv_pcpu_input_arg is is not freed.

> hv_cpu_die never frees the vp_assit page. It merely disables it.
> hv_cpu_init only allocates a new page if necessary.

I'm not really sure that Hyper-V will like us when we disable VP Assist
page and have an active L2 guest using Enlightened VMCS, who knows what
it caches and when. I'll try to at least test if/how it works.

This all is not really related to Dexuan's patch)

-- 
Vitaly

