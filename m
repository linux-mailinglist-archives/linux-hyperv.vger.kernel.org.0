Return-Path: <linux-hyperv+bounces-4481-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE40A5F9CA
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Mar 2025 16:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCE4F19C07FD
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Mar 2025 15:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD07260366;
	Thu, 13 Mar 2025 15:27:01 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BC363B9;
	Thu, 13 Mar 2025 15:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741879621; cv=none; b=TupaoWyRU55kXza7HnF+gKUooaTgo1iT2MxCBiPqElfm3nckHVd7o1+WqTVOFLrz1PKlUsSg5QWWcOyP97wkmK4Xn/PSqPLa5sPHRAE0UGAszZXPPh7w74B+heV8O1oePuDdEQtLyKADIevTGj8IjOrzJO0ma71DGZbvcGrCCWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741879621; c=relaxed/simple;
	bh=JaWdHtclyHa0bgMdVySszEZZWhHhlIfv5c5n3NzJu0o=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=akUv/GH88gQm0UUuYDLPGzWvl0PJAuUWxBrJpSFvE4hY44DKuaKiUK45CvS5jqDDjcnMHaObE9ndVrnQqjoISwRVV9iMWRg3o1y5QRcIYvVOafSWcNnFEQu4PqdT7CSGzN6CR2QXdop3mlUuGTwwJFO+RZdL1nbwtJ9IQ5DypcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZDB9F0ZVsz6H8m8;
	Thu, 13 Mar 2025 23:23:45 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id EF57C140D30;
	Thu, 13 Mar 2025 23:26:54 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 13 Mar
 2025 16:26:53 +0100
Date: Thu, 13 Mar 2025 15:26:52 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: LKML <linux-kernel@vger.kernel.org>, Marc Zyngier <maz@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Nishanth Menon <nm@ti.com>, "Dhruva Gole"
	<d-gole@ti.com>, Tero Kristo <kristo@kernel.org>, Santosh Shilimkar
	<ssantosh@kernel.org>, Logan Gunthorpe <logang@deltatee.com>, Dave Jiang
	<dave.jiang@intel.com>, Jon Mason <jdmason@kudzu.us>, Allen Hubbe
	<allenbh@gmail.com>, <ntb@lists.linux.dev>, Bjorn Helgaas
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>, Michael Kelley
	<mhklinux@outlook.com>, Wei Liu <wei.liu@kernel.org>, Haiyang Zhang
	<haiyangz@microsoft.com>, <linux-hyperv@vger.kernel.org>, Wei Huang
	<wei.huang2@amd.com>, Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>, "James E.J. Bottomley"
	<James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>, Jonathan Cameron
	<Jonathan.Cameron@huwei.com>
Subject: Re: [patch V2 02/10] genirq/msi: Use lock guards for MSI descriptor
 locking
Message-ID: <20250313152652.00001b7f@huawei.com>
In-Reply-To: <20250313130321.506045185@linutronix.de>
References: <20250313130212.450198939@linutronix.de>
	<20250313130321.506045185@linutronix.de>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 13 Mar 2025 14:03:39 +0100 (CET)
Thomas Gleixner <tglx@linutronix.de> wrote:

> Provide a lock guard for MSI descriptor locking and update the core code
> accordingly.
> 
> No functional change intended.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


