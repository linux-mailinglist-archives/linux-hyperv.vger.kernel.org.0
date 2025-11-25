Return-Path: <linux-hyperv+bounces-7816-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 120DEC84918
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Nov 2025 11:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8CFD134B1F2
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Nov 2025 10:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D37310647;
	Tue, 25 Nov 2025 10:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPtcs6gE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FEC2DAFDD;
	Tue, 25 Nov 2025 10:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764067893; cv=none; b=XFDz6eV4Ldqpe7xjno5DFWe4Y06Ietb38RJUBZ5PLeCpVC63Eg4j9lR3Zai5qbsG0C8yYRPuB3IKuvfoagxKZYlHB2PRAigOF/OSNHne2qxaff4o9oURBJJ4cc7F1jO4PHN32zGPGboXZWmaEh9l4W6QdH8Ncbw97hofkD2JgfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764067893; c=relaxed/simple;
	bh=DDx/vasiDd5eOZFzzyitm2GuMGkbBnr8GuTVczDCcLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0QojGGB9syiBzmL01UDm117RLi8q/b67DyVpjZu4SPGbgS3+C68vblDfGVk7JA6paYcKdJ4O0lwI43hspPN/mS0Ika9ULFA0KjkPNE0aMm5ImzGwGtRIWuHdHJwMJzLsxQptnBtEJ7YviyPVTItTTH+f3SZ8hk2bWU1ia+w/YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPtcs6gE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01F7C4CEF1;
	Tue, 25 Nov 2025 10:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764067891;
	bh=DDx/vasiDd5eOZFzzyitm2GuMGkbBnr8GuTVczDCcLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nPtcs6gED44KQjgxKbvjYzr/pAtq81DhttQWC5vQ3nk++wjkUJet+20eAwhkLlSmw
	 X+LODhXoKuHH0jsvMMnPrOqpaC6C1OfZg7X+iXaXLSi5m7QOzsE2cTIQgh8mL3wopT
	 DnLf/rmNxVPyOgZJeUvJ15XexkMXQ9wb0qKfT7OxygJ7CCFIRTiSdP0uu5BFquyZC7
	 fcHYrDn8BrhA2d2N8r1GL+c/FTMKooYsIItPjvW+/7EOo0GVm4/JT9nCVxW/oq2qn6
	 30cec1TJYBBEGOIeeeI5jYBFAWI0kLskY4V4fXD7O0H3agOl7x+kQHFaIhWK3jHsZR
	 k2emGsmlakcjw==
Date: Tue, 25 Nov 2025 10:51:25 +0000
From: Simon Horman <horms@kernel.org>
To: longli@linux.microsoft.com
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
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	Long Li <longli@microsoft.com>
Subject: Re: [Patch net-next v3] net: mana: Handle hardware recovery events
 when probing the device
Message-ID: <aSWKLefd_mhycGDv@horms.kernel.org>
References: <1763680033-5835-1-git-send-email-longli@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1763680033-5835-1-git-send-email-longli@linux.microsoft.com>

On Thu, Nov 20, 2025 at 03:07:13PM -0800, longli@linux.microsoft.com wrote:
> From: Long Li <longli@microsoft.com>
> 
> When MANA is being probed, it's possible that hardware is in recovery
> mode and the device may get GDMA_EQE_HWC_RESET_REQUEST over HWC in the
> middle of the probe. Detect such condition and go through the recovery
> service procedure.
> 
> Fixes: fbe346ce9d62 ("net: mana: Handle Reset Request from MANA NIC")

If this is a fix, should it be targeted at net rather than net-next?

Alternatively, if it is not a fix for net, then I suggest dropping
the Fixes tag and adding something about commit fbe346ce9d62 ("net: mana:
Handle Reset Request from MANA NIC") to the patch description, above the
tags (with a blank line in between).

> Signed-off-by: Long Li <longli@microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
> Changes
> v2: Use a list for handling multiple devices.
>     Use disable_delayed_work_sync() on driver exit.
>     Replace atomic_t with flags to detect if interrupt happens before probe finishes
> 
> v3: Rebase to latest net-next. Change list_for_each_entry_safe() to while(!list_empty()).

Code changes look good to me.

Reviewed-by: Simon Horman <horms@kernel.org>


