Return-Path: <linux-hyperv+bounces-8222-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 052DBD13446
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 Jan 2026 15:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 608BF3066D73
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 Jan 2026 14:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AA725A642;
	Mon, 12 Jan 2026 14:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.b="kgH9Gpiu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2683225B1D2;
	Mon, 12 Jan 2026 14:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.30.2.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768228806; cv=none; b=cwURC0cVWoGT/ruY2pYp9W6oU71RQcANeLoSiMw0ws5bKpbk7QmParebX1awnUIMjawRoLN0ZWmfduiLBJM3W+loFNJFzkmxbZPRfOuH72dPirnelo4wncGLGJt+QK06oY9K7CQRxBaVnaaKdQfvs09DIDGW6ZJBYFLa+vtl/ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768228806; c=relaxed/simple;
	bh=o1iNiArgHH8WtIVlO9KKHPRIhCKW0gyuEJqSdpVC20U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VmFq9SzeUSt5FQCJ/mqo2G+KKOBcHif50p7OGOAiEUoWF54T+xfITeBaamQ8C3d+WLHeSswQH72euNFuB+JI+KzMH+Iw8z9JLzDQKNJJZk4k5JfaRu4veF/1xKJNXRTZbQPzkpef2QHl07pamJNQ6MzrL/+ZgX6JFouhLw76a3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu; spf=pass smtp.mailfrom=csail.mit.edu; dkim=pass (2048-bit key) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.b=kgH9Gpiu; arc=none smtp.client-ip=128.30.2.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csail.mit.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=outgoing.csail.mit.edu; s=test20231205; h=In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ydrZoxkV6O7ZRauys1QMgFWqtUFjFYz2TetCiceIH5A=; t=1768228804; x=1769092804; 
	b=kgH9GpiuIrusaqPYpDpqRH68LCPsIHcKL01BYaXPXteS0ZbVRqY5ewlzxgt532vqRP6qy3ZL+VD
	t/oEN4deillAVg1goTktr1ezjcFsmRPUaTX5MkYobmyV4hy3hZX2tg64agZbZWCbeV9e7/Br/00An
	mWjOfjxBPMI3il73g2neMerqCJ/WUAZsKUuNSa47KqMyif3PxA0UjL6aHk4KkMyT1m+B7VVt0lOiX
	87FnVfb95TtYA8g4D7nlBTjednFfN3QyOXjn7CJEL1n6+5mKSGj+u1BovxwmupvbrUZpb4+l9hFw0
	nGOVILaf+Ng+oAubCaWMLsGdnXZPnkViP+Pw==;
Received: from [49.207.196.83] (helo=csail.mit.edu)
	by outgoing2021.csail.mit.edu with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <srivatsa@csail.mit.edu>)
	id 1vfIvD-006Jsn-62;
	Mon, 12 Jan 2026 09:29:31 -0500
Date: Mon, 12 Jan 2026 19:59:17 +0530
From: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
To: mhklinux@outlook.com
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: hv: Remove unused field pci_bus in struct
 hv_pcibus_device
Message-ID: <aWUFPUxrMkM32zDD@csail.mit.edu>
References: <20260111170034.67558-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260111170034.67558-1-mhklinux@outlook.com>

Hi Michael,

On Sun, Jan 11, 2026 at 09:00:34AM -0800, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> Field pci_bus in struct hv_pcibus_device is unused since
> commit 418cb6c8e051 ("PCI: hv: Generify PCI probing"). Remove it.
> 

Since that commit is several years old (2021), I was curious if this was found by
manual inspection or if the compiler was able to flag the unused
variable as well.

> No functional change.
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

Reviewed-by: Srivatsa S. Bhat (Microsoft) <srivatsa@csail.mit.edu>

Regards,
Srivatsa
Microsoft Linux Systems Group

> ---
>  drivers/pci/controller/pci-hyperv.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 1e237d3538f9..7fcba05cec30 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -501,7 +501,6 @@ struct hv_pcibus_device {
>  	struct resource *low_mmio_res;
>  	struct resource *high_mmio_res;
>  	struct completion *survey_event;
> -	struct pci_bus *pci_bus;
>  	spinlock_t config_lock;	/* Avoid two threads writing index page */
>  	spinlock_t device_list_lock;	/* Protect lists below */
>  	void __iomem *cfg_addr;
> -- 
> 2.25.1
> 
> 

