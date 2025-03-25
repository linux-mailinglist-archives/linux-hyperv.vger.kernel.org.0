Return-Path: <linux-hyperv+bounces-4701-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC7DA70A41
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Mar 2025 20:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D4D03BFAFC
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Mar 2025 19:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A131F1312;
	Tue, 25 Mar 2025 19:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0uaSQ+o"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE401F0980;
	Tue, 25 Mar 2025 19:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742930508; cv=none; b=SHisxi1UtjlS4k87SEajnaI2t9c0j6TQUrFKZhOR6+l7Gjdg6A2eOruyzgB3H7avalY7Go9f9CwM+xe9X3UwfH5wMooX54PtX0BJad/UIcOAYe0l7kRafKiHKBilH8STDcQXqPq1/wcsJuKrg07Vofy6VKLLkVJKRmjqq9ICqy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742930508; c=relaxed/simple;
	bh=2lppo/h1Ns/+mEujlov/y1LOi8smo04jL6sSv9o4gwc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P0nYzmNHAvXydY5/mJYg3kcl2h3/A7U8Ox+rPXNIoavdCD/hC0Vc2KOcG+ShVbapmdMdb2L4xr58d0e3y+sMFYBD+EzK6dzHxUzU+JqKbYydQY9X6uQhcANMkrXTsG9rTLHUqi1iqiSY/A9PU1wl5VUs1jiD/1uKw6kH0kak6zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r0uaSQ+o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 050EEC4CEE4;
	Tue, 25 Mar 2025 19:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742930507;
	bh=2lppo/h1Ns/+mEujlov/y1LOi8smo04jL6sSv9o4gwc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r0uaSQ+ocYQ1u9k9URaaCwkzUpmlRgImuqi3zNjqtXINP35sRfm+vKf5apPUDL+G1
	 tCD0nDtbSIBkjZeMOD1f8f5PZO4so2D/NR474GkrddzRXJ6rjpXFgPcATbfNm3C5bk
	 FsGMPfeL4hJvg9LubcLf7naqdthfnDi7ZSGzfXQrHX69mh5pZr97AaPvoCquDFTonv
	 0HBfLWcxhs/0aV5Qpnv2UtQxkhSPfaN9KEmWcGpfuOcgypvYPN0wP3OXntj+025TXC
	 LH3PvMO7n2nuoI/caUA3xJKcAVsgvoR1U/8KhpA3f9RM7AahPM+Wa4JN7KE9udhiPC
	 ZT+fZR+nRlJ2A==
Date: Tue, 25 Mar 2025 12:21:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Erni Sri Satya Vennela <ernis@linux.microsoft.com>, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, longli@microsoft.com, kotaranov@microsoft.com,
 horms@kernel.org, brett.creeley@amd.com, surenb@google.com,
 schakrabarti@linux.microsoft.com, kent.overstreet@linux.dev,
 shradhagupta@linux.microsoft.com, erick.archer@outlook.com,
 rosenp@gmail.com, linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 2/3] net: mana: Implement set_link_ksettings in ethtool
 for speed
Message-ID: <20250325122135.14ffa389@kernel.org>
In-Reply-To: <adaaa2b0-c161-4d4f-8199-921002355d05@lunn.ch>
References: <1742473341-15262-1-git-send-email-ernis@linux.microsoft.com>
	<1742473341-15262-3-git-send-email-ernis@linux.microsoft.com>
	<fb6b544f-f683-4307-8adf-82d37540c556@lunn.ch>
	<20250325170955.GB23398@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
	<adaaa2b0-c161-4d4f-8199-921002355d05@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Mar 2025 18:52:40 +0100 Andrew Lunn wrote:
> Using TC would be more natural in this case. The user action is to
> remove the TC filter and that should set it back to unlimited.

better still - net shapers

