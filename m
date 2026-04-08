Return-Path: <linux-hyperv+bounces-10072-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id jnNCGhDW1WkD+gcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10072-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Apr 2026 06:14:08 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D223B6B73
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Apr 2026 06:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CAC63007E08
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Apr 2026 04:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA95834DCD7;
	Wed,  8 Apr 2026 04:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rlOPUBf8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB6B34D39B
	for <linux-hyperv@vger.kernel.org>; Wed,  8 Apr 2026 04:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775621610; cv=pass; b=h4TdCnqT5QByW7Rcq6Oo1/Ch3vjWH3n3UXedOXeNHGRgXWadkJbsHvhKjb5/QOhkwmpV8GZ81mzhc00Ca+7jnVE4cQ4fCMOxYR//gVoidtqhKxypZqDdoY3qxCw0dA+Ti1iwVaDFj/Eilt6VJGW2JAa8rhiTonJfbPG9tF86WnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775621610; c=relaxed/simple;
	bh=mSu21n7FtXaiXm7xUkvFg5Z4GAfXF9LADkpKmy8CBU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OwLWbFYfJs0fLChJmaOQt1jefyQA9dL1BAUzniydymKi/kEKmNlsfM96v1WZ3zz9KPsZwok7sTi+CzdgaBlR95gvIe38NM3p+y+68GpdrQ1RljyBlGPILDQzdQkV/fRZuVdGPnChkWtZ4LVffNIbYj6BtXLMZLEcjEFZEgaNwXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rlOPUBf8; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35d9923eec5so3409222a91.2
        for <linux-hyperv@vger.kernel.org>; Tue, 07 Apr 2026 21:13:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775621609; cv=none;
        d=google.com; s=arc-20240605;
        b=jLx11G2yvR9Cpb/lh9yxDAYXSW8/ihQxelwu3xCiiZk6FN1xrZxvP/DYXE2e+h/I4m
         HgnN5c+Y/Y8QVMKK58l0rImszMWhxNGVaRPv172XPpFfUc/ze5kN+YWvtLsMO4Nd8pTK
         m7exUtV+u8gygJ5jYdDMIMlgDBuS+O2ry3bCrksCFXiQoqGx06GS8Nn9GxpJeAOUNud7
         dz6MpWante2xcBq9pUoiJ187h2zu88Rsh0iMXAux3JU2qQRskAq76a2xpWuwjxTIMRZc
         zhH+k78Lf+8+sxtDOapVIJdH3dtoqQIOZ0kFd7Y+LCq8grv6DMr3bmM3ujteSIzYHT1l
         F4jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mSu21n7FtXaiXm7xUkvFg5Z4GAfXF9LADkpKmy8CBU4=;
        fh=/9Odbb4id7M0CnjzpBWtbI5Tn39LV5tqpMNG+aiyx/0=;
        b=jOunNfLnNgKkZlFL4yH6zQku374A+eSLyeOIPbh0v1L1f8tJgpG8a4UaDTvd1JWsnC
         HSTkjCvaMZbt/kgUe8AY70+dAu2iN+x9Tibp3yEHBykHuok2QXecsezBqptK9Z2QoD9W
         x1BmdoFmbMvml3U/Foqst617UchWvNSbqe/GoH/Br+75RV/24PR2W6JnjtGLjpZlsqwW
         CIllxhRWP7G1doIg0h5FnAFbFg+9ERRKWEY2Uayn3V5ajybxGfu7UHKw747Sbs6MIQu3
         hiDPn7HWQEGLVfG+g73HVxqdtX3vHKsNR0ywVqIAoaovaFOmUCMjNFY57cpK40L/CScc
         PHgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775621609; x=1776226409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSu21n7FtXaiXm7xUkvFg5Z4GAfXF9LADkpKmy8CBU4=;
        b=rlOPUBf85DMmPWFiVD05kriRJmZiH71jVCY1+hYVkqkQopganQI6uoiEQirJDaD6Gn
         OfptHV78/3ABCAGrWTTv2usfwW2JRfqku+iqhDEbhPdFixgfKATHmg1wVOu3Dn/EQUZp
         jR4zPkqQoeWvk8QDfy31mWxPvtaaE1iZ5Lr4l5EuHuTRleJ6Aa/MekLO9tdkPLin3eny
         Kdof7R0oUc3xXLwqlfJXjBQqgLmLTH6y7Df1o3YfKteGV/b5jTHrbzkwqsrYgLmHdAhD
         R59jrXgiDyroTVnjNQzg1vGaMHBsaNTTW/QrpZzM9GFi0B1XEhv82Pw2ftuoJ4ZPJP0b
         AYxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775621609; x=1776226409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mSu21n7FtXaiXm7xUkvFg5Z4GAfXF9LADkpKmy8CBU4=;
        b=WBAhwmDHjZDyVPpfBEU94JPQojLcYY2gVN/a0bo04B4ytjus98hdbDakCyZ4ItacZO
         BRyos3ZDeN5Vr00nmk6lVwe4b8rAxl5fmge+Q8sa4d448Q843xm4uCGoTdPtQnUTLtqz
         rzrZYmdhjqqOfC/sCIrC4PDHqmBkogpHsWtnGnSsCSFNCwqZzcuziNOkqwoWxjEMWUEn
         +BmBg7U2NhoHwoX9vJc3MnMxUYYB3gG0XF+wJzMrel7w0lTnj68tDCdMYeR+/gjdoej7
         umAlUB47KN0PxLP/1GJIn5XjXFpeHhhSi/+V6/ya2xxKy1UcEKjeetdDbWzbiSrlLrRn
         e97w==
