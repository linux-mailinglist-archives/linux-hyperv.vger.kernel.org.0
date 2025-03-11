Return-Path: <linux-hyperv+bounces-4397-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E28A5CC8B
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Mar 2025 18:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 004DD7A67A9
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Mar 2025 17:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC23B41C72;
	Tue, 11 Mar 2025 17:45:23 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFB21EDA2A;
	Tue, 11 Mar 2025 17:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741715123; cv=none; b=XFUhBF2AxhT7QF3QgrwtbJm3He02UCDYHeDESQdkkyrvRBws31KaCWKpMUahcZhffuPVoys6P056NX9fHkL4gb9LkMKz92tAIo89hxHH8Y/z2ztZQCAMgQehmdLRlWgBLVECrjkwfvQ6wpfgtjk58OpMaovC/odKi1KuLh+TvhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741715123; c=relaxed/simple;
	bh=bfkWzUq+yvmb9L/sL1r8Mimsv1uoJJ31qsbzcYKgUXw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cHR1yj+A15xJTSRx4VVwZ8j2Cwy1JHRtd4mj7F6eAgoDYQPVcSC1NZ5/oFybmlKHstYRDEk3oNw5Jg2JhTXHWGQJcYkxxf7gvp9aF8njG3SEI3shKH0q2nTPIJxxOSBBB9zoDyEnHNIAHWsjnH0e3kcqw/ZHnuL/ij3AA0V7QYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZC1LR2NWWz6HJj9;
	Wed, 12 Mar 2025 01:42:39 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 57978140442;
	Wed, 12 Mar 2025 01:45:12 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 11 Mar
 2025 18:45:11 +0100
Date: Tue, 11 Mar 2025 17:45:09 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: LKML <linux-kernel@vger.kernel.org>, Marc Zyngier <maz@kernel.org>,
	Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, "Santosh
 Shilimkar" <ssantosh@kernel.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang
	<dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
	<ntb@lists.linux.dev>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, <linux-hyperv@vger.kernel.org>, Wei Huang
	<wei.huang2@amd.com>, Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>, "James E.J. Bottomley"
	<James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>
Subject: Re: [patch 01/10] genirq/msi: Make a few functions static
Message-ID: <20250311174509.00001785@huawei.com>
In-Reply-To: <20250309084110.204054172@linutronix.de>
References: <20250309083453.900516105@linutronix.de>
	<20250309084110.204054172@linutronix.de>
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

On Sun,  9 Mar 2025 09:41:42 +0100 (CET)
Thomas Gleixner <tglx@linutronix.de> wrote:

> None of these functions are used outside of the MSI core.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


