Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25E9026D9EC
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Sep 2020 13:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgIQLN6 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 17 Sep 2020 07:13:58 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48952 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726480AbgIQLNn (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 17 Sep 2020 07:13:43 -0400
X-Greylist: delayed 305 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 07:13:43 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600341187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GKnhWldhLJFQr5DuJgjC2hvPEX9vnawus1q/hrcZp+0=;
        b=P7XtXXe60RWe5DuGUDOAazKrykAnio/lccCZSjLcBEWFtPQia+xFBI/gV0VTk/et5FpyLN
        p/6ISroMdFDw0ZSGVqDhXYKyg1jmIdzUBUVPn7fh6Wo+fqDHMKvtvmU+rRrmZ/bhiEpaa1
        y2C395kOFoLq2NR2TCGd+Sk25iGI7KE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-V3p4RzN-PcWMCOT-iY_VKQ-1; Thu, 17 Sep 2020 07:06:09 -0400
X-MC-Unique: V3p4RzN-PcWMCOT-iY_VKQ-1
Received: by mail-wr1-f71.google.com with SMTP id 33so753309wre.0
        for <linux-hyperv@vger.kernel.org>; Thu, 17 Sep 2020 04:06:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=GKnhWldhLJFQr5DuJgjC2hvPEX9vnawus1q/hrcZp+0=;
        b=NOEEIqrZpPWrx2hzJcahhqQld/1INwFswyqVI+tGDMsbrJYtm6OFkNKJR7XZc7U0Yx
         +JbF2aAL6IfpsW7fnHodFcx1jyQdV14H3emm5Spt1ZBQeZxU7QRxACT4qFArLI/3tsvW
         FPpM5y4e9wM3YUcjbr54Tuqpl+1/ahVtlW1RuvOI31LpRcHXg3U/h10E2T7Ndl1zVaAx
         kTMnUccdhCWLHANbEps7jj4h1lXMUHfSLz+fUQBYBEs+7xDyjrHE7i7KKrKK92sn/D7w
         oUoMtyBPgfq5//Vy7fpGS5f6RCmckG1AIa9B1O8y4Z+ChGwMn5bGZV6izOIQHvxUr2hu
         m+uA==
X-Gm-Message-State: AOAM531OifX+4nHm1NUNOtaD9LJhsgNxgfPH0nvvhuVB03xkXwFJDP2z
        cs4Bw3axBRvCh4BjihExBaByxFT1fhCdWxwcnOGfCPk2gmkepnrKBpgv9stkzWJbvA9Kcru8NX/
        nl8VqLjhTrZm6Vz+eKv49VR97
X-Received: by 2002:a1c:480a:: with SMTP id v10mr8966910wma.141.1600340768653;
        Thu, 17 Sep 2020 04:06:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfvk8nBFDHZbY4h5lzElLZko5UHfTtrciX4WBrNYMfc9yO+qi5h6FrEF/dqbAWoZhK7788tg==
X-Received: by 2002:a1c:480a:: with SMTP id v10mr8966887wma.141.1600340768444;
        Thu, 17 Sep 2020 04:06:08 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id v4sm10412112wml.46.2020.09.17.04.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 04:06:07 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sunil Muthuswamy <sunilmut@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Cc:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        "virtualization\@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Nuno Das Neves <Nuno.Das@microsoft.com>,
        Lillian Grassin-Drake <Lillian.GrassinDrake@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer\:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: RE: [EXTERNAL] Re: [PATCH RFC v1 08/18] x86/hyperv: handling hypercall page setup for root
In-Reply-To: <SN4PR2101MB0880AAC1B92038C7FDE3496DC0210@SN4PR2101MB0880.namprd21.prod.outlook.com>
References: <20200914112802.80611-1-wei.liu@kernel.org> <20200914112802.80611-9-wei.liu@kernel.org> <87v9gfjpoi.fsf@vitty.brq.redhat.com> <20200915103710.cqmdvzh5lys4wsqo@liuwe-devbox-debian-v2> <SN4PR2101MB0880AAC1B92038C7FDE3496DC0210@SN4PR2101MB0880.namprd21.prod.outlook.com>
Date:   Thu, 17 Sep 2020 13:06:06 +0200
Message-ID: <87o8m4hdcx.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Sunil Muthuswamy <sunilmut@microsoft.com> writes:

>> 
>> On Tue, Sep 15, 2020 at 12:32:29PM +0200, Vitaly Kuznetsov wrote:
>> > Wei Liu <wei.liu@kernel.org> writes:
>> >
>> > > When Linux is running as the root partition, the hypercall page will
>> > > have already been setup by Hyper-V. Copy the content over to the
>> > > allocated page.
>> >
>> > And we can't setup a new hypercall page by writing something different
>> > to HV_X64_MSR_HYPERCALL, right?
>> >
>> 
>> My understanding is that we can't, but Sunil can maybe correct me.
>
> That is correct. For root partition, the hypervisor has already allocated the
> hypercall page. The root is required to query the page, map it in its address
> space and wrmsr to enable it. It cannot change the location of the page. For
> guest, it can allocate and assign the hypercall page. This is covered a bit in the
> hypervisor TLFS (section 3.13 in TLFS v6), for the guest side. The root side is 
> not covered there, yet.

Ok, so it is guaranteed that root partition doesn't have this page in
its address space yet, otherwise it could've been used for something
else (in case it's just normal memory from its PoV).

Please add a comment about this as it is not really obvious.

Thanks,

-- 
Vitaly

