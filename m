Return-Path: <linux-hyperv+bounces-3064-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46441983B97
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Sep 2024 05:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C886EB228C6
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Sep 2024 03:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50E71A270;
	Tue, 24 Sep 2024 03:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.b="r/cen+gm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FE311CAF;
	Tue, 24 Sep 2024 03:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.30.2.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727148586; cv=none; b=jXWoGM0o5Sd38mvXocj6C8a5E05kGFMQtpQYflpNnf2bt4wpiOkifrY2UAPlUyy5GPPSMmHPgA7nWgOhRQgXl/5C8Hsb498tKFMulr2hQkvqVzo6bxRkfEmwZAiteZJt3C07pzqUyvoG0qMTl+L0ldWnHLaoB4795Z+herg7Kpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727148586; c=relaxed/simple;
	bh=He4RSk+VyNqC7R9e8sia//RliWJ2E0nW4v8e5cf2rHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kto0g2eGVGFqPfl2hMCTJ2m6eUaH1STWLHcv15dz4mjTGh9C68Nryx6ZpbUwyq8bI7xYUdQAiKR9wrB0ThQlKTS/RyRThs8/Q+AQkBr01Kwk58gjaF6SJJaTYa9j1JlktRGh3DWJf2J3FQ15dKOOAppmsYBVCRB+IJpcOcKFXzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu; spf=pass smtp.mailfrom=csail.mit.edu; dkim=pass (2048-bit key) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.b=r/cen+gm; arc=none smtp.client-ip=128.30.2.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csail.mit.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=outgoing.csail.mit.edu; s=test20231205; h=In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CLHuzZ3zITPRDC0K133CNkneyz/m1pTgbOcS+Htx+l0=; t=1727148585; x=1728012585; 
	b=r/cen+gmCwRcmiFkbD1Y+MNeK4HY7FDebxbHZ/Ff8otczSZdvebTQxkRhA9zF6lgl2Q9hOS2I+K
	Yp89Ee2tGrC1lh7Qe446i5WNlX7Cds3Q/PlawQDZXzrnuomnv2O5oonvCYljeRoImsMeoJr0s9y3N
	64l0EQWOBlPjvUANzmVK05P9Uv3bh3Tgpmkfx6S54eahOmdivuwTt2DGgWRxSFQe2XLInQjqgXLW4
	I87d3B92Gw5tbzCAoBc++/rEEF2xDx250Ue85wR+3WpLOUjfpG8bqDM9JFF6j6E8PHCymG7sJ7YQL
	RBZMfo2bZaE1VIC8UFU1SVrI2AQ5iNIycLwA==;
Received: from [172.179.10.40] (helo=csail.mit.edu)
	by outgoing2021.csail.mit.edu with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <srivatsa@csail.mit.edu>)
	id 1sswFC-00EsWF-DI;
	Mon, 23 Sep 2024 23:29:42 -0400
Date: Tue, 24 Sep 2024 03:29:39 +0000
From: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, jikos@kernel.org, bentiss@kernel.org,
	dmitry.torokhov@gmail.com, linux-hyperv@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	ernis@microsoft.com, rafael@kernel.org, pavel@ucw.cz,
	lenb@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/3] Revert "HID: hyperv: register as a wakeup source"
Message-ID: <ZvIyI2N4V2rGABvh@csail.mit.edu>
References: <1726176470-13133-1-git-send-email-ernis@linux.microsoft.com>
 <1726176470-13133-4-git-send-email-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1726176470-13133-4-git-send-email-ernis@linux.microsoft.com>

[+linux-pm, Rafael, Len, Pavel]

On Thu, Sep 12, 2024 at 02:27:50PM -0700, Erni Sri Satya Vennela wrote:
> This reverts commit f1210455e78a610c7b316389b31c162c371d888c.
> 
> Remove mouse as wakeup source since Suspend-to-Idle feature
> is disabled.
> 
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> ---
>  drivers/hid/hid-hyperv.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
> index f33485d83d24..b6d0f7db4c93 100644
> --- a/drivers/hid/hid-hyperv.c
> +++ b/drivers/hid/hid-hyperv.c
> @@ -293,9 +293,6 @@ static void mousevsc_on_receive(struct hv_device *device,
>  		memcpy(input_dev->input_buf, input_report->buffer, len);
>  		hid_input_report(input_dev->hid_device, HID_INPUT_REPORT,
>  				 input_dev->input_buf, len, 1);
> -
> -		pm_wakeup_hard_event(&input_dev->device->device);
> -
>  		break;
>  	default:
>  		pr_err("unsupported hid msg type - type %d len %d\n",
> @@ -502,8 +499,6 @@ static int mousevsc_probe(struct hv_device *device,
>  		goto probe_err2;
>  	}
>  
> -	device_init_wakeup(&device->device, true);
> -
>  	input_dev->connected = true;
>  	input_dev->init_complete = true;
>  
> @@ -526,7 +521,6 @@ static void mousevsc_remove(struct hv_device *dev)
>  {
>  	struct mousevsc_dev *input_dev = hv_get_drvdata(dev);
>  
> -	device_init_wakeup(&dev->device, false);
>  	vmbus_close(dev->channel);
>  	hid_hw_stop(input_dev->hid_device);
>  	hid_destroy_device(input_dev->hid_device);
> -- 
> 2.34.1
> 
> 

