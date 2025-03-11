Return-Path: <linux-hyperv+bounces-4402-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BF7A5CD13
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Mar 2025 19:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2CCC7AD5EF
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Mar 2025 18:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E0E261590;
	Tue, 11 Mar 2025 18:02:24 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CFD25DD12;
	Tue, 11 Mar 2025 18:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741716144; cv=none; b=Jy/oMxz4ox3bujPS2f4FGga1klp7ifgnhZ0Dtqsv8oF/mA6z0LlBo7egi05Wf5RI+kFAbX0iTgjFghdMq9IFQ18Q8Yv1qfn+C48aqg0/TG3pv3oOv8NcunYeLFXBg0RQ7pcFhj8xJJF/tIk/TtJIaP2iixGP+VW9ahE1oWw3bEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741716144; c=relaxed/simple;
	bh=t0IBQXYSVpg4ekMlAHcyuNlKdryH3NzS6jNR7ikMcak=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jQV1I5hgiCiA6keOnxuShkzPO1kmDYSjDhF01ezvIv9Div9W8PmUeH8w3TsnjOPbCBiPcoV+e2o8t2uyxL0YNyBmc8NcqFy0YDNplWA1M9H+0nGcSI34vA60nowdcU8Pc0gPouwrdDeIVJ4Ybax3cGWb2sQdvYlN/WdAVulp+AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZC1jY5mRRz6H8ZZ;
	Wed, 12 Mar 2025 01:59:13 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D5DEA140CB9;
	Wed, 12 Mar 2025 02:02:20 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 11 Mar
 2025 19:02:20 +0100
Date: Tue, 11 Mar 2025 18:02:18 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: LKML <linux-kernel@vger.kernel.org>, Marc Zyngier <maz@kernel.org>, "Jon
 Mason" <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe
	<allenbh@gmail.com>, <ntb@lists.linux.dev>, Nishanth Menon <nm@ti.com>, "Tero
 Kristo" <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>, "Bjorn
 Helgaas" <bhelgaas@google.com>, <linux-pci@vger.kernel.org>, Haiyang Zhang
	<haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	<linux-hyperv@vger.kernel.org>, Wei Huang <wei.huang2@amd.com>, "Manivannan
 Sadhasivam" <manivannan.sadhasivam@linaro.org>, "James E.J. Bottomley"
	<James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>
Subject: Re: [patch 04/10] NTB/msi: Switch MSI descriptor locking to lock
 guard()
Message-ID: <20250311180218.00005208@huawei.com>
In-Reply-To: <20250309084110.394142327@linutronix.de>
References: <20250309083453.900516105@linutronix.de>
	<20250309084110.394142327@linutronix.de>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Sun,  9 Mar 2025 09:41:48 +0100 (CET)
Thomas Gleixner <tglx@linutronix.de> wrote:

> Convert the code to use the new guard(msi_descs_lock).
> 
> No functional change intended.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jon Mason <jdmason@kudzu.us>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Allen Hubbe <allenbh@gmail.com>
> Cc: ntb@lists.linux.dev
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

