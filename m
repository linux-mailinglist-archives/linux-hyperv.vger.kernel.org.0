Return-Path: <linux-hyperv+bounces-11685-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Rrq+ECpwPWql3AgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11685-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jun 2026 20:15:06 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2AC6C8203
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jun 2026 20:15:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=izTXGs74;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11685-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11685-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A83D4302A68C
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jun 2026 18:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5051630E0E4;
	Thu, 25 Jun 2026 18:15:02 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A81305693
	for <linux-hyperv@vger.kernel.org>; Thu, 25 Jun 2026 18:15:00 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782411302; cv=pass; b=A5PT4Ac6ibE95pkoyPnszHimGKNOx+g80sC7+HB6b0c6GwNh3DFiNkAuJvKFa/gVwOhLqkjTdzcoosTvxNur3Kw7eMrwSs77hXe5pSZahrFYtT/AIRF2D0UelpSWTTYT3R4dV3ENERVDXPOVnySoqmlI9NjWikSUdZV/2Eqd0qo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782411302; c=relaxed/simple;
	bh=BVes5aBRaWmGgMBb9dlxEVgUv2H6uHRoq1KJyX8EnbI=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=booijKlSJZj8BWdhIl7VkqSX5KihozXZCi73zstrebHU4CnhJ7TLnli51A4vDCbX/7VFo9yYc1W8E5TlNSV/YJakJDp4R45qZNEOnRIRvu+AvbnLrndETd+dFQCxeqBNB0Tkk02r4wFXo5cKIHq91S2p7zQuky5g7jAdZ8X/S94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izTXGs74; arc=pass smtp.client-ip=74.125.224.54
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-662dd616cdbso217256d50.1
        for <linux-hyperv@vger.kernel.org>; Thu, 25 Jun 2026 11:15:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782411300; cv=none;
        d=google.com; s=arc-20260327;
        b=XherK1vQ1+TV780hThv4i0uwILq58bEIfZ07syOH4rR4xkwxo5/aaFEVCc490bFZR1
         xAXMRbkpZy9Zky0l+1H6bnW3ABlL64kIIJtEp09yHdHRrfWTjFOIOE3j2+H9AjEiWfwi
         MqvEYe+JCVGGT1ZDIzhl1qIk9sZFZZNJiOiGM4/88vaKws7XiO+zPwq8ssgb5cVGJmzf
         Qsdm663SPZS8TkwdLScvPhh0IPvAwcbcUilXexs2pJzyeY4PY7A6FW/mSyrf11HGiTj1
         SKPjjsvORWadOsxvQcdUmu93YyFOkLXRu/RRd2wu/+sAq7z9g5SX5NIi+qN2qHtIUseM
         JUUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:dkim-signature;
        bh=BVes5aBRaWmGgMBb9dlxEVgUv2H6uHRoq1KJyX8EnbI=;
        fh=VSE9VIKtYorNkxQGVT+9U3JoYlHmcifMvZh1W9/4XSg=;
        b=LqF5ScWT/NLfRBXCNJHO5GR3eC9caKwNu8vANjeh8xOzX8dWVQg9VaIHbobr8GnjaW
         sPEoK1SfDk0oBogAtjxgqGroniZRrPFQFssXb+DT3yqMyq1cojzQS+kAvBAhoIFaT+LB
         +Wy0pz4waTxEYYmvwpO3x4hHCbJhhU1KfENCJQFtuPRlNu7bqbcMt447fOXP/fzcoUgK
         UQlbaCAcij3fBQDp18rmu10lcfGpmLp7BdrO3uhlN0Q7UTaOR53ozapjizBPYKWXiAuH
         AJY8q6uig5kpJHqLoWLzNQvTtuBydg+/x9GRh9ni8wlue6FxeGSFqVgWda6HNFsS5YIB
         Cggg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782411300; x=1783016100; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=BVes5aBRaWmGgMBb9dlxEVgUv2H6uHRoq1KJyX8EnbI=;
        b=izTXGs74+8qPXMq+9DB9zW5W6y17crs1PQAKN1+vzU6TcLo5dqxcIXdB7TT0BwJprJ
         OooD2qLW31PotEkdpHWehQ+Vw8Cht63mfiKW+T0x41hKJ5ULwuOLHg3WZAaRAtxOIJjy
         Yz+hDBm39gRj6HaP/xEchsNb4m3QMGaYytQrfakyZ6uEkxRputxNTWLXsDfDptL6TdQW
         qwXniIwevptkFi7g5woweyyCEF8PnjZhMiPdOWfUOa+xKSoMFT6pt4L/o4j692K9H3pZ
         zdXEbAXVD2NGa42oLdSfQMouGKIXF6eNsaiShnwINcfJ/KlM8wWvyFrYCllj8RN4hFVJ
         qEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782411300; x=1783016100;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVes5aBRaWmGgMBb9dlxEVgUv2H6uHRoq1KJyX8EnbI=;
        b=GdzqIJYdJe4BSEY3Dc8Uth0OQ7JiBxzoiXJHTgg/K0V7lRxH62DKxXKQW6A26OUuz1
         ix/7IRb4J3Tzd7AwD110CYgE0thcv47GH3Ji0R5YYqbtDUYGtm29P+2Pdf5FlxLMqwLR
         AIFtcwakXSFXgajEAqANX0+lN7QWowNkrbaLTNLtjQq4WP2TzD6LxHVskDyyGqF8Iu2a
         Hs5Dk5ucpqgjUDhQqx3RQKd2yM2sRoVS1SDQxhlVS2NCK291dHgS2EMTlKoKFg1Z3E+2
         OnGja87XMuJWjanRhAiAqviRYwOe0bvAHccOIzNqWzImcBtJOOzdj5PSyJjr400Aq6V1
         Ysdg==
