Return-Path: <linux-hyperv+bounces-4410-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1B1A5D216
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Mar 2025 22:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 681AD17B407
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Mar 2025 21:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71132264F93;
	Tue, 11 Mar 2025 21:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byRQQRx2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457FE264A94;
	Tue, 11 Mar 2025 21:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741730092; cv=none; b=eP5ZT2sGNNUVN3UDKsxUzm3LPhpy2VRUsKEgkEpdQ/yNG5gcymjsiUd6f65xT1ip4cXXMepgZ6KYzDKk/e9FRQUZ7iKDiBkwoFAB3fTDsrUtQf6AkwGGDCFzLAVW1vuAkjJgebsLeSRbXz42bA8WhI121pjLbhXXRq04aPKlnZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741730092; c=relaxed/simple;
	bh=dgCDRRCaDUGdEb5+XrQyoxYViRq9OEfNVP33iEShzL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DhrMdZvHdRysa0xXYOFpvcLlTHVvG4N6VDUFH3pYHvVuPiE8dbKhwpUsiMtPuTEuj9t52QJnuETtG6knIbwpy7mHS02YLn6b32lDnsdEV49nLHhr8e/kM4ta1AuePWW27foFxDUM8u7LUvACbwVbA9CM5ckSRrfctNUy/TII+Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byRQQRx2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93CDAC4CEE9;
	Tue, 11 Mar 2025 21:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741730091;
	bh=dgCDRRCaDUGdEb5+XrQyoxYViRq9OEfNVP33iEShzL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=byRQQRx2duPgo+SnsZ/GTrr8avf6FbK9eE7V++3NdBdtWS1ld5v3YpOsXn+qG2qbm
	 NtT0EB6lFO5Or+z1x1VOYEIDftiOS6UwPw0r4nASe6R3tGsgAEjZRNzpNHMwUXZeD2
	 Ug7gH7GGLfXCbHJymw3poh65a4FwKpHEswcn5YnRM8D5cFixUKl4H3pnc8xunDIj2h
	 hW1QGHH3mSQXUi4E7r7+dbn5CIFje1aJvWT/+uKg6St+zPwtDllVlf875va45tgLFX
	 4c/4j6vJ0W7smz85+JWyA0xFjTghi49PFdb7MNr+UknNBrKl9K2onKo6DwvKR6J4OE
	 nvjXjX5mINwVg==
Date: Tue, 11 Mar 2025 21:54:50 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hyperv: Remove unused union and structs
Message-ID: <Z9CxKvarA4VaAp2a@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <20250311091634.494888-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311091634.494888-2-thorsten.blum@linux.dev>

On Tue, Mar 11, 2025 at 10:16:34AM +0100, Thorsten Blum wrote:
> The union vmpacket_largest_possible_header and several structs have not
> been used for a long time afaict - remove them.
> 
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Applied to hyperv-next. Thanks.

