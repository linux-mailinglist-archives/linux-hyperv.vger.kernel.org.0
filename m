Return-Path: <linux-hyperv+bounces-3426-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F359E86BA
	for <lists+linux-hyperv@lfdr.de>; Sun,  8 Dec 2024 17:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E40C16410F
	for <lists+linux-hyperv@lfdr.de>; Sun,  8 Dec 2024 16:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6991865E1;
	Sun,  8 Dec 2024 16:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="sXXG7uY2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF1E20323;
	Sun,  8 Dec 2024 16:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733676964; cv=none; b=lQD/sZHx+tB5/z5IGz3gNw1pIiLMd5wMz8h3YAuGr9YufKaiZDUlY1bUOe5txPV5Cn9N4c31oNT1d+FnQlHfsGxqsptGfk5TuIFO4m+AFSTmIyfTU0CHiatHI3A1GotOWxG2+hbF4lvmg1Ep7oFbeGUGslROx625yYpePtG8ExU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733676964; c=relaxed/simple;
	bh=ny8mXLIdAupvpyUpKQoQ+xdHWHAeocwZ77i9RZL1inc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dEH5pJvQWi2wzS49qOsr1o1W0dViA4okXf81wE//x+3dHzV5+W2b025kEABLdR1JByE3P8FMqm0I9h4P/UQGV2MfKrhR+A81F4JSh9KOkyv0f8CiUZreLK16GDG25CE+mtSP0XGjoBVq4m6c51L15EsefkEG5kc+xSPsUtq8LQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=sXXG7uY2; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id B9CAD205368C; Sun,  8 Dec 2024 08:55:56 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B9CAD205368C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1733676956;
	bh=fqoAooQBnbwo+j3cFKVyrDsnRKcuOZ6qs+N3hEmk6Jk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sXXG7uY2RACfwKW/H7GEVcb8SLbB+fFTVlZxPy3Mw4yRZdFvdDNujVB7ZV0leRWrJ
	 CzuhGbDpXXvlsexpT831admkSWfWELRLiC+flUQ1qWsfrL6aonbvn2k0DjSNGAXf06
	 EyqMZLNILKrh7Z+CJuWAZmJ9bfZjDeGrbt0QkPE4=
Date: Sun, 8 Dec 2024 08:55:56 -0800
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Olaf Hering <olaf@aepfle.de>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH v1] tools/hv: add a .gitignore file
Message-ID: <20241208165556.GA9638@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20241202124107.28650-1-olaf@aepfle.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202124107.28650-1-olaf@aepfle.de>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Dec 02, 2024 at 01:40:52PM +0100, Olaf Hering wrote:
> Remove generated files from 'git status' output after 'make -C tools/hv'.
> 
> Signed-off-by: Olaf Hering <olaf@aepfle.de>
> ---
>  tools/hv/.gitignore | 3 +++
>  1 file changed, 3 insertions(+)
>  create mode 100644 tools/hv/.gitignore
> 
> diff --git a/tools/hv/.gitignore b/tools/hv/.gitignore
> new file mode 100644
> index 000000000000..0c5bc15d602f
> --- /dev/null
> +++ b/tools/hv/.gitignore
> @@ -0,0 +1,3 @@
> +hv_fcopy_uio_daemon
> +hv_kvp_daemon
> +hv_vss_daemon

Changes looks fine to me,

Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>

