Return-Path: <linux-hyperv+bounces-4426-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53590A5DFD3
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Mar 2025 16:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2184F1890D29
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Mar 2025 15:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C5424EF95;
	Wed, 12 Mar 2025 15:10:28 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE79C1E9B18;
	Wed, 12 Mar 2025 15:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792228; cv=none; b=j+FwUWyT6fLOZkwsFRCopU+ciQKGkw7QEjR6iIlKI4XmAiqnqK5734eRBxBcegNeFaNXwZCusqsBMDPfT4aBj8PnlR+jy3rDmz0D/POi9EjmQcxwf8ghfKdwIEkxH02fpjuyCz9ZgnNYt6XmPFQkVP54I85om2sEHjAeteZYFs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792228; c=relaxed/simple;
	bh=oczBX5xZMEbmydaNzMcN4tYsC+6yRur7QI5ZpckdznE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BZJy2aO3LDGjk2akh7ji9dWSVjd0lgzSbJo4NAPek3XPk1SfetKA4R+m1ITpgcqkrNWecKdq4FG+6RAz2rFkL8VUYKP0GtHsYl5l36uZM2PptLfIAcXRTMiIcBekT62Ejl0anveEwbld5sb4QvysDOiLggRhiYGCksRlRCcnCd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZCYsK1zMrz6K9Hp;
	Wed, 12 Mar 2025 23:07:49 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id BC59D1404FC;
	Wed, 12 Mar 2025 23:10:24 +0800 (CST)
Received: from localhost (10.202.227.76) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 12 Mar
 2025 16:10:23 +0100
Date: Wed, 12 Mar 2025 15:10:21 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: LKML <linux-kernel@vger.kernel.org>, Marc Zyngier <maz@kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>, "Nishanth Menon"
	<nm@ti.com>, Tero Kristo <kristo@kernel.org>, Santosh Shilimkar
	<ssantosh@kernel.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang
	<dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
	<ntb@lists.linux.dev>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, <linux-hyperv@vger.kernel.org>, Wei Huang
	<wei.huang2@amd.com>, Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>, "James E.J. Bottomley"
	<James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>
Subject: Re: [patch 05/10] PCI/MSI: Switch to MSI descriptor locking to
 guard()
Message-ID: <20250312151021.00002ed2@huawei.com>
In-Reply-To: <87plinz1fb.ffs@tglx>
References: <20250309083453.900516105@linutronix.de>
	<20250309084110.458224773@linutronix.de>
	<20250311181018.0000477f@huawei.com>
	<87plinz1fb.ffs@tglx>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 11 Mar 2025 22:45:44 +0100
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Tue, Mar 11 2025 at 18:10, Jonathan Cameron wrote:
> > On Sun,  9 Mar 2025 09:41:49 +0100 (CET)
> > Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > This one runs into some of the stuff that the docs say
> > to not do.  I don't there there are bugs in here as such
> > but it gets harder to reason about and fragile in the long
> > run.  Easy enough to avoid though - see inline.  
> 
> Right. Updated variant below.
LGTM

Thanks,

Jonathan

