Return-Path: <linux-hyperv+bounces-5980-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FC6AE1898
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Jun 2025 12:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AD7C189761C
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Jun 2025 10:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9758A1FBEB9;
	Fri, 20 Jun 2025 10:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Mq+Xn2KL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8A9101EE
	for <linux-hyperv@vger.kernel.org>; Fri, 20 Jun 2025 10:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750414161; cv=none; b=Rpd9HZDR5CADKviSvJzyZ0nBQfviZDZFcpXQCYha6vDZOBJChYLVgqSqUAMnLJTSVVESYWB3Xbjcd+mXZBXEtxJ9uGjDZESceTj3JboxRPvM9J4bNfq3eYNCi1mUOb/mbV7MmQfv77989egnV8Kchw59aZB1oFXxdC1M2xTWcJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750414161; c=relaxed/simple;
	bh=lT7ArWGhij9qZ7Hpmf7mQ9kHl3sdlAJy7xlbGSqvXVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BsKakdNT4Si6cVxfg/0dArg1y5mSjWTxw5+6H2ARDa/mqHaROjmVD4hoyRTzHWkbeAYOe9b3TeT9YegbviWk5tsUxnxjglXccnoaZMvn0nS2MVY24DnSDgyZV27lHtv5aBNU+BWBI1V8o5UYyXLkYL6bdG3Y56+AVvAoyU7T4GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Mq+Xn2KL; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.202.98] (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8BB2C2115189;
	Fri, 20 Jun 2025 03:09:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8BB2C2115189
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1750414158;
	bh=/B7fiyGBUN2QC3rsm7BpjXHUwN6PlzG5rHTjpmw9rPU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Mq+Xn2KLr29F/aXsvNC43uIzdflp/39fnGBh0//3Xkg48xt4/9O7caT3408PLO3hS
	 0eWKVXSDkTQ8zr5+WUUTFRjWO51LAvItBSQIroY8yquwzz5wVRxCB792OgyOqpSwV/
	 8BOmEb+zC7ZGYxt1u4MdTi7mjcG8rElor7gNthrw=
Message-ID: <ab06bb44-a718-411b-bf9c-e7af3a2d8de5@linux.microsoft.com>
Date: Fri, 20 Jun 2025 15:39:14 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] tools/hv: Fix incorrect file path conversion in
 fcopy on Linux
To: yasuenag@gmail.com
Cc: eahariha@linux.microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, linux-hyperv@vger.kernel.org,
 ssengar@linux.microsoft.com
References: <20250613104648.1212-1-yasuenag@gmail.com>
 <20250613104648.1212-2-yasuenag@gmail.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20250613104648.1212-2-yasuenag@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/13/2025 4:16 PM, yasuenag@gmail.com wrote:
> From: Yasumasa Suenaga <yasuenag@gmail.com>
> 
> The hv_fcopy_uio_daemon fails to correctly handle file copy requests
> from Windows hosts (e.g. via Copy-VMFile) due to wchar_t size
> differences between Windows and Linux. On Linux, wchar_t is 32 bit,
> whereas Windows uses 16 bit wide characters.
> 
> Currently, the code casts __u16 arrays directly to wchar_t* and
> uses wcstombs(), which leads to corrupted file paths or even crashes.
> 
> This patch changes:

Please use imperative mood to write commit msg. Avoid using "This patch 
does xyz".

> - Treats file name and path as __u16 arrays, not wchar_t*.
> - Allocates fixed-size buffers (W_MAX_PATH) for converted strings
>    instead of using malloc.
> - Adds a check for target path length to prevent snprintf() buffer
>    overflow.
> 
> This change ensures file transfers from host to Linux guest succeed
> with correctly decoded file names and paths.

Ditto.

Sample commit msg:
The hv_fcopy_uio_daemon fails to correctly handle file copy requests
from Windows hosts (e.g. via Copy-VMFile) due to wchar_t size
differences between Windows and Linux. On Linux, wchar_t is 32 bit,
whereas Windows uses 16 bit wide characters.
Fix this by ensuring that file transfers from host to Linux guest 
succeed with correctly decoded file names and paths.

Regards,
Naman

> 
> Signed-off-by: Yasumasa Suenaga <yasuenag@gmail.com>
> ---
>   tools/hv/hv_fcopy_uio_daemon.c | 37 +++++++++++++---------------------
>   1 file changed, 14 insertions(+), 23 deletions(-)
> 
> diff --git a/tools/hv/hv_fcopy_uio_daemon.c b/tools/hv/hv_fcopy_uio_daemon.c
> index 0198321d1..4b09ed6b6 100644
> --- a/tools/hv/hv_fcopy_uio_daemon.c
> +++ b/tools/hv/hv_fcopy_uio_daemon.c
> @@ -62,8 +62,11 @@ static int hv_fcopy_create_file(char *file_name, char *path_name, __u32 flags)
>   
>   	filesize = 0;
>   	p = path_name;
> -	snprintf(target_fname, sizeof(target_fname), "%s/%s",
> -		 path_name, file_name);
> +	if (snprintf(target_fname, sizeof(target_fname), "%s/%s",
> +		     path_name, file_name) >= sizeof(target_fname)) {
> +		syslog(LOG_ERR, "target file name is too long: %s/%s", path_name, file_name);
> +		goto done;
> +	}
>   
>   	/*
>   	 * Check to see if the path is already in place; if not,
> @@ -270,7 +273,7 @@ static void wcstoutf8(char *dest, const __u16 *src, size_t dest_size)
>   {
>   	size_t len = 0;
>   
> -	while (len < dest_size) {
> +	while (len < dest_size && *src) {
>   		if (src[len] < 0x80)
>   			dest[len++] = (char)(*src++);
>   		else
> @@ -282,27 +285,15 @@ static void wcstoutf8(char *dest, const __u16 *src, size_t dest_size)
>   
>   static int hv_fcopy_start(struct hv_start_fcopy *smsg_in)
>   {
> -	setlocale(LC_ALL, "en_US.utf8");
> -	size_t file_size, path_size;
> -	char *file_name, *path_name;
> -	char *in_file_name = (char *)smsg_in->file_name;
> -	char *in_path_name = (char *)smsg_in->path_name;
> -
> -	file_size = wcstombs(NULL, (const wchar_t *restrict)in_file_name, 0) + 1;
> -	path_size = wcstombs(NULL, (const wchar_t *restrict)in_path_name, 0) + 1;
> -
> -	file_name = (char *)malloc(file_size * sizeof(char));
> -	path_name = (char *)malloc(path_size * sizeof(char));
> -
> -	if (!file_name || !path_name) {
> -		free(file_name);
> -		free(path_name);
> -		syslog(LOG_ERR, "Can't allocate memory for file name and/or path name");
> -		return HV_E_FAIL;
> -	}
> +	/*
> +	 * file_name and path_name should have same length with appropriate
> +	 * member of hv_start_fcopy.
> +	 */
> +	char file_name[W_MAX_PATH], path_name[W_MAX_PATH];
>   
> -	wcstoutf8(file_name, (__u16 *)in_file_name, file_size);
> -	wcstoutf8(path_name, (__u16 *)in_path_name, path_size);
> +	setlocale(LC_ALL, "en_US.utf8");
> +	wcstoutf8(file_name, smsg_in->file_name, W_MAX_PATH - 1);
> +	wcstoutf8(path_name, smsg_in->path_name, W_MAX_PATH - 1);
>   
>   	return hv_fcopy_create_file(file_name, path_name, smsg_in->copy_flags);
>   }


