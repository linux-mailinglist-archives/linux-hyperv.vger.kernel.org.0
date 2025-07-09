Return-Path: <linux-hyperv+bounces-6165-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E398AFF4E7
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Jul 2025 00:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B3501890CD4
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Jul 2025 22:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45600238C25;
	Wed,  9 Jul 2025 22:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENjAdTk9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2127A226D1F
	for <linux-hyperv@vger.kernel.org>; Wed,  9 Jul 2025 22:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752101069; cv=none; b=TxAGcVUEMp4aJHUwyiqpNa9HjyxUizTeRXAEf3qPzArEAtKFwEyY1H1u8J6Ldc/945GG/z0OrXJ6EFOhrHhsXYL0SOQZytAxKMmWj6B5O7SzrThO1G5gRhnEWO8HE2YQ1FH47FRfj3Iq2q7843MEexLSQuQIECee87Hpp0CPYlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752101069; c=relaxed/simple;
	bh=pRPyzo0hNSJRrZyPk7OySyP+bsog19bnCXv3QnReyTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRAhJGRsft3LQErg8YWOsZkdjPOEX+Xt3+W5+qiZJXxpM66EfgetysTnevp8rLWvaYeELVT0XxBRJkQHGTK2+8mJw8xSjLkMvASb0AIWdSZq8KHJGUb8iK48l0rdYo4a6+ziqY/KQeo1hsIvQ/lEM9nVAPDLt/97A13Oj7wYMeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENjAdTk9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B25C4CEEF;
	Wed,  9 Jul 2025 22:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752101068;
	bh=pRPyzo0hNSJRrZyPk7OySyP+bsog19bnCXv3QnReyTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ENjAdTk9N7QGrjEGZFWSMs+CWoVIJoCNnyIe7FcFwZumpCPfIykpfeDYDaOs8UqHr
	 o2kP82ChabfyaqB2v93vtbAPKHjJHGOyLBjmtQQq2nhd/Ms11gHqhdr+G8Xn0bajrv
	 sCgobfCs8MfeUYaUyMpsiiA8gtiVaf3cpejwLEdfhdpz0Kwp8zsSGZIkC+93n6rJr2
	 mn21KsCjL5iyt9cIwlyzmsrCNEQ2thPaVqtBvYfeYIbHB88W/vkv7Kc3rJi8/6VIYp
	 zKPmVayREn6Ux7Z2LJ5hyBwgFXlwUJ4d3xV2AW5vgNbB4CJODSlLcmEF+J4Oezgzku
	 jtfassepuYKfQ==
Date: Wed, 9 Jul 2025 22:44:27 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Ben Hutchings <benh@debian.org>
Cc: linux-hyperv@vger.kernel.org, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH 0/2] tools/hv: Improve the sample hv_get_dhcp_info script
Message-ID: <aG7wy7gvoFR88Su_@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <aE9Ri42HK2L1YOn3@decadent.org.uk>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aE9Ri42HK2L1YOn3@decadent.org.uk>

On Mon, Jun 16, 2025 at 01:04:43AM +0200, Ben Hutchings wrote:
> The sample hv_get_dhcp_info script was originally supposed to be
> replaced by downstream distributions, but:
> 
> - Network Manager and systemd-networkd are used across many
>   distributions
> - Debian's ifupdown is not only used in Debian derivatives but also
>   Alpine and Void Linux
> 
> This adds support for all of those.
> 
> The check for DHCP in network-scripts configuration files was
> also quite lax.  This makes the regex a bit more strict.
> 
> Ben.
> 
> Ben Hutchings (2):
>   tools/hv: Make the sample hv_get_dhcp_info script more useful
>   tools/hv: Make network-scripts DHCP status check more specific

Applied to hyperv-next. Thanks.

