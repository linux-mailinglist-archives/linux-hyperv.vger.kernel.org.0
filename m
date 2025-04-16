Return-Path: <linux-hyperv+bounces-4937-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBBEA8AF73
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Apr 2025 07:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C17E1167F9D
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Apr 2025 05:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93FD16D9C2;
	Wed, 16 Apr 2025 05:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="G4f3ThK/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9CCE571
	for <linux-hyperv@vger.kernel.org>; Wed, 16 Apr 2025 05:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744779764; cv=none; b=HoyUcFQlhjdfxVGr2ats3qMjgOesDw0SMR8tvIVKt/NQDMT1up8UsOV7aojJjZ7V+PP0iJiLuJ/AbG/flO828pdYNbCbgvqC2eWZEDKDxrsg4bP37EuTS7vqRPpsZIkclNm5YqiA4ojK9tro27KXc7rB6PTSMlNwL4VAhYM/t7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744779764; c=relaxed/simple;
	bh=URBDzJiVd2C1ngiP/o3HXQWCwAZq8UgSwhE4Budrk5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZsL8AFNjS+CeIVqjRshNDXzA1Xmj/3oeToM1qX7jRP2yWEpv3VpNAqsiRmEOKaDQyffD2OVkFuki9thLqZUDURfbS4blZl9BX2iJiQQ7uGqgtRgNLxFWjong9rQYXD9GN+R3TarNoXq8cFsVuSVh6iMts/7+kh80TuYVA/fBXHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=G4f3ThK/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id E5A9E210C452; Tue, 15 Apr 2025 22:02:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E5A9E210C452
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744779762;
	bh=OTqeb6WTHcCvuCiLRdebJ9jVFE3q15hjO891hmaS9iU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G4f3ThK/KGQ+Jx5bRCiDm0CCSnHmSNsPeKBbeMc/ZZOia/wfG+/07/klmsHW3mYA4
	 Yllb3jM/hs+02tmzGE0L+gH186iXLz1GYNymjgUjnF7N+DxuR3+w0kZ6EvGVIObE3z
	 qFmeQkCYjVdPTG1goyGIoIPtPQSV0TUBSFFGcR8E=
Date: Tue, 15 Apr 2025 22:02:42 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Olaf Hering <olaf@aepfle.de>
Cc: linux-hyperv@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH v1] tools/hv: update route parsing in kvp daemon
Message-ID: <20250416050242.GA931@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20241202102235.9701-1-olaf@aepfle.de>
 <20250408062057.6f5812d3.olaf@aepfle.de>
 <20250410163435.GA18846@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410163435.GA18846@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Apr 10, 2025 at 09:34:35AM -0700, Shradha Gupta wrote:
> On Tue, Apr 08, 2025 at 06:20:57AM +0200, Olaf Hering wrote:
> > Mon,  2 Dec 2024 11:19:55 +0100 Olaf Hering <olaf@aepfle.de>:
> > 
> > > After recent changes in the VM network stack, the host fails to
> > > display the IP addresses of the VM. As a result the "IP Addresses"
> > > column in the "Networking" tab in the Windows Hyper-V Manager is
> > > empty.
> > 
> > Did anyone had time to address this issue?
> > 
> > 
> > Olaf
> > 
> Hi Olaf,
> Wei's message for a review and quick test, somehow got missed by me.
> Let me get back to you after a few tests with the patch on our envs.
> 
> Thanks,
> Shradha.

I have verified this patch on Hyper-V with network-manager and wicked
services.
The changes look good to me.

Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>

