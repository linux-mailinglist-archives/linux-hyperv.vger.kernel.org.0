Return-Path: <linux-hyperv+bounces-4992-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D9BA959FE
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Apr 2025 02:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D42E16635D
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Apr 2025 00:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4103376;
	Tue, 22 Apr 2025 00:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TysWquBb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84F6DF58;
	Tue, 22 Apr 2025 00:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745280231; cv=none; b=nWgUatSQFu1jyvXa7F9aIUwnsNcUQ7u13DTbjRNoUvQvNHxfz1fMZI7ZZl98QlRUsPEoUQz8tKjDFY/CLuJrbD9WNNscWBw3vyLam4MHtjvuTGu4W0SHPA8CqWFS/DStsamCtPRiLat76Z+9qbOLuM5ke4kLRfO44LFA5hbXuLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745280231; c=relaxed/simple;
	bh=ByXM9NwhLFSE7cwLmMnQdf3Y/z48xuxLc5CpTPHWd8E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sj3+tgd43yPgJgg/V8tuhlvqdjQQlyhenED9zgId/Uvp7fAK95dG9t/jlMB5iedRK9nKyodYyregs6D4+Ut4ZwNQwq7Lryq9TYCT3pKh8ftqhmUi5Zwz1nwrmjt5HI8Feim+Z+FBbQ3+WqhUsoRrqh0YUK/Id36iq+pLh0Hm1gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TysWquBb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D231C4CEE4;
	Tue, 22 Apr 2025 00:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745280231;
	bh=ByXM9NwhLFSE7cwLmMnQdf3Y/z48xuxLc5CpTPHWd8E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TysWquBb8nGwZpbr/arQtdRMae5KhBFd2ZpyWCcnUHoR3UrCUEoDqU9isnIgRM7h2
	 hkncZot2SV5UDJXVU6oH1tu2LYMi5xwHGvS2fXYfuX5+AwKn+Au23FYxO28WmvQW2N
	 NwsTdO+vJYtzk94+26Zbu5Hzjdj9DCbgso5VpuZ8xyiB6pn9C7IAr1Szgr5JgxnjcF
	 4aDX7EHxoCdCbH2pgLd3Uq502Ill+BA0U3s65jgVcYxr+q9SkBm9L8GSKIWEHFJgla
	 RMEd14cK5LpxzO0Jtxi9XKbJDn4d29tgLsF77ct9/zWQuLNwIt+FbH3EhYzzI/Kv9V
	 7iS+UM/9NK5ZQ==
Date: Mon, 21 Apr 2025 17:03:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, longli@microsoft.com,
 kotaranov@microsoft.com, horms@kernel.org, mhklinux@outlook.com,
 pasha.tatashin@soleen.com, kent.overstreet@linux.dev,
 brett.creeley@amd.com, schakrabarti@linux.microsoft.com,
 shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
 rosenp@gmail.com, paulros@microsoft.com, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] net: mana: Add sched HTB offload support
Message-ID: <20250421170349.003861f2@kernel.org>
In-Reply-To: <1745217220-11468-3-git-send-email-ernis@linux.microsoft.com>
References: <1745217220-11468-1-git-send-email-ernis@linux.microsoft.com>
	<1745217220-11468-3-git-send-email-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 20 Apr 2025 23:33:39 -0700 Erni Sri Satya Vennela wrote:
> This controller can offload only one HTB leaf.

This is not a reasonable use case for HTB.

If your reason not to use the shaper API is that there is no CLI
for it perhaps you should add one to iproute2.