X-Gm-Message-State: AOJu0YyncLy8uZNUX7P4Yc1flfcQHtaJ/iPHA/F4NVkJ8T6iP+e7++Q0
	mRF29f6v3NLmNEsgJ0Wu9xUJ7C5V+1ucAOBma/lXdGRIYdt+amxQ+UX0qGHNPDSTve32nSOkR3v
	mWIBu9uqw/fqITz1M7GWoGLvl5XsDLFYfVxfUMa8=
X-Gm-Gg: AfdE7cl5K2ZkFzFfZUMILoFKGNF23TpGsi8KOgiTJ1v3F4oVNtBHKZWjz7gCtrF6AHa
	bxfnK0SZxqvL+j6QBCr8ZCv3TIQdnnmWwob7G5dn3cGKjVxqN/EdGnAAE3Q4E1P/Unc2wVOWVWS
	+aa98jG+b6Em65mZBFJ6Mi6q5qav3qZqH4Sb+zGPYfkJ4WbR+Lomk8bu+8EDtjQS2ZHzxi2OcOF
	/ohnQ/oezsFQ0B/tVOpLBj6t5+GL3ESYdiQrarwhDF/tsS0Sy/jqDCnDto1KuoFAiKVQ8YSIw==
X-Received: by 2002:a05:690c:e07:b0:7bd:7d69:7660 with SMTP id
 00721157ae682-80a6bd96a12mr33808247b3.43.1782411299656; Thu, 25 Jun 2026
 11:14:59 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 25 Jun 2026 11:14:58 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 25 Jun 2026 11:14:58 -0700
In-Reply-To: <SN6PR02MB415746E6EDCF82DAFA8B1C49D4EC2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260624175703.9285-1-alhouseenyousef@gmail.com> <SN6PR02MB415746E6EDCF82DAFA8B1C49D4EC2@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
Date: Thu, 25 Jun 2026 11:14:58 -0700
X-Gm-Features: AVVi8CdyWxhiSRMRNa7k9bq_1AquMTIQfNMbWt4n0IRINK6meuQPWgjqs5EFtuE
Message-ID: <CAMuQ4bW+KdfEOQnPPbAJUySO7arRhmqXo5viE9SJu-JKaUWeTA@mail.gmail.com>
Subject: RE: [PATCH] hyperv: mshv: zero VTL hypercall input page
To: Michael Kelley <mhklinux@outlook.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11685-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mhklinux@outlook.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[alhouseenyousef@gmail.com,linux-hyperv@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com,microsoft.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alhouseenyousef@gmail.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,outlook.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8A2AC6C8203

Hi Michael,

That makes sense. Please drop this patch.

I sent a v2 for the output-page issue with the mshv_vtl prefix and
your suggested changes.

Thanks,
Yousef

On Thu, 25 Jun 2026 16:41:51 +0000, Michael Kelley <mhklinux@outlook.com> wrote:
> From: Yousef Alhouseen <alhouseenyousef@gmail.com> Sent: Wednesday, June 24, 2026 10:57 AM
> > Subject: [PATCH] hyperv: mshv: zero VTL hypercall input page
> >
>
> Same comment here about the patch "Subject:" prefix.
>
> > mshv_vtl_hvcall_call() copies only the user-provided input size.
> >
> > It then passes the page to hv_do_hypercall().
> >
> > For short inputs, stale bytes can remain in the bounce page.
> >
> > Those bytes can be consumed by the hypervisor.
>
> It's unclear to me that there's really a problem here. In a
> CoCo VM, the host hypervisor isn't trusted, so hypercall sites
> must be careful to only expose intended data in the hypercall
> input and output pages. But this code already doesn't support
> CoCo VMs, as noted in the comment. So in the supported
> scenario, the hypervisor has access to all of guest memory. Passing
> stale bytes to the hypervisor vs. passing zeros really wouldn't matter.
> And user space can already pass stale/garbage bytes to the hypervisor
> if it wants to. This code doesn't try to validate the input data for
> whatever hypercall user space is requesting to be made.
>
> When support for CoCo VMs is added, this code will indeed
> need to make sure not to allow garbage kernel data in the
> hypercall input or output pages. But decrypting the pages
> so the hypervisor can access them should take care of that
> issue.
>
> Michael
>
> >
> > Allocate the input page zeroed, matching the output page.
> >
> > Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> > ---
> > drivers/hv/mshv_vtl_main.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
> > index 0365d207c..f2633148c 100644
> > --- a/drivers/hv/mshv_vtl_main.c
> > +++ b/drivers/hv/mshv_vtl_main.c
> > @@ -1146,7 +1146,7 @@ static int mshv_vtl_hvcall_call(struct mshv_vtl_hvcall_fd *fd,
> > *
> > * TODO: Take care of this when CVM support is added.
> > */
> > - in = (void *)__get_free_page(GFP_KERNEL);
> > + in = (void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
> > out = (void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
> > if (!in || !out) {
> > ret = -ENOMEM;
> > --
> > 2.54.0
> >

