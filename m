Return-Path: <linux-hyperv+bounces-2055-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B078B69F2
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Apr 2024 07:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFCF62831DB
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Apr 2024 05:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A1417582;
	Tue, 30 Apr 2024 05:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rZr/iCae"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA2B5256;
	Tue, 30 Apr 2024 05:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714455100; cv=none; b=t06z4NGFEplWk3YnuhXdqP1cFEW0C3YG7HZi3yHflcogJYoIgVE/qsDLWHFKwv+XfKV3uIySAt6SKzlkwrmV+3hRgUGzqLrX2ZV82KPdK+8HTtMEyuCAI1fsp8EoYwIsONVaZ8UJ7dmSPUKaRzpPc68ALrWO5v37civBmgo8LeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714455100; c=relaxed/simple;
	bh=Q8V+3JOr+a1s8/qzOBuGdcCPedYadHh3WFecyLKH3wI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jj+kXERdPZuRfU5X3l45ZHUGWtylU5ESHNREfjn6R1JC4xiy5N9I1uqeTWDIrzGKhb5KEf4kgnKER0rIKTBmoRlvkrVNyh/t9SCPU+DK7u1cmWSvrzv217m9PsMFh0EsWtX7PgvEX1gdlXvlbSxRhFzWTb5XTTHl7ssCUA6Rtds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rZr/iCae; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id E1ACD210FBCF; Mon, 29 Apr 2024 22:31:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E1ACD210FBCF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1714455098;
	bh=KzxTstJtvUd8l5rN/2EuPcSEUQvGKdejTaLmiq9IXsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rZr/iCaeB86PuU863wNDmHMaF42RuhfpgFeX8DMHrg7zO2gvIwKI2vqnOu9agG7rP
	 Ah6600TxzkAhIbI2+muTf0bZgZV9WAeWghc+cHKUnaI12PkBud4l+PrvpsMM5FfRNu
	 ois5YgS1cu1CY/1DmTiMVgwyQofPJslwJAZUXBmA=
Date: Mon, 29 Apr 2024 22:31:38 -0700
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
Message-ID: <20240430053138.GA6429@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1713954774-29953-1-git-send-email-shradhagupta@linux.microsoft.com>
 <ZikbpoXWmcQrBP3V@nanopsycho>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZikbpoXWmcQrBP3V@nanopsycho>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Apr 24, 2024 at 04:48:06PM +0200, Jiri Pirko wrote:
> Wed, Apr 24, 2024 at 12:32:54PM CEST, shradhagupta@linux.microsoft.com wrote:
> >These patches include adding sysfs attributes for improving
> >debuggability on MANA devices.
> >
> >The first patch consists on max_mtu, min_mtu attributes that are
> >implemented generically for all devices
> >
> >The second patch has mana specific attributes max_num_msix and num_ports
> 
> 1) you implement only max, min is never implemented, no point
> introducing it.
Sure. I had added it for the sake of completeness.
> 2) having driver implement sysfs entry feels *very wrong*, don't do that
> 3) why DEVLINK_PARAM_GENERIC_ID_MSIX_VEC_PER_PF_MAX
>    and DEVLINK_PARAM_GENERIC_ID_MSIX_VEC_PER_PF_MIN
>    Are not what you want?
Thanks for pointing this out. We are still evaluating if this devlink param
could be used for our usecase where we only need a read-only msix value for VF.
We keep the thread updated.
> 
> >
> >Shradha Gupta (2):
> >  net: Add sysfs atttributes for max_mtu min_mtu
> >  net: mana: Add new device attributes for mana
> >
> > Documentation/ABI/testing/sysfs-class-net     | 16 ++++++++++
> > .../net/ethernet/microsoft/mana/gdma_main.c   | 32 +++++++++++++++++++
> > net/core/net-sysfs.c                          |  4 +++
> > 3 files changed, 52 insertions(+)
> >
> >-- 
> >2.34.1
> >
> >

