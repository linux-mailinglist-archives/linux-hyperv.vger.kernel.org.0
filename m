Return-Path: <linux-hyperv+bounces-3882-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 457FBA2F69F
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Feb 2025 19:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89BF97A1D68
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Feb 2025 18:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816A024418C;
	Mon, 10 Feb 2025 18:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cxU9OQ8U"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C17725B67D;
	Mon, 10 Feb 2025 18:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739211369; cv=none; b=A30WTzQ8O3VZZt4M0R5ibXg38KprKg0blWj08tIr2fu59LwI0+W7ECvZ99zMAtjrfl1svMwLD6eNz/DexAnEBxXOJ81UIxpODTIk81azm2HWmDsqTpLDEfPQZxHUKFU705v1Rtogi+qQLaPx1uXYb3iqxnnDvh4baNyaRUJ9bhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739211369; c=relaxed/simple;
	bh=muocnsK2MfueYqQiuvQOXtEYcq3B+lSSYghB9Dk0Ccs=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=g+V7G351jI0On2aA9lkSMBnrhPd2SANE5wvvWNb2biQcfxPr0CvtpQ9zFRCHfnf4PdXCVDmpkjfqHX91nIyp5m6VJn5POONEvvm6hgSY7E4natpXqc13tFBU2rnPiQ3OuJG+iHFdA3go4fsDmJ7bUtSVm9yGyd6BMXN+OgpIr1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cxU9OQ8U; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.35.166] (c-73-59-8-18.hsd1.wa.comcast.net [73.59.8.18])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7C8282107A8D;
	Mon, 10 Feb 2025 10:16:03 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7C8282107A8D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739211363;
	bh=6l8sxe+Qhe4cGlUnMZkaUQNy2wAXPMJANDkpQnlf2EY=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=cxU9OQ8U/h/Caz/4cTmBZDTwvEjSE0cBS33ETu9AijeTC9RJCvM+iByvkCGI/nqGd
	 ipmF84HGRmkM7XQroorFhQV3ZivRgOjVUyEvQdXwuFDjbes5kN+jsrYfh3pbMaN/DJ
	 ermb3z0XjZ5Jak8LpSpwoKOYPHj1K/29tZhFdsZI=
Message-ID: <f4f8bfc5-6246-4aba-854f-71f0697b1bf3@linux.microsoft.com>
Date: Mon, 10 Feb 2025 10:16:02 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: eahariha@linux.microsoft.com, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 "open list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>,
 "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS"
 <linux-pci@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: hv: Correct a comment
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <20250207190716.89995-1-eahariha@linux.microsoft.com>
 <20250210175258.pwaqr3dqxstcjmui@thinkpad>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20250210175258.pwaqr3dqxstcjmui@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/10/2025 9:52 AM, Manivannan Sadhasivam wrote:
> On Fri, Feb 07, 2025 at 07:07:15PM +0000, Easwar Hariharan wrote:
>> The VF driver controls an endpoint attached to the pci-hyperv
>> controller. An invalidation sent by the PF driver in the host would be
>> delivered *to* the endpoint driver by the controller driver.
>>
>> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
>> ---
> 
> Where is the changelog?
> 
> - Mani
> 

Yes, sorry, I realized it after I sent it.

Thanks for the review!

- Easwar (he/him)

