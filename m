Return-Path: <linux-hyperv+bounces-7406-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 120ECC3398A
	for <lists+linux-hyperv@lfdr.de>; Wed, 05 Nov 2025 02:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B302A34577C
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Nov 2025 01:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EF127A122;
	Wed,  5 Nov 2025 01:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FjlXP0Ye"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5D926CE3A;
	Wed,  5 Nov 2025 01:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762305047; cv=none; b=mQiloUwUIcVUl1uiAJMr9qQlhvb95HRgEoF8vn83s7M5t1yQxrYJ0mjYs+hEJmFiP7yU3OlNm5nyuPDAGZ3VOqUbE9uFiGsKC6RZ3p4xcjZdL14Fb1WF0xeqA15Q5l+S0vtSQ2wpDZ7yxe3QNe5YJRIcjshdR6JZ/EvEyMh/cx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762305047; c=relaxed/simple;
	bh=VryhGGcbzk2d/iHnsA2ib3+gX9kmoD9gOA+GFMs5c2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xg6/AH8TybnMUbyKB3kkBFvlwu5htq2DmOvZNaBzBrtyRYb7It2eAvaTt4QJfOyobrOch/eQxE1PTJoNTkxho7tdRSE2jnlKmWpLv1pxL3SfU/eZ+XnVAt+p4+irUMgjBTsCXv9aU5BJToAjS+9cI70GDUX2tqmiGCeSNeDo8x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=FjlXP0Ye; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.32.195] (unknown [20.236.11.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id D1A3A20120A5;
	Tue,  4 Nov 2025 17:10:39 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D1A3A20120A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1762305040;
	bh=Bwg81lUU1BiqKdd1asgtMAjvCLTY6UnLRcAdJpu4tY0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FjlXP0Ye6cr+xh/cJ+FFKecYrdLIegSug2GASdWm92EXyyjuVxyLJJusdFY7mSzry
	 m95+3be2hTfO8bMSbnR/2tQ+4i3+hU1wk/9Zi6ODU0+TDHAqxexryW7L8rT37xGPVV
	 hCbQkQkogvmJriN9YPGvpwj+psCj6D2Nc3gB80ew=
Message-ID: <f6c01c55-8930-459a-baa5-1465c5047b3e@linux.microsoft.com>
Date: Tue, 4 Nov 2025 17:10:40 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] dt-bindings: microsoft: Add vmbus
 message-connection-id property
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: apais@microsoft.com, cho@microsoft.com, conor+dt@kernel.org,
 decui@microsoft.com, devicetree@vger.kernel.org, haiyangz@microsoft.com,
 hargar@microsoft.com, krzk+dt@kernel.org, kys@microsoft.com,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, robh@kernel.org,
 ssengar@linux.microsoft.com, wei.liu@kernel.org
References: <6d3b5d1e-de1b-4d3b-ba14-7029c51b8e05@kernel.org>
 <1753395133-26061-1-git-send-email-hargar@linux.microsoft.com>
 <94d3e709-8c8b-40cb-a829-92c2012b4e0a@kernel.org>
Content-Language: en-US
From: Hardik Garg <hargar@linux.microsoft.com>
In-Reply-To: <94d3e709-8c8b-40cb-a829-92c2012b4e0a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/25/2025 12:32 AM, Krzysztof Kozlowski wrote:
> On 25/07/2025 00:12, Hardik Garg wrote:
>>> Then all guests can use the same value, 0, making this property redundant.
>>
>> No, they cannot use the same value. The protocol requires different connection IDs for different communication paths.
>> For example, a guest communicating with a VTL0 control plane uses a different connection ID than one communicating with
>> a VTL2 control plane. The host specifies this value based on the guest's configuration, and there is no other discovery
>> method available to determine the correct connection ID.
> 
> You completely removed entire thread and discussion making it difficult
> to connect to one of 100 or more discussions I am doing.
> 

Apologies for the very late reply — I realize it’s been a few months
since your last feedback. I wanted to take time to revisit the design
and explore possible alternatives to avoid introducing the connection-id
property in the Device Tree. After evaluating the available mechanisms,
unfortunately there isn’t a viable alternative for passing this
information from the host to the guest in the current Hyper-V architecture.

To address your earlier comments in detail:

The connection-id is not an arbitrary or per-guest runtime configuration
parameter — it is a hardware-level identifier that specifies which
Hyper-V message port (or mailbox slot) the guest should use to
communicate with the VMBus control plane. Historically, VMBus always
used a single, fixed connection ID. However, with the introduction of
Virtual Trust Level 2 (VTL2) support, the control plane can now reside
in a different trust level, requiring the guest to communicate through a
different message port. This connection-id is determined by the
hypervisor based on the status of VMBus relay. From the guest’s
perspective, it is completely static for the lifetime of that VM
instance — it never changes at runtime. Once the kernel boots, it must
read this value to establish communication with the correct VMBus
control plane. There is currently no system API, or discoverable
interface that allows the guest to determine this value dynamically.

> 
> The guest should not care about the value. Otherwise what if guests
> decides to ignore your DT property and start using other value? Sniffing
> other guests traffic? Causing conflicts or denial of service?
> 

Regarding security and isolation:

Each guest has a private hypervisor mailbox and cannot access any other
guest’s communication path. Using an incorrect connection ID does not
allow eavesdropping or cause interference — it only results in failed
VMBus initialization because the host drops messages sent to an
unexpected port. Thus, exposing the correct connection ID to the guest
is safe and necessary for correct initialization.

> If different values are important for the host, then all guests should
> use whatever 0 which will map to different values on host by other means
> of your protocol.
> 

Using a fixed value such as 0 for all guests would not work, because the
Hyper-V host differentiates between multiple control-plane contexts (for
example, VTL0 vs VTL2) using distinct connection IDs. The guest must use
the value assigned by the host, as there is no implicit mapping or
negotiation protocol to determine it otherwise.

In summary:
The connection-id is a static hardware configuration detail provided by
the host before boot, not a runtime variable. It is required for correct
message routing between the guest’s VMBus driver and the appropriate
control plane. There is no existing API or firmware interface that can
expose this information. Each guest has a dedicated, isolated mailbox,
so security is preserved. If you still feel that Device Tree is not the
right mechanism, I’m open to discussing alternative approaches that
could convey this information from the host to the guest early during
boot — though based on the current architecture, I have not found a
suitable one yet.

Thank you again for your time, patience, and for your detailed feedback.
I’ll make sure my next submission keeps full context and follows proper
wrapping and quoting conventions.



Thanks,
Hardik



