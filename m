Return-Path: <linux-hyperv+bounces-3048-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EB497C469
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Sep 2024 08:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79E911F244E9
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Sep 2024 06:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384DA18DF6A;
	Thu, 19 Sep 2024 06:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjF5mtRt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E73D3FBA5;
	Thu, 19 Sep 2024 06:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726728486; cv=none; b=E2o9z/5LSligLOsnOfRBNDW0C0YFNgqJOBZZA5lRSCosYB6TxvO/xtF1f/+TXEOULQeNp/j2gygfaArbMIQfaBA3NtegbGUy76ku4JzE7XE5PYj32afLhnmEvDIILffN66XiJ70NaWvVqLIsIs3Gn3O7NN7yfFUxwx3/Q8fvYGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726728486; c=relaxed/simple;
	bh=l8QuQExTIALeEogvOZYS7ZFTbRcrL+7Jen45HIbIHJg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=AS4y+dKPK5LC4zyCzMgkbHI/KO6OZgX8PkZrEx8wb+xDJOU1O8XHhADySK/2ccqvDdJ3w5fSkog0+PVbiwazfY5FJWSUYaVOZibZFtxYRe8EHze513USGl9C4PAv/2ANCVbqB38KP7XOrTO+PkoqGITAGHWnzocI4fvD8yFdr7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DjF5mtRt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4089C4CEC4;
	Thu, 19 Sep 2024 06:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726728485;
	bh=l8QuQExTIALeEogvOZYS7ZFTbRcrL+7Jen45HIbIHJg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DjF5mtRtPP1DryiMKTpyzxa7FzZC9bFybST0raRYWwFuHS/neBnFCUxW0ZC+uv/6Q
	 WEabu9FhqmX3RZMhbtxL//EY878ISsO41hzHClKmMyq03f+cq+A63sug/SlTQ2nQiQ
	 imDWfCkVOcG00kS7LlnDnITwLdhs8gv9UGXpZwMMRTZDaxMrJ8P60JIa+xP9p/gbaU
	 OIRfg5Q6LA6SXpGYOpIau8sb9jBrSHcykRC/jR1TXFHBSbLkeT8MdFMggtBwUasCcN
	 LSqwNdiGzJFDd/l1Z0okoRVDOrLDloqqRstQnANyOGl9JgVfRlOKpDq4TXK2uHJrpF
	 PwZbeVbDXvY4w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0213809A80;
	Thu, 19 Sep 2024 06:48:08 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V next for v6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZujPjfi61CEVvhw3@liuwe-devbox-debian-v2>
References: <ZujPjfi61CEVvhw3@liuwe-devbox-debian-v2>
X-PR-Tracked-List-Id: <linux-hyperv.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZujPjfi61CEVvhw3@liuwe-devbox-debian-v2>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20240916
X-PR-Tracked-Commit-Id: 94e86b174d103d941b4afc4f016af8af9e5352fa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1d7bb2bf7ad8c95cd50e97a83461610385b5259d
Message-Id: <172672848758.1360580.9472539844905759378.pr-tracker-bot@kernel.org>
Date: Thu, 19 Sep 2024 06:48:07 +0000
To: Wei Liu <wei.liu@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Wei Liu <wei.liu@kernel.org>, Linux on Hyper-V List <linux-hyperv@vger.kernel.org>, Linux Kernel List <linux-kernel@vger.kernel.org>, kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 17 Sep 2024 00:38:37 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20240916

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1d7bb2bf7ad8c95cd50e97a83461610385b5259d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

