Return-Path: <linux-hyperv+bounces-6181-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDB5B0033D
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Jul 2025 15:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD0861C454F2
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Jul 2025 13:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8B12356BA;
	Thu, 10 Jul 2025 13:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aLZp32V0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CMmyK+8X"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC07235355;
	Thu, 10 Jul 2025 13:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752153772; cv=none; b=pXIUTMrx0ZaO+0rk/OrCBn5LYvKf6WhKhErkeRkLbRkhrTzKcjRqeTd0zW9JVAGEUDX5eqmJ7XzWVRhyet5hpUppCTGGJ3qFlAAnEMfqQDz7pXvysVkq/0GGfS2CbGBOgL4hPPNSfYzekFiNh3yb4WQ/XaYTAO+0IyDme5Gawtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752153772; c=relaxed/simple;
	bh=7QIsPK3mzOmwlxDTxQ2TDkWR31pvi1CnlsU7S+GHllU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZaB8FdDn4bZ/b+yuj6/FHbzxMI6oLDwdPthgWyk/yC/IFlRvqjc2cBmfOc4Red8fmAIbt+WGEXxLy1/NQRXnhxlYa7X6d3TcyGGoDc9oTaYt0b4DEnrlaoCYvGBixQ0V531Cp8EGHzh8JrHC2hftF2yeLb2FGzWcBXWm9XoSuF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aLZp32V0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CMmyK+8X; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 10 Jul 2025 15:22:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752153762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ONkY7ypCOC2VTFmOQMwyjVwi1ZdUs1CD2Tg1G47272k=;
	b=aLZp32V0SgOC4KTKT9y1UErztjM0/hfdH/+FeL+CtdXgC1Lmawxy+cB+EHQRvPjeoghCge
	4J3Tu9oUsAi+LvVTR3b7eASSzC/NIHQOACzyCwmJnY1V2ZHP231BTK9FiYl/zC5SYS20Xh
	NLu1QI7TNpkgD/XaluqCX8azoyOueuPKZWNe926i57+Oh3wQmLLtTw3scsGxaf82/TkS2W
	OQaNqETnOe6YJ6lp3sVUHdLSm9OVJLMuWMc5pVjP5kaZK0k1WaXmsmmvCU60a+oobwvqlL
	2K93glxAi6PFmlQ0BYW2+VRpR4bK+4m6op05opuGhmndsJxi2SJw2s0PJrvSIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752153762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ONkY7ypCOC2VTFmOQMwyjVwi1ZdUs1CD2Tg1G47272k=;
	b=CMmyK+8XzJgF+pPNzrAX/fEz0QhbRmq0EdASIY5RMA7JYheH5tEKnjsTYZnmSGB0Rk/uTI
	uznMY6BF2/7e9mBg==
From: Nam Cao <namcao@linutronix.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: "open list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Simon Horman <horms@kernel.org>, Marc Zyngier <maz@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for-netdev v2 2/2] PCI: hv: Switch to
 msi_create_parent_irq_domain()
Message-ID: <20250710132241.Wo6NATNQ@linutronix.de>
References: <cover.1751875853.git.namcao@linutronix.de>
 <7b99cca47b41dacc9a82b96093935eab07cac43a.1751875853.git.namcao@linutronix.de>
 <SN6PR02MB41577987DB4DA08E86403738D44FA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <505fa40f-ba51-4f6e-9517-af3e7596a1cb@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <505fa40f-ba51-4f6e-9517-af3e7596a1cb@redhat.com>

On Thu, Jul 10, 2025 at 03:11:36PM +0200, Paolo Abeni wrote:
> I think this series could go via netdev, to simplify the later merge,
> but it would be better to have explicit ack from Hyper-V people.
> 
> Adding more Microsoft folks.

Right. Sorry Microsoft folks, I fumbled my scripts and didn't Cc you in the
patch.

Nam

