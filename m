Return-Path: <linux-hyperv+bounces-6445-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 784B9B15F16
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Jul 2025 13:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94DD3174FB0
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Jul 2025 11:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485C0293C45;
	Wed, 30 Jul 2025 11:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QDbvB1Fc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5E3481B6;
	Wed, 30 Jul 2025 11:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753873720; cv=none; b=XSKKL5asjVJ9LJrWMyczVwaogSWlDjjak7ASQVh5vsqtO21bMPIfPvN4uS0BBsvBz6uRMI0RYfMMuVhNs07AoDlvkiW8BjvQt6f7qKtlDoSg+P0Lsqk2czYBVG5uD1tVarejFxWA16bUHRFRBPVaeaLsnzl1611+IgKMJCunXzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753873720; c=relaxed/simple;
	bh=IFvT7xNWi57iDKOhUCOkfp//6Q3AGbBGhf64z6miS80=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aohKYs8sxCx2U1iRUTiwp1OASjjWlQ4pJ/OtYq8pPnG9DK/8M2OAY/svM3iJIFTwR27JFaA5L6M1XO6r6Qflj53cK+lzBKQSH/gSx+V4tmMiW/0hQofv9HQDnqk0QUemApwDygl2lBexu4hfUOA1DCJ/TcH9WRAgZURxuUv4ziY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QDbvB1Fc; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.161.243] (unknown [4.194.122.136])
	by linux.microsoft.com (Postfix) with ESMTPSA id E65A62120EB4;
	Wed, 30 Jul 2025 04:08:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E65A62120EB4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1753873717;
	bh=wLtXKAawS87NuBJ56dqPZmZZjD2O493QXmx3zPterwo=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=QDbvB1FcA2S1E1NA1nqZ1uUru/xLqpBnRJnBpmPoZ5YTkCAqy40xaNGI1GXyg6GaK
	 g4aWxf/pMeCVepL21qqYPkE9DUVPn31nddDlKzqkavdgFfUGCITzP5SOIH4+rd4qWn
	 sJ/ZTmVTo1omLVPLYchdFPdqC3I02Kdx/shqxD7M=
Message-ID: <83070bd2-209a-4143-9efa-0a67f489563f@linux.microsoft.com>
Date: Wed, 30 Jul 2025 16:38:33 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/hyperv: Cosmetic changes for hv_utils_transport.c
To: Abhishek Tiwari <abhitiwari@linux.microsoft.com>,
 abhitiwari@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, ssengar@microsoft.com
References: <1753871840-23636-1-git-send-email-abhitiwari@linux.microsoft.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <1753871840-23636-1-git-send-email-abhitiwari@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/30/2025 4:07 PM, Abhishek Tiwari wrote:
> Fix issues reported by checkpatch.pl script for hv_utils_transport.c file
> - Update pr_warn() calls to use __func__ for consistent logging context.
> - else should follow close brace '}'
> 
> No functional changes intended.
> 
> Signed-off-by: Abhishek Tiwari <abhitiwari@linux.microsoft.com>

Please use a different prefix for Subject.
Replace "x86/hyperv:" with "Drivers: hv: util:"

We generally follow the naming practice used for a file, which can be
seen in git log <file_path>.

Rest LGTM. Post above change:
Reviewed-by: Naman Jain <namjain@linux.microsoft.com>

Regards,
Naman


