Return-Path: <linux-hyperv+bounces-2449-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CAD90DA7C
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Jun 2024 19:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6164A1F225D9
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Jun 2024 17:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FE913D8AE;
	Tue, 18 Jun 2024 17:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AHKJM69s"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB6514BF92;
	Tue, 18 Jun 2024 17:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718731317; cv=none; b=ZlstSaUtIDjRACAYj2zjLmbjo+ZzeHTprJ/ZNw4TmJ994SaDVC+eMp2o3pk4BABGFGgpAIqd0a1hlB/mrh40VRxm3i3BKCFBoX4bwPHwwtBCPVhIsfQblIryPERUpqFR1o4VsvTmbyNuR2MnyHs/7GJ2USfdBEtRAAq3zwKdW2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718731317; c=relaxed/simple;
	bh=bsVokfsJrJR2cRpyjIXEMxdNXyqgBpZXtl9kY/mti1A=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oJBuK88DeS2jOKy5RnCR5rDrHwCuBkJ0Fy/uWNAcbtXY4euPnluvcAQ+PqMNs/EgPtJOKLCH6r/n3ETF5EeOoI5q0GZ6agJpE2E71SkERxlInUfz8k98FLcb5ydDuyAf4Kuwn1nWpZdFBmMXrHJN3NxBbRd8ngoWnkp7ULpPcLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AHKJM69s; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.0.17] (unknown [20.236.10.120])
	by linux.microsoft.com (Postfix) with ESMTPSA id C7B1720B7004;
	Tue, 18 Jun 2024 10:21:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C7B1720B7004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1718731316;
	bh=8qgAm8SJGz97J3QCsDSTv37+33XsXvUm8qxrMQOuEJQ=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=AHKJM69skZr7DtDCCpIfWeimIP8A8CF+yNo97CiZ5rilYr+ix+B+SOdaSty4V7aOT
	 2xX0y3CzdpPyNm6PMEssyS2ZCEkanrrhoSJrQ8ig8FZ/JxiF0jed0iu/6WqHUJ92bg
	 5UWpCoejZ70ZOJwWoluQ1sn90/Y92oIev09VT/G8=
Message-ID: <0c3b2cc7-076d-45a5-9750-f78f15c8c0f0@linux.microsoft.com>
Date: Tue, 18 Jun 2024 10:21:56 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: eahariha@linux.microsoft.com
Subject: Re: [PATCH v2 1/1] Documentation: hyperv: Add overview of
 Confidential Computing VM support
To: mhklinux@outlook.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, corbet@lwn.net,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-coco@lists.linux.dev
References: <20240618165059.10174-1-mhklinux@outlook.com>
Content-Language: en-US
From: Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <20240618165059.10174-1-mhklinux@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/18/2024 9:50 AM, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> Add documentation topic for Confidential Computing (CoCo) VM support
> in Linux guests on Hyper-V.
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
> Changes in v2:
> * Added hyperlink to Coconut github project
> 
>  Documentation/virt/hyperv/coco.rst  | 260 ++++++++++++++++++++++++++++
>  Documentation/virt/hyperv/index.rst |   1 +
>  2 files changed, 261 insertions(+)
>  create mode 100644 Documentation/virt/hyperv/coco.rst
>

Looks good to me.

Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>

