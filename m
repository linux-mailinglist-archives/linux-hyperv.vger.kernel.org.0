Return-Path: <linux-hyperv+bounces-4405-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F816A5CD7F
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Mar 2025 19:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B611164374
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Mar 2025 18:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9152F2620DB;
	Tue, 11 Mar 2025 18:14:24 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDC126280A;
	Tue, 11 Mar 2025 18:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741716864; cv=none; b=JvM2IQfr4M9YGn5ZK+GkpYV//6eK9tHq2sUPIMSy49wlQrsDhUN8uKlme4Cvf915nP1UOhI4XAFE/u501+ozNoFpQsPgN82Eo6KOsdz2LGR3bpTk/dxKyyHCh5OeeOy7mrpX74qpnMyDmGNTSCv6LtJWfNCIQOzq6WQohoSDJMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741716864; c=relaxed/simple;
	bh=uLJcJ2E5by7/L+jLn25m72qfzTNr6EIlt9OKOUdIM+8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D9crMSXgyqD3ifAc/FKzdV+Wzj5vL1n4v9Rzqg/ArGr+yPY7ExH0C7AfY4ntm/bQhZri6RSe09mdYVe5I3O0xtIq8U8VA9xZumY0iRK2NNQncwdtsMZ81N9pxlFUoJJZFUs3k4Lz+WPd91Ng92ExH6UckYe8wW8uSa1TwtKVO/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZC203619Lz6HJgy;
	Wed, 12 Mar 2025 02:11:47 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id E1C6B140155;
	Wed, 12 Mar 2025 02:14:20 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 11 Mar
 2025 19:14:20 +0100
Date: Tue, 11 Mar 2025 18:14:18 +0000
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
Subject: Re: [patch 10/10] genirq/msi: Rename msi_[un]lock_descs()
Message-ID: <20250311181418.00002f8f@huawei.com>
In-Reply-To: <20250309084110.776899075@linutronix.de>
References: <20250309083453.900516105@linutronix.de>
	<20250309084110.776899075@linutronix.de>
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

On Sun,  9 Mar 2025 09:41:58 +0100 (CET)
Thomas Gleixner <tglx@linutronix.de> wrote:

> Now that all abuse is gone and the legit users are converted to
> guard(msi_descs_lock), rename the lock functions and document them as
> internal.
> 
> No functional chance.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Sensible.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huwei.com>

