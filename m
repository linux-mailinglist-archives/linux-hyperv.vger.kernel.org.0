Return-Path: <linux-hyperv+bounces-6352-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F47FB0EA7D
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Jul 2025 08:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37AE41C25EEC
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Jul 2025 06:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D256A26B2D7;
	Wed, 23 Jul 2025 06:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXeHXmHR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25B618C91F;
	Wed, 23 Jul 2025 06:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753251503; cv=none; b=O0uvXhLSXe8G02x6Imf8Kq6/rTAVfmf+9+1B9V7wA2coo5I3cfnZNmh82XIZYF8B2vzwqBrYwEVj1JApGS0fY2eE/L6/ed3I54JsshspmRh5ZjpqMqjbojHSn2v7SbFs3WjIyJT24Nh2TOrKCaajYQkdgs8JMWzG1PWH3iCKLJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753251503; c=relaxed/simple;
	bh=rqrM0LKO3Whud6YGkhw6uiewxJ3mRCF6N+fqxS7NLeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ybxmzh/1eDdt/mv4jb+Jpsd1S35cn7bO8bDJKe6insfsDolaVh7U0cS+MAzqD5kUmiRfk9C29TeEAxI7HBa7euQHQys3JPZt6hCuIBTiJr4TA3dKBZ6xlRTYWZb0pwTI0Y8zHiRMma3a+H4L2Nf/8LvXTFDC+8oGeBGbPy9rpwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXeHXmHR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEDC0C4CEE7;
	Wed, 23 Jul 2025 06:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753251503;
	bh=rqrM0LKO3Whud6YGkhw6uiewxJ3mRCF6N+fqxS7NLeY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gXeHXmHRncObLrt5e2njqEHHRsAANFxsyooWQ1cBdnJmVGG4UnAJIeYxP2jMxkjMu
	 idpNqLypXd0/5YBkau7B9SDXAtbsGIRs64poWz1nPXqDCAHu1nYY2oLzwMHxku556U
	 nr3sqCdVf/Y9yIb+K25qRvAhmd7f1aVy7jXW9zXPgB9lAW5w9mYA5M2XOMA2t8B5Ow
	 yEvSJwqfgy4L9XaaqxIr7eOU56rvJlSdIan9viYKFSkJ9bOt/LjmVpj7GvFwZDLgnC
	 ns2neJFZ0aNByHl3bB6APbkUUW2bj6mclPa44DQPIrv6yhKoctxYkVvgseU7trYo4d
	 wSbD74A5GJ7vA==
Message-ID: <6d3b5d1e-de1b-4d3b-ba14-7029c51b8e05@kernel.org>
Date: Wed, 23 Jul 2025 08:18:17 +0200
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
Cc: apais@microsoft.com, conor+dt@kernel.org, decui@microsoft.com,
 devicetree@vger.kernel.org, haiyangz@microsoft.com, hargar@microsoft.com,
 krzk+dt@kernel.org, kys@microsoft.com, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, robh@kernel.org, ssengar@linux.microsoft.com,
 wei.liu@kernel.org, cho@microsoft.com
References: <095a1455-c6ac-4a7d-a219-ddfd0a93d8d6@kernel.org>
 <1753240089-29558-1-git-send-email-hargar@linux.microsoft.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <1753240089-29558-1-git-send-email-hargar@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/07/2025 05:08, Hardik Garg wrote:
>> Host is supposed to have multiple guests, so this feels like you are
>> going to prepare for each guest different DTS with different connection
>> ID. This feels like poor design. DTS is supposed to be relatively static
>> configuration, not runtime choice vmguestid+1.
> 
>> The guest cannot access other configuration channels, can it? If it can,
>> it would mean it can eavesdrop on other guests? So obviously it cannot.
>> Therefore from guest point of view this is completely redundant. Guest
>> cannot use any other value, thus guest should not configure it. The
>> guest has only one channel and uses only this one which gets to right
>> place to the host.
> 
> Thank you for your feedback. Let me explain the connection ID in more detail:
> 
> 1. Message Port Architecture:
>    - The connection ID specifies which Hyper-V hypervisor message port (mailbox slot) to use for communication between the host and guest
>    - The hypervisor has multiple message ports, but historically VMBus only used one
>    - With the introduction of VTL2 (Virtual Trust Level 2), the control plane can now be hosted in VTL2, requiring different message ports for communication
> 
> 2. Control Plane Communication:
>    - The VMBus control plane on the host needs to communicate with the VMBus driver in the guest
>    - When the control plane is hosted in VTL2, it requires a different message port than the standard communication path
>    - The connection ID tells the guest whether to use the standard or alternate message port for this control plane communication
> 
> 3. Message Processing:
>    - Each message is tagged with an ID
>    - If the guest uses an incorrect ID, the host won't recognize the message and will drop it
>    - This is not about choosing between multiple available channels - it's about using the correct mailbox slot for communication
> 

Don't paste me specs in response to questions, but answer specific
questions.

> 4. Security and Isolation:
>    - Each guest has its private hypervisor mailbox
>    - Multiple guests using the same connection ID cannot interfere with each other

Then all guests can use the same value, 0, making this property redundant.

>    - The connection ID is more like a "root ID" that helps enumerate devices on the bus, not a channel selector between guests
> 
> 5. Dynamic Nature:
>    - The connection ID is specified when the guest starts running
>    - The host can change it during VM lifecycle events (reset/reboot)

So not suitable for DT. DT is a static data. You cannot just keep
changing existing DT to match whatever you want runtime.

>    - This is why the VMBus driver needs to know the connection ID every time the kernel starts
>    - The ID might be different from what it was during the last guest run
Best regards,
Krzysztof

