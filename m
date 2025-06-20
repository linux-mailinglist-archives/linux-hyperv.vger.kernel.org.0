Return-Path: <linux-hyperv+bounces-5981-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F15AE1E0E
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Jun 2025 17:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FFB41675CB
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Jun 2025 15:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1858A2951CD;
	Fri, 20 Jun 2025 15:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpbWGLV6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E23030E85E;
	Fri, 20 Jun 2025 15:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750431968; cv=none; b=nlSBwIPeGuLsnTBsac/ICQwNS7P6zQpH6jJh50lB6Zq72YWGTcMnoDZsptDO+1yfrpc/beqKPNiT/TXC2mOzKTavIdiEa6GBkXtuwgFXg2jnIT6Ryx+qqKgE52W6mET2RTs9Fi8oZHC2bE+FtZxUaTWnX78yX/MhNrngc79HyEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750431968; c=relaxed/simple;
	bh=ksFoRy/K+QsZuP+UMssBVlk6SssmE35N4Xgff7AljiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mb+Ca80S1Ypon649xPRHoJGenJDHSFvhFLgYWyCX0PjVKXJZC75zE5myEDGb595oila+YVysjv1OqJTfFVt9gORFHeyFhkPZi/VHcgcSNPzeiHpKS9F7PoEfXkAion7zZ2jq42I3prADToo15YJcx2bWwa8FaUNRVKCXGEX5j5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KpbWGLV6; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b31f22d706aso729127a12.0;
        Fri, 20 Jun 2025 08:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750431965; x=1751036765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FpAdBIqUH78Z3by75NaLpSLv18gjCC1aaRhrF+ZhAN8=;
        b=KpbWGLV6wxjXuKgGo83HpxXZsFIZddJtObNUKj2aGxsqGYjqpp0bxQbDm9MTn0/vYN
         1EEYI8zvJMD2/WCO8qS0mKW39VMcJyYeXf0s1rrs7l8sS4aekAfYpk9mtW+WBy3ZiCWP
         VajyY4HHotEacJsu8wi0ajL4SaijaySgIKRT3bEzX7LBhZA1Is6r3ySABIhxVUXppatj
         0gOouHp7YFq7a9JAbeNedTX+FumAG66vSkf9kq8+A9pg0rOMqfHKcfQpbI0uZI1RPjmu
         3h6raVSsF28gP+tpoHkaurce9xfO/16cSkYuLpKa/CdQjkgnCvk1Bqs3lxBaNIRocI7+
         kGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750431965; x=1751036765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FpAdBIqUH78Z3by75NaLpSLv18gjCC1aaRhrF+ZhAN8=;
        b=nfjM9xx8W+/K1bAWWiklwyhtz7DZCMLdosYWgC03b4hj8Wn66zoELiVOZenHxzCk0R
         mOQwqjTUn6ulOqm2nj/gAHAclcmPvWwgfZyKW4JE7b28iURTnND4Pfe1ZCu7vyc3tCYq
         ayYQL1jFC3ZMwb8cPQIbt4gZxdyojMDdhp/iG0wJh/SV895AQXqJFZ0H1Gz+VoZQW0M+
         Wxqsz6BrvoycJBUIEUssjR5zlrppqOr48/YWu2ErvYV7HXBc1nIO5d1vkb0mvOJAuzF8
         I18IsZLTFXtSd1qQVV4jYuud1Cba2Z4K65Pa6y3JXXIDIjkMXLxFLvuH7n1thyxIUeh6
         AagA==
X-Forwarded-Encrypted: i=1; AJvYcCUsu0wqrbEAg5MFabqDRy1shDDEmpymJEN2cL+MtWmHpi8UAimoeY0LDaQ5oimVJVhtFjXjF8MsXrdXST0h@vger.kernel.org, AJvYcCVKdDZwKKVOxz29BqzZtI3BuUgVw5y1E4HHmrtXQ1dFjK/3cxc3OgD4BAqloBgHv5oD/ZoKboqEBgy30Q0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeNEjJKyAndgiXxd+/rZ1EO8QxTCzK45BYqBaSR68rQrQ1uif2
	4qieE0jLTaFH1EjgwPvPnakhVGQTGpYQoHe6Rj9/1DWvbjh29BD3u93oTsSnm2oFb+4qk07cBzP
	/BEzGp/HNjQKxK9PqurzGzg6yZsJtsSg=
