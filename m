Return-Path: <linux-hyperv+bounces-4345-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C0DA59CE9
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Mar 2025 18:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B3A116F68E
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Mar 2025 17:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DE9233733;
	Mon, 10 Mar 2025 17:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="dWjxD4eQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3397A22FDE2;
	Mon, 10 Mar 2025 17:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741626947; cv=none; b=ahlYWE0OMXNumNDrFUomXt48Pj+rTe1CSP+CcgexgQBwruwG3osisqQcEqrOZhD7KCZSWtWiWwl6A5moqx54MN5p2jchqM25w/OTa/cDVzjFYE5OXqCyspbTdS1r2UBH8hIeEgEZnG9iBvCdF7ODrJ/7KuVE65oISxWf73aMOIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741626947; c=relaxed/simple;
	bh=0OCVYF/UAGmF/bg0cdYT6l4Xx+OUMgdepEGS07Yb3NA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=jpO7aMtdWfu/6BLVxkgn7VvF+G9bgu7eekPNGCc9z6+ncZax242S2jsLV/TACINnH1lpEwmk+//DBA85yqxzRHYM5VSTaZi0nYiWhrJE/Mg/thXyKmGro/CbcM3jsY+i/uXrzAuv68v/sA37vM3Z7u4usSxML73S4gLgUKjWX7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=dWjxD4eQ; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=/rk8STxE+umsrTdOZizpHycgtQykDpsqh9BmTH896vM=; b=dWjxD4eQWjlXrG8ZX77eNYor4l
	JjJhbLJwZThFv/nCP5TmvkSmlYzVDAMxIN2FLDzwrrpaUWalU1HjUsb1cbj0odt8hX32qHjSHmrot
	THhXfivyU2MifCS1j4ExAwzbL/IwqyIxvcJX8TAlWQ7oeELyngz4wzmIkBD6DaDosI2CpMY6rH3Uw
	piKRWJTyLaVWqR9nQ+Zd8Bwme2g+birN0r+XRFLvPzS+PMNSuM34ijj7JO+GStMbe9r6aHfQ0l23a
	l9mHTMzqUCOuOmMxB0Z+vsNwj5n8zNCqILspF7q2BSzNvDmsrGT3e4T02NOzF0NwLWaFmelCgDPJQ
	drHrl30Q==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <logang@deltatee.com>)
	id 1trg5B-00G6mD-0b;
	Mon, 10 Mar 2025 10:34:25 -0600
Message-ID: <b419ea3f-50b8-481e-abc6-6eac7ce43021@deltatee.com>
Date: Mon, 10 Mar 2025 10:34:12 -0600
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Jon Mason <jdmason@kudzu.us>,
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
 ntb@lists.linux.dev, Nishanth Menon <nm@ti.com>,
 Tero Kristo <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 linux-hyperv@vger.kernel.org, Wei Huang <wei.huang2@amd.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org
References: <20250309083453.900516105@linutronix.de>
 <20250309084110.394142327@linutronix.de>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20250309084110.394142327@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: tglx@linutronix.de, linux-kernel@vger.kernel.org, maz@kernel.org, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, ntb@lists.linux.dev, nm@ti.com, kristo@kernel.org, ssantosh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org, haiyangz@microsoft.com, wei.liu@kernel.org, linux-hyperv@vger.kernel.org, wei.huang2@amd.com, manivannan.sadhasivam@linaro.org, James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com, linux-scsi@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [patch 04/10] NTB/msi: Switch MSI descriptor locking to lock
 guard()
X-SA-Exim-Version: 4.2.1 (built Wed, 06 Jul 2022 17:57:39 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2025-03-09 01:41, Thomas Gleixner wrote:
> Convert the code to use the new guard(msi_descs_lock).
> 
> No functional change intended.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jon Mason <jdmason@kudzu.us>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Allen Hubbe <allenbh@gmail.com>
> Cc: ntb@lists.linux.dev

Looks really nice to me, thanks.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>


