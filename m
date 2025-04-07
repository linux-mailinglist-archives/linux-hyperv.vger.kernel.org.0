Return-Path: <linux-hyperv+bounces-4800-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAE2A7D39A
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Apr 2025 07:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A23AA3AB85A
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Apr 2025 05:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2232A224245;
	Mon,  7 Apr 2025 05:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7SXHhVP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAACB2236F3;
	Mon,  7 Apr 2025 05:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744004254; cv=none; b=s3gNuWIg1ymNLDnYbSgJVCB+UAHZNVOTqt2WXq8S3XY5+PO74hN2T8YnydgBM1rIDxiAKBctgOlTxbc7tzSE2L8gkRalcv2Mhdxl0BY2BjIMBELjrNoZJYLBTdy6qis/ZyO6a9NGSF0LjUWnDyjm80uAbShZXOvNYNuipo7Kp4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744004254; c=relaxed/simple;
	bh=iuAds8JJoa+dbYsSrJ66iR8rQIcqF5nXdx0l7K8tiIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JquBI9WCZtvNzuaioMI79Wo4UVGMxmAVA9M8Yvz3gRNOY6gE1lL90utWfziOYCkPSt5Lv8hGAh1GYmPLQheTMBoRhdrgoL9lnLZkLFrseCTDrmmoc22nWVTQiAcBmHEnsoI5R74gI3FedCTs+eJvM/qzdozk7H0PFnsWrDl659I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7SXHhVP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850ADC4CEDD;
	Mon,  7 Apr 2025 05:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744004253;
	bh=iuAds8JJoa+dbYsSrJ66iR8rQIcqF5nXdx0l7K8tiIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l7SXHhVPZJH1W7ANVSO5S54c7aEMlgNAlUen2nFf80lr2CfCEjci5two0FSDc6n2z
	 /mwIZGQaRkWkfzKPtymGpEUQDNf5OVE/eB8aZ2Qfc6V1R885oY7LCQkd0WjnkaqIji
	 o2OGYt+17JThJpbZv+9tAXG51WAuwiUJoOsOUaYUTOhe/BcUIAaan+Al+JSSYbM9+M
	 NH9+tzr2jXhIYIONK1VhnRvR9eBolMBqTHx5xjAajOo3PAHVqKomqj4DzAGBnuLfZt
	 PWEMMaHOnVI3svtvo9Z+3YpGFeTOHw6wKQLPXmffqzys2tIfvMw6Pcd5jiPRDVL0IX
	 oZ0GGezcJGHlA==
Date: Mon, 7 Apr 2025 05:37:32 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Malaya Kumar Rout <malayarout91@gmail.com>
Cc: linux-kernel@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	linux-hyperv@vger.kernel.org
Subject: Re: [PATCH] tools/hv: Memory Leak on realloc
Message-ID: <Z_NknPrx26vMuJ-9@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <20250322164709.500340-1-malayarout91@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250322164709.500340-1-malayarout91@gmail.com>

On Sat, Mar 22, 2025 at 10:16:47PM +0530, Malaya Kumar Rout wrote:
> Static analysis for hv_kvp_daemon.c with cppcheck : error:
> 
> hv_kvp_daemon.c:359:3: error: Common realloc mistake:
> 'record' nulled but not freed upon failure [memleakOnRealloc]
> record = realloc(record, sizeof(struct kvp_record) *
> 
> If realloc() fails, record is now NULL.
> If we directly assign this NULL to record, the reference to the previously allocated memory is lost.
> This causes a memory leak because the old allocated memory remains but is no longer accessible.
> 
> A temporary pointer was utilized when invoking realloc() to prevent
> the loss of the original allocation in the event of a failure

While this patch finds a problem, it misses the big picture.

If realloc fails, the process quits. It depends on the OS to reclaim the
memory. Freeing this one instance to prevent a memory leak is not
sufficient -- there can be already memory allocated prior to a failure.

Unless this program is sufficiently reworked to be resilient against
OOM, this change itself does not bring much value.

That being said, thank you for writing a patch and went through the
trouble to submit it.

Thanks,
Wei.

> 
> CC: linux-kernel@vger.kernel.org
>     linux-hyperv@vger.kernel.org
> Signed-off-by: Malaya Kumar Rout <malayarout91@gmail.com>
> ---
>  tools/hv/hv_kvp_daemon.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
> index 04ba035d67e9..6807832209f0 100644
> --- a/tools/hv/hv_kvp_daemon.c
> +++ b/tools/hv/hv_kvp_daemon.c
> @@ -356,11 +356,14 @@ static int kvp_key_add_or_modify(int pool, const __u8 *key, int key_size,
>  	 */
>  	if (num_records == (ENTRIES_PER_BLOCK * num_blocks)) {
>  		/* Need to allocate a larger array for reg entries. */
> -		record = realloc(record, sizeof(struct kvp_record) *
> -			 ENTRIES_PER_BLOCK * (num_blocks + 1));
> -
> -		if (record == NULL)
> +		struct kvp_record *temp = realloc(record, sizeof(struct kvp_record) *
> +				ENTRIES_PER_BLOCK * (num_blocks + 1));
> +		if (!temp) {
> +			free(record);
> +			record = NULL;
>  			return 1;
> +		}
> +		record = temp;
>  		kvp_file_info[pool].num_blocks++;
>  
>  	}
> -- 
> 2.43.0
> 

