Return-Path: <linux-hyperv+bounces-4850-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 923D8A82EB3
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Apr 2025 20:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D74A97A6AEA
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Apr 2025 18:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB442777FE;
	Wed,  9 Apr 2025 18:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Oben+jao"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5405E2777EF;
	Wed,  9 Apr 2025 18:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744223403; cv=none; b=MXTn8h6Vn7fC8x6fcLXbyJyMQSTnEHLQySusgf7qk9oym9W/Kvk7utUMugkyj19gLkxtxR9iiFJhZ4DsBA/srqgRLyQjLeVZcBac3N4DdraWKZC1DKLsZRx9rWvNKC5BFNZN6Halr9LUpwBQlC3TM86wL+0vIQSHL1p/SJ4RLbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744223403; c=relaxed/simple;
	bh=5oRObHQr/2zxP1+n4IXBD/4FEd/MdlnQN8xaBIZBnjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nH4CUe/dkCQmWz11Wm4UonA3lcCGLctIkl7t0f2fJlSCGUwA2Iq/WWgkmTUZSJpjG/VmV5qdUF3l8tt1l86ctqozI53g2eGlaTh3RyghghitWiM34EIukBI2e6/k955aciu4dxu0yNAQL30q6J+Q8UVfNxkM095bK6NtjShshU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Oben+jao; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7AC0A40E0200;
	Wed,  9 Apr 2025 18:29:57 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id mC0_SoCKP1kE; Wed,  9 Apr 2025 18:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1744223393; bh=+3jdce2oV/wlpTCh9nVzDCQMPe79U9ZqKxnpwEsP4C4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Oben+jaogdG78UROuUb/bpHhWyjgmtmOmtSZdo2t3cwVOYCnVBIQ5aPHSM7JbfA8L
	 a7il1MtnGehbn1Dbsi95rzTwuV/7/fZ1Qt/cWrp5u2VAuxgG2oLQNhXUn3gqGFBZlg
	 SlJQxStq41uzYFGCmJXB11wrnm6C5bTgGE7dUvBi3L/bVRf6OUL5pDm57e4FIwZs2g
	 bxKXkINO/igclxF+tmgtogaa7mhy0CmtrVSErM8WfrnBz6jcs0OZG+5i7nGb+/QAqy
	 yskMHOTwDJf0UtMMUk+cwEbHtp1KgPnNszpgTdwkgQ/XZqg5h57JD7WTz2CQjmYGkE
	 XdzttnJ/H4UpRrIbNr1geo2K80Cy8l5QLGqzGf7nQgsrQie6pePjHih9boX9oNY86U
	 mdQjNqwcyv2fIA5onMgaxzwAtOO+yfeT+VDoJ6Jqr9sNgWXkr81io2DNsJehA/kHu9
	 HAOpjQzkb4Ng0XCl4mxZu3J3ERcvXNgU3v1xle428jBuyb0Z5nEcmzP6cXzCG1ETwx
	 lMhOWKkPJQcDVT2Zezl0eZen+E2U+5/zrWMSPj8WPbgUN4D6xdvHQMBBXDMZtcSujk
	 H4WeGkbHx1iFn0IwMJDWTvVRl1ObxIK+tCIZ/w8BSl1Ck5s8TLKBUUwuFCM+bxHUPR
	 h9Pu6YFAOfQeJQ8B2d+g6nD4=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B820E40E0244;
	Wed,  9 Apr 2025 18:29:26 +0000 (UTC)
Date: Wed, 9 Apr 2025 20:29:17 +0200
From: Borislav Petkov <bp@alien8.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Bert Karwatzki <spasswolf@web.de>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org, James.Bottomley@hansenpartnership.com,
	Jonathan.Cameron@huawei.com, allenbh@gmail.com, d-gole@ti.com,
	dave.jiang@intel.com, haiyangz@microsoft.com, jdmason@kudzu.us,
	kristo@kernel.org, linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org,
	logang@deltatee.com, manivannan.sadhasivam@linaro.org,
	martin.petersen@oracle.com, maz@kernel.org, mhklinux@outlook.com,
	nm@ti.com, ntb@lists.linux.dev, peterz@infradead.org,
	ssantosh@kernel.org, wei.huang2@amd.com, wei.liu@kernel.org
Subject: Re: commit 7b025f3f85ed causes NULL pointer dereference
Message-ID: <20250409182917.GBZ_a8fYnLJHngPM0Z@fat_crate.local>
References: <20250408120446.3128-1-spasswolf@web.de>
 <87iknevgfb.ffs@tglx>
 <87friivfht.ffs@tglx>
 <f303b266172050f2ec0dc5168b23e0cea9138b01.camel@web.de>
 <87a58qv0tn.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a58qv0tn.ffs@tglx>

On Tue, Apr 08, 2025 at 10:46:12PM +0200, Thomas Gleixner wrote:
> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> index 4027abcafe7a..77cc27e45b66 100644
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -680,8 +680,8 @@ static int __msix_setup_interrupts(struct pci_dev *__dev, struct msix_entry *ent
>  	if (ret)
>  		return ret;
>  
> -	retain_ptr(dev);
>  	msix_update_entries(dev, entries);
> +	retain_ptr(dev);
>  	return 0;

Tested-by: Borislav Petkov (AMD) <bp@alien8.de>

Fixes my machine too.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

