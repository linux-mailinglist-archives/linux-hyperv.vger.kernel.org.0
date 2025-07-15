Return-Path: <linux-hyperv+bounces-6244-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C792FB04D6C
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Jul 2025 03:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EC5D1A663A7
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Jul 2025 01:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D20D1B4231;
	Tue, 15 Jul 2025 01:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKQgAWUe"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD00D126BFF;
	Tue, 15 Jul 2025 01:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752542958; cv=none; b=aClm0EE1fS7zt9yErgMrB5aNC4hihsofKuKYSVDEskxqPL6eFVv9O66yGSkdds379TLM0H6cAkYfTPgHIcADH767fOkBT0hwWOWP8HD25eRB+3ivVwrUK/s0gNUW8CqYvv4i2mQ8r1AMB+o9DODGhYFaXZ0f5ewL/+c5ZiTvHww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752542958; c=relaxed/simple;
	bh=LN3SDU0SJ2mAMDx6DoNHbADF0j7JFa7bL8zPf+ObbHk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sF3HV5QK4lawBvAwm4w32YtOXR02AZtDkcmiT9F3b7e70lvnVgcBwAfRbd1oknpld/NQlNhb9Tv/RxYMViNhWoGn6UOvy06j3KwK0V6awr+EtrK4x2Caa6BAsTTPw9Z+iDpMCxOyw/ABXqpisL0lhPNvCrlFPi4QdFxiMxyXeqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKQgAWUe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB86BC4CEED;
	Tue, 15 Jul 2025 01:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752542955;
	bh=LN3SDU0SJ2mAMDx6DoNHbADF0j7JFa7bL8zPf+ObbHk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IKQgAWUew8JrCt5xcLQ2oYee1YvYR8KC4tGKllVov7izR7wpPEUp99AIMLjGAJODZ
	 rycnSRv/rHww451DmWzJawsPOcTxQCdRUNZZYgjBm7AlPWEw83krXzEsftExd55suy
	 k4KihSquEoYOULx0wNBDreI8RsAuTVLVN544hxK4rY2u5Q1oVi3GJmx1l0evh2+2nX
	 4h9zhinF9Sxdrz2cK+HSe6kPCzti00U92H65lDEQTV4znCPT+w5qIydht+i6dWHB6H
	 P+RVyGXhmuqOWEb7qpLmW3/zvuJXqzFxywwScHdg1T32P0ekI5ZEggd1NsPdUBKtUe
	 P0tesGRFPe69Q==
Date: Mon, 14 Jul 2025 18:29:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Haiyang Zhang <haiyangz@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 haiyangz@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, edumazet@google.com, pabeni@redhat.com,
 stephen@networkplumber.org, davem@davemloft.net,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] hv_netvsc: Switch VF namespace in netvsc_open
 instead
Message-ID: <20250714182914.27c94a91@kernel.org>
In-Reply-To: <1752267430-28487-1-git-send-email-haiyangz@linux.microsoft.com>
References: <1752267430-28487-1-git-send-email-haiyangz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Jul 2025 13:57:10 -0700 Haiyang Zhang wrote:
> The existing code move the VF NIC to new namespace when NETDEV_REGISTER is
> received on netvsc NIC. During deletion of the namespace,
> default_device_exit_batch() >> default_device_exit_net() is called. When
> netvsc NIC is moved back and registered to the default namespace, it
> automatically brings VF NIC back to the default namespace. This will cause
> the default_device_exit_net() >> for_each_netdev_safe loop unable to detect
> the list end, and hit NULL ptr:

Are you saying that when netns is dismantled both devices are listed
for moving back to default, but the netvsc_event_set_vf_ns() logic
tries to undo the move / move the VF before the netns dismantle loop
got to it?

This needs a better fix, moving on open is way too hacky. 
Perhaps we should start with reverting 4c262801ea60 and then trying
to implement it in a more robust way?
-- 
pw-bot: cr

