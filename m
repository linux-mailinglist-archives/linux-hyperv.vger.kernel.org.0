Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1AFF2A0C30
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Oct 2020 18:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbgJ3RKE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 30 Oct 2020 13:10:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28882 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727260AbgJ3RKD (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 30 Oct 2020 13:10:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604077802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=POiH+UTIQRn0JBLcQzI9Mi/p4K/baPIJccrz/92D+8g=;
        b=g6Qs4EaAJwz/eOEeifHd9tpCW8c4jxfchtum4SF9BaoT6K8QtIy0m0DbTYL9q9V9tML+t+
        UWN+HZ/G5H5WeMhw95MXfEqauH2Pq0B4BNHtomhnA7TbcWYYLBBcbV9B+OYt8smVEIwMHS
        eRGcF8CI4GDn2xnwmHb7QFdEVMbc90k=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-slPuIQRsNpKqDiZOqv7ldQ-1; Fri, 30 Oct 2020 13:10:00 -0400
X-MC-Unique: slPuIQRsNpKqDiZOqv7ldQ-1
Received: by mail-ej1-f70.google.com with SMTP id x12so2655917eju.22
        for <linux-hyperv@vger.kernel.org>; Fri, 30 Oct 2020 10:10:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=POiH+UTIQRn0JBLcQzI9Mi/p4K/baPIJccrz/92D+8g=;
        b=U4Tm7IhA4ZF69caQN9QIbU455cnM2mhGtXgRmtjvsjfqgFMLGO3PwTD3oBW794gDeM
         HR0nq8TUaHFbhrAF5WZvBDL1cj3u+a2rx+TcQNieeymJB1cXl1gqtoTx9hd/Qc0Yajrm
         12Ffwpqe6c2OUx20HFYbEtVvW2TswC92ZsNGVk5ogqLepnl4jF1EJX+VdnI/kOegJh3K
         t6GrEzC2D3LXw0uCuwKs37yK9QGYNFVzEL+uvEKl2fBHTLBQpDjJrSqZ7RhNO9d7OSvj
         eRmCFzV16HO5OMfEgATpcZu1zs4Q17m5VHKSpkpuutCG8pvW9QLz5fsIxtKkSRVWN+WZ
         tKlQ==
X-Gm-Message-State: AOAM533LdIxCj628E5XDzdeJF557N3oW4fSRsgz0OtQOl4cCtg8mPMBt
        iogWCheZL1w42jmQEHDnO/IatA3VTTgq/4Ah+Y+kvdcS7VR2KGZ5eolJ+iP5Hku0FsrSWYH92xD
        kt3/9XYoUfvE4xQ5VYMIijjeY
X-Received: by 2002:a17:906:abcf:: with SMTP id kq15mr3453974ejb.208.1604077798635;
        Fri, 30 Oct 2020 10:09:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQmMw/BcCSYTPYNtDCi4SYyoff/S9mRwPykV6ni6VVynXSkdXnwRZ0NfUl9xrU+UVzA74cUg==
X-Received: by 2002:a17:906:abcf:: with SMTP id kq15mr3453953ejb.208.1604077798425;
        Fri, 30 Oct 2020 10:09:58 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id b25sm3309998eds.66.2020.10.30.10.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 10:09:57 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Cc:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Subject: Re: ** POTENTIAL FRAUD ALERT - RED HAT ** RE: Field names inside ms_hyperv_info
In-Reply-To: <MW2PR2101MB10520A20D4ADB1CE6B6AD559D7150@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20201028150323.tz5wamibt42dgx7f@liuwe-devbox-debian-v2> <87lffnzqhp.fsf@vitty.brq.redhat.com> <MW2PR2101MB10520A20D4ADB1CE6B6AD559D7150@MW2PR2101MB1052.namprd21.prod.outlook.com>
Date:   Fri, 30 Oct 2020 18:09:57 +0100
Message-ID: <87imarzllm.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Michael Kelley <mikelley@microsoft.com> writes:

> From: Vitaly Kuznetsov <vkuznets@redhat.com>
>> 
>> Wei Liu <wei.liu@kernel.org> writes:
>> 
>> > Hi all
>> >
>> > During my work to make Linux boot as root partition on MSHV, I found out
>> > that a privilege mask was not collected in ms_hyperv_info.
>> >
>> > Looking at the code, the field names of ms_hyperv_info are not
>> > consistent with the names defined in TLFS. That makes it difficult to
>> > choose a name for the field that stores the privilege mask.
>> >
>> > I've got a local patch to make the existing fields closer to TLFS. The
>> > suffix "_a" means the value comes from EAX.
>> >
>> > Given that this structure is also used on ARM, so having x86 suffix is
>> > probably not the best idea. Do people care?
>> >
>> > diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
>> > index c57799684170..913af5e93cce 100644
>> > --- a/include/asm-generic/mshyperv.h
>> > +++ b/include/asm-generic/mshyperv.h
>> > @@ -26,9 +26,9 @@
>> >  #include <asm/hyperv-tlfs.h>
>> >
>> >  struct ms_hyperv_info {
>> > -       u32 features;
>> > -       u32 misc_features;
>> > -       u32 hints;
>> > +       u32 features_a;
>> > +       u32 features_d;
>> > +       u32 recommendations;
>> >         u32 nested_features;
>> >         u32 max_vp_index;
>> >         u32 max_lp_index;
>> >
>> > Any comment on this? I'm normally bad at naming things so any suggestion
>> > is welcomed.
>> 
>> My take: let's avoid ambiguous '_a', '_d' and use full register names,
>> it's only three letters after all. Let's also avoid suffix-less names as
>> eventually we'll need to add non-eax parts. That is:
>> 
>>        u32 features_eax;
>>        u32 features_edx;
>>        u32 recommendations_eax;
>>        u32 nested_features_eax;
>> ...
>> 
>> I would also feel comfortable with these names sortened,
>> 
>>        u32 feat_eax;
>>        u32 feat_edx;
>>        u32 recomm_eax;
>>        u32 nested_feat_eax;
>> ...
>> 
>
> This is in the asm-generic portion of mshyperv.h, so it is shared
> across the x86 and ARM64 architectures.  So I don't think we
> want x86 register names.  On ARM64, the eax/ebx/ecx/edx
> portions are retrieved all together in a single 128-bit register
> read.  I abstracted this into four 32-bit parts labeled
> "a", "b", "c", and "d" with the obvious mapping to
> eax/ebx/ecx/edx on the x86 side, but without using those names.
>

Oh, yea, I completely forgot about ARM! Using '_a'..'_d' suffixes is
justified then. 

> We don't have a TLFS for ARM64 (should be coming soon).  Might
> be worth seeing what naming, if any, will be used there.

In that case we should probably wait untill the naming there is clear as
I'm afraid we'll be renaming again.

-- 
Vitaly

