Return-Path: <linux-hyperv+bounces-3381-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 572509DF377
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 Nov 2024 23:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C171128136C
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 Nov 2024 22:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236DF1AA7B1;
	Sat, 30 Nov 2024 22:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGCAkHLz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD461A9B58;
	Sat, 30 Nov 2024 22:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733004190; cv=none; b=N+3tuAMZNAO6Q+eki6sBtMtoTteTzFC7IIIz5rTOlwZB/9hq60BODymlapsM8Z+Ggo4BJBxMLAdzITL9xJN+rpOX5GHnpioF9xnHo2d4kAsByE+YjSMAR8jxurPFrpoabqUCrrI/zJZgTAD+Jq4PktGhNLWavmS36l4RY6G8dkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733004190; c=relaxed/simple;
	bh=cSG/0QfMLpGgugGMeoqQy4eeYYHrqIdNNTuEdiWAP5I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ij4YhsI3bEeMwzGrjTYhoA+w73G/GO/DJ+uAWRPzv4HlTWrj2WdtoG8dkgL6esuvpPKq2gUGJpVB1yXCZwSmOgs7AOEOVLYiBTGwQyqVoSZNLewuBYVpoo4bLZTVPBsvP0X7osWTEQdeGjChUc9PoiUQoJIZZI0DuxBV3szdu58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGCAkHLz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5CF4C4CED3;
	Sat, 30 Nov 2024 22:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733004189;
	bh=cSG/0QfMLpGgugGMeoqQy4eeYYHrqIdNNTuEdiWAP5I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XGCAkHLz5ZE7bU+L+nUBTE0y0OhK/NG1LZg9Y8IgL3INmNXIFelOQTWe1DwnL7rPI
	 96RS990iYIib072aVevhuqV7G94HejMx3XR84vv8ZodHTN8YOvfe+JSRZc3DpQnBmK
	 ydFPuecmGEZ2XQ+esSJpPSqyrCZySqWU/h0TSp+U6ErP/ZdWqohcaT/n7YcKWx5hyK
	 zLjsBWo0SwzXMDAmPAmeAIi09Nzof2FggkhTZB1UeIH5VJ83XOB59mCfljBWz/5RPe
	 1Y7oNiJhUadFdYFwVgUCp1Zc08L4Wu4yMDLNQ82/+eQinMA/+vo/suBiOj7k033dPY
	 CBycqzaWSvSCw==
Date: Sat, 30 Nov 2024 14:03:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: longli@linuxonhyperv.com
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shradha
 Gupta <shradhagupta@linux.microsoft.com>, Simon Horman <horms@kernel.org>,
 Konstantin Taranov <kotaranov@microsoft.com>, Souradeep Chakrabarti
 <schakrabarti@linux.microsoft.com>, Erick Archer
 <erick.archer@outlook.com>, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Long Li
 <longli@microsoft.com>
Subject: Re: [PATCH] hv_netvsc: Set device flags for properly indicating
 bonding
Message-ID: <20241130140307.3f0c028c@kernel.org>
In-Reply-To: <1732736570-19700-1-git-send-email-longli@linuxonhyperv.com>
References: <1732736570-19700-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Nov 2024 11:42:50 -0800 longli@linuxonhyperv.com wrote:
> hv_netvsc uses a subset of bonding features in that the master always
> has only one active slave. But it never properly setup those flags.
> 
> Other kernel APIs (e.g those in "include/linux/netdevice.h") check for
> IFF_MASTER, IFF_SLAVE and IFF_BONDING for determing if those are used
> in a master/slave setup. 

I feel like this has been nacked 10 times already?
IFF_BONDING means the bonding driver.
There is more than one driver in the tree providing link aggregation
and only bonding uses IFF_BONDING. If some user is buggy fix the user.
-- 
pw-bot: reject

