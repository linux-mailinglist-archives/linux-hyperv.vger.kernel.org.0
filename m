Return-Path: <linux-hyperv+bounces-7379-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25446C1E0EF
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Oct 2025 02:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D46AD3A66FA
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Oct 2025 01:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834072DBF69;
	Thu, 30 Oct 2025 01:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OHHgj6p6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D9D21ABA2;
	Thu, 30 Oct 2025 01:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761789150; cv=none; b=Yn7bBGcGkKE+aH0S+mbGg3/gpf3sGmtXyc2oQHmR3j+CBSNhOun8bn62ImtesCY+6u+fmZNbMhKW0sY1/MoZMQ1gfY5a8G8eV1eocvK1Z+B7xZU+K3CzSdC/VRuohf8duwuYKXWKK1V0l24V84WkcUlgQhCI8Yka+OCm6JIpxrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761789150; c=relaxed/simple;
	bh=Ic9O0/2u74wHwW8wBGsNLD2iRerNjlVMf5m0rfxMtTc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rIqlACXA7NGLXKMSR0VeXXUBFtADijy6o+Rh774CpPPwGZawrJqG583ZRS9A72b9On3QTZ2frMpnqiNB6y0WqYhAchTxorgBb6O1C2ZqHMkHuz9ubAg4/Aeth67auLCrlWjp6S3yHOmg7HTT0gVV8Wzaff/SduDJPefL2I/0hhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OHHgj6p6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E27FC4CEF7;
	Thu, 30 Oct 2025 01:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761789149;
	bh=Ic9O0/2u74wHwW8wBGsNLD2iRerNjlVMf5m0rfxMtTc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OHHgj6p6QF2rK3ts0WCBIBqsMJu39Iqj5nk/6WMLl/Z5OvjY6QZyI513GNE47hR6k
	 2cWh3pS2lltyEUhczP/mk+V7qNdJKVdwEIEwW48/fkyobyn2vjTsxm0gAhFCmtjEN6
	 XKpXraZ2BDbr0npXQAsdXMgxmuAJzhBPA4WbLeg9DVIvzZExMsmoYmwpv7w0IxaojM
	 nuDYWq1UNOZknGqkRkT5X3Ny7eWazuZB8AA4zwXsG6jml9pEGIstkcXK3Lrjt3jJ7Q
	 M77RDbMYqyd/UeeairCBtumpZXNkqGH4qqoo8o1fG/BlgSrN7wO5duGqyFbH2a66s9
	 4kOZUT+2QqSHQ==
Date: Wed, 29 Oct 2025 18:52:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, shradhagupta@linux.microsoft.com,
 ssengar@linux.microsoft.com, dipayanroy@linux.microsoft.com,
 shirazsaleem@microsoft.com, kotaranov@microsoft.com, longli@microsoft.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: mana: Fix incorrect speed reported by
 debugfs
Message-ID: <20251029185228.0c2da909@kernel.org>
In-Reply-To: <1761735154-3593-1-git-send-email-ernis@linux.microsoft.com>
References: <1761735154-3593-1-git-send-email-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Oct 2025 03:52:34 -0700 Erni Sri Satya Vennela wrote:
> Fixes: 75cabb46935b ("net: mana: Add support for net_shaper_ops") 

I've preferred this without the fixes tag, TBH.
It's debugfs, nobody is supposed to be using it in production.
-- 
pw-bot: cr

