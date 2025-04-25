Return-Path: <linux-hyperv+bounces-5103-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DC8A9BE64
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Apr 2025 08:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0A911899C8C
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Apr 2025 06:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB929156C69;
	Fri, 25 Apr 2025 06:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+gxqCXs"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973A82701D7
	for <linux-hyperv@vger.kernel.org>; Fri, 25 Apr 2025 06:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745561257; cv=none; b=BsjVEDywEdLIMc8JmjC+glRpiWBW6w4cOKxcsRtvOI9ALZs9OlK0QTfyG0Iu29lNUX6Od5ZoI3a3W4BrZAICvv3qsbBirnQa9oY1ic6nfIuGqpfDndMLF5VtQJwl7Y0jin//YvkEGaq8DRE2UbkciV99C0Ap836w6peVmpPcVxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745561257; c=relaxed/simple;
	bh=CRZcDmRZ8LDtE3EcvsMyoJuAqPH1B8oUlWYV9PDXIp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MiaVvjWQmJ+duPqkLkmgDqqeXS8RCGuKowPPDxDvuayvOxO360BX1yq3RPE8Sh4OgmGNQwkq4YPMI38T9vFiKmzgyXRwydPTKFKAF2RVWp9vcPI3kxNFP9rv2bnQPEbxsWCS6krF5q/FOasYTnZQ9ao48szJNQ8UtFybeG+wQP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+gxqCXs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1560C4CEE4;
	Fri, 25 Apr 2025 06:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745561257;
	bh=CRZcDmRZ8LDtE3EcvsMyoJuAqPH1B8oUlWYV9PDXIp4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E+gxqCXs+LkomcvjNQWPPoD2Are08iLwtQkFRTCC8PVV+IBqZWdNRDyN9BrcdWczb
	 cAdVMHHT/vjH2uvbjTQ19oHYV6G2fgLpLzOIuGxUDcLkriUYqiQfS8aGjhSutO0EB3
	 dJAwhmFYvOHM3whPE/rrtb1UjpYRxbAMICaOkjccsaxSRqs9AaEoHmNAvYZzJKkVUC
	 Sjqp6HNHz8rwoEFWGGALEmOQGECGEU04lzOC7q1ABjO5dCCKPu2P4aEXiTVbTLvK3g
	 iN9tru5ACykkI2p+NAT9cS5PYjqIwXhm9eIvkw2/tehNlGrpvudljkISI0i3+PdIst
	 fnAiOjd6IdxNQ==
Date: Fri, 25 Apr 2025 06:07:35 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: Olaf Hering <olaf@aepfle.de>, linux-hyperv@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH v1] tools/hv: update route parsing in kvp daemon
Message-ID: <aAsmp6-rQn5h9ikw@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <20241202102235.9701-1-olaf@aepfle.de>
 <20250408062057.6f5812d3.olaf@aepfle.de>
 <20250410163435.GA18846@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20250416050242.GA931@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416050242.GA931@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Tue, Apr 15, 2025 at 10:02:42PM -0700, Shradha Gupta wrote:
> On Thu, Apr 10, 2025 at 09:34:35AM -0700, Shradha Gupta wrote:
> > On Tue, Apr 08, 2025 at 06:20:57AM +0200, Olaf Hering wrote:
> > > Mon,  2 Dec 2024 11:19:55 +0100 Olaf Hering <olaf@aepfle.de>:
> > > 
> > > > After recent changes in the VM network stack, the host fails to
> > > > display the IP addresses of the VM. As a result the "IP Addresses"
> > > > column in the "Networking" tab in the Windows Hyper-V Manager is
> > > > empty.
> > > 
> > > Did anyone had time to address this issue?
> > > 
> > > 
> > > Olaf
> > > 
> > Hi Olaf,
> > Wei's message for a review and quick test, somehow got missed by me.
> > Let me get back to you after a few tests with the patch on our envs.
> > 
> > Thanks,
> > Shradha.
> 
> I have verified this patch on Hyper-V with network-manager and wicked
> services.
> The changes look good to me.
> 
> Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> 

Thanks. Applied to hyperv-fixes.