X-Gm-Gg: ASbGncsJbVjWmMrNAIydF2DjLUsBoIdXQqwTm7x7169Fp/jnAAlrIi692sG0x6DzjZ5
	60kshfg7oLnZxFP6q/DiOk1nOYyE/IV5+tcG8iU5eIcoaOMltCVNWWCp22dLt/rth9dk+cBbT0+
	qlvpv7pkprAsDwsVNDpZochAdHWt5wu3YRlU0pvu285gYMcMJTkqM=
X-Google-Smtp-Source: AGHT+IFs1wDL+Fq34XOMDcxJYXK2p83tODMKFqB5EPpzMmEwzoywgbh28enfu/rjuNlD9SkE6FZWERHQsPwWGgXgmr4=
X-Received: by 2002:a17:90b:538d:b0:313:283e:e87c with SMTP id
 98e67ed59e1d1-3159d6347famr5079508a91.3.1750431964650; Fri, 20 Jun 2025
 08:06:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613110829.122371-1-ltykernel@gmail.com> <SN6PR02MB41579BCC56F6C966E3E2499CD47CA@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB41579BCC56F6C966E3E2499CD47CA@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Fri, 20 Jun 2025 23:05:28 +0800
X-Gm-Features: Ac12FXzP9tlv4Hr8yWE5eMb2orG3vvSitxGnMHugM7FMpfdlgMpzp9R-ZhuwjoA
Message-ID: <CAMvTesAscN2MyqJXpcbwcXWC-6-en6U_c03M+2=zcMF0bLv4iw@mail.gmail.com>
Subject: Re: [RFC Patch v2 0/4] x86/Hyper-V: Add AMD Secure AVIC for Hyper-V platform
To: Michael Kelley <mhklinux@outlook.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>, 
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"hpa@zytor.com" <hpa@zytor.com>, "kvijayab@amd.com" <kvijayab@amd.com>, 
	"Neeraj.Upadhyay@amd.com" <Neeraj.Upadhyay@amd.com>, Tianyu Lan <tiala@microsoft.com>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2025 at 10:17=E2=80=AFAM Michael Kelley <mhklinux@outlook.c=
om> wrote:
>
> From: Tianyu Lan <ltykernel@gmail.com> Sent: Friday, June 13, 2025 4:08 A=
M
> >
> > Secure AVIC is a new hardware feature in the AMD64
> > architecture to allow SEV-SNP guests to prevent the
> > hypervisor from generating unexpected interrupts to
> > a vCPU or otherwise violate architectural assumptions
> > around APIC behavior.
> >
> > Each vCPU has a guest-allocated APIC backing page of
> > size 4K, which maintains APIC state for that vCPU.
> > APIC backing page's ALLOWED_IRR field indicates the
> > interrupt vectors which the guest allows the hypervisor
> > to send.
> >
> > This patchset is to enable the feature for Hyper-V
> > platform. Patch "Expose x2apic_savic_update_vector()"
> > is to expose new fucntion and device driver and arch
> > code may update AVIC backing page ALLOWED_IRR field to
> > allow Hyper-V inject associated vector.
>
> The last sentence above seems to be leftover from v1 of the
> patch set and is no longer accurate. Please update.

Thank you very much, Michael!  Will update.
>
> Additional observation:  These patches depend on
> CC_ATTR_SNP_SECURE_AVIC, which is not set when operating
> in VTOM mode (i.e., a paravisor is present). So evidently Linux
> on Hyper-V must handle the Secure AVIC only when Linux is
> running as the paravisor in VTL2 (CONFIG_HYPERV_VTL_MODE=3Dy),
> or when running as an SEV-SNP guest with no paravisor. Is
> that correct?

This patchset enables Secure AVIC function for enlightened SEV-SNP guest
which uses c-bit to encrypt/decrypt guest memory.

--=20
Thanks
Tianyu Lan

