Return-Path: <linux-hyperv+bounces-2065-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EEB8BA933
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 May 2024 10:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A46161C215AC
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 May 2024 08:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C8714A4FF;
	Fri,  3 May 2024 08:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YY49NBns"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A86414A0A2;
	Fri,  3 May 2024 08:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714726088; cv=none; b=J1JRKpzRPYEoFlNqhuHCRMTPIWDa0JK9O1YZdvV2WdPRlU4O+jfnlB6u3RAH+u5R4Xdnl/fhQUuTqc9Kdh0yo9m/6YityvZXmJIdTZvybuz20umBATeLZUq8BynMMXyf3nSG5Rt8c3R7UwTAsq5ukm+FolWniz0GR115d6IQDKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714726088; c=relaxed/simple;
	bh=Etxg/YHMDKlpBP32lFDLlbJbSn/TfzZAQBVqlraiDDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDIVzWHAQKYZAJWj1DmMeVmFm/CeZhby4KgK05SK3rxfKlSJS3Qw2ROjRyTKhlOnL9O8lXraCeUEo84indLQOdOgbrU5IekS0y54NHGS6KYVAzdaeJ7MUHHOEoBcfGEGIl5ZXRjgHHdlJ9l1dmPpoBmTdLFQcZPrLa1oD2VLfqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YY49NBns; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id C9B0220B2C80; Fri,  3 May 2024 01:48:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C9B0220B2C80
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1714726086;
	bh=i7337QBeIGytOvVKmvrACz56gMsVGvMlwWZTi53xsLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YY49NBnsr3733U23ONC3HeNSrFWhcfqJUUOhGmt7SF2sx8ELfV27k8uB3Qh4zpyy7
	 2m9l5urjC7tt5mvzIANbyq/jaTnKqxyjdnawdBUZQMA37FuLWSRSTiBvoS2EOzcrXj
	 bSmPiBcruCWnyQzZzPTBlcfeHLRZylpxj25fi7GQ=
Date: Fri, 3 May 2024 01:48:06 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Breno Leitao <leitao@debian.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Yury Norov <yury.norov@gmail.com>, linux-hyperv@vger.kernel.org,
	shradhagupta@microsoft.com
Subject: Re: [PATCH net-next v2 0/2] Add sysfs attributes for MANA
Message-ID: <20240503084806.GA1248@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1713954774-29953-1-git-send-email-shradhagupta@linux.microsoft.com>
 <ZikbpoXWmcQrBP3V@nanopsycho>
 <20240430053138.GA6429@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430053138.GA6429@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Apr 29, 2024 at 10:31:38PM -0700, Shradha Gupta wrote:
> On Wed, Apr 24, 2024 at 04:48:06PM +0200, Jiri Pirko wrote:
> > Wed, Apr 24, 2024 at 12:32:54PM CEST, shradhagupta@linux.microsoft.com wrote:
> > >These patches include adding sysfs attributes for improving
> > >debuggability on MANA devices.
> > >
> > >The first patch consists on max_mtu, min_mtu attributes that are
> > >implemented generically for all devices
> > >
> > >The second patch has mana specific attributes max_num_msix and num_ports
> > 
> > 1) you implement only max, min is never implemented, no point
> > introducing it.
> Sure. I had added it for the sake of completeness.
> > 2) having driver implement sysfs entry feels *very wrong*, don't do that
> > 3) why DEVLINK_PARAM_GENERIC_ID_MSIX_VEC_PER_PF_MAX
> >    and DEVLINK_PARAM_GENERIC_ID_MSIX_VEC_PER_PF_MIN
> >    Are not what you want?
> Thanks for pointing this out. We are still evaluating if this devlink param
> could be used for our usecase where we only need a read-only msix value for VF.
> We keep the thread updated.
The attribute that we want is per VF msix max. This is per PF and would not be
the right one for our use case.
Do you have any other recommendations/suggestions around this?

Regards,
Shradha.
> > 
> > >
> > >Shradha Gupta (2):
> > >  net: Add sysfs atttributes for max_mtu min_mtu
> > >  net: mana: Add new device attributes for mana
> > >
> > > Documentation/ABI/testing/sysfs-class-net     | 16 ++++++++++
> > > .../net/ethernet/microsoft/mana/gdma_main.c   | 32 +++++++++++++++++++
> > > net/core/net-sysfs.c                          |  4 +++
> > > 3 files changed, 52 insertions(+)
> > >
> > >-- 
> > >2.34.1
> > >
> > >

