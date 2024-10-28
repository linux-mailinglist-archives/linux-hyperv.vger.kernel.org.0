Return-Path: <linux-hyperv+bounces-3195-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B599B2AF0
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Oct 2024 10:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 427C31F21B5E
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Oct 2024 09:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14005192B76;
	Mon, 28 Oct 2024 09:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NsT3vwNq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE301922F0;
	Mon, 28 Oct 2024 09:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730106383; cv=none; b=n8SrMm2ufLfywut18q64nTh5RAW4AQuYXRlkIuaAN88Ac8RE4yy0o3EwGUNx+Pn1jSw5+KGxmFFg46vaENe4hhjVKueax1aBYTmvpCVBQkl+YxVGfVzTGxr3tnj/Tq3POae40hp2aD2a+9SHCkDxC71ntS1VuZSEG5lK7vjZKOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730106383; c=relaxed/simple;
	bh=ViwSMCPOKpsjbU6GX9IH828/KohcZb1lK0478wIT/9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UpiMrehm2noUJYDdQXwdhiue/W/W3O2gDT4/GAVp3lgQTEJqXfWo0KXa+nU3Y04CY4V//3ZO8hocj2m+lar4B+q5ibbqrm2HKMiheSSm1zVPqo9pBJiRr2RoTppqWfadhY+CSkpuJi5VOrFYfJh2O8fs2qw4WU4gxJylCQduo/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=NsT3vwNq; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id C3BC3211DBDF; Mon, 28 Oct 2024 02:06:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C3BC3211DBDF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1730106380;
	bh=4h4FrzIv9ddKhiti8LPlTZA9MNsITLa45zqTSPuD+q0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NsT3vwNqpUf7fKXotzbimG4por1LX/KOutRDcNezzjq4Dt+ubGorN025JuAh4zmGZ
	 EH/d+i7+R8QHIdrMnLtB0GelBPN+Rkcf8S9VsLycdHbDxQxeWt1Iyrw+DaICkR+5US
	 AMUVM3kJ4Ghge1qtn6pgt9wqzV+vKyohIMWUFNfw=
Date: Mon, 28 Oct 2024 02:06:20 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Olaf Hering <olaf@aepfle.de>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH v1] tools/hv: terminate fcopy daemon if read from uio
 fails
Message-ID: <20241028090620.GA32655@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20241025143009.4571-1-olaf@aepfle.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025143009.4571-1-olaf@aepfle.de>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Fri, Oct 25, 2024 at 04:28:27PM +0200, Olaf Hering wrote:
> Terminate endless loop in reading fails, to avoid flooding syslog.
> 
> This happens if the "Guest services" integration service is
> disabled at runtime in the VM settings.
> 
> Also handle an interrupted system call, and continue in this case.
> 
> Signed-off-by: Olaf Hering <olaf@aepfle.de>
> ---
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

Thanks for the patch. Changes look good to me, I will suggest to improve this
log message incase the error type is EIO by suggesting that users verify if
'Guest Services' is enabled.

- Saurabh

