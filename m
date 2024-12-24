Return-Path: <linux-hyperv+bounces-3517-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0FC9FB971
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Dec 2024 06:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2503164DFE
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Dec 2024 05:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798A713E88C;
	Tue, 24 Dec 2024 05:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxbOkTBW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5C0433AD;
	Tue, 24 Dec 2024 05:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735017577; cv=none; b=q1z2SZWmh9V8gGHEcNAeKaII/Mr2B+u7BhSDjo8cal49K4nxEJwqJmU8fDGHoy0uhmTG0rDkW+Q6NfI3uSFPibfGCFZnZQiCb2sFaAm6A/KXR+VKLgDw3MQ3rDz1zLcFGp3btaGkcMHXoqyfE1wgpf1mVGG6RMh2QMTOTsLLW5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735017577; c=relaxed/simple;
	bh=QhlLnJ27Xk/nU2exkppZU4RlAZu9hVwFWUx7EQMoEXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+BKsx45Sa1d9cmR5lXnJ1jIL8Mgp7jIRO3I4qFg96uB5qB9BvvHbc3v+urlz83/RcZjowT9TPQMHr9TllOEWR+R6hpnvQTSNtXNUUVnFDVm69DzmeUwvnv3MhkPpA5E5kgEzs/HKoftlhhfdDehwDB0ClDv/9oLPtVlfAhURpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxbOkTBW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F2D0C4CED0;
	Tue, 24 Dec 2024 05:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735017576;
	bh=QhlLnJ27Xk/nU2exkppZU4RlAZu9hVwFWUx7EQMoEXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hxbOkTBWTZgzSy2Vkblta6W4Q4dFYYtLvT2J3oT0g8ptmp+sUKi2gDTg5S6WAeqEn
	 EBx9Fs+QUtTLVOnW1Kx8432wN/YsAXlKqvZYk5hW9y20t3izMLlfu2ws70lMDiU3BE
	 RywA2nZX65Vc4ePJJ+UJE6GjFYyymLmrt+HpQvHNb/khzUCW5riNToIK6oXee7iHmq
	 lj9Fj20wijFm7MvB3VUpB8f2Ru+8X/HlorHe4XbeU9rLi8YA14BZJPmG/otW4dKs1C
	 2KILUxHjP4fE3UzBuDMB3JTgv7C+aXXFe0P4R7nFXjZrCD2ap9Cjlsoq/zRDTNMuii
	 Mdnfur5czjipg==
Date: Tue, 24 Dec 2024 05:19:35 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	John Starks <jostarks@microsoft.com>, jacob.pan@linux.microsoft.com,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Subject: Re: [PATCH v4 0/2] Drivers: hv: vmbus: Wait for boot-time offers and
 log missing offers
Message-ID: <Z2pEZycwPkLAFfVQ@liuwe-devbox-debian-v2>
References: <20241118070725.3221-1-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118070725.3221-1-namjain@linux.microsoft.com>

On Sun, Nov 17, 2024 at 11:07:23PM -0800, Naman Jain wrote:
[...]
> John Starks (1):
>   Drivers: hv: vmbus: Log on missing offers if any
> 
> Naman Jain (1):
>   Drivers: hv: vmbus: Wait for boot-time offers during boot and resume
> 
>  drivers/hv/channel_mgmt.c | 61 +++++++++++++++++++++++++++++----------
>  drivers/hv/connection.c   |  4 +--
>  drivers/hv/hyperv_vmbus.h | 14 ++-------
>  drivers/hv/vmbus_drv.c    | 31 ++++++++++----------
>  4 files changed, 67 insertions(+), 43 deletions(-)

Can you please rebase on top of the latest hyperv-next? There are some
conflicts now.

Thanks,
Wei.

