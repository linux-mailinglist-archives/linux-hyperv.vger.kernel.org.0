Return-Path: <linux-hyperv+bounces-5996-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD94FAE7351
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Jun 2025 01:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BB6C7A1192
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Jun 2025 23:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888E526B75E;
	Tue, 24 Jun 2025 23:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/sGf/6l"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB7F26B08F;
	Tue, 24 Jun 2025 23:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750808024; cv=none; b=cwYztOJjs3S+mh3EUugUevTW9fG26IlhbHuFgdSp8CHlDgT2+eXxhdbIjmGEds6yyAQixvWAPGw2XBCGdlEs1Xb8T6fIUjyWH14wI5oT0k10HwoRHS/G4bMjERn0KX6JBky8BLiOH9CrX/I4Fh3WCFkjwkiJCcDASr6Bp34kZO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750808024; c=relaxed/simple;
	bh=4avPtNtUoxb/+S1f/LWKJnt3NGHmsFwhH6VG8MXb3TY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N7MczX4moa1wSKOfwygV93iti6NaxGfTc37fbDBvzzZUyJEZ3I+bQ0mi6CwP4prfDoiiLuzp1zzSP/W9KD7eTs9yotykclmdYSylpgjGuxrGtdXijjStR0+Xgv6XtPhA5KEJ2GwD2hfP7JJAOeMkpM3OoScyuphrGPy8KjEK+OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/sGf/6l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C33C4CEF0;
	Tue, 24 Jun 2025 23:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750808023;
	bh=4avPtNtUoxb/+S1f/LWKJnt3NGHmsFwhH6VG8MXb3TY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A/sGf/6lrXD5CY75T4xTGmGAIT3S26/DltWsHtAQCkh67GFVoPBd5reVEQSdHgEyA
	 iWthSz/LVg1mfXgdalUx+uqR2trMVzLyi8fijVC1/jisUqNHwZWLzh9nZTVwu5udSf
	 nyMgMiWfEOTcHYFRnZb1qz0GAHqeiHFP+ml96iiCQ4k5yK5l9auEDDyb2IfG0cr5q+
	 52h59xqdhuKJF/FY468A98Lb5tPXLdty1g8T22By1MCsrrKUbbNeUP5ppGKEf5NG7B
	 c7WprHBDavv8tROCteM32kUeF1Sqaj2eU7vypzXhUFvqVjbuPSkNZm5xa4p5jEcLO2
	 cRTyJ1yo86m3Q==
Date: Tue, 24 Jun 2025 16:33:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, shradhagupta@linux.microsoft.com,
 longli@microsoft.com, kotaranov@microsoft.com, lorenzo@kernel.org,
 shirazsaleem@microsoft.com, schakrabarti@linux.microsoft.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: mana: Fix build errors when
 CONFIG_NET_SHAPER is disabled
Message-ID: <20250624163342.754f5b64@kernel.org>
In-Reply-To: <1750677241-1504-1-git-send-email-ernis@linux.microsoft.com>
References: <1750677241-1504-1-git-send-email-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Jun 2025 04:14:01 -0700 Erni Sri Satya Vennela wrote:
> Fix build errors when CONFIG_NET_SHAPER is disabled, including:
> 
> drivers/net/ethernet/microsoft/mana/mana_en.c:804:10: error:
> 'const struct net_device_ops' has no member named 'net_shaper_ops'
> 
>      804 |         .net_shaper_ops         = &mana_shaper_ops,
> 
> drivers/net/ethernet/microsoft/mana/mana_en.c:804:35: error:
> initialization of 'int (*)(struct net_device *, struct neigh_parms *)'
> from incompatible pointer type 'const struct net_shaper_ops *'
> [-Werror=incompatible-pointer-types]
> 
>      804 |         .net_shaper_ops         = &mana_shaper_ops,

You have to add

	select NET_SHAPER

to kconfig dependencies for the driver. This symbol cannot be selected
by the user, its hidden from the menus.
-- 
pw-bot: cr

