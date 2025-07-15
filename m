Return-Path: <linux-hyperv+bounces-6245-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76277B04D76
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Jul 2025 03:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 134A57AAD9F
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Jul 2025 01:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0CF1ADFFB;
	Tue, 15 Jul 2025 01:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8wURV+y"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CF086337;
	Tue, 15 Jul 2025 01:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752543163; cv=none; b=I/ROo+7bLGBwxAGl4sE1euTjSfpg7xjIgl39o2doAw8uw3y5WaN88nIhke+aKYBpPUtYbEWcrcxkeHJgneM7yxeb7asHATFwXuvzmAjllxaI79lrb4CrRlMKxGt8VB8W3l1QsPi1dRx/GLf1NLR1LlfPAz5OSWmoYpbK45b+zoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752543163; c=relaxed/simple;
	bh=4X9PMiQSHXCuAFU/Rgaom9rSazS9ZHJ9k7UyTvWMp94=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jp+m78qjPSKKBb6F5aaHGrCE4f+CafZ4bPNYU35Y/+rn74ugOpZhxt1yp+0afxJCwWp1JBsKJ54PoBc6AAESlRGSfGPVJXo6Ux5CXrklZJPbkpSXVT/nKA1fZ8EkMFzePDxiubHje+/InER+RZpNvtX+ceWXUHz6ttYvBs0fAu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8wURV+y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E47DC4CEED;
	Tue, 15 Jul 2025 01:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752543163;
	bh=4X9PMiQSHXCuAFU/Rgaom9rSazS9ZHJ9k7UyTvWMp94=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P8wURV+ywM653PShMtixhFGZMmr7y2kEwCb8uoHCLf11cXNwQYGhXhlP/ewn/Ke4u
	 ZnU5Uux/88e1QOPjyISQG/bMbdsHkxeFlwM2bbViwxx+aSWM575oFW2TTbh6O2oVTL
	 IC9nnwafySl0IPAx1yfr87pkWXfzCGjYd9GjM72lJ8eIrLnwyIUikr2WtmuwWTF2VW
	 VVr/r0PBByd2OBik+6zOeXdpsjZaxCLSW7I8wVAi5BQb1ojwtzy2F7BBUwR8OrxIvP
	 +KkCS+F/Ey8FA6ECQavARIQpF23OBrLKfCgwU0CA1YZEDtPRWsN5wbrkphdpV3J/4v
	 FCgU8gZoPpybA==
Date: Mon, 14 Jul 2025 18:32:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Li Tian <litian@redhat.com>
Cc: netdev@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>,
 Dexuan Cui <decui@microsoft.com>, Stephen Hemminger
 <stephen@networkplumber.org>, Long Li <longli@microsoft.com>
Subject: Re: [PATCH net v3] hv_netvsc: Set VF priv_flags to IFF_NO_ADDRCONF
 before open to prevent IPv6 addrconf
Message-ID: <20250714183242.58bf076f@kernel.org>
In-Reply-To: <20250712100716.3991-1-litian@redhat.com>
References: <20250712100716.3991-1-litian@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 12 Jul 2025 18:07:08 +0800 Li Tian wrote:
> Set an additional flag IFF_NO_ADDRCONF to prevent ipv6 addrconf.
> 
> Commit 8a321cf7becc
> ("net: add IFF_NO_ADDRCONF and use it in bonding to prevent ipv6 addrconf")

This line looks quite odd, it's in the middle of the commit message but
it's not a real sentence. If there's a single Fixes tag I usually refer
to it as "commit under Fixes", e.g. "Commit under Fixes changed XYZ but
it missed .." Please make this commit message read like a coherent
explanation rather than set of notes..

> This new flag change was not made to hv_netvsc resulting in the VF being
> assinged an IPv6.
> 
> Fixes: 8a321cf7becc ("net: add IFF_NO_ADDRCONF and use it in bonding to prevent ipv6 addrconf")
-- 
pw-bot: cr

