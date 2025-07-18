Return-Path: <linux-hyperv+bounces-6304-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA3CB0AC97
	for <lists+linux-hyperv@lfdr.de>; Sat, 19 Jul 2025 01:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3AF67ACD17
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Jul 2025 23:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BF021CFF4;
	Fri, 18 Jul 2025 23:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mj4qVPGm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EC15479B;
	Fri, 18 Jul 2025 23:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752881844; cv=none; b=eBHWs8hoX8q1HggxEYx4Sv5WfcYggo8/wHaLijsH9fFS4w+97IpGv/2fEvqHhn9G66pa89OTJJeOv1HkA3ZwTRusEkSOzUFmRPhZ1ze+VdPKn4IwH9LgLKgOV2KWvGd7l2UN2GFb1u0CXHZPKXfRJUTbmJCv03P547g8T6OQaKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752881844; c=relaxed/simple;
	bh=i/DZrEEXHs8Q2rMc5+5X5kEhFG1UD6Uqa/oIKPuu3sk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fgFXngTAIZ5KtcgCPJcEwGw9QBnOA15LLfYjn8xALblvidc4L2k0OkLji/l/RrN8hG+yk6kejijRcEbX0RQtdcykE2fXcBRyPN/5vQxXnySC5KjsfwV4iyaV5BRyYJsMmwWtdf4qSjtMjmxCSBjoEoMCW+uA9jXHsI3S0Aun8fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mj4qVPGm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE177C4CEEB;
	Fri, 18 Jul 2025 23:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752881844;
	bh=i/DZrEEXHs8Q2rMc5+5X5kEhFG1UD6Uqa/oIKPuu3sk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Mj4qVPGmWmNQQrdnHAUdYzajX0sjKDMW40Eo97OX5sQwSOfHNgE7rPJq3SE9GQ009
	 S751fReuKalJHFKOUAZMXH/OlvLbmCLwlLJoEF3/AXjQsggREFe5gdHKd8241bGvON
	 oQ7YeDMkM/lAShwlB5f0CyPF+S+G7N08LDprISYGvztBj1b0pBUYGOD1g3ONVtq8P1
	 p6RA6my4+NXMXO8fXICdG2tay9nH83+9WDBIkNIqIhrf4WpknNKuw4OKWc/Yugikar
	 /4cAMRWST2ccjcMfoth4CJ3JIubteRouFFEGcFV6W5gYCcpaZVbyTtjK8ZI3/OXSoc
	 o7quIgv6QzsdA==
Date: Fri, 18 Jul 2025 16:37:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Haiyang Zhang <haiyangz@linux.microsoft.com>, kuniyu@google.com
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 haiyangz@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 davem@davemloft.net, sdf@fomichev.me, ahmed.zaki@intel.com,
 aleksander.lobakin@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: core: Fix the loop in
 default_device_exit_net()
Message-ID: <20250718163723.4390bd7d@kernel.org>
In-Reply-To: <1752870014-28909-1-git-send-email-haiyangz@linux.microsoft.com>
References: <1752870014-28909-1-git-send-email-haiyangz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Jul 2025 13:20:14 -0700 Haiyang Zhang wrote:
> The loop in default_device_exit_net() won't be able to properly detect the
> head then stop, and will hit NULL pointer, when a driver, like hv_netvsc,
> automatically moves the slave device together with the master device.
> 
> To fix this, add a helper function to return the first migratable netdev
> correctly, no matter one or two devices were removed from this net's list
> in the last iteration.

FTR I think that what the driver is trying to do is way too hacky, and
it should be fixed instead. But I defer to Kuniyuki for the final word,
maybe this change is useful for other reasons..

