Return-Path: <linux-hyperv+bounces-3258-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2479BC82B
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Nov 2024 09:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80E3628385F
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Nov 2024 08:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138941D2202;
	Tue,  5 Nov 2024 08:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GSnyT20u"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBAB1D1E60;
	Tue,  5 Nov 2024 08:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730795917; cv=none; b=s0NCu5HbkvTOr3NJp6nGxZde+yMECioLHiqtLKvQcQea28RQfQnStjN0SSY48RUk1lD5wleZjMMB5TOvj2fcXr96e55QI/PDfYhez5teTa0kEd1tHOHiqMixmglfUOx9IJPt0kdNmKGpUskVLNX67rHqE3Vtj61uM0abDAw+tfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730795917; c=relaxed/simple;
	bh=pwqKeV0X9ptiMKf8+eBBie8UYfUYm+D5ovV/9aj1tHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bp8qCxZiJQc8zVR075xUYRDnhdxZgAgGl+1wKknMNef9QQSKPOroVWb3CU9eYiiFT2+h8BrIH3/dXbvbco8fDw7wPApxWfJiIOb/mLt5kSEvF5hJvz+8G7nR+Mg71rkcRe3qjvCq0HuT8G0CCTYHw7GoejktJ4DPnJvZoIlEOH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GSnyT20u; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id BC7CB2126CA7; Tue,  5 Nov 2024 00:38:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BC7CB2126CA7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1730795914;
	bh=DE0o8dmbPLaELVhiexJqjr6kR6LP/5pJljv1r2xc0Ms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GSnyT20uN29oWUvU0nxM3pM1Ul2sdRnEchHTlhEcel9azrcsJQzif1PgOJVvmZmMf
	 YakRGk6yBBT4vFljJJSMZSobhFxyAR0AfRj4ON2GOJjdCi5oXYmXo+uabVYDt1Qh+K
	 fCRDPCOUbO5EpwX/6k/iF/Qadf3qEtcaykyb7Xeg=
Date: Tue, 5 Nov 2024 00:38:34 -0800
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Olaf Hering <olaf@aepfle.de>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH v2] tools/hv: terminate fcopy daemon if read from uio
 fails
Message-ID: <20241105083834.GA8168@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20241105081437.15689-1-olaf@aepfle.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105081437.15689-1-olaf@aepfle.de>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Nov 05, 2024 at 09:14:04AM +0100, Olaf Hering wrote:
> Terminate endless loop in reading fails, to avoid flooding syslog.
> 
> This happens if the state of "Guest services" integration service
> is changed from "enabled" to "disabled" at runtime in the VM
> settings. In this case pread returns EIO.

My comment on V1 was meant to log this information in the syslog, so the
user can look for the Guest Service status incase of EIO. Capturing these
details in the commit will require additional effort from user.

Nevertheless, thanks for fixing this:

Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>

> 
> Also handle an interrupted system call, and continue in this case.
> 
> Signed-off-by: Olaf Hering <olaf@aepfle.de>
> ---
> v2: update commit message
> 
> A more complete fix is to handle this properly in the kernel,
> by making the file descriptor unavailable for further operations.
> 
>  tools/hv/hv_fcopy_uio_daemon.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/hv/hv_fcopy_uio_daemon.c b/tools/hv/hv_fcopy_uio_daemon.c
> index 7a00f3066a98..281fd95dc0d8 100644
> --- a/tools/hv/hv_fcopy_uio_daemon.c
> +++ b/tools/hv/hv_fcopy_uio_daemon.c
> @@ -468,8 +468,10 @@ int main(int argc, char *argv[])
>  		 */
>  		ret = pread(fcopy_fd, &tmp, sizeof(int), 0);
>  		if (ret < 0) {
> +			if (errno == EINTR || errno == EAGAIN)
> +				continue;
>  			syslog(LOG_ERR, "pread failed: %s", strerror(errno));
> -			continue;
> +			goto close;
>  		}
>  
>  		len = HV_RING_SIZE;

