Return-Path: <linux-hyperv+bounces-2264-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 385E58D4F8E
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 May 2024 18:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6680F1C2351B
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 May 2024 16:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA76E1F941;
	Thu, 30 May 2024 16:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEiajTd+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959EB18E10;
	Thu, 30 May 2024 16:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717085042; cv=none; b=LIqcL17iLzFaqYNbRQL+NQUug+c8z1uocJjWgHchegEQOtrM9QtjLmOHP9vgVINrg6SvzLYv8jkkJLcxLnTPsohyPKmcwmSX22PpM0iC1V5ZpzD1rYKCaniF1c595vJ2hPDu7fQT9a53AUeP/NmuOSjgmLaX3e1EhzM9pfeMYCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717085042; c=relaxed/simple;
	bh=gza8xgBN5lr2MYcZ39xcmjQltHcmPpx1sEKVWrjZn4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1SLZzhFd50mBNEgmQ0I/MSEzi1uYbOYZmMCSY9d7qDO39b6qEwjIXKXSjPA/YlK3+a19WOzxYBeo5vKGQXF3fGQvImhXIY03Zj4dJpS+8qeX8KdJ3E1zbkQM5/OSZiUytaYLAhvAuUEUTH3XC0xww11qBT+Znxc29OMSROTbWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEiajTd+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C26C2BBFC;
	Thu, 30 May 2024 16:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717085042;
	bh=gza8xgBN5lr2MYcZ39xcmjQltHcmPpx1sEKVWrjZn4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GEiajTd+UBB3uPY4EhizLThEONXgFq62rERV15OkwH7fQyJd1VQLHF9qBa1nh5S1Q
	 fcB32091J6uFewcBVtyJ3lWLGPDtWooFALP//XgxuodZJCmgGdRdgaeP9Plrz3sktr
	 UjHvOsOpBG2UggHs9l4KqJsQXxVKnmi167LygJAH4lqJ1ruv+XUelPQCvNcY9W6cTK
	 AdKaG3a0X10hSYd4FDP0lq/DslPjNg62T6UrkM+TsQe6GDMl3VnOzGQ8SHbC2tUkpu
	 Z+uc6KIxF9NTRTEomu4unoyUpcDMVTPWgzdVwfl2CaKyojZ9NSoT800lHFKS0BJfbL
	 ZtKrCSPbNhO/w==
Date: Thu, 30 May 2024 19:03:57 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	linux-hardening@vger.kernel.org, netdev@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, Colin Ian King <colin.i.king@gmail.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Kees Cook <keescook@chromium.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH net-next v2] net: mana: Allow variable size indirection
 table
Message-ID: <20240530160357.GD3884@unreal>
References: <1716960955-3195-1-git-send-email-shradhagupta@linux.microsoft.com>
 <20240530143702.GB3884@unreal>
 <20240530084255.0b550d35@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530084255.0b550d35@kernel.org>

On Thu, May 30, 2024 at 08:42:55AM -0700, Jakub Kicinski wrote:
> On Thu, 30 May 2024 17:37:02 +0300 Leon Romanovsky wrote:
> > Once you are ok with this patch, let me create shared branch for it.
> > It is -rc1 and Konstantin already submitted some changes to qp.c
> > https://lore.kernel.org/all/1716366242-558-1-git-send-email-kotaranov@linux.microsoft.com/
> > 
> > This specific patch applies on top of Konstantin's changes cleanly.
> 
> Yeah, once it's not buggy shared branch SG! Just to be sure, on top
> of -rc1, right?

Yes, it will be based on clean -rc1.

Thanks

