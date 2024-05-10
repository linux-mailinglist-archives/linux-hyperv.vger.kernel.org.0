Return-Path: <linux-hyperv+bounces-2097-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 707DC8C2999
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 May 2024 19:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A312CB20B61
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 May 2024 17:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E65B1C6B5;
	Fri, 10 May 2024 17:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cnHFoHnm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D1F199B9;
	Fri, 10 May 2024 17:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715363772; cv=none; b=Don3beZCKXplYeyJOeAMBrY8y6Eb0Z1Zmi/+ZLb04Vp6r2tkPgJNxW7bEUMibgJbPi3pHep/MzkfzUgaa7eidbzd2vyBvbdel3LVB4JxGnb3H8a6R0JemSWjNVXYDbxUSHZ7Y5K8j0y0T/lrk37ompp9EgYVgwOilzhWGMpoYK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715363772; c=relaxed/simple;
	bh=cue48BDlRusS3Iy/MlTn98/USIiO39fLjrbxsAxixQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VW/oBBsk9Ohx9rrHtQ9w2Cc0PrrRv48583ePsV4+dj2Res5tMrTlTwm1GxSiDym8Wji/KdiSPOAc76NX88EKZjHdNXymBNjpGvNTuvS6OIG8PqHWfhZBzF8qaLkYKRgETMNteUB55PXk6Fy+kA+ckX9XnXmHygaDEDEeHgivhJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cnHFoHnm; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.49.54] (c-73-118-245-227.hsd1.wa.comcast.net [73.118.245.227])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7D836209122A;
	Fri, 10 May 2024 10:56:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7D836209122A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1715363770;
	bh=xmPsBmG0MtWTWMPACua6uWLBycHnXSypEXgsfIjpL4Q=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=cnHFoHnm7TCe7I5MKziDNmP8eLNUrav9WOHKtfkcsS2zME7EwLwTyQHW/n0XdUZ1D
	 auuEEXG/uoBpyW8BG6DzTaSeUIvjAQDLIf4Z0+zSsZvJbbP/25fGp89RFey3sXwdJK
	 Un7DI1chzJWYDIaXIh6oaww4QZf0ItYEpxm6S4EA=
Message-ID: <c377df78-0a0e-4d0a-8460-6911db657c48@linux.microsoft.com>
Date: Fri, 10 May 2024 10:56:09 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Documentation: hyperv: Update spelling and fix typo
To: mhklinux@outlook.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, kys@microsoft.com, corbet@lwn.net,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20240507131607.367571-1-mhklinux@outlook.com>
Content-Language: en-CA
From: Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <20240507131607.367571-1-mhklinux@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/7/2024 6:16 AM, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> Update spelling from "VMbus" to "VMBus" to match Hyper-V product
> documentation. Also correct typo: "SNP-SEV" should be "SEV-SNP".
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
>  Documentation/virt/hyperv/overview.rst | 22 +++----
>  Documentation/virt/hyperv/vmbus.rst    | 82 +++++++++++++-------------
>  2 files changed, 52 insertions(+), 52 deletions(-)
> 

Looks good to me, FWIW:

Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>


