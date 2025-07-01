Return-Path: <linux-hyperv+bounces-6061-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9237AAEF378
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Jul 2025 11:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE7654A2A12
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Jul 2025 09:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8B3264F87;
	Tue,  1 Jul 2025 09:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="k21wLWo2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C5226CE0E
	for <linux-hyperv@vger.kernel.org>; Tue,  1 Jul 2025 09:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751362574; cv=none; b=bsUz8+KIiEcT+Ruy5r7lM1G5Dx6lYsf5SoSOWOmrGWoF5rXsfAcVUjaKXiQDyGLKKjEJKmuwVe2DXTfXmOAyJ0zZCTUBy+x5yNUztd4Ti21/OBWiwYStxGaY5hALzis3AQYBFb21qGFFQ4nGbN4GbIVQsMhSElrDGPYIs0WqBmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751362574; c=relaxed/simple;
	bh=N4Hrvs0kGNQDTapHId61hvN7ZpGwMxn+XmljC3YWkv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kWh4z/6g1XphdcB8fwTjuYYtvYQjGN8wQ2uQEzYHNDaKy3aWOi3FezrIj9WoJ3GEoI5iPYA/Ri9RwPxzx5ZE+av0wSBwBOhSY3S+zI9mLzOqaj4vVquUdKcU1n7PnzgfMYl194tOMlMH9AGLuDv4aWKMai7xM1Hir1OTVDfA5B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=k21wLWo2; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.95.67.184] (unknown [167.220.238.152])
	by linux.microsoft.com (Postfix) with ESMTPSA id 422442035F6E;
	Tue,  1 Jul 2025 02:36:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 422442035F6E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1751362572;
	bh=osN49wFnfEqJOnEMeDYEVytoQRw7zJZNcnJmSNfVVrI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k21wLWo2krPm6FgsYAtW4QQXiXaUfdCoIHKRJoi1vXiFNDRQwaQNrs7fMbgTXjrTu
	 RZd2xUM7y5FHRTC3FmcKqmWOO5t8Xq+dazoGrojUYv1ScYOETf5lG9Fo9jGlRv67AR
	 ulJzFCi/tYAP1QyuMbaWwvzmv0Y08fKJwSPrA0SA=
Message-ID: <f71d33bb-65e5-4a92-b08b-9d706e74e745@linux.microsoft.com>
Date: Tue, 1 Jul 2025 15:06:08 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/1] tools/hv: fcopy: Fix incorrect file path
 conversion
To: yasuenag@gmail.com
Cc: eahariha@linux.microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, linux-hyperv@vger.kernel.org,
 ssengar@linux.microsoft.com
References: <20250628022217.1514-1-yasuenag@gmail.com>
 <20250628022217.1514-2-yasuenag@gmail.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20250628022217.1514-2-yasuenag@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/28/2025 7:52 AM, yasuenag@gmail.com wrote:
> From: Yasumasa Suenaga <yasuenag@gmail.com>
> 
> The hv_fcopy_uio_daemon fails to correctly handle file copy requests
> from Windows hosts (e.g. via Copy-VMFile) due to wchar_t size
> differences between Windows and Linux. On Linux, wchar_t is 32 bit,
> whereas Windows uses 16 bit wide characters.
> 
> Fix this by ensuring that file transfers from host to Linux guest
> succeed with correctly decoded file names and paths.
> 
> - Treats file name and path as __u16 arrays, not wchar_t*.
> - Allocates fixed-size buffers (W_MAX_PATH) for converted strings
>    instead of using malloc.
> - Adds a check for target path length to prevent snprintf() buffer
>    overflow.
> 
> Fixes: 82b0945ce2c2 ("tools: hv: Add new fcopy application based on uio driver")
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

LGTM. FYI, Fcopy daemon is broken on some systems currently. Below
change should fix it:

https://lore.kernel.org/all/20250620070618.3097-1-namjain@linux.microsoft.com/


Reviewed-by: Naman Jain <namjain@linux.microsoft.com>

