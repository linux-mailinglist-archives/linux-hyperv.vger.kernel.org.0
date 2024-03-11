Return-Path: <linux-hyperv+bounces-1704-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE34E87842F
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Mar 2024 16:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 975FA282F5B
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Mar 2024 15:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05B744C86;
	Mon, 11 Mar 2024 15:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpGMOAXp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3554122D;
	Mon, 11 Mar 2024 15:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710172288; cv=none; b=KUOypfXMKv3iE6R3dMLXBl1hkCEEFbBNeyWOYWRFLZ8kfBn0xI7nPDE8ahUs5wpDTlywEr93p7F67iMTlhkF2u6ISclGeHQCMJwHMRVZsG+ygwWrCK/DbATnvJrcW7n/kKdWNV/GL93dKPfRUfww0TRCBJPyqmMEus/O8/NIPOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710172288; c=relaxed/simple;
	bh=XNWhsq6o7ciElMMRkGWuW4CuG+Gx1UWKBsIqAvIJeAw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KtFK7hxPntoExM1XF9kgwTTp0PQ2amfIqX5Vf9gEGzWBM+HUHC1jQshPR233lvucnSfavV41DDN/6+WEFKvFnG2b5HoXl7oxWrKWeHwYweWgcfi8R8GtYcXHTd66f/sNC18Hs9fZAJLWb5RmIlVc4jhZcBeBVpu3cIYSMNOg9VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpGMOAXp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4A9C433F1;
	Mon, 11 Mar 2024 15:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710172288;
	bh=XNWhsq6o7ciElMMRkGWuW4CuG+Gx1UWKBsIqAvIJeAw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kpGMOAXpJd25+8/IDUvs7hkHrVGyOW6NfVYglOWk/RwNhFzrQ2GSeud23Rm9VZO7R
	 9F5zSzq4yGwAucDuKT86FY5pN/TzwGALGUogfrEKZkHdHumPRyPbO2WOurexMIkB2I
	 8Pij0GupcDlvtw3rJSwiHrbT9o6scfcuhAm+8gMiPtZl/A0humI6ohxO411uSVmH7B
	 Twz+tHq368LwzdhzMxzrcM16Bvx0rQCoFcnWWFjhov/kHYK8H+GQoUxJjGxbIF8bNL
	 cVLLGZzvcUy1V2KMIGmSCjMOuqnEaNyO+hgyWmE69rKeg4/ntNG7NVC0hKay5M4u8/
	 e67Ax6Uk7zMiQ==
Date: Mon, 11 Mar 2024 08:51:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Shradha Gupta
 <shradhagupta@microsoft.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
 <linux-hyperv@vger.kernel.org>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Ajay Sharma <sharmaajay@microsoft.com>, Leon
 Romanovsky <leon@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, KY Srinivasan
 <kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, Long Li <longli@microsoft.com>, Michael Kelley
 <mikelley@microsoft.com>
Subject: Re: [PATCH] net :mana : Add per-cpu stats for MANA device
Message-ID: <20240311085126.648f42e0@kernel.org>
In-Reply-To: <20240311041950.GA19647@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1709823132-22411-1-git-send-email-shradhagupta@linux.microsoft.com>
	<20240307072923.6cc8a2ba@kernel.org>
	<DM6PR21MB14817597567C638DEF020FE3CA202@DM6PR21MB1481.namprd21.prod.outlook.com>
	<20240307090145.2fc7aa2e@kernel.org>
	<CH2PR21MB1480D3ACADFFD2FC3B1BB7ECCA272@CH2PR21MB1480.namprd21.prod.outlook.com>
	<20240308112244.391b3779@kernel.org>
	<20240311041950.GA19647@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 10 Mar 2024 21:19:50 -0700 Shradha Gupta wrote:
> > Seems unlikely, but if it does work we should enable it for all
> > devices, no driver by driver.  
> You mean, if the usecase seems valid we should try to extend the framework
> mentioned by Rahul (https://lore.kernel.org/lkml/20240307072923.6cc8a2ba@kernel.org/)
> to include these stats as well?

"framework" is a big word, but yes, add a netlink command to get 
pcpu stats. Let's focus on the usefulness before investing time
in a rewrite, tho.

