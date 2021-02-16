Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F23DA31CC82
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Feb 2021 15:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbhBPO5a (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 16 Feb 2021 09:57:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22147 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229913AbhBPO5a (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 16 Feb 2021 09:57:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613487362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c9i3Hr8uth70LALw4hTIVfqBZpUvvD/U0p+pBCzkPuo=;
        b=OFm6453BdfZTMH/h6lWpfZudCaA1QmIW1R5c4M+AVKoB6wgKmwZC68hf8LGKxQKQAofXen
        DpQlb4Ppm77ukBlPA1cADp4kDS9b8WUaj0Yx784fPL8KPrl4Zr1iL5cwo9ifv3IBJI4c9F
        DYeMFYEkEsMtiFrBq/JlfLp6N9Go1Ps=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-OeEzBJDgMOKawlGQHN-z4g-1; Tue, 16 Feb 2021 09:55:29 -0500
X-MC-Unique: OeEzBJDgMOKawlGQHN-z4g-1
Received: by mail-ej1-f69.google.com with SMTP id jg11so6372558ejc.23
        for <linux-hyperv@vger.kernel.org>; Tue, 16 Feb 2021 06:55:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=c9i3Hr8uth70LALw4hTIVfqBZpUvvD/U0p+pBCzkPuo=;
        b=Jcy6G5noyJIeR/1+YmVy1XFyTMSfwuBL37CZURXBmWeXlJ9Ra5KMKpXf2BC/alFLCx
         6g6T6BoFVXk/sOdv0vfXZNLylgA+uwY0hucmZGLJIE7HmxocozaYdd6H4N/b1fJiKw7F
         9j2puXsimrdKNSBz/zMES628h1wU18MTETfTT4QbYkIxG6/snYfBDxE5QDqk18SLIM3q
         DVW3ZNewbCJnfqz/ysueRBoa5ZPNz+KpdzDXIDEp3GSqjhm5je/t25onAlOACRFAq/2X
         aYWzJDKXNdpT/8qi556X+UMuyb1BDbm3KS78gtb7Ie6z/KfOi5YATvGDv0zI1wFDDzSK
         Yong==
X-Gm-Message-State: AOAM533pxzYGLMrNrZc/JbgD9A0Ouc++8xIM4AWN25pT7V8pXn3Dk3kY
        swXfcrf/PT+IydRJzcqZ2LuZLuZovV3H5uj5vubtFWKUw/uGoN855n4hVJD0hKTz9/mwgmaPQSD
        DAXyjW21bopFeDCkH5KAtvliUbDhmfIBso7Mf2s7GzGB0E5mQZ0KNYrM8VDNAOKwVfaFrx1YSzb
        fI
X-Received: by 2002:aa7:c58b:: with SMTP id g11mr15663925edq.354.1613487327516;
        Tue, 16 Feb 2021 06:55:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyLeBpUgSCIOdzdc+kzUL9A4wj31wbAJEClQEH2/Hy2C04SXzV0wOIlfsk6w1k8Grt/QMa7Ww==
X-Received: by 2002:aa7:c58b:: with SMTP id g11mr15663908edq.354.1613487327227;
        Tue, 16 Feb 2021 06:55:27 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id x25sm14192346ejc.33.2021.02.16.06.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 06:55:26 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: ** POTENTIAL FRAUD ALERT - RED HAT ** RE: Checking Hyper-V
 hypercall status
In-Reply-To: <MWHPR21MB15932A447B6A9AAE21AE4119D7879@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <MWHPR21MB15934013452AE9F2DF80C02DD78D9@MWHPR21MB1593.namprd21.prod.outlook.com>
 <MWHPR21MB15932A447B6A9AAE21AE4119D7879@MWHPR21MB1593.namprd21.prod.outlook.com>
Date:   Tue, 16 Feb 2021 15:55:25 +0100
Message-ID: <87mtw4jc4i.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Michael Kelley <mikelley@microsoft.com> writes:

> From: Michael Kelley  Sent: Wednesday, February 10, 2021 9:09 AM
>> 
>> From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Tuesday, February 9, 2021 8:51 AM
>> >
>> > Michael Kelley <mikelley@microsoft.com> writes:
>> >
>> > > As noted in a previous email, we don't have a consistent
>> > > pattern for checking Hyper-V hypercall status.  Existing code and
>> > > recent new code uses a number of variants.  The variants work, but
>> > > a consistent pattern would improve the readability of the code, and
>> > > be more conformant to what the Hyper-V TLFS says about hypercall
>> > > status.  In particular, the 64 bit hypercall status contains fields that
>> > > the TLFS says should be ignored -- evidently they are not guaranteed
>> > > to be zero (though I've never seen otherwise).
>> > >
>> > > I'd propose the following helper functions to go in
>> > > asm-generic/mshyperv.h.  The function names are relatively short
>> > > for readability:
>> > >
>> > > static inline u64 hv_result(u64 status)
>> > > {
>> > > 	return status & HV_HYPERCALL_RESULT_MASK;
>> > > }
>> > >
>> > > static inline bool hv_result_success(u64 status)
>> > > {
>> > > 	return hv_result(status) == HV_STATUS_SUCCESS;
>> > > }
>> > >
>> > > static inline unsigned int hv_repcomp(u64 status)
>> > > {
>> > > 	return (status & HV_HYPERCALL_REP_COMP_MASK) >>
>> > > 			HV_HYPERCALL_REP_COMP_OFFSET;
>> > > }
>> > >
>> > > The hv_do_hypercall() function (and its 'rep' and 'fast' variants) should
>> > > always assign the result to a u64 local variable, which is the return
>> > > type of the functions.  Then the above functions can act on that local
>> > > variable.  Here are some examples:
>> > >
>> > > 	u64		status;
>> > > 	unsigned int	completed;
>> > >
>> > > 	status = hv_do_hypercall(<some args>);
>> > > 	if (!hv_result_success(status)) {
>> > > 		<handle error case>
>> > > 	}
>> > >
>> > > 	status = hv_do_rep_hypercall(<some args>);
>> > > 	if (hv_result(status) == HV_STATUS_INSUFFICIENT_MEMORY) {
>> > > 		<deposit more memory pages>
>> > > 		goto retry;
>> > > 	} else if (!hv_result_success(status)) {
>> > > 		<handle error case>
>> > > 	}
>> > > 	completed = hv_repcomp(status);
>> > >
>> > >
>> > > Thoughts?
>> >
>> > Personally, I like it and think it's going to be sufficient.
>> >
>> > Alternatively, I can suggest we introduce something like
>> >
>> > struct hv_result {
>> > 	u64 status:16;
>> > 	u64 rsvd1:16;
>> > 	u64 reps_comp:12;
>> > 	u64 rsvd1:20;
>> > };
>> >
>> > and make hv_do_rep_hypercall() return it. So the code above will look
>> > like:
>> >
>> > 	struct hv_result result;
>> >
>> > 	result = hv_do_rep_hypercall(<some args>);
>> >         if (result.status) == HV_STATUS_INSUFFICIENT_MEMORY) {
>> >                 <deposit more memory pages>
>> >                 goto retry;
>> >         } else if (result.status != HV_STATUS_SUCCESS) {
>> >                 <handle error case>
>> >         }
>> >         completed = result.reps_comp;
>> >
>> > --
>> 
>> Your proposal is OK with me as well, though one downside is that it is
>> not compatible with current code.  The return type of hv_do_hypercall()
>> and friends would change, so we would have to change all occurrences
>> in a single patch.  With the helper functions, changing the code to use
>> them can be done incrementally.
>> 
>> Back when I was first working on the patches for Linux on ARM64 on
>> Hyper-V, I went down the path of defining a structure for the hypercall
>> result, but ended up abandoning it, probably because of the compatibility
>> issue.
>> 
>> But either works and is OK with me.
>> 
>
> In thinking about this a few more days, having the hv_do_hypercall()
> functions return a struct rather than a scalar value seems a bit off
> the beaten path, even if the struct is a 64 bit quantity.  I just wonder
> if currently unknown problems might arise later with other tooling
> (like sparse) in using that approach.  So I'm leaning toward the
> helper function approach instead of bit fields in a struct.
>

No problem with me, let's stay conservative and use helpers.

-- 
Vitaly

