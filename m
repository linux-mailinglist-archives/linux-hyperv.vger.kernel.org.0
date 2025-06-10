Return-Path: <linux-hyperv+bounces-5835-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FB2AD460D
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Jun 2025 00:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DCC9189E3BD
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Jun 2025 22:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DC32868AC;
	Tue, 10 Jun 2025 22:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZ3HR1Wv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00826248F74;
	Tue, 10 Jun 2025 22:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749594939; cv=none; b=AnPYNgbaH28GaxvpoBHhWCvFcN1/cqVk+V6GC/Dm5WlO4DHbQbgXgTYVZByT/ZnMoWx6D8hupgxAGxGQnyh8Qr58Tw/9n09sBI9EHFT1aF0X4dgUu2uJHSkQYbUn1p8LdtTRv3HC6fTAoAAmEUCpGCTiuC1AHaT4c/L/RUpL//s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749594939; c=relaxed/simple;
	bh=4/j43Zu0GL7ig2H6mfd+D0Go2TbiM72gN9/cHaPFpys=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p2t13wStAPQkaENMjCPT+b+7Nv8WXMfjcWW6vuf83a/yOvr3UCbya0vQupD/kc7Q6DOjsyp8xKXgCLP97kqQXO7GtoSrNmyjWUcY4bZuwpDvF/M8D2nGzmFGqH71G7a92K7bbP1tm6zbizs3qPjyeRoeWu1S1O1vDJSIVjeee3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZ3HR1Wv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE2B3C4CEED;
	Tue, 10 Jun 2025 22:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749594936;
	bh=4/j43Zu0GL7ig2H6mfd+D0Go2TbiM72gN9/cHaPFpys=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mZ3HR1WvCKa33xdcXVYbE6utkjLLnDVYJEfLFRVDyMYU3h7xtoQLWYg093qRYIsfM
	 702nFmtpaaOn+kijo8h4cLXhIDR8FaMziah2KcAFYZr4PMsfufJHA0AbBHpa3Bt+b3
	 BKwVlSTt4XeBN8mqEsAa3YT3HoS17EZ2HmdSq3DvKhBP+kahlVjyjtCyizWiIbzY5F
	 rlp9g7hX87aZSfD2qptConTnYP59+JHOXVdyVIAMUVfBjVrQa/HFfO1fO+OwsLVWaf
	 BIqoaYBh+nqFqIBEhH9GMK6wg9s2umLKr3bMnx8zuVsHVXo9njGggczkEsmRM0+npE
	 OVDAws/s3DjTQ==
Date: Tue, 10 Jun 2025 15:35:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: longli@linuxonhyperv.com
Cc: longli@microsoft.com, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shradha
 Gupta <shradhagupta@linux.microsoft.com>, Simon Horman <horms@kernel.org>,
 Konstantin Taranov <kotaranov@microsoft.com>, Souradeep Chakrabarti
 <schakrabarti@linux.microsoft.com>, Erick Archer
 <erick.archer@outlook.com>, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next] net: mana: Record doorbell physical address in
 PF mode
Message-ID: <20250610153534.0011c952@kernel.org>
In-Reply-To: <1749510580-21011-1-git-send-email-longli@linuxonhyperv.com>
References: <1749510580-21011-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Jun 2025 16:09:40 -0700 longli@linuxonhyperv.com wrote:
> From: Long Li <longli@microsoft.com>
> 
> MANA supports RDMA in PF mode. The driver should record the doorbell
> physical address when in PF mode.

Could you explain in more detail what happens if it doesn't?
What user-visible improvement does this patch bring?
-- 
pw-bot: cr