X-Forwarded-Encrypted: i=1; AJvYcCWXBxaHCGL8Ei+XVf1eLMrJ17DjseQgVDrshS5p68PvMHBggzug2fwahAnAtiJaHwnYQUII7HJx+4bDOb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnpEHpzFbgeWi1X/IlgVw/B1IeboR3thHoUfqWtW7vjHp7WNgD
	Cqab2Bowwz0tDZij6an/rJqg4PgwWjq3rFwthqe/ep2f69jnRfGkCJT4oEbBL3EI1UuH36fQyDT
	Nt3cG6OozMkEoYwZKXBwkoh1Z9BeFpT8=
X-Gm-Gg: AeBDievcSvl3y+F5rCsbzfD6L/hIeAanDMHY7SrRCe5wd3seoQHHJI5HNbpw37UylC/
	0/h6GETeMsMg5BezlaISfa4Af768YuHeq6fbg8Ejn2cQI2KROyutvpqHe8yECbZ8BrNXyHrcuGH
	gWj4e0kr1nA6fJlH5xWVD1PULyWFvW8ninP0nd1jJ0EuDNTPJfqe0DjvSGRWY/uGCiQcUVtuN5Q
	OiErBmSzyFu/WivztCyOfAsg2C98NtTSMB/zvj0B7NUCx05WGWbLyCP4tzJHMcPL5yI8UkIdcFG
	U957rdqBDVggq4gVoEM9glDF4l6OxNitolV+3VQk
X-Received: by 2002:a17:90a:dfc3:b0:35b:e529:2d60 with SMTP id
 98e67ed59e1d1-35de68712b0mr18352058a91.8.1775621608929; Tue, 07 Apr 2026
 21:13:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKdXbaV1PTwetd4zs6+6Rp7h0dwHU1ygMoof5eAcfL6XYZF1xA@mail.gmail.com>
 <87v7e3mbgj.fsf@redhat.com> <adU0LAW1h8q9HsGu@google.com> <SN6PR02MB4157F82E4907C1B3305E86D5D45AA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <CAKdXbaXdSWq-NYk8z6_OtSgb6xsp+GJxrnF2iBMRdk0nfYne=A@mail.gmail.com> <SN6PR02MB4157A58DA24233B77829B59FD45AA@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB4157A58DA24233B77829B59FD45AA@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Thomas Lefebvre <thomas.lefebvre3@gmail.com>
