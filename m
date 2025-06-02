Return-Path: <linux-hyperv+bounces-5710-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D8CACB9BB
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Jun 2025 18:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 362CA7A6D7B
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Jun 2025 16:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072B12222C2;
	Mon,  2 Jun 2025 16:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VCMgNy4B"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577832C3258
	for <linux-hyperv@vger.kernel.org>; Mon,  2 Jun 2025 16:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748882371; cv=none; b=RabbNiDzqvLHqOx8NAS4Clm8KPhI6ftjlfbDxj97GbDecIHU7GANjcFCKslId4XrBiCVPbzzA3F+UawGSOmNLNjQCjtNwEfJmM71+sbeCUGr/lkuJ4LXbdIN7G5QPJogRDSeiBX5/ZiG/xv8fSLqCh73nR01wNenXpVGdZCL7Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748882371; c=relaxed/simple;
	bh=n38Va4pcN6e4HbdAUNxHSOOeRqMbb+5ZHTVjbt56m/s=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hZzXC5dJ0aWHZEcb1u5XNzC0shjy86W2VUZSmV1TqL3/ASdokjjZ+zdUNniq4HuzQQ0jHxLyX4DGxzmXcV7RV+lecRFxpLBWN6tdGTRuniA1GOVRQAMW22K1ajmA+Af4o2DQ1ecOrsYvrA6NtuUn8jpM7+rkVYqwiHKuK+1SNTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VCMgNy4B; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.209.24] (unknown [20.236.10.129])
	by linux.microsoft.com (Postfix) with ESMTPSA id 83ADD2113A47;
	Mon,  2 Jun 2025 09:39:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 83ADD2113A47
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748882369;
	bh=Z+sbIfFD6eqYVBQXoDJUeD05OJTNyQRsFnq5lSn3YPQ=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=VCMgNy4BAkhgOcnhfYvJmXet8+d9WOrCe8dliA0TxviGCyNDkNOdHq8vQhSUbe4Ec
	 HVSHY4bblHm3rp4VCYnRHG8ivwDf0FMSGHqqn3+MPSW4j19XAbJLwXfywGpFWoSRXM
	 jU3EgPBR6Nj/A5p5XOfyoxlVysbfXkdisylrl88U=
Message-ID: <82cbefe0-c9d0-457e-99dd-82842ee64cef@linux.microsoft.com>
Date: Mon, 2 Jun 2025 09:39:28 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, eahariha@linux.microsoft.com,
 linux-hyperv@vger.kernel.org,
 Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Subject: Re: [PATCH] Path string from the host should not be treated as
 wchar_t
To: yasuenag@gmail.com
References: <20250601134538.3299-1-yasuenag@gmail.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20250601134538.3299-1-yasuenag@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/1/2025 6:45 AM, yasuenag@gmail.com wrote:
> From: Yasumasa Suenaga <yasuenag@gmail.com>
> 
> hv_fcopy_uio_daemon handles file copy request from the host.
> (e.g. Copy-VMFile commandlet)
> The request has file path and its name, they would be stored as
> __u16 arrays in struct hv_start_fcopy. They are casted to wchar_t*
> in fcopyd to convert to UTF-8 string. wchar_t is 32bit in Linux
> unlike Windows (16bit), so string conversion would be failed and
> the user cannot copy file to Linux guest from Host via fcopyd.
> 
> fcopyd converts each characters to char if the value is less
> than 0x80. Thus we can convert straightly without wcstombs() call,
> it means we are no longer to convert to wchar_t.
> 
> Length of path depends on PATH_MAX (Linux) and W_MAX_PATH (Windows),
> so this change also addes new check to snprintf() call to make
> target path.

Missing Signed-off-by for developer certificate of origin

> ---
>  tools/hv/hv_fcopy_uio_daemon.c | 38 ++++++++++++++--------------------
>  1 file changed, 16 insertions(+), 22 deletions(-)
> 

Thanks for the patch! Please look through https://www.kernel.org/doc/html/latest/process/submitting-patches.html
to see hints for the expected subject line, explanation body, and developer's certificate of origin

+CC: Saurabh for review, weird why get_maintainer.pl didn't get him 


> diff --git a/tools/hv/hv_fcopy_uio_daemon.c b/tools/hv/hv_fcopy_uio_daemon.c
> index 0198321d1..049d4fd9c 100644
> --- a/tools/hv/hv_fcopy_uio_daemon.c
> +++ b/tools/hv/hv_fcopy_uio_daemon.c
> @@ -58,12 +58,16 @@ static unsigned long long filesize;
>  static int hv_fcopy_create_file(char *file_name, char *path_name, __u32 flags)
>  {
>  	int error = HV_E_FAIL;
> +	int ret_snprintf;
>  	char *q, *p;
>  
>  	filesize = 0;
>  	p = path_name;
> -	snprintf(target_fname, sizeof(target_fname), "%s/%s",
> -		 path_name, file_name);
> +	ret_snprintf = snprintf(target_fname, sizeof(target_fname), "%s/%s",
> +	                        path_name, file_name);
> +	if (ret_snprintf >= sizeof(target_fname))
> +		/* target file name is too long */
> +		goto done;

The error check can be inlined since we don't use ret_snprintf elsewhere, i.e.

if(snprintf(target_fname, sizeof(target_fname), "%s/%s", path_name, file_name) >= sizeof(target_fname)) {
	/* target file name is too long */
	goto done;
}

Note also the added braces, even if the extra line is a comment. https://www.kernel.org/doc/html/latest/process/coding-style.html

>  
>  	/*
>  	 * Check to see if the path is already in place; if not,
> @@ -273,6 +277,8 @@ static void wcstoutf8(char *dest, const __u16 *src, size_t dest_size)
>  	while (len < dest_size) {
>  		if (src[len] < 0x80)
>  			dest[len++] = (char)(*src++);
> +		else if (src[len] == '0')
> +			break;
>  		else
>  			dest[len++] = 'X';
>  	}
> @@ -282,27 +288,15 @@ static void wcstoutf8(char *dest, const __u16 *src, size_t dest_size)
>  
>  static int hv_fcopy_start(struct hv_start_fcopy *smsg_in)
>  {
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
> +	*/
> +	char file_name[W_MAX_PATH], path_name[W_MAX_PATH];
>  
> -	wcstoutf8(file_name, (__u16 *)in_file_name, file_size);
> -	wcstoutf8(path_name, (__u16 *)in_path_name, path_size);
> +	setlocale(LC_ALL, "en_US.utf8");
> +	wcstoutf8(file_name, smsg_in->file_name, W_MAX_PATH - 1);
> +	wcstoutf8(path_name, smsg_in->path_name, W_MAX_PATH - 1);
>  
>  	return hv_fcopy_create_file(file_name, path_name, smsg_in->copy_flags);
>  }


