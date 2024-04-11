Return-Path: <linux-hyperv+bounces-1959-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C99778A228C
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Apr 2024 01:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E71C1F233C7
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 Apr 2024 23:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DC448CE0;
	Thu, 11 Apr 2024 23:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfSFX4OI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C0748787;
	Thu, 11 Apr 2024 23:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712879040; cv=none; b=QdtTn9DauDKOd8SSIXZW3UBF1B0sxd8Y8fgTk1RZQJFUZS6I45Doxc/EO7vQRy6YGoPODIf7t5VuDA9DOJDg2n61LB5EycBdbrixhe6lZvgQgH9QWthHEGy0QDZ2bS8XJmdYXeAZYrhUkM4yS3HMilaXtXuMbBcAPZz78HXcID0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712879040; c=relaxed/simple;
	bh=92/ta+eUUDq3ed7mZzfQylMxmPphmjEUg08yLQjQeHY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JAk3TLfdzXm90D4CHHbue12a4KALcvvVoyQJYG0OK1pt0Nw0jlNRY+2WK5lhZyyj17ExINbG11UonbPyAj4EfIPEexpchAtmkJD70d8SPNjVwO76i5cP6CJ7MfYIS96XTAONFHZpH8j31PujjWT1bkaxkyIF1PMSpDAksfE9nms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IfSFX4OI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27533C072AA;
	Thu, 11 Apr 2024 23:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712879040;
	bh=92/ta+eUUDq3ed7mZzfQylMxmPphmjEUg08yLQjQeHY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IfSFX4OIRaBaKzfhfzpXcuwBVIz/PUIaY3O+ovvrdsb8emdap6GskJamWyDgecylT
	 0N2+kp31A5L2z1YgN3Jr0ZlClfg3Kooo6p77J3TbL+NmFj64Pjqv82sgtlEjB2rE/3
	 PRTPAhofmZVYQBOElGDlKc1Qmr1ARa1tv5MiTzTKHi1Ru0K34jv9e/pb6ffFi6ibfs
	 Idm9Di0ykHxXEFZVMiwUvPtV05izbF3MhIMCimYLbPnk2rUauRO1MSTjR+TTO9xHf4
	 62+5qJCBwVoQYDIy+osml2xG/woA7WKu+6uRQ2YOLvMGHdNtxO2yyZOYKm2BTPffJi
	 hSgg/oemILQmQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 17455C433F2;
	Thu, 11 Apr 2024 23:44:00 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V fixes for 6.9-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZhhmLy_V-B97jAaQ@liuwe-devbox-debian-v2>
References: <ZhhmLy_V-B97jAaQ@liuwe-devbox-debian-v2>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZhhmLy_V-B97jAaQ@liuwe-devbox-debian-v2>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20240411
X-PR-Tracked-Commit-Id: 30d18df6567be09c1433e81993e35e3da573ac48
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 52e5070f60a9a159dc4fe650408fc6ecdf7bfe51
Message-Id: <171287904008.19771.4430716406158768353.pr-tracker-bot@kernel.org>
Date: Thu, 11 Apr 2024 23:44:00 +0000
To: Wei Liu <wei.liu@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Wei Liu <wei.liu@kernel.org>, Linux on Hyper-V List <linux-hyperv@vger.kernel.org>, Linux Kernel List <linux-kernel@vger.kernel.org>, kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 11 Apr 2024 22:37:35 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20240411

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/52e5070f60a9a159dc4fe650408fc6ecdf7bfe51

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

