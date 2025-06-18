Return-Path: <linux-hyperv+bounces-5943-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CD2ADEBF7
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Jun 2025 14:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85EBB189C153
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Jun 2025 12:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD16A2E54DD;
	Wed, 18 Jun 2025 12:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="datD/rfw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA122E54C1;
	Wed, 18 Jun 2025 12:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750249273; cv=pass; b=tIKIyMI+nVomh84RMn//O2aGcCQrKifYmTzeOkMsyNarRcxZHFmW6z8NahjRgUvPSLgtYrik92gSHy1Z1kd2SnPZb6iyy+fs7EjaTwMahzvlae7hTZqkRrDeD/l15awO3N8JLDale7EEf5DToYRqvv1uw8C7rtPQUxgduWPgSOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750249273; c=relaxed/simple;
	bh=E064ukqN3Wl9q9gQuizMeRwtlaUTJRIBMleiLRK5WuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVqaf+uhsa5fLPpNgQUEXQaj/JZoZh9nYLXDWaALPdBM47g/VegWPuuX9mo6ZkE1AS9iaElGEwUJ+AP1x40Mx3aWbAFN/xcwOpWJ6d3D/t5FL/yUs4REwTi0xwNjjCw9kF3b2QbddH8zfqhsOXj36Cf4J+Wl4FD3FZnBGPp8slc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=datD/rfw; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1750249258; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YSCSonrtrvMPJCPNYdTP7AcpMF8tT6Ns+Mv0ldpqQIo6+VVsWvybiYTHRm/bIudq32v2ha6n346/3FTTt+P8UbHfS6rugLW+Hg+0RXyT4HQrnkCnTTUas5LplGasyde1d8xWsilHCV9lDTk9wUxa/5Zld7ToYUxGQ13t64ww604=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1750249258; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=u8sJ6HYzkRIIDcV1u64F3+oicJvBZLiGsmcxqwkREC8=; 
	b=JFWPoiTxYzoV/wI4zmhzdU3LumXwpVOmn6Xjug2vC/+vAooCkOufMzx+rhanMRI3io5JbRU9w1xCKvup4SQ49dBrmU3K2WqWAjvqAn+Ea3m2Mz9Ng7fYE/lZWNyu0qwlyN6lDrBGShLzD2po6+qF2UHxyuZ5UeMKF8JthEkOkBA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750249258;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
	bh=u8sJ6HYzkRIIDcV1u64F3+oicJvBZLiGsmcxqwkREC8=;
	b=datD/rfwSFfsy4TyCfsc6mkuDCWoa9zxex6dKoTdTJWSQuYfB/9o4mPHJA3e0aZT
	okQ6zz1y4stvizRXXqCvfWHFBOvd5V2/h+HF2Vnw6295W+lLgRfVYywxnK9GyV+aLOG
	Ea+R2YiQxv4PNY5eVOavAkWiujrDNfPLqnlC+DEU=
Received: by mx.zohomail.com with SMTPS id 1750249209729383.6811066576498;
	Wed, 18 Jun 2025 05:20:09 -0700 (PDT)
Date: Wed, 18 Jun 2025 12:20:05 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: sudeep.holla@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	lpieralisi@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH] firmware: smccc: support both conduits for getting hyp
 UUID
Message-ID: <aFKu9TFA6oj1N2cR@anirudh-surface.localdomain>
References: <20250605-kickass-cerulean-honeybee-aa0cba@sudeepholla>
 <20250610160656.11984-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250610160656.11984-1-romank@linux.microsoft.com>
X-ZohoMailClient: External

On Tue, Jun 10, 2025 at 09:06:48AM -0700, Roman Kisel wrote:
> > (sorry for the delay, found the patch in the spam 🙁)
> 
> "b4" shows the the mail server used for the patch submission
> doesn't pass the DKIM check, so finding the patch in the spam seems

How do you check this? I mean, what b4 command do you run?

I think it should be fix now. Let's see...

> expected :) Thanks for your help!
> 
> >
> > On Wed, May 21, 2025 at 09:40:48AM +0000, Anirudh Rayabharam wrote:
> >> From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> >>
> >> When Linux is running as the root partition under Microsoft Hypervisor
> >> (MSHV) a.k.a Hyper-V, smc is used as the conduit for smc calls.
> >>
> >> Extend arm_smccc_hypervisor_has_uuid() to support this usecase. Use
> >> arm_smccc_1_1_invoke to retrieve and use the appropriate conduit instead
> >> of supporting only hvc.
> >>
> >> Boot tested on MSHV guest, MSHV root & KVM guest.
> >>
> >
> > Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> >
> > Are they any dependent patches or series using this ? Do you plan to
> > route it via KVM tree if there are any dependency. Or else I can push
> > it through (arm-)soc tree. Let me know.
> 
> Anirudh had been OOF for some time and would be for another
> week iiuc so I thought I'd reply.

Thanks Roman!

Regards,
Anirudh

> 
> The patch this depends on is 13423063c7cb
> ("arm64: kvm, smccc: Introduce and use API for getting hypervisor UUID"),
> and this patch has already been pulled into the Linus'es tree.
> 
> As for routing, (arm-)soc should be good it appears as the change
> is contained within the firmware drivers path. Although I'd trust more to your,
> Arnd's or Wei's opinion than mine!
> 
> >
> > --
> > Regards,
> > Sudeep