Date: Tue, 7 Apr 2026 21:13:18 -0700
X-Gm-Features: AQROBzD8Y_tEgQIjbAiFXo2wngetYtmxuzapG1FgBs4QKYX1TeAbwm6u_umXi_c
Message-ID: <CAKdXbaUwVuvnC3L38bOp-EZqf+=PjAi7tCeJJRTTnUFTja6a8A@mail.gmail.com>
Subject: Re: [BUG] KVM: x86: kvmclock jumps ~253 years on Hyper-V nested virt
 due to cross-CPU raw TSC inconsistency
To: Michael Kelley <mhklinux@outlook.com>
Cc: Sean Christopherson <seanjc@google.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-10072-lists,linux-hyperv=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[outlook.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomaslefebvre3@gmail.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[7];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B8D223B6B73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thanks, that's very useful information.

Unfortunately, I can't easily reproduce the issue; I can't seem to get
pvclock_update_vm_gtod_copy() and __get_kvmclock() to run on different vCPU=
s
which was one of the two required conditions that triggered the
unsigned subtraction wraparound
(the second condition being inconsistent values between L1 vCPUs).

I just upgraded to Windows 11 25H2 and my Hyper-V VM config from v9 to v12,
I now see tsc_reliable and constant_tsc in the L1 Linux VM lscpu and
/sys/devices/system/clocksource/clocksource0/current_clocksource is
tsc.
I'll report back if I still encounter the problem when spinning up L2
Linux VMs with KVM.

On Tue, Apr 7, 2026 at 1:40=E2=80=AFPM Michael Kelley <mhklinux@outlook.com=
> wrote:
>
> From: Thomas Lefebvre <thomas.lefebvre3@gmail.com> Sent: Tuesday, April 7=
, 2026 12:13 PM
> >
> > Hi everyone, thank you for your attention to this bug report.
> >
> > Michael,
> >
> > 1. No, lscpu in the L1 guest does not show the flags "tsc_reliable"
> > and "constant_tsc".
> > $ lscpu | grep tsc_reliable
> > $ lscpu | grep constant_tsc
> > $ cat /sys/devices/system/clocksource/clocksource0/current_clocksource
> > hyperv_clocksource_tsc_page
> >
> > 2. Windows 10
> > Version 22H2 (OS Build 19045.6466)
> >
> > 3. Hyper-V: privilege flags low 0x2e7f, high 0x3b8030, ext 0x2, hints
> > 0x24e24, misc 0xbed7b2
> >
> > 4. Yes, the laptop hibernates and then resumes.
> > When the problem occurred, the laptop had gone through multiple
> > hibernate and resume cycles.
> > I haven't seen it happen after a full reboot before a hibernate/resume =
cycle.
> >
> > Thomas
> >
>
> How easy is it for you to reproduce the problem? Would it be feasible
> to get a definitive answer on whether the problem repros after a
> full reboot, but before a hibernate/resume cycle?
>
> There's a known bug Windows 10 Hyper-V where the hardware TSC
> scaling gets messed up after a hibernate/resume cycle, causing the TSC
> values read in the guest to drift from what the Hyper-V host thinks
> the guest's TSC value is. A summary of the problem is here:
> https://github.com/microsoft/WSL/issues/6982#issuecomment-2294892954
>
> Of course, this doesn't sound like your symptom. And Hyper-V is not
> telling your guest that it supports hardware TSC scaling, because the
> HV_ACCESS_TSC_INVARIANT flag is *not* set and the clocksource
> is hyperv_clocksource_tsc_page. But my understanding is that the code
> changes to fix the Hyper-V problem weren't trivial, and I'm speculating
> that maybe you are seeing some other symptom of whatever the
> underlying Hyper-V issue was.
>
> Of course, this is just speculation. If the problem can occur before
> any hibernate/resume cycles are done, then my speculation is
> wrong. But if the problem only happens after a hibernate/resume
> cycle, then this known problem, or something related to it, becomes
> a pretty good candidate. Unfortunately, I'm pretty sure there's no
> fix for Windows 10 Hyper-V. You would need to upgrade to
> Windows 11 22H2 or later.
>
> Michael

