Return-Path: <linux-hyperv+bounces-7901-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A37C96CCC
	for <lists+linux-hyperv@lfdr.de>; Mon, 01 Dec 2025 12:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DA9AE3435FF
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Dec 2025 11:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAED305051;
	Mon,  1 Dec 2025 11:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="cM7qvnzE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADE72D0C9D;
	Mon,  1 Dec 2025 11:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764587187; cv=pass; b=Fm1y4/+mN39TSseXUYVoFpIamsBYRDxpmwPC+2ZTOpec0TnXLe0yuw8GPQJlicCqmdGj83x9fdPXqPWmdv1uVKeIolklSS8theNQ1nM9OYdbpBTN/amDExj+2ROkteom16LTKCc8j0AEadp+deiAJNCsQiMC1uezMMCyy0agYNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764587187; c=relaxed/simple;
	bh=53J5CIcwPf6WNYaOYHJafnIIhhWG5K31oKL4aJ5YFhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ndub2jdAZBoGUUw1h7TpGoxCHSYTWuxJfe4d5OPvcQiWZ4n8vaNOYFDxVJ1obv5+gC9ZW8r6UX8LwjkN1RagnpLIyeYoVZHNXPaij2EYCAYFW61lxbapyUy+kx1tPXb9Kz1Ch+b3h1q0pBH+VfIv3R31vJ/MjeAguGnncEiZfXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=cM7qvnzE; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1764587176; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YHlSSwcE4wXgT6Ur01fKuso17wkG4+MPtpkSCc4AmavRCJsDbgrBTz/dKTxa15OhAYuDY9QnOo+H1miNkSNugyGyxgQOryillgmrYPLgmasogtyBlDtuywVo8ajrPqjETV0GrzYra20Hdc+re0C/raLruVuJt9HElXT7YVMLf/o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1764587176; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WunXeaWSRVJCeMRpAlaGGyRAVRQ2bSkzoVppXITiPeo=; 
	b=ECiiM6P6NvVrxFFCp7dyQRnuwSqVkuhrJyTOT7ikrs0MK9W0Ydc2hN680kO+qTDxEFyW/e2Gk22wFDJX3FlWQ5oLVT31d21uIGxzjgi6C/gLzp6sn1JCzhEi7NVcHPfcNPCeIzgBUenjCoHuDHb6WhOAS3bhDwB2F+0N+peGSjQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764587175;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=WunXeaWSRVJCeMRpAlaGGyRAVRQ2bSkzoVppXITiPeo=;
	b=cM7qvnzEdmRz/AwhlJcmFyrHkEtqX8XBrSD2Y9TSdaqdejzc8CF8DmgYSyWvIMsA
	ytacWZSXoFrxo7x853G6gmbPn0o5zloTW4NQARLqxYLhFVPU/equccxGV6j/CmWHa2k
	0U8fzSYki73vxPQrLghaGrxLYFdBrWc06YkzepqQ=
Received: by mx.zohomail.com with SMTPS id 1764587171433413.37797427190947;
	Mon, 1 Dec 2025 03:06:11 -0800 (PST)
Date: Mon, 1 Dec 2025 11:06:07 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/7] Drivers: hv: Move region management to
 mshv_regions.c
Message-ID: <aS12nwVq_jWGwpNI@anirudh-surface.localdomain>
References: <176412196000.447063.4256335030026363827.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <176412294544.447063.14863746685758881018.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176412294544.447063.14863746685758881018.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
X-ZohoMailClient: External

On Wed, Nov 26, 2025 at 02:09:05AM +0000, Stanislav Kinsburskii wrote:
> Refactor memory region management functions from mshv_root_main.c into
> mshv_regions.c for better modularity and code organization.
> 
> Adjust function calls and headers to use the new implementation. Improve
> maintainability and separation of concerns in the mshv_root module.
> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  drivers/hv/Makefile         |    2 
>  drivers/hv/mshv_regions.c   |  175 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/hv/mshv_root.h      |   10 ++
>  drivers/hv/mshv_root_main.c |  176 +++----------------------------------------
>  4 files changed, 198 insertions(+), 165 deletions(-)
>  create mode 100644 drivers/hv/mshv_regions.c
> 
> diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
> index 58b8d07639f3..46d4f4f1b252 100644
> --- a/drivers/hv/Makefile
> +++ b/drivers/hv/Makefile
> @@ -14,7 +14,7 @@ hv_vmbus-y := vmbus_drv.o \
>  hv_vmbus-$(CONFIG_HYPERV_TESTING)	+= hv_debugfs.o
>  hv_utils-y := hv_util.o hv_kvp.o hv_snapshot.o hv_utils_transport.o
>  mshv_root-y := mshv_root_main.o mshv_synic.o mshv_eventfd.o mshv_irq.o \
> -	       mshv_root_hv_call.o mshv_portid_table.o
> +	       mshv_root_hv_call.o mshv_portid_table.o mshv_regions.o
>  mshv_vtl-y := mshv_vtl_main.o
>  
>  # Code that must be built-in
> diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
> new file mode 100644
> index 000000000000..35b866670840
> --- /dev/null
> +++ b/drivers/hv/mshv_regions.c

How about mshv_mem_regions.c?

Nevertheless:

Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>


