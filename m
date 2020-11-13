Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38F52B1FD4
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Nov 2020 17:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgKMQOB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 13 Nov 2020 11:14:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44603 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726648AbgKMQOA (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 13 Nov 2020 11:14:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605284039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lPjThI4CN4zNtchIWv2ayPLPXQ5dzA6VBedvQBJvswQ=;
        b=W9A6l0AIkxPh6tKgD+0gzY7oa8WdQFUdEKvuyAl6LGwUvhUvFU2Mu6FmzPOoPTGxulLKWQ
        qZZj115Af8gCG826hjfjj+w8GkVv+wRMBE+i3+bhB64oyG4tNra8MMwGvHBZr0b5zNVtjy
        Eu3AatCyLkU4RNSrkGibn98iw4bgZFA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-pQyrAZMkM0iVtKRDTg_6XQ-1; Fri, 13 Nov 2020 11:13:57 -0500
X-MC-Unique: pQyrAZMkM0iVtKRDTg_6XQ-1
Received: by mail-wr1-f71.google.com with SMTP id w6so4091409wrk.1
        for <linux-hyperv@vger.kernel.org>; Fri, 13 Nov 2020 08:13:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=lPjThI4CN4zNtchIWv2ayPLPXQ5dzA6VBedvQBJvswQ=;
        b=BpO74l7kOErSsO5u/eSJCmCyfs1ViRJbc/ugF9UMyM1aAlWFkiQMQD/UzMoiz9k1T7
         PtMh0C9lk9IbNjujbtBQ4LaFRUw/2RoIiTEBjNf+vxQ7lu1Ufa9lnHtG0pMHhTQYxk27
         2pbcsxNAIASEpHpmlo45jvW4wErfGfJiD4kHQfO3y3r0nUwNOtvGZ3aQ5wO1MtfOUwT0
         Ov81ikT8Wmm5teOogLc31Zh/Macq4t43kC4AYlnG5fsiPmRbtWVCNH+dgR0Ub0dTTvVU
         nyst2jyuspH9AQyLyBexmn7pKmTQgcd3O3dwcvcX5Njzmku2GIhzV7YzlBjJd0ONZvBs
         jKMw==
X-Gm-Message-State: AOAM532Drix9T8JtA7c76/kwsJGDAaa7fFr/yQUdrynBO/C/ZVZ7YmDg
        gJYlNw2BmFTKNhZi2FSfk+n08jjYkCugx27gQxfHYTtHUBE57E6L+FY7gtYcmFVETv2tSBAbnY1
        Sks//g340EBpfMkUinVj2LDzV
X-Received: by 2002:a1c:6508:: with SMTP id z8mr3330857wmb.80.1605284031507;
        Fri, 13 Nov 2020 08:13:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwEiuKnDYBv81x66rrPhoiQlzwCLdD8os2zSbokQH7OHbb6WTSUyo1RRJZXPMJ4FUH64NtzPg==
X-Received: by 2002:a1c:6508:: with SMTP id z8mr3330501wmb.80.1605284026289;
        Fri, 13 Nov 2020 08:13:46 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id u6sm10587225wmj.40.2020.11.13.08.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 08:13:45 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Lillian Grassin-Drake <ligrassi@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v2 09/17] x86/hyperv: provide a bunch of helper functions
In-Reply-To: <20201113155111.fcruk7dlsp6ohoq5@liuwe-devbox-debian-v2>
References: <20201105165814.29233-1-wei.liu@kernel.org>
 <20201105165814.29233-10-wei.liu@kernel.org>
 <871rgyy3d1.fsf@vitty.brq.redhat.com>
 <20201113155111.fcruk7dlsp6ohoq5@liuwe-devbox-debian-v2>
Date:   Fri, 13 Nov 2020 17:13:44 +0100
Message-ID: <87zh3lutdz.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Wei Liu <wei.liu@kernel.org> writes:

> On Thu, Nov 12, 2020 at 04:57:46PM +0100, Vitaly Kuznetsov wrote:
>> Wei Liu <wei.liu@kernel.org> writes:
> [...]
>> > diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
>> > index 67f5d35a73d3..4e590a167160 100644
>> > --- a/arch/x86/include/asm/mshyperv.h
>> > +++ b/arch/x86/include/asm/mshyperv.h
>> > @@ -80,6 +80,10 @@ extern void  __percpu  **hyperv_pcpu_output_arg;
>> >  
>> >  extern u64 hv_current_partition_id;
>> >  
>> > +int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
>> > +int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
>> > +int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);
>> 
>> You seem to be only doing EXPORT_SYMBOL_GPL() for
>> hv_call_deposit_pages() and hv_call_create_vp() but not for
>> hv_call_add_logical_proc() - is this intended? Also, I don't see
>> hv_call_create_vp()/hv_call_add_logical_proc() usage outside of
>> arch/x86/kernel/cpu/mshyperv.c so maybe we don't need to export them at all?
>> 
>
> hv_call_deposit_pages and hv_call_create_vp will be needed by /dev/mshv,
> which can be built as a module.
>

I'd suggest to move EXPORT_SYMBOL_GPL() to the series adding '/dev/mshv'
then. Dangling exported symbols with no users tend to be removed. No
strong opinion, just a suggestion.

> hv_call_add_logical_proc is only needed by mshyperv.c and not exported
> in the first place.
>
> This code is fine.

Thanks for the confirmation!

-- 
Vitaly

