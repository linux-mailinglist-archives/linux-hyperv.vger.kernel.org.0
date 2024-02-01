Return-Path: <linux-hyperv+bounces-1492-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6B3844DDB
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Feb 2024 01:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34A2A1F29A70
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Feb 2024 00:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78B7A47;
	Thu,  1 Feb 2024 00:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsmaJ8xY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872191FA4;
	Thu,  1 Feb 2024 00:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706747454; cv=none; b=bhPOQTqF7q48gqBEQB5TCmeXWxCf3OruDRAOZMB1GS4K1C4zRZNKNXvAK8s7llfUWtIK4Gno/9RGFyphiLwMDiBEEW4frUx22tCTidlKohE+eueFzPy2v0Or6T0djBS6NUpaljPvpNRaLUt16pmX8TAbsjff8x/+2Ycu8pT11zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706747454; c=relaxed/simple;
	bh=CxnsDVYhkH8+1lNzX4f8/hgDqk5t0WmxzEduiMc1gI0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tyGRNCNOHh3Xvg9tzDb7VBm8rq9o6z1pDDTyHVBKSeKnUbHOTiZXFgXsTSkklA7VDHn+aj2A3IDn+EV6Rbg4VamI+ufWuRXTRQzk5z6Ylyy46Qmw5LV5unt15lLjKdXv72tDxOISNyh9iKI1UDa8DTy0xZf+7bx5bGsdML/f68k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsmaJ8xY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5750CC433F1;
	Thu,  1 Feb 2024 00:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706747454;
	bh=CxnsDVYhkH8+1lNzX4f8/hgDqk5t0WmxzEduiMc1gI0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UsmaJ8xY6wLIKInRNG7FYQOpKeKBStnwImOiSAYblX4o2uJMMTBNOX1NphQ7SJQy5
	 m0JaHMRNjY+DjMDogMyr+IYwo1pVYe3VDxXtCdJnwyDjxcEdlT4AziyNFDe9KJ8lhN
	 cbtCgJ0vspMe0zSjFUj+y3Utwh5JBYKRwqpBXI9Hjtt1MiIKX+aOb4XP+H+eTG3jlg
	 Np4PDEm8H6NQFEt5GWNR3A3yjAhllSvNocfFGnkIfkyXRhebGhrSzt2YUf2w6Jl9fD
	 CIfDU85ykBdpeUYrI5MJqe4jXYYlESErCUhryOAogNyVGutmKWuLkOxKtloUFuQ4fc
	 ITR8Q1NwVGRTA==
Date: Wed, 31 Jan 2024 16:30:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Wojciech
 Drewek <wojciech.drewek@intel.com>, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 shradhagupta@microsoft.com, stable@vger.kernel.org
Subject: Re: [PATCH] hv_netvsc:Register VF in netvsc_probe if
 NET_DEVICE_REGISTER missed
Message-ID: <20240131163048.574707f2@kernel.org>
In-Reply-To: <20240131060957.GA15733@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1706599135-12651-1-git-send-email-shradhagupta@linux.microsoft.com>
	<20240130182914.25df5128@kernel.org>
	<20240131060957.GA15733@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jan 2024 22:09:57 -0800 Shradha Gupta wrote:
> This patch applies to net, which is missed in the subject. I will fix
> this in the new version of the patch. Thanks


$ git checkout net/main 
[...]
$ git am raw
Applying: hv_netvsc:Register VF in netvsc_probe if NET_DEVICE_REGISTER missed
error: patch failed: drivers/net/hyperv/netvsc_drv.c:42
error: drivers/net/hyperv/netvsc_drv.c: patch does not apply
Patch failed at 0001 hv_netvsc:Register VF in netvsc_probe if NET_DEVICE_REGISTER missed
hint: Use 'git am --show-current-patch=diff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

