Return-Path: <linux-hyperv+bounces-1997-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C918A9FDC
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Apr 2024 18:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43E92282083
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Apr 2024 16:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8ACE16F906;
	Thu, 18 Apr 2024 16:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="I+DPm/06"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5900016FF48;
	Thu, 18 Apr 2024 16:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713456952; cv=none; b=mMJnwIOd50dKoJm7xlhEwPABUvF84S3nFQb2GvY6t2RrADnjt163Rst/lhsnR7JVM1qGMNvSSogzbOL7O40td7jSKE4S0/qpiGbp3CyBr8yMiyn2fDCoUuE1iHgwabRZXu62S17DvofKSeCUlgoedaKHs8c5sZizSB6RgKWmb/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713456952; c=relaxed/simple;
	bh=dzWJk/AKNpODHXz+qqTZXgmHW+ImAxMS1UX+Qpbdyzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JBlABd60j9gaIPIa2NmTXRWXFqwn58PpXYL7bqAiAnOuawY8JRILpPSF+zHHYB9YYZ2HXFoA+Om3R/RmkDYh6r9x2H5UPvexNEEELP/8V4OPdpipKKYTp+akvjoWOAneeptzjbSEKlsnUSLtVSrLeo1v7mFaUzl4NWlanBp65U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=I+DPm/06; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.72.0.75] (unknown [20.236.11.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id 68A3720FD8C4;
	Thu, 18 Apr 2024 09:15:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 68A3720FD8C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1713456950;
	bh=MWOwTVDiu4K6YbjXv7uAPQpvbdgODgAb4GN8I5OuR7k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=I+DPm/062TYCzU2rLwp0nsTAu4f1ZG79Rs0Uj/5pNupY+3mNAjWZRjiFTSAENC9Iq
	 VXPb6a2PeNZh8WAQpPYFlepFy8DlJ8URIU2irBFW5umkNrYJvwXbvqoK1PnVnj+rtk
	 ugrDiMk2lGJyxvNgL+8z/W/SlyQRHWJ5gqyvIx7E=
Message-ID: <19df975d-167f-424a-92ce-5135cbeb8a07@linux.microsoft.com>
Date: Thu, 18 Apr 2024 09:15:51 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Add a header in ifcfg and nm keyfiles describing the
 owner of the files
To: Ani Sinha <anisinha@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>
Cc: shradhagupta@linux.microsoft.com, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240418120549.59018-1-anisinha@redhat.com>
Content-Language: en-CA
From: Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <20240418120549.59018-1-anisinha@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/18/2024 5:05 AM, Ani Sinha wrote:
> A comment describing the source of writing the contents of the ifcfg and
> network manager keyfiles (hyperv kvp daemon) is useful. It is valuable both
> for debugging as well as for preventing users from modifying them.
> 
> CC: shradhagupta@linux.microsoft.com
> CC: eahariha@linux.microsoft.com
> CC: wei.liu@kernel.org
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  tools/hv/hv_kvp_daemon.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> changelog:
> v2: simplify and fix issues with error handling.
> 
> diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
> index ae57bf69ad4a..014e45be6981 100644
> --- a/tools/hv/hv_kvp_daemon.c
> +++ b/tools/hv/hv_kvp_daemon.c
> @@ -94,6 +94,8 @@ static char *lic_version = "Unknown version";
>  static char full_domain_name[HV_KVP_EXCHANGE_MAX_VALUE_SIZE];
>  static struct utsname uts_buf;
>  
> +#define CFG_HEADER "# Generated by hyperv key-value pair daemon. Please do not modify.\n"
> +
>  /*
>   * The location of the interface configuration file.
>   */
> @@ -1435,6 +1437,18 @@ static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
>  		return HV_E_FAIL;
>  	}
>  
> +	/* Write the config file headers */
> +	error = fprintf(ifcfg_file, CFG_HEADER);
> +	if (error < 0) {
> +		error = HV_E_FAIL;
> +		goto setval_error;
> +	}
> +	error = fprintf(nmfile, CFG_HEADER);
> +	if (error < 0) {
> +		error = HV_E_FAIL;
> +		goto setval_error;
> +	}
> +
>  	/*
>  	 * First write out the MAC address.
>  	 */


Looks good to me, I'll defer to other folks on the recipient list on whether "hyperv" should be capitalized
as HyperV or other such feedback.

Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>

Thanks,
Easwar

