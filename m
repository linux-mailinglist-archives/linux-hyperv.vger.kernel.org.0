Return-Path: <linux-hyperv+bounces-6349-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFEDB0E83D
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Jul 2025 03:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 824EC1CC0BF8
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Jul 2025 01:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44F318D656;
	Wed, 23 Jul 2025 01:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhTgRdqF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7808382C60;
	Wed, 23 Jul 2025 01:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753235075; cv=none; b=GiY50poJcWpz5PqtHWhvJRxohk8o+/9WqO15CtRjry63W1J1wvp7MjHiHiIq/wJkEgabY/mvV8/lz0GbEBVPE2YkUyAEngAM2jEuZh1fX6Dc7uYuy2AGeDHv3xs++os+cBWE1Blhu67crN3ngqAJuK8p3XKEkI2URZof82xf4Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753235075; c=relaxed/simple;
	bh=bg+FuJXnf5/pwiZWY8Lvl++Haa5Bn7sNvuLdW5dqKrY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BouKlsgXFcGQazpiSvlxo9Xb3N4MfnCvzlR5tNrr/fEosXXW5bj3QfdK7EIicyYTmhspiZL6AZ6eeaH2VCjycBs55/jD6BR4L8Aq5YBBprnDXYLLXUXoovC9GdnFVy52BHAkeqidCCMhGbuhhyZnslhvEoMe2z9LtudtQVl1hVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhTgRdqF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD57C4CEEB;
	Wed, 23 Jul 2025 01:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753235075;
	bh=bg+FuJXnf5/pwiZWY8Lvl++Haa5Bn7sNvuLdW5dqKrY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZhTgRdqFo5srui6QNNPKt6OhHYmrKnuB+hwskQMWYgkMb6wPG1F1isQI7OHCdYSlo
	 Ll2PUgOOeLBfhY7OINLgAI9FTpN07qJ2cmcFzJEBBy7iHmXYKLow697TJiUOdaLcAI
	 F76ejHtWG0TOQTcMmCaYJEsrmr/CUy5KvD5OkQKsVc110PEJNVGRWkkmLoI3dMqIw+
	 ++hfPkyqP/CSNEs0ZFIlBppVz2jiuWfJ+wXQe3uxe8rq27iWQ3mHtOAfoPpmE7nX0G
	 sfJ1aMdn98F58z41t/G7seEsjHR4mx29NVu2dK2koZIRnxOfSvUQBnCoVAyQXIKcFR
	 Cl1ZUgvYTyuVQ==
Date: Tue, 22 Jul 2025 18:44:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Haiyang Zhang <haiyangz@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 haiyangz@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, sd@queasysnail.net,
 viro@zeniv.linux.org.uk, chuck.lever@oracle.com, neil@brown.name,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 davem@davemloft.net, kuniyu@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net, 0/2] net: Add llist_node init and fix hv_netvsc
 namespace error
Message-ID: <20250722184433.2b951171@kernel.org>
In-Reply-To: <1753228248-20865-1-git-send-email-haiyangz@linux.microsoft.com>
References: <1753228248-20865-1-git-send-email-haiyangz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Jul 2025 16:50:46 -0700 Haiyang Zhang wrote:
> Add llist_node init to setup_net(), so we can check if the node is on list.
> Then, fix the namespace callback function in hv_netvsc.

Can you not do the moving from a workqueue? Schedule a work, let the
stack finish what it's doing, take rtnl_lock, do you your own moving?
-- 
pw-bot: cr

