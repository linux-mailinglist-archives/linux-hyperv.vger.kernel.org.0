Return-Path: <linux-hyperv+bounces-5759-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2F2ACD7CB
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Jun 2025 08:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0627E188AFA3
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Jun 2025 06:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCFD1DF728;
	Wed,  4 Jun 2025 06:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="S+0WS1Lc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8E2224CC
	for <linux-hyperv@vger.kernel.org>; Wed,  4 Jun 2025 06:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749017979; cv=none; b=YdMgM9uAVc9A6iyzuKRnvcNWCIDf9QV7cg5CmSifBdcQ6z/vsF6/5K7GdELu5sEQUORlf0e5w+25qQ1YH+0X1jgXGH/NWfUya121USrgYAf8M8e4OmGUP3m6R5BcnMiAaxeVWv3ZTp13+ejkRgF1/M/yvYo43LyKZY1/wPXXJZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749017979; c=relaxed/simple;
	bh=Qw8rbx9p2XySCWzL/lluzmewvbR+ywYAl+5oLv19sfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H+2D9GaADr1DRMmp5kIL/6oeJAFhm/sZ7SyATyRFaIAHjzatV0iXG6VouYOWZzvmT1OjFamfUDkSOkT0/XEAvLNoMLVv87o1yZZQp8SAplAsJRNlWn8S96ff+ogVUi28byRKbNyiZFnNVZRfcgyCklvX0sU/nbr8FD1XgAPqBpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=S+0WS1Lc; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.33.62] (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id 38D84201FF31;
	Tue,  3 Jun 2025 23:19:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 38D84201FF31
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1749017977;
	bh=R3jjF1HaNrOKq9MIoplu+kX5Y0IPJOetwvVlKtyChyI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=S+0WS1LcUh8Erwvp7Tfi316+8fJQ818NPAeajNOz1iC/oEjGTn5nT3MmpV/E122Ya
	 oG8R7EmLtFhE0strodWP9aEWx5wVgHArQ33pXnnhPNWa6zcIGlPYmU232suDpfZrpv
	 R6BgA7EGZUe4kuE2kH7UQ6nzMxnsqYrewmpdIq0E=
Message-ID: <581033c2-4ff4-44c8-a33c-02da3461fb51@linux.microsoft.com>
Date: Wed, 4 Jun 2025 11:49:32 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] hv_fcopy_uio_daemon: Fix file copy failure between
 Windows host and Linux guest
To: yasuenag@gmail.com, eahariha@linux.microsoft.com
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, linux-hyperv@vger.kernel.org,
 ssengar@linux.microsoft.com
References: <e174e3b0-6b62-4996-9854-39c84e10a317@linux.microsoft.com>
 <20250603234300.1997-1-yasuenag@gmail.com>
 <20250603234300.1997-2-yasuenag@gmail.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20250603234300.1997-2-yasuenag@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/4/2025 5:13 AM, yasuenag@gmail.com wrote:
> From: Yasumasa Suenaga <yasuenag@gmail.com>
> 
> Handle file copy request from the host (e.g. Copy-VMFile commandlet)
> correctly.
> Store file path and name as __u16 arrays in struct hv_start_fcopy.
> Convert directly to UTF-8 string without casting to wchar_t* in fcopyd.
> 
> Fix string conversion failure caused by wchar_t size difference between
> Linux (32bit) and Windows (16bit). Convert each character to char
> if the value is less than 0x80 instead of using wcstombs() call.
> 
> Add new check to snprintf() call for target path creation to handle
> length differences between PATH_MAX (Linux) and W_MAX_PATH (Windows).
> 
> Signed-off-by: Yasumasa Suenaga <yasuenag@gmail.com>
> ---
>   tools/hv/hv_fcopy_uio_daemon.c | 37 ++++++++++++++--------------------
>   1 file changed, 15 insertions(+), 22 deletions(-)
> 
> diff --git a/tools/hv/hv_fcopy_uio_daemon.c b/tools/hv/hv_fcopy_uio_daemon.c
> index 0198321d1..86702f39e 100644
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
> +		/* target file name is too long */
> +		goto done;
> +	}
>   
>   	/*
>   	 * Check to see if the path is already in place; if not,
> @@ -273,6 +276,8 @@ static void wcstoutf8(char *dest, const __u16 *src, size_t dest_size)
>   	while (len < dest_size) {
>   		if (src[len] < 0x80)
>   			dest[len++] = (char)(*src++);
> +		else if (src[len] == '0')
> +			break;
>   		else
>   			dest[len++] = 'X';
>   	}
> @@ -282,27 +287,15 @@ static void wcstoutf8(char *dest, const __u16 *src, size_t dest_size)
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

Hi,
I understand this is your first patch for upstreaming. Here are a few
things you should consider:
1. Create a new patch file for every new version and then send it.
Currently it seems you are manually editing the same patch file in the
subject and sending it, so each patch version is showing up in the same
thread.
2. Read, re-read, absorb the information in the link that Easwar also
mentioned:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html
3. Keep a minimum of 1-2 weeks gap between successive patch versions to
give time to people to review your changes.
4. In the commit msg of v3, it is still not very clear what problem, you
are trying to fix here. Do you mean to say that fcopy does not work on
Linux? Or you are assuming it won't work and fixing some generic
problem?
Fcopy is supposed to work fine on Linux VM on HyperV with windows host. 
If there are some errors, please share in cover letter/comments
in the patch along with steps of execution.

5. If its a fix, we should have a proper Fixes tag with the commit you
are fixing.
6. Have a look at existing conversations at lore to get to know common
practices with single patch, multi patch, cover letters etc.
https://lore.kernel.org/linux-hyperv/?q=linux-hyperv

Regards,
Naman



