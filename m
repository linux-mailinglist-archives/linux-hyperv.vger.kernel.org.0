Return-Path: <linux-hyperv+bounces-3434-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B129E88C2
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Dec 2024 01:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01C7E2810D6
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Dec 2024 00:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B5BAD2C;
	Mon,  9 Dec 2024 00:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMvJVdOn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEB6433BE;
	Mon,  9 Dec 2024 00:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733705184; cv=none; b=tIQZOUlZAUXqCX/pMtZ2QMgXiXv9E15vj1xoHqpGSRWuhbo4UPgY2w5Ju0mL0m+7coWo0sObD+HFvk6XFFYyKLES9tlCkWx4Np1CvHKLiu8M2Fam25z2MWgMZR4D0p6jfoyNqZAfKAn3vKDKDqPPtzDIMkUwluPDBkDBt9OjEFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733705184; c=relaxed/simple;
	bh=O5Ubw+Z1f/k7rRBXuudzG5XXiSAKB4XQ4Qo/GTy60j4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RssU4mb6kK7kFmYCkVb7Ijm0YrHYRCRzdxJ4ozrtgr//Sd9MOmcJ7vxm+pBA/leq0lkGytjsfe/9E8x3vOGneXO6/TFt03xskx7gtRnFgCmgQ+zKIWzbr5imkk9EVo3xipfOnGVI2C/B3Jh4EkjGM+G78grEQOpx1aYQ9N52g6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMvJVdOn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A948C4CED2;
	Mon,  9 Dec 2024 00:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733705184;
	bh=O5Ubw+Z1f/k7rRBXuudzG5XXiSAKB4XQ4Qo/GTy60j4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YMvJVdOniuMJwD0vJwgzQxLHQSNr8ZP6itDcaXbdRWrDF5mAP8DKj5ytouEULyiof
	 UfvgXl4Hq8sHdtKYN+hYLLVk+RDt5ZzovrgJSNpde0GhsCV2sA5dsgzaM5eeHQTpxJ
	 x80S9ccPlKeeYG+cXxDg2+3LYolhs5FDhwsWUHhZtYaAX78ISTm6b0LsW1nAPjUc0c
	 7FqYviCw+fZt17nIdbuvAwP/ehcPEnulBR0vpRsQUodT0RsHVjAUw9R0V4Nx/KU0Yj
	 +KqAwjUi6wF6Zh/mJvDlSAimHt0xnkqAasX4dE+S9DkCEDmA8pPyx4/YMqjiP0f6Be
	 8Cyhqdfu597tw==
Date: Mon, 9 Dec 2024 00:46:22 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Wei Liu <wei.liu@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] hv: hyperv.h: Annotate vmbus_channel_gpadl_header with
 __counted_by()
Message-ID: <Z1Y93kdMPeuF6t3N@liuwe-devbox-debian-v2>
References: <20241015101829.94876-2-thorsten.blum@linux.dev>
 <Z1P94CdlCAzDc3d3@liuwe-devbox-debian-v2>
 <77790477-238D-482F-9431-FA85091685BB@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77790477-238D-482F-9431-FA85091685BB@linux.dev>

On Mon, Dec 09, 2024 at 01:16:01AM +0100, Thorsten Blum wrote:
> On 7. Dec 2024, at 08:48, Wei Liu wrote:
> > On Tue, Oct 15, 2024 at 12:18:29PM +0200, Thorsten Blum wrote:
> >> Add the __counted_by compiler attribute to the flexible array member
> >> range to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> >> CONFIG_FORTIFY_SOURCE.
> >> 
> >> Compile-tested only.
> >> 
> >> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > 
> > Applied to hyperv-fixes. Thanks.
> 
> This should probably not be applied anymore given the kernel test robot
> build warnings. Unless I missed something and this works now?

Yes, you're right. The patch has been dropped from hyperv-fixes.

Thanks,
Wei.

> 
> Thanks,
> Thorsten

