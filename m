Return-Path: <linux-hyperv+bounces-7407-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1F8C341A7
	for <lists+linux-hyperv@lfdr.de>; Wed, 05 Nov 2025 07:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A87B3BFC91
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Nov 2025 06:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B792C0F79;
	Wed,  5 Nov 2025 06:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdOCfeKx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FDD26CE32;
	Wed,  5 Nov 2025 06:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762325759; cv=none; b=NsrujOl2K6a0qQtMsBz4kguzGjvqE3pmzf1F8z/p7IlGaVmCR4o+OwzneCIZWCUZTmXeSmsaSbnB9JGR/d2pEJfXZqH32TdLDlofAAq6FakWm9PY8Dy+qFBuvHWvn/hWGoyWR+nL+pTjH3CtcrUcmrK4Tqbh1f8CvWaGrscBeZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762325759; c=relaxed/simple;
	bh=ckgneUbTpeEuNMdYvm3uNVbdalbnfVOTsYT16lj5Pdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J4ApTZ3L9Lqx19HyK5RaK1JrEgMluPKJsMUlROk8W9IxT5ctVWlPr9M99oXabwKpWLCMBBgZrK6EzTirZ6xzhhiCL0v37JY+PontH3nt7UBfV7jElCtUlv5kNg8ZVXZLJnxXvpy+//raMwnr/hp9B9wbY3J+7CPAn12WTgNa1iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdOCfeKx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CEDAC4CEF8;
	Wed,  5 Nov 2025 06:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762325758;
	bh=ckgneUbTpeEuNMdYvm3uNVbdalbnfVOTsYT16lj5Pdw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gdOCfeKxtduUp22tMaJB7VkO6yydydvVHVpadPBijLIkAmReVl5Q1MZ/RG+YRb9nk
	 0ooidf/hyo78s999N9HRQQcrT9k2iXqn9id71A0h968JEaGEf5Akd+0ysEPLVMc8sh
	 ubkBlTdPoMA270DI5vdc+6OkzB/EmfTOTf/VIejYQtGgOttyQjSctWXRfnIUzqwYoQ
	 Ffz2MMpKrh9JX7i5yNzEg+6NMm/m4aKy67UCaGNU82I/nv5U9rUREvSGG2mVGYH1h8
	 in0Dqy64N13ibvSdcs7XiRgm4OfMHmMGlMvUolm6LGU/3WKLO3LyuLuzYTHdxrLF9y
	 eJw6+n348T3+w==
Message-ID: <69ed5b38-830d-46d7-a84b-86787c39df7d@kernel.org>
Date: Wed, 5 Nov 2025 07:55:53 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] dt-bindings: microsoft: Add vmbus
 message-connection-id property
To: Hardik Garg <hargar@linux.microsoft.com>
Cc: apais@microsoft.com, cho@microsoft.com, conor+dt@kernel.org,
 decui@microsoft.com, devicetree@vger.kernel.org, haiyangz@microsoft.com,
 hargar@microsoft.com, krzk+dt@kernel.org, kys@microsoft.com,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, robh@kernel.org,
 ssengar@linux.microsoft.com, wei.liu@kernel.org
References: <6d3b5d1e-de1b-4d3b-ba14-7029c51b8e05@kernel.org>
 <1753395133-26061-1-git-send-email-hargar@linux.microsoft.com>
 <94d3e709-8c8b-40cb-a829-92c2012b4e0a@kernel.org>
 <f6c01c55-8930-459a-baa5-1465c5047b3e@linux.microsoft.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <f6c01c55-8930-459a-baa5-1465c5047b3e@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 05/11/2025 02:10, Hardik Garg wrote:
> 
> Each guest has a private hypervisor mailbox and cannot access any other
> guest’s communication path. Using an incorrect connection ID does not
> allow eavesdropping or cause interference — it only results in failed
> VMBus initialization because the host drops messages sent to an
> unexpected port. Thus, exposing the correct connection ID to the guest
> is safe and necessary for correct initialization.
> 
>> If different values are important for the host, then all guests should
>> use whatever 0 which will map to different values on host by other means
>> of your protocol.
>>
> 
> Using a fixed value such as 0 for all guests would not work, because the
> Hyper-V host differentiates between multiple control-plane contexts (for
> example, VTL0 vs VTL2) using distinct connection IDs. The guest must use
> the value assigned by the host, as there is no implicit mapping or
> negotiation protocol to determine it otherwise.

Sorry, I am not going back to three months old discussion.

Therefore I close this topic for me with: since the actual value does
not matter for the host - it will discard all messages which are not
intended to this guest - you can just use value 0 and your hypervisor
will map to proper port.

Best regards,
Krzysztof

