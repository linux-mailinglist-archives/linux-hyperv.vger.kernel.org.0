Return-Path: <linux-hyperv+bounces-5964-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2B6AE0780
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Jun 2025 15:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43BB7188347E
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Jun 2025 13:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E67525A32C;
	Thu, 19 Jun 2025 13:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kn0RJble"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D166F2AF07;
	Thu, 19 Jun 2025 13:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750340203; cv=none; b=OU8bBejxEpOqqF7OX8jWvsVFWJBFBYSCMlSTPoHtNBTVc/3EjuUMS85y4/zTD09cPG/L8yh9ecAQ6sqzPJlBETY8ipuvKtnNgn1k0gn8nd3ShGmwqmwQJrDdxyf0gqnB7Qh7acS0xKQKHqt7saUJNFEz50jhYmVM6LSvMERo2xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750340203; c=relaxed/simple;
	bh=i1H5EU2QfSJgEPMhXbCA744BQEMY5sB9PjVmugZBvxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LGiN4h+De7ztHscxiS+a2pLO84Ii6NxyuwTZQwwZvlRRZNbNodw3DmoZtXUC/ugHaegIk+iQFxQjG/qMLsHc58d8oR+S4BAC3xX9Tbms5qKOeK7/jxmNIpi/0ETHqshEPwcJ4pfoXdVRyDIo+g+tWLt2yWRVCTH0Ef+r4fqt1CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kn0RJble; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 402C2C4CEEA;
	Thu, 19 Jun 2025 13:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750340203;
	bh=i1H5EU2QfSJgEPMhXbCA744BQEMY5sB9PjVmugZBvxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kn0RJbleSIGEFtAZ62vfWjYvGwPEU4GnzYYzZvVPx9AHK26rImHo3WCEiEcsD3CLg
	 IjGPdvDRctBJJJMb0cyhkLeqcCfWkBTmvKUqWVrHdC8dA0sovwscwVhZwwn29PI0jA
	 jd9PeR3JMxgf9KSCLbmZjQDovVnlTwyFvbRsKkKVw7CuaRcIxsqemDbN0s4MxCdwt3
	 yYCqSBGEU0kfs9kH97YQ8SLfhuJlUaTDNUpBTxfB6Z398wX1ZNzvLUsDZJ9i5A7ASz
	 v+1iDKGAlK5D0VZgCaSZ4YgPog4AsRa7/jJH3/z1VsEjNMqA1ZLAeAC7/hl71MvEtz
	 Dk+T/lQfpiL3g==
Date: Thu, 19 Jun 2025 14:36:38 +0100
From: Simon Horman <horms@kernel.org>
To: longli@microsoft.com
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	Erick Archer <erick.archer@outlook.com>,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [Patch net-next v3] net: mana: Record doorbell physical address
 in PF mode
Message-ID: <20250619133638.GR1699@horms.kernel.org>
References: <1750210606-12167-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1750210606-12167-1-git-send-email-longli@linuxonhyperv.com>

On Tue, Jun 17, 2025 at 06:36:46PM -0700, longli@linuxonhyperv.com wrote:
> From: Long Li <longli@microsoft.com>
> 
> MANA supports RDMA in PF mode. The driver should record the doorbell
> physical address when in PF mode.
> 
> The doorbell physical address is used by the RDMA driver to map
> doorbell pages of the device to user-mode applications through RDMA
> verbs interface. In the past, they have been mapped to user-mode while
> the device is in VF mode. With the support for PF mode implemented,
> also expose those pages in PF mode.
> 
> Support for PF mode is implemented in
> 290e5d3c49f6 ("net: mana: Add support for Multi Vports on Bare metal")
> 
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
> Changes
> v2: add more details in commit message on how the doorbell physical address is used
> v3: add the early commit detail where the support for PF mode is implemented

Thanks for the updates.

I agree that this revision address Jakub's feedback on v2.
Which in turn addressed his feedback on v1.

Reviewed-by: Simon Horman <horms@kernel.org>


