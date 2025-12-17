Return-Path: <linux-hyperv+bounces-8044-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9613FCC59FD
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Dec 2025 01:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21DF23028DAA
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Dec 2025 00:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C14F19CCFD;
	Wed, 17 Dec 2025 00:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ArBgX1li"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D278A1E50E;
	Wed, 17 Dec 2025 00:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765932318; cv=none; b=th+UlJTNh2iyYKmPp6EIZWFkMsnGOVVn3dfCLPPBth/ncoxAzY2GShFPazEtlRuKSsJmBpnxPJoEguNRUw1q68HSyeOWpDYW4P2rlz9uGq4OkWdgLykakJmcy7Dahy5sv+uIXikOkOZljRnOd23A8VfWo+65NJbwog/qUlcGw5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765932318; c=relaxed/simple;
	bh=mxuMPDZfc7IPfHb74eP86EePxY94M9soIY9e3F67tco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cNiJd/iS6LDyxVmdwmNRewqZb5zKuW+a7Wx+HvfEfThvCiCxDuUrEwmNayz549zhWDMQXiRoEOIqjqiWj8/9uOpk5JArLembYniHQzkiruKkRkrZsBFgsYxTDwT/UlZEvHVoQlUdbGJD16Lg/x507sgf/M3NfwLPlYdk02edbqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ArBgX1li; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.236.10.120])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6425D200D641;
	Tue, 16 Dec 2025 16:45:14 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6425D200D641
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1765932314;
	bh=qTk2pAUuPOQECROXNeIvo5BgCJM7QiJ+tFdc8PMvSKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ArBgX1lizotouIWTU9LmZpsJ4NJha4rDX08t1IhJzuClVrvsej9Zl1cRYZmYa4sfR
	 eTlHY62qNFl8NoX+iCKoNlFA3rePukoWY4ojXAEILn0YEICrPxHFuvrARXq8OIYrpC
	 c5sytDgxmynHUkaXcy4e3+rn58M43C88UoCy6/0Q=
Date: Tue, 16 Dec 2025 16:45:12 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Wei Liu <wei.liu@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
	Stansialv Kinsburskii <skinsburskii@linux.miscrosoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Easwar Hariharan <easwar.hariharan@linux.microsoft.com>,
	Anatol Belski <anbelski@linux.microsoft.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Sean Christopherson <seanjc@google.com>,
	Naman Jain <namjain@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv: hide x86-specific functions on arm64
Message-ID: <aUH9GGzROHfbP6pj@skinsburskii.localdomain>
References: <20251216213619.115259-1-arnd@kernel.org>
 <20251216222129.GA1300707@liuwe-devbox-debian-v2.local>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216222129.GA1300707@liuwe-devbox-debian-v2.local>

On Tue, Dec 16, 2025 at 10:21:29PM +0000, Wei Liu wrote:
> On Tue, Dec 16, 2025 at 10:36:12PM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > The hv_sleep_notifiers_register() and hv_machine_power_off() functions are
> > only called and declared on x86, but cause a warning on arm64:
> > 
> > drivers/hv/mshv_common.c:210:6: error: no previous prototype for 'hv_sleep_notifiers_register' [-Werror=missing-prototypes]
> >   210 | void hv_sleep_notifiers_register(void)
> >       |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/hv/mshv_common.c:224:6: error: no previous prototype for 'hv_machine_power_off' [-Werror=missing-prototypes]
> >   224 | void hv_machine_power_off(void)
> >       |      ^~~~~~~~~~~~~~~~~~~~
> > 
> > Hide both inside of an #ifdef block.
> > 
> > Fixes: f0be2600ac55 ("mshv: Use reboot notifier to configure sleep state")
> > Fixes: 615a6e7d83f9 ("mshv: Cleanly shutdown root partition with MSHV")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Thanks Arnd. I have a queued up a patch which make available the
> declarations to arm64. Let me think about whether to use your patch
> instead.
> 
> Anyway, this issue will be fixed one way or the other once I send a PR
> to Linus.
> 

The whole idea of mshv_common.c is to have common code for all archs.
It would be nice to keep this file as it is.

Thanks,
Stanislav

> Wei
> 
> > ---
> >  drivers/hv/mshv_common.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/hv/mshv_common.c b/drivers/hv/mshv_common.c
> > index 58027b23c206..63f09bb5136e 100644
> > --- a/drivers/hv/mshv_common.c
> > +++ b/drivers/hv/mshv_common.c
> > @@ -142,6 +142,7 @@ int hv_call_get_partition_property(u64 partition_id,
> >  }
> >  EXPORT_SYMBOL_GPL(hv_call_get_partition_property);
> >  
> > +#ifdef CONFIG_X86
> >  /*
> >   * Corresponding sleep states have to be initialized in order for a subsequent
> >   * HVCALL_ENTER_SLEEP_STATE call to succeed. Currently only S5 state as per
> > @@ -237,3 +238,4 @@ void hv_machine_power_off(void)
> >  	BUG();
> >  
> >  }
> > +#endif
> > -- 
> > 2.39.5
> > 

