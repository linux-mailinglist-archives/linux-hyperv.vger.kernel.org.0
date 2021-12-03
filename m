Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D6946791F
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Dec 2021 15:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbhLCOM6 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 3 Dec 2021 09:12:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22622 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352549AbhLCOM5 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 3 Dec 2021 09:12:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638540572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Th3/AwwdNWFRMVyXQbUB5Zn699vPcry9PjQt24tDZNs=;
        b=BnvbZmSxAKuvvWFBMi779uHrkQGll0hXImSlHmkSWpO7ywlwSlsIBz6Kj5TGGYEcqZt+Ws
        1EKfjkacukyWiUhKPTrWxTecZc1X4Dgjgm5kwpcHdAXK9vAbKkpY+WyWSaAvdKDHI3nlDq
        ESj7hRUa5t32cu+XiS1ieiPE9Q5u/nA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-102-ips9VtC-NRm1VmuM0Xs6_Q-1; Fri, 03 Dec 2021 09:09:31 -0500
X-MC-Unique: ips9VtC-NRm1VmuM0Xs6_Q-1
Received: by mail-wm1-f72.google.com with SMTP id l4-20020a05600c1d0400b00332f47a0fa3so1414570wms.8
        for <linux-hyperv@vger.kernel.org>; Fri, 03 Dec 2021 06:09:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Th3/AwwdNWFRMVyXQbUB5Zn699vPcry9PjQt24tDZNs=;
        b=RMTrPbSHZfEGYcdTgRTejbXVpMURWbDSF9dy8PizGSqlUcziN9pF8C4uXJfHG+aaz1
         qXkOtWTUwVcjnegNZYOmo9UnH/vNxLrDYQnAlMG0BJjWHtwUuBvlbrByQZAXx9FwjdC7
         DeC93eTWXKQCo5+OTrGnbVfyuaA5uHfr1oNuc6qpI6BuifH316/SzBks3K7WGK6z2Ung
         /4V5WeWvOoVbrmKsrT+8lRYSNe21dQMjVhAphKiW20NqNY9Z6AKu3xQL5r1carnSR0is
         kBXIuVdOUlV83MFuOZEgwq6m9lyzOYCN7w+LyHngLurEJRvKktUcozJXhDyd/g/culqR
         L5gw==
X-Gm-Message-State: AOAM530Zy0cOcRVZtv5ezQZXmTfBZrIbbxNPYO3Zu2yjzbIrMl7mZ7j4
        VVyz2LXxrOeP2Scw7s6h7yoX3BD4N50O9TuMdRyDZXAnJH3kIXqbOKsijSMUt7dMOAFIzqvwmDj
        1TeNdorACpAcI3IMqE2pNeAj1
X-Received: by 2002:adf:e2c5:: with SMTP id d5mr21726922wrj.338.1638540569912;
        Fri, 03 Dec 2021 06:09:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwn8SCemCKl3G0iSjXXF2Z8BcbWnjoIe4SW0+H1SuKLyllcsxQUH/Bt1H7vpADvQabw8WfPDw==
X-Received: by 2002:adf:e2c5:: with SMTP id d5mr21726875wrj.338.1638540569626;
        Fri, 03 Dec 2021 06:09:29 -0800 (PST)
Received: from fedora (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id f15sm3497480wmg.30.2021.12.03.06.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 06:09:29 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ajay Garg <ajaygargnsit@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: ** POTENTIAL FRAUD ALERT - RED HAT ** RE: [PATCH v2 8/8] KVM:
 x86: Add checks for reserved-to-zero Hyper-V hypercall fields
In-Reply-To: <MWHPR21MB1593E284E412873C64B54A32D7699@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20211030000800.3065132-1-seanjc@google.com>
 <20211030000800.3065132-9-seanjc@google.com>
 <87v91cjhch.fsf@vitty.brq.redhat.com> <YagrxIknF9DX8l8L@google.com>
 <MWHPR21MB1593E284E412873C64B54A32D7699@MWHPR21MB1593.namprd21.prod.outlook.com>
Date:   Fri, 03 Dec 2021 15:09:27 +0100
Message-ID: <87o85x7pbc.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

"Michael Kelley (LINUX)" <mikelley@microsoft.com> writes:

> From: Sean Christopherson <seanjc@google.com> Sent: Wednesday, December 1, 2021 6:13 PM
>> 
>> On Mon, Nov 01, 2021, Vitaly Kuznetsov wrote:
>> > Sean Christopherson <seanjc@google.com> writes:
>> >
>> > > Add checks for the three fields in Hyper-V's hypercall params that must
>> > > be zero.  Per the TLFS, HV_STATUS_INVALID_HYPERCALL_INPUT is returned if
>> > > "A reserved bit in the specified hypercall input value is non-zero."
>> > >
>> > > Note, the TLFS has an off-by-one bug for the last reserved field, which
>> > > it defines as being bits 64:60.  The same section states "The input field
>> > > 64-bit value called a hypercall input value.", i.e. bit 64 doesn't
>> > > exist.
>> >
>> > This version are you looking at? I can't see this issue in 6.0b
>> 
>> It's the web-based documentation, the 6.0b PDF indeed does not have the same bug.
>> 
>> https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/hypercall-interface#hypercall-inputs
>
> Did you (or Vitaly) file a bug report on this doc issue?  If not, I can do so.
>

Done, https://github.com/MicrosoftDocs/Virtualization-Documentation/pull/1682

-- 
Vitaly

