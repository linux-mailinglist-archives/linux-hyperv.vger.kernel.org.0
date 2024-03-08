Return-Path: <linux-hyperv+bounces-1688-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7404287681D
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Mar 2024 17:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A53D11C2188A
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Mar 2024 16:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4033525759;
	Fri,  8 Mar 2024 16:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CsV/vZBW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E31B567A;
	Fri,  8 Mar 2024 16:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709914226; cv=none; b=gGm0NapA/J7o//GHCfb/MiR1NE9dlA9GjtsJiRPma0VMw4Zh1ODQHBIy/IyppVP/zxnbVuwexCqt73uBbfpJWnj5sd8Ib4uM/RbZVPIiSQ0YVzqVPo8NN1XmNs72OnFNdZuU4PGHzvbTVCcgieMYxotdXabstSWMaFVjT2fhzUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709914226; c=relaxed/simple;
	bh=KmsqKvGg1bfnD6ZWCtDSJd3r55FEshEujbRcG6v2Tmk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YL2BJBZ3yuJ4BjK8uq37I4PoFlZaG0Pn08KK6fkq7PGmcEpDwv/KgbluqchJNGkq8aPyxPrVy+oGlAZUPuDVWYmArT9C0fKGCSsxyVf6cqJ2IeDvm/ntWAGPYAuldhQOgD/ISRZoRQcRbKyr9W7iLXqngDhLc/QmXPl4Wzl3JzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CsV/vZBW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ADB6C433C7;
	Fri,  8 Mar 2024 16:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709914225;
	bh=KmsqKvGg1bfnD6ZWCtDSJd3r55FEshEujbRcG6v2Tmk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CsV/vZBWwqNZq6COaZEWyHqD5mMFn3HoreLxtd9kU6LJnmyh7I6ZLuU+pNyeaSYDG
	 vtTjWNqDvlOcEK5136OtQIBlGXXBLC5OguE20zjk4sFUa8dAyZcl1VA4Ajh0E7oPxv
	 8JvOpwt4c0OUOij+oe3rGx2r85ddYBGc/+o7LCIq61K5zmzp7ks9lS+ZbC5vW1NKco
	 zD0ek4qKbzlqkNRaSLmpqDBZeZy6PoFVDsiefaeKNSu1xMCsWNghH1x9CyvoHZc2gE
	 oqXEY5DrpvtifFlJdCAcCHd3uaXtO7F320LV4s2zDeWEBJynm7MFnJzWsj20FBsxut
	 2HXGTYRml1cSg==
Date: Fri, 8 Mar 2024 08:10:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Ajay Sharma
 <sharmaajay@microsoft.com>, Leon Romanovsky <leon@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, Long Li <longli@microsoft.com>, Shradha Gupta
 <shradhagupta@microsoft.com>
Subject: Re: [PATCH v2] net :mana : Add per-cpu stats for MANA device
Message-ID: <20240308081024.6fde961f@kernel.org>
In-Reply-To: <1709894671-1018-1-git-send-email-shradhagupta@linux.microsoft.com>
References: <1709894671-1018-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  8 Mar 2024 02:44:31 -0800 Shradha Gupta wrote:
> Extend 'ethtool -S' output for mana devices to include per-CPU packet
> stats

You haven't answered the questions on v1 and haven't addressed all 
the feedback.
-- 
pw-bot: cr
pv-bot: feedback

