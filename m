Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A31A3E3382
	for <lists+linux-hyperv@lfdr.de>; Sat,  7 Aug 2021 07:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbhHGFAe (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 7 Aug 2021 01:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbhHGFAe (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 7 Aug 2021 01:00:34 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE3BC0613CF;
        Fri,  6 Aug 2021 22:00:16 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l34-20020a05600c1d22b02902573c214807so10331774wms.2;
        Fri, 06 Aug 2021 22:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=htA3zt2NsRRlUm+6rWMpnnpWo4ZJ3N2+Fkg/dmCWhXw=;
        b=iyvrOyZ7J4zGPgrMT3r3/qCCTVzC2MwHAMV93qqWD/oIzyDBBiFXJDaIrAZEDamvlx
         eQ3eCuh1VGG746+KmjwQ6DEtUJVgTallHhul4jAxrHc/jZOh85Z8Hoh05hUPsMRXPki2
         7ZlilskMmqDAhrrsremrGJ5bhkqQ7DWG8VlMEtB3a+EO/LgOGKAgGMvt+n2GPX7QfjD6
         cl79Ac6AXmG6J1ZE/ilG8HaoUg9iPwlTvewfhiqPEyb7ys888JM9zLCPSXGkILwpkxVO
         VxSTisl3t5Gp4+JjFwFV2/mLkfXyDwTw8cpQgZyAfqoUiaKe3l4fX/ccDJRrCnpXbL4C
         04Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=htA3zt2NsRRlUm+6rWMpnnpWo4ZJ3N2+Fkg/dmCWhXw=;
        b=QQgMvWXuUnirxshyifotMZwQ/DlI0bJ8CtVY28F0buoVRRDxz9BbNSnxeDNFxsKbVP
         u6sqhl4nalZYNfD3K3LY9ghZL+QLVd+aUWptjrfaHyETvppD1Kn5pGSAhobxJuo6lWZN
         nVzP7DeOMyuWnAI0l/aPcEnffQzQHwZIKuDWYvsyjZGE6kw0EyOn3fHJSNg5cpgHvmxz
         jEhg41buV/rTxQAZ/d0HF1iegaAnoN1kQ0ZMLk4jwBhLJixFkc+mOOa8Gm3r+j4k6gUU
         vojOeKAH36hJ7+W2RaIpCJGe6vd7Ea6awvTyxAxL9eDOThf3wOKiZFWGOGujvFd0d8lh
         2TCg==
X-Gm-Message-State: AOAM533I+BtXwgZQQvFfUF7x95PXyJm92Qi+ohK8K7NikyBVaaNw4OhU
        wyPacj1JHo4AmQpFguP4dqw=
X-Google-Smtp-Source: ABdhPJyIIwCVrQxA00bK2L2LzXkToN0nFgdT7CiNvb5NR/8DNkrEkw0KnliB+LRWmNIP5OldHgnBCg==
X-Received: by 2002:a1c:6a15:: with SMTP id f21mr23355619wmc.80.1628312414911;
        Fri, 06 Aug 2021 22:00:14 -0700 (PDT)
Received: from smtpclient.apple ([5.29.52.112])
        by smtp.gmail.com with ESMTPSA id h12sm11621385wrm.62.2021.08.06.22.00.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Aug 2021 22:00:14 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Moses <mosesster@gmail.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] x86/hyper-v: guard against cpu mask changes in hyperv_flush_tlb_others()
Date:   Sat, 7 Aug 2021 08:00:13 +0300
Message-Id: <FD8265E6-895E-45CF-9AE3-787FAD669FC8@gmail.com>
References: <MWHPR21MB15935468547C25294A253E0AD7F39@MWHPR21MB1593.namprd21.prod.outlook.com>
Cc:     =?utf-8?B?16rXldee16gg15DXkdeV15jXkdeV15w=?= 
        <tomer432100@gmail.com>, David Mozes <david.mozes@silk.us>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <MWHPR21MB15935468547C25294A253E0AD7F39@MWHPR21MB1593.namprd21.prod.outlook.com>
To:     Michael Kelley <mikelley@microsoft.com>
X-Mailer: iPhone Mail (18F72)
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



Sent from my iPhone

> On Aug 7, 2021, at 12:51 AM, Michael Kelley <mikelley@microsoft.com> wrote=
:
>=20
> =EF=BB=BFFrom: =D7=AA=D7=95=D7=9E=D7=A8 =D7=90=D7=91=D7=95=D7=98=D7=91=D7=95=
=D7=9C <tomer432100@gmail.com>  Sent: Friday, August 6, 2021 11:03 AM
>=20
>> Attaching the patches Michael asked for debugging=20
>> 1) Print the cpumask when < num_possible_cpus():
>> diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
>> index e666f7eaf32d..620f656d6195 100644
>> --- a/arch/x86/hyperv/mmu.c
>> +++ b/arch/x86/hyperv/mmu.c
>> @@ -60,6 +60,7 @@ static void hyperv_flush_tlb_others(const struct cpumas=
k *cpus,
>>         struct hv_tlb_flush *flush;
>>         u64 status =3D U64_MAX;
>>         unsigned long flags;
>> +       unsigned int cpu_last;
>>=20
>>         trace_hyperv_mmu_flush_tlb_others(cpus, info);
>>=20
>> @@ -68,6 +69,11 @@ static void hyperv_flush_tlb_others(const struct cpuma=
sk *cpus,
>>=20
>>         local_irq_save(flags);
>>=20
>> +       cpu_last =3D cpumask_last(cpus);
>> +       if (cpu_last > num_possible_cpus()) {
>=20
> I think this should be ">=3D" since cpus are numbered starting at zero.
> In your VM with 64 CPUs, having CPU #64 in the list would be error.
>=20
>> +               pr_emerg("ERROR_HYPERV: cpu_last=3D%*pbl", cpumask_pr_arg=
s(cpus));
>> +       }
>> +
>>         /*
>>          * Only check the mask _after_ interrupt has been disabled to avo=
id the
>>          * mask changing under our feet.
>>=20
>> 2) disable the Hyper-V specific flush routines:
>> diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
>> index e666f7eaf32d..8e77cc84775a 100644
>> --- a/arch/x86/hyperv/mmu.c
>> +++ b/arch/x86/hyperv/mmu.c
>> @@ -235,6 +235,7 @@ static u64 hyperv_flush_tlb_others_ex(const struct cp=
umask *cpus,
>>=20
>> void hyperv_setup_mmu_ops(void)
>>  {
>> +  return;
>>         if (!(ms_hyperv.hints & HV_X64_REMOTE_TLB_FLUSH_RECOMMENDED))
>>                 return;
>=20
> Otherwise, this code looks good to me and matches what I had in mind.
>=20
> Note that the function native_flush_tlb_others() is used when the Hyper-V s=
pecific
> flush function is disabled per patch #2 above, or when hv_cpu_to_vp_index(=
) returns
> VP_INVALID.  In a quick glance through the code, it appears that native_fl=
ush_tlb_others()
> will work even if there's a non-existent CPU in the cpumask that is passed=
 as an argument.
> So perhaps an immediate workaround is Patch #2 above.

The current code of hv_cpu_to_vp_index (where I generated the warning ) is r=
eturning VP_INVALID in this case (see previous mail) and look like it is not=
 completely workaround the issue.
the cpu is hanging even not panic Will continue watching .
>  =20
>=20
> Perhaps hyperv_flush_tlb_others() should be made equally tolerant of a non=
-existent
> CPU being in the list. But if you are willing, I'm still interested in the=
 results of an
> experiment with just Patch #1.  I'm curious about what the CPU list looks l=
ike when
> it has a non-existent CPU.  Is it complete garbage, or is there just one n=
on-existent
> CPU?
>=20
 We will do my be not next week since vacation but the week after

> The other curiosity is that I haven't seen this Linux panic reported by ot=
her users,
> and I think it would have come to our attention if it were happening with a=
ny frequency.
> You see the problem fairly regularly.  So I'm wondering what the differenc=
e is.
>=20
> Michael
